# -*- coding: utf-8 -*-
"""
Created on Friday January 14 1:27:03 2022
Created to search and translate search results in other languages.

@author: Olufemi Victor tolulope. @osinkolu on github.

Helper script with functions to call google's seach and translate libraries.
"""

from serpapi import GoogleSearch
from googletrans import Translator
from farmx_gemini import gemini_text

#api_key = "b1901bbcc4f4e6e021fb6814e54e330e214b6f92b7718e24f46ec69c546942ab" #os.environ['my_api_key'] # key already stored as a secret on Cloud and mapped in workflow

translator = Translator()

def search_and_translate(search_string, dest_language, with_gemini=False):
  params = {
    "q": search_string,
    "hl": "en",
    "gl": "us",
    "api_key": "b1901bbcc4f4e6e021fb6814e54e330e214b6f92b7718e24f46ec69c546942ab"
  }

  search = GoogleSearch(params)
  results = search.get_dict()

  try:
    answers = (results['knowledge_graph']['description'])
  except Exception:
    try:
      answers = (results["answer_box"]["snippet"] + "\n" + "\n".join(results["answer_box"]["list"]).replace("...","") )
    except Exception:
      try:
        answers = (results["answer_box"]["snippet"])
      except Exception:
        try:
          answers = (results["organic_results"][0]["snippet"])
        except Exception:
          answers = ("No results found")
          print("internet answer: ",answers)
          
  if search_string.split()[-1].lower() == "Nothing".lower():
    return(translate_alone("I'm sorry I didn't find anything. Kindly refer to the list of possible detections above, or reduce the threshold in settings.Thanks for your understanding.", dest_language, with_gemini))
  
  else:
    if with_gemini==True:
      answers = gemini_text(f"Assuming You are an agricultural Expert, and I'm a farmer. I have just checked the internet on {search_string}, the response i got from the internet was {answers}, Kindly help with a more consise and expert response.")
      print("Modifying with Gemini.....")
    return(translate_alone(answers, dest_language, with_gemini=with_gemini))

def translate_alone(answers,dest_language, with_gemini=False):
  if with_gemini==True:
    print("Translating with Gemini.....")
    return(translator.translate(answers, dest=dest_language, src= 'en').text)
  else:
    return(gemini_text(f"Assuming You are an Language Expert, and I can only speak and read {dest_language}. Respond only with translations and nothing else. Translate this text: {answers}"))