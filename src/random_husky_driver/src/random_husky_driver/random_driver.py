import rospy, tf
import geometry_msgs.msg, nav_msgs.msg
from math import *
from time import sleep
import random

def random_walk():
	rospy.init_node('random_husky_commands', anonymous=True)
	cmdmsg = geometry_msgs.msg.Twist()
	cmdpub = rospy.Publisher('husky_velocity_controller/cmd_vel', geometry_msgs.msg.Twist, queue_size=10)
	random.seed(10)
	r = rospy.Rate(10)
	while not rospy.is_shutdown():
		cmdmsg.linear.x = random.uniform(-2,2)
		cmdmsg.angular.z = random.uniform(-3,3)
		cmdpub.publish(cmdmsg)
		r.sleep()
	


