Face-Morphing
=============

Course project of CIS581: Computer Vision &amp; Computational Photography - 2013 Fall

**The codes produce a “morph” animation of one face/object into another face/object, implemented by two methods:** <br>
1. Triangulation<br>
2. Thin Plate Spline<br>


**This folder contains the source codes listed below:**<br>
1.funtions:<br>
&nbsp;&nbsp;&nbsp;&nbsp;click_correspondence.m<br>
&nbsp;&nbsp;&nbsp;&nbsp;delaunay_tri.m<br>
&nbsp;&nbsp;&nbsp;&nbsp;morph.m<br>
&nbsp;&nbsp;&nbsp;&nbsp;est_tps.m<br>
&nbsp;&nbsp;&nbsp;&nbsp;morph_tps.m<br>
&nbsp;&nbsp;&nbsp;&nbsp;morph_tps_wrapper.m<br>
<br>
2.test:<br>
&nbsp;&nbsp;&nbsp;&nbsp;test_script.m<br>
&nbsp;&nbsp;&nbsp;&nbsp;eval_project2.m<br>
&nbsp;&nbsp;&nbsp;&nbsp;zimengy_main.m<br>
<br>
in which eval_project2.m is the test script for image 'project2_testimg.png', which generates Project2_eval_tps.avi and Project2_eval_trig.avi<br>
zimengy_main.m is the test script for images 'image1' and 'image2', which is a morphing animation of my face into another person's face, and generates zimengy_trig.avi and zimengy_tps.avi<br>
control_points.mat is the control points used for image1 and image2<br><br>
**To use the codes, you could first produce control points with click_correspondence.m from your two images. And then substitute control_points.mat, image1, image2 in the folder, then run the main script.** 

Here's some interesting results of the codes:
<img src="https://raw.github.com/zimengy/Face-Morphing/master/hahaha.jpg" alt="GitHub" title="puma painting" width="100%" height="100%" />
<br>
Hope you will enjoy it!
