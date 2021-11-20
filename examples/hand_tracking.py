# This is for junction2021 competetion - smart helmet project 
# we are going to help engineer to gather information during elevator maintanance, and using Google mediapipe solutions to find finger's landmarks and taking picture and then sending to database instance which is based on aiven platform. 
################################
import cv2
import mediapipe as mp


# define solutions
mp_draw = mp.solutions.drawing_utils
mp_hands = mp.solutions.hands

# define video capture(camera on raspberry pi) index default is 0
cap = cv2.VideoCapture(0)

# resize width, height
cap.set(3, 320)
cap.set(4, 240)

while True:
    # read frame from camera
    ret, frame = cap.read()

    # convert frame from BGR to RGB mode
    frame_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)

    # define hands instance
    hands = mp_hands.Hands(min_detection_confidence=0.5,
            min_tracking_confidence=0.5)

    # get hand from camera
    result = hands.process(frame_rgb)

    # check if the landmarks is available, if so, drawing landmarks .
    if result.multi_hand_landmarks:
        for lms in result.multi_hand_landmarks:
            mp_draw.draw_landmarks(frame, lms, mp_hands.HAND_CONNECTIONS)
    
    cv2.imshow("junction2021 Smart Helmet", cv2.flip(frame, -1))
    
    if cv2.waitKey(1) & 0xFF == 27:
        break

cap.release()
cv2.destroyAllWindows()
