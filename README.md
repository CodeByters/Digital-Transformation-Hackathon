
# Code Byters
#### Digital Transformation Hackathon 2021



## Challenge & Solution

Our challenge was to use the Edge IoT platform to create a video analysis application for use in the workplace in different scenarios. Video analysis applications can be used to detect leaks, H&S violations, combustion patterns, etc.

For our solution we have applied computer vision concepts along with IoT solutions to develop different modules that run on an Edge IoT device. These modules included an [object detection module](#object-detection) that monitors people, cars and animals in a video feed. It also included an [MQTT publisher module](#mqtt-publisher-receiver) that uses the Agora SDK to collect data from other modules and send them on an MQTT channel. Lastly, we trained a [helmet detection model](#trainig-the-model-using-yolo-v5) to monitor H&S in the workplace. We deployed it to the device and linked it to a [live camera feed](#iot-device-implementation).

All the collected data was sent through MQTT and Node-Red to InfluxDB cloud and then injested into Grafana for visualisation. A demo of all the modules being visualised can be seen below:

[![final-demo](https://user-images.githubusercontent.com/85012228/120103786-0a5cbf80-c15a-11eb-8907-893b20bc605a.png)](https://youtu.be/s8Ydi4YPymU?list=PLItZkaSiINE6jMAruIIjf6_oiqE7TI6m6)

Below is a block diagram showing the complete solution with the different modules deployed on the IoT device.

<img width="500" alt="MQTT" src="https://user-images.githubusercontent.com/85012228/120103756-e26d5c00-c159-11eb-9e80-b432ea64f3f1.png">

## Object Detection

This was the main and first requirement for the challenge. Implementing this required learning about Docker Containers in order to adjust the provided dockerfile to work correctly. As a team we haven't had prior experience in Docker so that was a challenge that took a significant amount of time. The video below shows the setup and functioning of the object detection application that detects people, cars and animals in a given video.

[![Object-detection](https://user-images.githubusercontent.com/85012228/120103938-bb635a00-c15a-11eb-98bd-8d70245bd2ab.png)](https://youtu.be/VA3kkuE63co?list=PLItZkaSiINE6jMAruIIjf6_oiqE7TI6m6)

This application was further developed to detect person attributes (eg. has_hat, has_backpack, etc.) and was deployed as a dockerized Edge Application to our IoT Device. The data from the module was sent through the EdgeHub to the [MQTT publisher module](#mqtt-publisher-receiver).

``` python
from azure.iot.device import HubClient


```

## IoT Edge Device

In order to deploy the modules on the Azure Edge Platform we had to create a device on the DGIoTHub provided. Below you can see the configuration of the running device. This had all three modules running on it and the device itself was simulated on the development machine.

![WhatsApp Image 2021-05-30 at 16 10 57](https://user-images.githubusercontent.com/85012228/120105506-ddaca600-c161-11eb-9451-646e0c4507be.jpeg)

## Modules

### MQTT Publisher (receiver)

[![MQTT Video](https://user-images.githubusercontent.com/85012228/120103964-dfbf3680-c15a-11eb-8e70-ac28cab445c8.png)](https://youtu.be/YNCJL30d3t8?list=PLItZkaSiINE6jMAruIIjf6_oiqE7TI6m6)

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

[![Helmet-training](https://user-images.githubusercontent.com/85012228/120104030-2b71e000-c15b-11eb-88d3-3ffb658a9c1a.png)](https://youtu.be/p8nKQbGHa94?list=PLItZkaSiINE6jMAruIIjf6_oiqE7TI6m6)

### IoT Device Implementation

[![Helmet-training](https://user-images.githubusercontent.com/85012228/120104050-493f4500-c15b-11eb-8da3-23b309ddb22a.png)](https://youtu.be/XRuh1KX5Yr8?list=PLItZkaSiINE6jMAruIIjf6_oiqE7TI6m6)

## Visualization
### InfluxDB

![InfluxDB](https://user-images.githubusercontent.com/85012228/120104259-3da04e00-c15c-11eb-9fcf-8e0bb2b497b9.jpg)

### Grafana Daashboard

![Grafana](https://user-images.githubusercontent.com/85012228/120094459-26943880-c129-11eb-8d52-e0b5f2d89153.png)

#### Alerting system and notification channel 
<img width="1537" alt="Alerting-system" src="https://user-images.githubusercontent.com/85012228/120094492-5b07f480-c129-11eb-9662-55ec5f1d08e4.png">
<img width="1311" alt="Notification-Channel" src="https://user-images.githubusercontent.com/85012228/120094494-5d6a4e80-c129-11eb-8158-4bb207659b94.png">


