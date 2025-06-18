<div align="center">
   <h1>OMNI-DRONE FLIGHT SYSTEM</h1>
</div>
<p>The Omni-Drone Flight System is an open-source Lua based framework-library for creating Omni-Drones in Modded Minecraft.

</br>[Valkyrien Skies 2 (VS2)](https://modrinth.com/mod/valkyrien-skies) is a Minecraft Mod that turns player-built structures into physics objects. With it is a growing army of [addons](https://wiki.valkyrienskies.org/wiki/List_of_addons) that "add" stuff to make them fly among other things. Coupled with [ComputerCraft (CC)](https://modrinth.com/mod/cc-tweaked) we can achieve stable omnidirectional flight.

</br>Visit their discord servers: ([VS2](https://discord.gg/aWeNDCUTS6), [CC](https://discord.gg/dRTtrdK)) to learn more.

</br>
Some cool stuff about the library that I think is worth mentioning:

<ul>
   <li>
      Support For Varried Flight Components
      <p>
         - This flight system was originaly meant to exclusively use redstone thrusters but, Valkyrien Skies has a growing number of sub-mods. Most of them add different kinds of flight components to the game ranging from propellers, rotors and cola-rockets to ion-thrusters, jet engines and magic wands. This framework is meant to cater to a number of these components to let players build with more than just redstone thrusters. 
      </p>
   </li>
   <li>
      <b>Pulse Width Modulation</b>
      <p> 
         - When using Redstone controlled thrusters for propulsion, the system uses PWM Redstone signals to have finer control over the thrusters. Redstone only operates in integer values ranging from 0 to 15, making it very difficult to have precise thrust vectoring without modulating the signals.
      </p>
   </li>
         
   <li>
      <b>Thrust Vectoring</b>
      <p>
         - The system uses thrust vectoring techniques to allow omnidirectional flight. The net thrust of all the onboard thrusters controls the aircrafts position and orientation in space.
      </p>
   </li>
   <li>
      <b>Automatic Jacobian Matrix Construction</b>
      <p>
         - Here, a Jacobian matrix is used to map the needed net force and torque to the individual onboard thrusters' force and torque values to control the aircraft. I've made it so the system would build the matrix for you from a list of onboard active thrusters. 
      </p>
   </li>
   <li>Swappable <b>Feedback Controllers</b>:
      <p>
         - A feedback control loop is used to achive precise control over the aircraft's flight behaviour. I've mostly used P.I.D. controllers for the time being. Though, I've made it so that the framework allows the users to easily swapout the default controller with any feedback controller they might need or want.
      </p>
      <ul>
         <li>
            <b>PID Controllers</b>
            <p>
               - Proportional, Integral and Derivative feedback control is considered one of the simplest and widely used control loops in control systems. Here, I demonstrate the use of two of its most common forms:
            </p>
            <ul>
               <li>
                  Continuous
                  <p>
                  - I used a continuous implementation of a PID controller when I started out building this library. It's meant to sample error values in a continuous time domain. That means it needs smooth frame rates to work. When I started moving out of the test phase and into a laggy game server, I had to use a discrete PID controller.
                  </p>
               </li>
               <li>
                  Discrete
                  <p>
                  - While not as accurate as continuous PID controllers, this can adapt to changing sample time intervals. This makes it more suitable for laggy PVP servers.
                  </p>
               </li>
            </ul>
         </li>
         <li>
            More Feedback Controllers To Be Added
            <p>
            - I plan to implement <b>full-state feedback controllers</b> like <b>LQR and LQG</b> in the future.
            </p>
         </li>
      </ul>
   </li>
   <li>
      <b>Quaternion</b> Orientation
      <p>
         - Instead of using Euler angles, I use quaternions to measure aircraft rotation errors. This helps to avoid gimbal lock and have the ship turn smoother. 
      </p>
   </li>
   <li>
      <b>Inertia Tensors</b>
      <p>
         - PID controllers would usually be enough to control rotation by themselves, but setting the gains too often gets repetitive whenever the player changes the aircrafts form and weight distribution either while building or in combat. Though, unrealistic in the real world, including the complete unsymetrical inertia tensor in the control loop's plant model made it possible for the aircraft to adapt to structural changes in real time:
         <div align="center">
            </br>
            (The pictures are linked to videos, click on'm!)
            </br>
            <a href="https://youtu.be/Kqf0vo2cnQA?si=FZWUhKSWGSw9sOlh"><img src="https://github.com/user-attachments/assets/0d73e731-f94c-417a-93f8-48bfdaf2e32e" width=500></a>
         </div>
      </br> In earlier versions of the mod, I had to calculate the inertia tensor <a href="https://github.com/19PHOBOSS98/TILT_SHIP_MINECRAFT_SCHEMATIC_INERTIA_TENSOR_CALCULATOR">myself</a> from point cloud data (minecraft structure schematics).
      </p>
   </li>
   
   
   
   
</ul>

</p>
<div align="center">
   <h1>OMNI-DRONES</h1>
</div>

<div align="center">
   
   <p>Formerly known as <a href="https://github.com/19PHOBOSS98/TILT-SHIP-FRAMEWORK-FOR-VALKYRIEN-SKIES-2-AND-COMPUTERCRAFT">Tilt-Ships</a>, are semi-autonomous flying platforms with omnidirectional flight capabilities.
   
   </br> I took inspiration from Lockheed Martin's MKV demonstrations:
   
   <a href="https://youtu.be/_CwcQoTN4Tc?si=o4Gecc5YxzVWgUeG"><img src="https://github.com/user-attachments/assets/fd9bffbb-cd10-46e3-a328-5644d479752f" width=500></a>
   
   </br> I've mostly been using them as personal mobile weapons platforms:</p>
   <picture><img src="https://github.com/19PHOBOSS98/Mirage/assets/37253663/13752a40-b78b-4fd7-8433-c0f8ebf0710f" alt="divider180"></picture>
   <a href="https://youtu.be/V3nzxjTneVU?si=be4u1V4W7EaugcCa"><img src="https://github.com/19PHOBOSS98/VS2-SKY-LEVIATHANS/assets/37253663/2e28fdbd-9965-4669-9bbd-1f08b847e4fb" width=500></a>
   <a href="https://youtu.be/taD_ttDTe9o?si=I5Tb_lHbId45Q35O"><img src="https://github.com/19PHOBOSS98/VS2-SKY-LEVIATHANS/assets/37253663/7389152f-4932-49b3-94f5-349fe4b60b19" width=500></a>
   <a href="https://youtu.be/6bWQAPWenPQ?si=adP8IJIbNb8YkUDD"><img src="https://github.com/19PHOBOSS98/VS2-SKY-LEVIATHANS/assets/37253663/bb6d2b99-0aec-4507-bb44-dccc4fbd2111" width=500></a>
   <a href="https://youtu.be/SlBE66_YH5s?si=0GAqMIa5j-sWAy26"><img src="https://github.com/19PHOBOSS98/VS2-SKY-LEVIATHANS/assets/37253663/00cbd227-77a3-45d5-a33a-6859a0bfdf3a" width=500></a>
   <picture><img src="https://github.com/19PHOBOSS98/Mirage/assets/37253663/dd711759-589a-4317-a82f-671ab45baf45" alt="divider"></picture>
   
</div>

<div align="center">
   <p>But I chillout sometimes:</p>
   <picture><img src="https://github.com/19PHOBOSS98/Mirage/assets/37253663/13752a40-b78b-4fd7-8433-c0f8ebf0710f" alt="divider180"></picture>
   <a href="https://youtu.be/XAGlgm_46qY"><img src="https://github.com/19PHOBOSS98/VS2-SKY-LEVIATHANS/assets/37253663/efd321a6-02b6-4e3f-b955-5c71b814307d"  width=1000 alt="yt"></a>
   <a href="https://youtu.be/V5mmxK4O3HE?si=v8nPOR1zxZWqaxC6"><img src="https://github.com/19PHOBOSS98/VS2-SKY-WHALES/assets/37253663/d5f47755-08ed-49e0-9e88-3532d6404a50" width=1000 alt="yt"></a>
   <a href="https://youtu.be/tyDpnHnf88o"><img src="https://github.com/user-attachments/assets/44a5f1a9-82ee-4f0f-a2d2-9ddb9073cdfd"  width=1000 alt="yt"></a>
   <picture><img src="https://github.com/19PHOBOSS98/Mirage/assets/37253663/dd711759-589a-4317-a82f-671ab45baf45" alt="divider"></picture>
</div>

<div align="center">
   <p>Valkyrien Skies 2 has a lot of addons that add their own flight components ranging from ion thrusters to magic wands. 
   </br>The Omni-Drone library includes "DroneBaseClasses" specifically written to utilize these components in building Omni-Drones:</p>
   <picture><img src="https://github.com/19PHOBOSS98/Mirage/assets/37253663/13752a40-b78b-4fd7-8433-c0f8ebf0710f" alt="divider180"></picture>
   <a href="https://youtu.be/DYyF5lNlUgc"><img src="https://github.com/user-attachments/assets/59e0e4c1-9de3-475c-969a-a0817d342837"  width=1000 alt="yt"></a>
   <a href="https://youtu.be/MWgLyscnf6s"><img src="https://github.com/user-attachments/assets/e4f6c0cd-0ee6-4fed-bc67-2aa8e7d94fcd"  width=1000 alt="yt"></a>
   <a href="https://youtu.be/yQ7BXQkKIRI"><img src="https://github.com/user-attachments/assets/ea855ed3-1675-4a24-87b3-288c7f5b9007"  width=1000 alt="yt"></a>
   <picture><img src="https://github.com/19PHOBOSS98/Mirage/assets/37253663/dd711759-589a-4317-a82f-671ab45baf45" alt="divider"></picture>
</div>

<div align="center">
   
   <picture><img src="https://github.com/19PHOBOSS98/Mirage/assets/37253663/13752a40-b78b-4fd7-8433-c0f8ebf0710f" alt="divider180"></picture>
   <picture><img src="https://github.com/19PHOBOSS98/Mirage/assets/37253663/2f062bd9-d8cd-4425-8bcb-00096ee885e6" alt="krakenemblem"></picture>
   <a href="https://www.youtube.com/channel/UCmdUkIr-zCxO9CvOLxeSzlg"><img src="https://github.com/19PHOBOSS98/Mirage/assets/37253663/eaed673b-eda2-43b7-9312-60868037690a" alt="yt"></a>
   
   <picture><img src="https://github.com/19PHOBOSS98/Mirage/assets/37253663/dd711759-589a-4317-a82f-671ab45baf45" alt="divider"></picture>
</div>

## GETTING STARTED

Omni-Drones are mostly known for using [VS+Tournament](https://modrinth.com/mod/vs-tournament) thrusters but there are other Valkyrien Skies addons that the Omni-Drone system can use to fly your ship!
It is a bit complicated for beginners to setup an omni-drone using VS+Tournament so let's get you started using [VS+Kontraption](https://modrinth.com/mod/kontraption) instead!

You can follow the [tutorial series](https://youtube.com/playlist?list=PL1bsn0MYd0U66LAyrpklsqIQDQLFjEzH0&si=2GKLiGcCHLSxidNb) at my YT channel to learn more.

<a href="https://youtu.be/scK8bXvlTRU"><img src="https://github.com/user-attachments/assets/6c3aa62f-4617-4bf0-97da-efd5640ee0fd" width=1000></a>

Here's also a [playlist](https://youtube.com/playlist?list=PL1bsn0MYd0U4KVn1mPNpDMmZBm6LGZzIw&si=p_5jTw0TJzlFv06-) of what I have of the system so far.


## SETTING UP

### MODPACK DOWNLOAD
   You can get the modpack [here](https://www.planetminecraft.com/project/omni-drone-tutorial-part-4-world-save/).

### BUILDING A KONTRAPTION SHIP
  You can watch this [Mod Showcase about VS+Kontraption](https://youtu.be/XC42jOs6OnY?si=RifRivF0EY3qWojl) to learn how it works.

  Keep track of how many ION thrusters you have facing in each cardinal direction. This will be important later in programming our turtle.
  
  #### Make sure to place the "Ship Controller" facing your ship's positive X direction (EAST).
  Before assembling your structure as a ship, you need to keep track of where EAST is. Face that direction and place your Ship Controller block on your ship. This is what your turtle pilot will use to fly your ship.

### SETTING UP THE OMNI-DRONE CODE
   After downloading this repo thru the green button above and unziping it, you might notice that the `OMNI-DRONES/CC_TURTLE_PILOT/lib` is empty. That's because it's in it's own github repo. You need to download the [OMNI-DRONE-LUA-LIBRARY](https://github.com/19PHOBOSS98/OMNI-DRONE-LUA-LIBRARY) separately.
   Unzip that as well and throw the contents in the lib folder.
   
   If you are a git bash user, you should be able to get all of them in one go using the git clone command.

### SETTING UP COMPUTERCRAFT TURTLE PILOT
   Each Computercraft (CC):Computer/Turtle has its own `computer_id`. Each time you write a lua script on a  CC:computers/turtles, it gets saved in `[worldsave_folder]/computercraft/computer/[computer_id]`.
   If you are playing in a fresh new world, the computercraft folder usually starts out empty. It will stay empty until you create a file in one of the computers/turtles on your world.
   We can get the mod to generate the computer folder for us by creating a file. Type `edit [arbitray_file_name_here]` to create one and save it.
   or we can just visit the `computercraft` folder and create it ourselves.
   
   1. Computercraft (CC) adds a robot called a "turtle". This will be our omni-drone's "pilot". Place one down next to your Ship Controller so we can start programming it to fly the drone.
   2. Turn on your turtle. Type "id" and press enter to get its computer ID.
   3. Go to your world save folder and drop the contents of the `CC_TURTLE_PILOT` folder into your turtle's computer folder: `[worldsave_folder]/computercraft/computer/[computer_id]`. If the turtle's computer folder is not there yet, create one.

### PREPING THE CODE
   #### startup.lua
   In our turtle's computer folder edit the `startup.lua` script using your favourite text editor.
   Our turtle runs this script whenever it wakes up or restarts. This script, in turn, runs a `firmwareScript.lua` file.
   I've prepared a few sample firmwareScripts that you can use as you might have noticed. Since our ship is running on Kontraption. Edit `startup.lua` to run the `firmwareScript_Kontraption.lua`:
   ```
   ...
   shell.run("firmwareScript_Kontraption.lua")
   ...
   ```
   Now each time we need to change our code we just need to restart the drone by hitting its red power button. 

   #### firwareScript_Kontraption.lua
   We next need to edit our `firwareScript_Kontraption.lua` file. This is where your pilot's heart is written : )

   We need to tell it how many ion thrusters our ship is using thru the instance configs:
   `instance_configs > ship_constants_config > ION_THRUSTERS_COUNT`
   Remember +X is east, +Z is south and +Y is up.

### MOVING, TURNING AND SEQUENCING
   We can tell the drone where and how to move thru the `customFlightLoopBehavior` function. 
   Pick a coordinate (XYZ) in your world and type in those coordinates to set the drone's `target_global_position` variable:
   
```
...
self.target_global_position = vector.new(X,Y,Z)
...
```
   
   To learn more on how to use it follow this section of this [tutorial video](https://youtu.be/UjBYnDKEcdQ?si=ytZQRVUE_gKhOeR7&t=325). I know the video is outdated but the parts between 5:25 and 10:31 are still relevant in making it move and stuff:
   
   [POSITIONING](https://youtu.be/UjBYnDKEcdQ?si=MszuQ6OCrB3relZS&t=326)
   
   [DISTANCE MEASURING](https://youtu.be/UjBYnDKEcdQ?si=b0LDGcHqrKWo73Kz&t=376)
   
   [ROTATION](https://youtu.be/UjBYnDKEcdQ?si=aTY2puQDIxiEvRGk&t=429)
   
   [SEQUENCING ACTIONS](https://youtu.be/UjBYnDKEcdQ?si=_8k38H5ehNus8lYZ&t=530)

### FLY!
   Once you are happy with your changes in fligth behavior, we can now start flying. Just restart the turtle pilot. If everything goes well it should start flying to the coordinates you've set it to go. 
   
Add remote controls, swap to tournament, learn how to tame a Hound Turret! but most importantly, have fun :) 
   
