import cv2
import time


cap = cv2.VideoCapture(0)

while True:
    ret, img = cap.read()
    img = cv2.flip(img, -1)

    cv2.imshow("img", img)

    if cv2.waitKey(1) & 0xFF == 27:
        break

cap.release()
cv2.destroyAllWindows()
