"use client";

import { useState } from 'react';
import { GoogleGenerativeAI, HarmCategory, HarmBlockThreshold, } from "@google/generative-ai";

const ChatAssistant = () => {
  const [inputText, setInputText] = useState('');
  const [conversationHistory, setConversationHistory] = useState([
        {
          role: "model",
          parts: [{ text: "Hello there! 👋 How can I help you today? Are you interested in learning about regenerative and sustainable farming practices and methods? 🧑‍🌾🌱  Let me know what's on your mind!"}],
        },
      ]);


  async function runChat() {
    const API_KEY = process.env.API_KEY;

    const genAI = new GoogleGenerativeAI(API_KEY as string);
    const model = genAI.getGenerativeModel({ model: "gemini-pro" });
  
    const generationConfig = {
      temperature: 1,
      topK: 0,
      topP: 0.95,
      maxOutputTokens: 8192,
    };
  
    const systemInstruction = "You are a knowledgeable assistant for farmers and agricultural enthusiasts, demonstrating comprehensive knowledge in regenerative and sustainable agriculture and farming practices. If a question is not related to farming and africulture, the response should be That is beyond my knowledge.";

  
    const safetySettings = [
      {
        category: HarmCategory.HARM_CATEGORY_HARASSMENT,
        threshold: HarmBlockThreshold.BLOCK_MEDIUM_AND_ABOVE,
      },
      {
        category: HarmCategory.HARM_CATEGORY_HATE_SPEECH,
        threshold: HarmBlockThreshold.BLOCK_MEDIUM_AND_ABOVE,
      },
      {
        category: HarmCategory.HARM_CATEGORY_SEXUALLY_EXPLICIT,
        threshold: HarmBlockThreshold.BLOCK_MEDIUM_AND_ABOVE,
      },
      {
        category: HarmCategory.HARM_CATEGORY_DANGEROUS_CONTENT,
        threshold: HarmBlockThreshold.BLOCK_MEDIUM_AND_ABOVE,
      },
    ];
  
    const chat = model.startChat({
      generationConfig,
      safetySettings,
      history: [
        {
          role: "user",
          parts: [{ text: "Hello"}],
        },
        {
          role: "model",
          parts: [{ text: "Hello there! 👋 How can I help you today? Are you interested in learning about regenerative and sustainable farming practices and methods? 🧑‍🌾🌱  Let me know what's on your mind!"}],
        },
      ],
      // systemInstruction: 
      //   {
      //     role: "system",
      //     parts: [{ text: systemInstruction }],
      //   },
      });
  
    const result = await chat.sendMessage( inputText );
    const newConversationHistory = [...conversationHistory];
    newConversationHistory.push({
      role: "user",
      parts: [{ text: inputText }],
    });
    setConversationHistory(newConversationHistory);

    newConversationHistory.push({
      role: "model",
      parts: [{ text: result.response.text() }],
    });
    setConversationHistory(newConversationHistory);
  }
  
 

  const handleSubmit = async () => {
    runChat();
    setInputText('');
  };

  // Function to handle text input change
  const handleTextChange = (e) => {
    setInputText(e.target.value);
  };

  return (
    <div className="max-w-xl mx-auto ">
      {/* display the conversations */}
      <div className="">
        {conversationHistory.map((conversation, index) => (
          <div key={index} className={`mb-4 ${conversation.role === 'user' ? 'text-right' : 'text-left'}`}>
            {conversation.parts.map((part, index) => (
              <p key={index} className="inline-block px-4 bg-primary bg-opacity-70 py-4 text-white rounded-md">
                {part.text}
              </p>
            ))}
          </div>
        ))}
      </div>
  

      {/* Input field */}
      <input
        type="text"
        placeholder="Type your message..."
        value={inputText}
        onChange={handleTextChange}
        className="w-full border border-gray-300 rounded-md p-2 mb-4"
      />

      {/* Send button */}
      <button
        onClick={handleSubmit}
        className="bg-primary text-white px-4 py-2 rounded-md"
      >
        Send
      </button>
    </div>
  );
};

export default ChatAssistant;
