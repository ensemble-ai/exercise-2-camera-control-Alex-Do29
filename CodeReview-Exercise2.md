# Peer-Review for Programming Exercise 2 #

## Description ##

For this assignment, you will be giving feedback on the completeness of assignment two: Obscura. To do so, we will give you a rubric to provide feedback. Please give positive criticism and suggestions on how to fix segments of code.

You only need to review code modified or created by the student you are reviewing. You do not have to check the code and project files that the instructor gave out.

Abusive or hateful language or comments will not be tolerated and will result in a grade penalty or be considered a breach of the UC Davis Code of Academic Conduct.

If there are any questions at any point, please email the TA.   

## Due Date and Submission Information
See the official course schedule for due date.

A successful submission should consist of a copy of this markdown document template that is modified with your peer review. This review document should be placed into the base folder of the repo you are reviewing in the master branch. The file name should be the same as in the template: `CodeReview-Exercise2.md`. You must also include your name and email address in the `Peer-reviewer Information` section below.

If you are in a rare situation where two peer-reviewers are on a single repository, append your UC Davis user name before the extension of your review file. An example: `CodeReview-Exercise2-username.md`. Both reviewers should submit their reviews in the master branch.  

# Solution Assessment #

## Peer-reviewer Information

* *name:* Tim Dela Cruz 
* *email:* eedelacruz@ucdavis.edu

### Description ###

For assessing the solution, you will be choosing ONE choice from: unsatisfactory, satisfactory, good, great, or perfect.

The break down of each of these labels for the solution assessment.

#### Perfect #### 
    Can't find any flaws with the prompt. Perfectly satisfied all stage objectives.

#### Great ####
    Minor flaws in one or two objectives. 

#### Good #####
    Major flaw and some minor flaws.

#### Satisfactory ####
    Couple of major flaws. Heading towards solution, however did not fully realize solution.

#### Unsatisfactory ####
    Partial work, not converging to a solution. Pervasive Major flaws. Objective largely unmet.


___

## Solution Assessment ##

### Stage 1 ###

- [X] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
All that's needed is the one line of code, and that's exactly what they have, works perfectly as intended!

___
### Stage 2 ###

- [ ] Perfect
- [ ] Great
- [ ] Good
- [X] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
While the box is moving, the player doesn't keep up with the camera having to move the character myself. It stays in the box but in most schmups, the player doesn't have to move the vessel
themselves to "keep up" with the box. If you were to switch to the autoscroll camera, then switch off to the next camera and move somewhere else, then switch back to the autoscroll camera,
the vessel is teleported to where the autoscroll camera once was instead of starting where the player is at. This also leads to bugs where, depending on the location of the vessel and the
dimensions of the box, the vessel constantly jitters on the outside sides of the box instead of being in the box (this is also a result of how they did their math). The default dimensions 
of the vectors make the camera work, but changing the top_left and bottom_right dimensions causes these issues.

___
### Stage 3 ###

- [ ] Perfect
- [X] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Instead of the camera "starting" right at where the vessel is, it "spawns in" at the origin of the world and then quickly snaps to where the vessel currently is. Otherwise, the camera works
as intended, camera keeps up during hyper-speed, and changing the values of follow speed work perfectly! However, I'm not sure if we were allowed to use the actual lerp function, or if we 
had to implement our own version of it. Either way, works well!

___
### Stage 4 ###

- [ ] Perfect
- [X] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Similar to past stage, the camera has to spawn in at origin and then snap to the vessel when switching to this camera. The actual movement of the camera works perfectly, with the lead_speed 
being affected by the leash distance and the catchup_speed only triggering once the catchup_delay_duration is complete. The only thing is that when boosting the camera doesn't stay in front 
of the vessel if the camera_lead speed isn't fast enough.

___
### Stage 5 ###

- [ ] Perfect
- [] Great
- [X] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The way they implimented their exported values for the boxes was kinda weird since they have both axis' for the top_left positions of both boxes to be negative, which isn't where it visually
would be in the actual world. The vessel doesn't properly stay at the edge of the other sides and will either clip past the line, or be slighlty short of the line. Along with this, the vessel 
doesn't obey the outside box and will sometimes get past it (this happened when setting the pushbox_top_left to Vector2(-10, -5)), and doesn't stay properly adjust to just be inside of the 
small box. The vessel also moves past the outside box when boosting. The top and bottom halfs of the inside box don't feel properly implemented as the speed raio in the top and bottom halfs
differs from the speed of the left and right sides.
___
# Code Style #


### Description ###
Check the scripts to see if the student code adheres to the GDScript style guide.

If sections do not adhere to the style guide, please peramlink the line of code from Github and justify why the line of code has not followed the style guide.

It should look something like this:

