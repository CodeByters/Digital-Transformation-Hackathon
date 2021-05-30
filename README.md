
# Code Byters
#### Digital Transformation Hackathon 2021

## Challenge & Solution

![Demo Video](image_url)

![Solution Block Diagram](image_url)

## Object Detection

![Original Video](image_url)

## IoT Edge Device

## Modules
### Object Detection

``` python
from azure.iot.device import HubClient


```

### MQTT Publisher (receiver)

![MQTT Video](image_url)

## Helmet Detection

### Trainig the model using Yolo-v5

This Project is based on the [YOLOv5 repository](https://github.com/ultralytics/yolov5) by [Ultralytics](https://www.ultralytics.com/), and it is inspired by [PeterH0323](https://github.com/PeterH0323/Smart_Construction) 

Dataset is downloaded from [nuvisionpower](https://github.com/njvisionpower/Safety-Helmet-Wearing-Dataset) and transformed into the required format using [Roboflow](https://roboflow.com/)

Follow this link to view the training on [Code byters COLAB](https://colab.research.google.com/drive/1xCgBS7XCsMftAK2gccdvB4Gsx4K5APZX?usp=sharing)

### Steps Covered in this Project

* Install YOLOv5 dependencies
* Download custom YOLOv5 object detection data
* Write YOLOv5 Training configuration
* Run YOLOv5 training
* Evaluate YOLOv5 performance
* Visualize YOLOv5 training data
* Run YOLOv5 inference on test images
* Export saved YOLOv5 weights for future inference
* Run detection code on local device using custom weight

![training Video](image_url)

### IoT Device Implementation

![Webcam Video](image_url)

## Visualization
### InfluxDB

![Screenshot](image_url)

### Grafana Daashboard

![Grafana](https://user-images.githubusercontent.com/85012228/120094459-26943880-c129-11eb-8d52-e0b5f2d89153.png)

#### Alerting system and notification channel 
<img width="1537" alt="Alerting-system" src="https://user-images.githubusercontent.com/85012228/120094492-5b07f480-c129-11eb-9662-55ec5f1d08e4.png">
<img width="1311" alt="Notification-Channel" src="https://user-images.githubusercontent.com/85012228/120094494-5d6a4e80-c129-11eb-8158-4bb207659b94.png">


