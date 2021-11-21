# This is for junction2021 competetion - smart helmet project 
# we are going to help engineer to gather information during elevator maintanance, and using Google mediapipe solutions to find finger's landmarks and taking picture and then sending to database instance which is based on aiven platform. 
################################
import cv2
import mediapipe as mp
import requests


# define solutions
mp_draw = mp.solutions.drawing_utils
mp_hands = mp.solutions.hands

# define server ip address and port
HOST = "http://192.168.77.47:3000"

# define video capture(camera on raspberry pi) index default is 0
cap = cv2.VideoCapture(0)

# resize width, height
cap.set(3, 1024)
cap.set(4, 768)

bg = 0

while True:
    # read frame from camera
    ret, frame = cap.read()

    # convert frame from BGR to RGB mode
    frame_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)

    # define hands instance
    hands = mp_hands.Hands(min_detection_confidence=0.5, min_tracking_confidence=0.5)

    # get hand from camera
    result = hands.process(frame_rgb)

    # check if the landmarks is available, if so, drawing landmarks .
    if result.multi_hand_landmarks:
        for lms in result.multi_hand_landmarks:
            for idx, lm in enumerate(lms.landmark):
                h, w, c = frame.shape
                cx, cy = int(lm.x*w), int(lm.y*h)
                if idx == 8:
                    feed = cv2.rectangle(frame, (cx, cy), (cx+550, cy+550),(0, 0, 255), 32)
                    cv2.imwrite("sample.jpg", feed)

                    bg = cv2.rectangle(frame,(0,0), (1024, 768), (255,255,255), cv2.FILLED)
                    cv2.rectangle(bg, (cx, cy), (cx+150, cy+150),(0, 0, 255), 2)
                    # mp_draw.draw_landmarks(frame, lms, mp_hands.HAND_CONNECTIONS)
                    params = {"engineer_id": "1", "case_name": "Problem Position",  "elevator_tag": "ELEVATOR_002", "description": "Out of Service"}
                    r = requests.post("{}/service/create_case".format(HOST), params) 
                    print(r.text)

                    files = {"photo": open("sample.jpg", "rb")}
                    params = {"case_name": "Problem Position", "label":"Cable broken", "description": "Blue cable "}
                    r = requests.post("{}/service/create_problem".format(HOST), params, files=files)
                    print(r.text)
    
    if cv2.waitKey(1) == ord('q'):
        break
    # frame = cv2.flip(frame, -1)
    cv2.imshow("junction2021 Smart Helmet", bg)

cap.release()
cv2.destroyAllWindows()
