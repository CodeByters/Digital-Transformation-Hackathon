
# Code Byters
#### Digital Transformation Hackathon 2021

We are a group of three passionate engineers that love to learn new skills. We have teamed up to develop an IoT Edge Application that uses computer vision to make the workplace safer for everyone. This is a brief description of our solution that outlines the different modules that made this application possible.

## Challenge & Solution

Our challenge was to use the Edge IoT platform to create a video analysis application for use in the workplace in different scenarios. Video analysis applications can be used to detect leaks, H&S violations, combustion patterns, etc.

For our solution we have applied computer vision concepts along with IoT solutions to develop different modules that run on an Edge IoT device. These modules included an [object detection module](#object-detection) that monitors people, cars and animals in a video feed. It also included an [MQTT publisher module](#mqtt-publisher-receiver) that uses the **Agora SDK** to collect data from other modules and send them on an MQTT channel. Lastly, we trained a [helmet detection model](#trainig-the-model-using-yolo-v5) to monitor H&S in the workplace. We deployed it to the device and linked it to a [live camera feed](#iot-device-implementation).

These modules were setup to run on the Edge Device on a **virtual machine running ubuntu 20** due to the requirements of the code. This was set up on a windows machine and all the prerequisites were installed on the machine to run the modules and the device.

All the collected data was sent through MQTT and Node-Red to InfluxDB cloud and then injested into Grafana for visualisation. A demo of all the modules being visualised can be seen below:

[![final-demo](https://user-images.githubusercontent.com/85012228/120103786-0a5cbf80-c15a-11eb-8907-893b20bc605a.png)](https://youtu.be/s8Ydi4YPymU?list=PLItZkaSiINE6jMAruIIjf6_oiqE7TI6m6)

Below is a block diagram showing the complete solution with the different modules deployed on the IoT device.

![flow-chart](https://user-images.githubusercontent.com/85012228/121373898-1f023a00-c948-11eb-9ab9-c372881ff19c.png)

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

The device used the MQTT standard to send the data to external sources. The "receiver" module used the **Agora SDK** collected the data from the other modules through the EdgeHub and then send the data on different topics to the MQTT broker running on the local machine. This was processed using Node-Red and sent to a cloud bucket on InfluxDB.

The video below shows the setup of the **Agora SDK** Environment and the development and running of the module includeing the MQTT Broker, Node-Red and InfluxDB.

[![MQTT Video](https://user-images.githubusercontent.com/85012228/120103964-dfbf3680-c15a-11eb-8e70-ac28cab445c8.png)](https://youtu.be/YNCJL30d3t8?list=PLItZkaSiINE6jMAruIIjf6_oiqE7TI6m6)

Below is a code snippet for the main logic inside the module:

```python
import paho.mqtt.client as mqtt

client = mqtt.Client()
client.on_connect = on_connect
client.on_message = on_message

client.connect("172.17.0.1", 1883, 60)
client.loop_start()

def on_connect(client, userdata, flags, rc):
    logging.debug("Connected:" + str(rc))
    client.subscribe($SYS/#")
    
def on_message(client, userdata, msg):
    logging.debug(msg.topic + " " + str(msg.payload))
    
if SrcModule == "videoAnalysisModule":
    client.publish("det/object", payload)
elif SrcModule == "helmetDetection":
    client.publish("det/helmet", payload)
```

## Helmet Detection

The development of this module oncluded collecting a dataset, training the custom model, dockerizing the application and deploying to the Edge Device and linking it to a live camera feed.

### Trainig the model using Yolo-v5
The trainig is based on the [YOLOv5 repository](https://github.com/ultralytics/yolov5) by [Ultralytics](https://www.ultralytics.com/), and it is inspired by [PeterH0323](https://github.com/PeterH0323/Smart_Construction) 

Dataset is downloaded from [nuvisionpower](https://github.com/njvisionpower/Safety-Helmet-Wearing-Dataset) and transformed into the required format using [Roboflow](https://roboflow.com/)

Follow this link to view the training on [Code byters COLAB](https://colab.research.google.com/drive/1xCgBS7XCsMftAK2gccdvB4Gsx4K5APZX?usp=sharing)

#### Steps Covered in the training

* Install YOLOv5 dependencies
* Download custom YOLOv5 object detection data
* Write YOLOv5 Training configuration
* Run YOLOv5 training
* Evaluate YOLOv5 performance
* Visualize YOLOv5 training data
* Run YOLOv5 inference on test images
* Export saved YOLOv5 weights for future inference
* Run detection code on local device using custom weight

[![Helmet-training](https://user-images.githubusercontent.com/85012228/120104030-2b71e000-c15b-11eb-88d3-3ffb658a9c1a.png)](https://youtu.be/nJqgFT8EmWM?list=PLItZkaSiINE6jMAruIIjf6_oiqE7TI6m6)

### IoT Device Implementation

The code could use the model and detect whether a person is wearing a helmet or not in a video file. This was first modyfied to use the webcam on the laptop as a live camera feed. This was analysed by the program and an output live feed could run showing the result. The program was then dockerised in order for us to be able to run it on the Edge Device. A pytorch docker base was used and requirements installed and the code was run inside the container. The docker image was pushed to the local registry and ran on an Edge module.

In order to give access to the webcam from inside the docker container the Container Create Options had to be correctly set up on the Edge module as seen below.

```
{
  "HostConfig": {
    "Devices": [
      {
        "PathOnHost": "/dev/video0",
        "PathInContainer": "/dev/video0",
        "CgroupPermissions": "mrw"
      }
    ]
  }
}
```

[![Helmet-demo](https://user-images.githubusercontent.com/85012228/120104050-493f4500-c15b-11eb-8da3-23b309ddb22a.png)](https://youtu.be/XRuh1KX5Yr8?list=PLItZkaSiINE6jMAruIIjf6_oiqE7TI6m6)

## Visualization
### InfluxDB

The data was collected from the different modules theough the EdgeHub and sent to influxdb on the cloud. Influxdb is a realtime timeseries database that is widely uused in IoT applications. Using the cloud allowed us to visualize the data on any device and not just the development device.

![InfluxDB](https://user-images.githubusercontent.com/85012228/120104259-3da04e00-c15c-11eb-9fcf-8e0bb2b497b9.jpg)

### Grafana Daashboard

We created a dashboard on Grafana for data visualization and monitoring. The data source is configured to import real time data from Influx DB. This dashboard has three main sections that are used to monitor differernt helath and safety conditions :
  1. Helmet Detection: used to monitor if the personas in workplace are wearing proper PPE or not, an alert will be creatd and sent to the manager when the HSE rule is violated.
  1. Workplace Monitoring: This monitored the number of people and car in the workplace and was used mainly to limit the number of people in an area and alert when this is violated.
  1. Vehicle Monitoring: The same model was used to restrict an area and allow no vehicles in it. Again, an alert was triggered when a vehicle enters the area.

![Grafana](https://user-images.githubusercontent.com/85012228/120094459-26943880-c129-11eb-8d52-e0b5f2d89153.png)

## Alerting system and notification channel

Below you can see the different alerts that can be seen on the alerts panel on Grafana. An email is sent whenever a violation occurs to notify the adimns.

![Visualization](https://user-images.githubusercontent.com/85012228/121374658-be273180-c948-11eb-9531-847462d31170.png)
