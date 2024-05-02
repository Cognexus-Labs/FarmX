FROM python:3.10.12

# Install libusb-1.0
RUN apt-get update && \
    apt-get install -y libusb-1.0-0

WORKDIR /app

COPY ["requirements.txt", "app.py","object_detection_helper.py","search_and_translate.py","farmx_gemini.py","settings.py","./"]

RUN pip install googletrans==4.0.0-rc1
RUN pip install tensorflow-cpu==2.13.1
RUN pip install tflite-support==0.4.4
RUN pip install Flask
RUN pip install pillow
RUN pip install google-search-results
RUN pip install gunicorn
RUN pip install requests
RUN pip install Flask-Cors
RUN pip install google-generativeai
RUN pip install protobuf==3.20.3

COPY ["model zoo/chicken.tflite","model zoo/crop_disease.tflite","model zoo/fruits_harvest.tflite", "model zoo/weeds.tflite","./model zoo/"]

EXPOSE 8080

ENTRYPOINT ["gunicorn", "--bind=0.0.0.0:8080", "app:app"]