* [description of infraction](https://github.com/dr-jam/ECS189L) - this is the justification.

Please refer to the first code review template on how to do a permalink.


#### Style Guide Infractions ####
This was technically an infraction that Josh committed, however the line for creating a mesh_instance is past 100 characters, and is like this for each of their cameras. 
This specific link is for the lerp_camera script, but shows up in the other cameras as well. 
https://github.com/ensemble-ai/exercise-2-camera-control-Alex-Do29/blob/58acfb7c1c2dde901fd52d38922ab00b24de833a/Obscura/scripts/camera_controllers/lerp_camera.gd#L67

That said, the coder also commited this infraction when creating a variable for the mario camera. 
https://github.com/ensemble-ai/exercise-2-camera-control-Alex-Do29/blob/58acfb7c1c2dde901fd52d38922ab00b24de833a/Obscura/scripts/camera_controllers/speed_up_push_zone.gd#L26

#### Style Guide Exemplars ####
Despite the other infractions, they made sure to stay under the line limit in their lerp_focus camera while still keeping the code formatted nicely!
https://github.com/ensemble-ai/exercise-2-camera-control-Alex-Do29/blob/58acfb7c1c2dde901fd52d38922ab00b24de833a/Obscura/scripts/camera_controllers/lerp_focus_camera.gd#L34
___
#### Put style guide infractures ####
I'll just put the links of the infractions here as well I guess?
https://github.com/ensemble-ai/exercise-2-camera-control-Alex-Do29/blob/58acfb7c1c2dde901fd52d38922ab00b24de833a/Obscura/scripts/camera_controllers/lerp_camera.gd#L67
https://github.com/ensemble-ai/exercise-2-camera-control-Alex-Do29/blob/58acfb7c1c2dde901fd52d38922ab00b24de833a/Obscura/scripts/camera_controllers/speed_up_push_zone.gd#L26
___

# Best Practices #

### Description ###

If the student has followed best practices then feel free to point at these code segments as examplars. 

If the student has breached the best practices and has done something that should be noted, please add the infraction.


This should be similar to the Code Style justification.

#### Best Practices Infractions ####
There are a couple of comments to help organize/understand the code, however they also left print statements for debugging in their scripts.
https://github.com/ensemble-ai/exercise-2-camera-control-Alex-Do29/blob/58acfb7c1c2dde901fd52d38922ab00b24de833a/Obscura/scripts/camera_controllers/lerp_camera.gd#L34

They also have incomplete/missing comments just left in the script.
https://github.com/ensemble-ai/exercise-2-camera-control-Alex-Do29/blob/58acfb7c1c2dde901fd52d38922ab00b24de833a/Obscura/scripts/camera_controllers/auto_scroll_camera.gd#L50

There are also a lot of unused nodes, having 3 push_box cameras that were still a part of the camera controller (not sure I can "link" that when that's something more part of
the actual godot project, and less an actual script)

Finally, althought their math for their cameras somewhat worked, having the "wrong sign" for where the positon should visually be in is kinda janky, despite accounting for that
in their math/code. Specifically, when you think of "top_left", your brain would think "go left (negative) in the x-axis, and go up (positive) in the y axis. However, in their
exported variable for pushbox_top_left in their mario camera, they have both axis' as negative.
https://github.com/ensemble-ai/exercise-2-camera-control-Alex-Do29/blob/58acfb7c1c2dde901fd52d38922ab00b24de833a/Obscura/scripts/camera_controllers/speed_up_push_zone.gd#L5

Also a similar problem in their auto scroll camera when defining their exported variables.
https://github.com/ensemble-ai/exercise-2-camera-control-Alex-Do29/blob/58acfb7c1c2dde901fd52d38922ab00b24de833a/Obscura/scripts/camera_controllers/auto_scroll_camera.gd#L4

#### Best Practices Exemplars ####
For the lerp camera they created (and properly named) a private function "_follow_vessel" to help orgranize their code for the lerp camera.
https://github.com/ensemble-ai/exercise-2-camera-control-Alex-Do29/blob/58acfb7c1c2dde901fd52d38922ab00b24de833a/Obscura/scripts/camera_controllers/lerp_camera.gd#L24

Althought not having comments, I was able to follow along with their code's logic as their code wasn't lengthy via the use their function and having well named variables 
like "frame_pos" for the camera! I personally didn't use variables as much making for lengthier code that might be harder to read despite comments clarifying what was going
on, so I thought this was worth mentioning! TLDR; I liked how they organized their code haha
https://github.com/ensemble-ai/exercise-2-camera-control-Alex-Do29/blob/58acfb7c1c2dde901fd52d38922ab00b24de833a/Obscura/scripts/camera_controllers/lerp_camera.gd#L30
