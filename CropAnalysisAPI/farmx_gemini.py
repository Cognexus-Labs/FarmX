import google.generativeai as genai
import PIL



genai.configure(api_key="AIzaSyB6O4654SjxpTlCOhUwtmgVAVn3m_kBx00")
genai.GenerationConfig(temperature=0)


def gemini_text(text):
    model = genai.GenerativeModel('gemini-pro')
    response = model.generate_content(text)
    return(response.text)

def gemini_img2text(img_array):
    model = genai.GenerativeModel('gemini-pro-vision')
    response = model.generate_content(img_array)
    return(response.text)