# Scale-Space-Blob-Detector
Computer Vision and Image Processing

Homework 2 ∗ Scale-space blob detection

Instructor: Kevin R. Keane

TAs: Radhakrishna Dasari, Yuhao Du, Niyazi Sorkunlu

Due Date: October 18, 2017

The goal of the assignment is to implement a Laplacian blob detector as discussed in class.

Algorithm outline

1\. Generate a Laplacian of Gaussian filter.

2\. Build a Laplacian scale space, starting with some initial scale and going for n iterations:

(a) Filter image with scale-normalized Laplacian at current scale.

(b) Save square of Laplacian response for current level of scale space.

(c) Increase scale by a factor k.

3\. Perform nonmaximum suppression in scale space.

4\. Display resulting circles at their characteristic scales.

Test images

In the data directory of hw2.zip, there are four images to test your code, and sample output images for

your reference. Keep in mind, though, that your output may look different depending on your threshold,

range of scales, and other implementation details. In addition to the images provided, also run your code

on at least four images of your own choosing.

∗ Credit to Svetlana Lazebnik for this assignment.

1

Detailed instructions

- Don't forget to convert images to grayscale (rgb2gray command) and double (im2double).

- For creating the Laplacian filter, use the fspecial function (check the options). Pay careful attention

to setting the right filter mask size. Hint: Should the filter width be odd or even?

- It is relatively inefficient to repeatedly filter the image with a kernel of increasing size. Instead of

increasing the kernel size by a factor of k, you should downsample the image by a factor 1/k. In

that case, you will have to upsample the result or do some interpolation in order to find maxima in

scale space. For full credit, you should turn in both implementations: one that increases

filter size, and one that downsamples the image. In your report, list the running times for both

versions of the algorithm and discuss differences (if any) in the detector output. For timing, use tic

and toc commands.

Hint 1: Think about whether you still need scale normalization when you downsample the image

instead of increasing the scale of the filter.

Hint 2: For the efficient implementation, pay attention to the interpolation method you're using to

upsample the filtered images (see the options of the imresize function). What kind of interpolation

works best?

- You have to choose the initial scale, the factor k by which the scale is multiplied each time, and the

number of levels in the scale space. The initial scale is typically set to 2, and use 10 to 15 levels in the

scale pyramid. The multiplication factor should depend on the largest scale at which you want regions

to be detected.

- You may want to use a three-dimensional array to represent your scale space. It would be declared as

follows:

% h,w - dimensions of image,

% n - number of levels in scale space

scale_space = zeros(h,w,n);

Then scale space(:,:,i) would give you the ith level of the scale space. Alternatively, if you are

storing different levels of the scale pyramid at different resolutions, you may want to use a cell array,

where each "slot" "slot" can accommodate a different data type or a matrix of different dimensions.

Here is how you would use it:

scale_space = cell(n,1); %creates a cell array with n ''slots''

scale_space{i} = my_matrix; % store a matrix at level i

- To perform nonmaximum suppression in scale space, you should first do nonmaximum suppression in

each 2D slice separately. For this, you may find functions nlfilter, colfilt or ordfilt2 useful.

Play around with these functions, and try to find the one that works the fastest. To extract the final

nonzero values (corresponding to detected regions), you may want to use the find function.

- You also have to set a threshold on the squared Laplacian response above which to report region

detections. You should play around with different values and choose one you like best.

- To display the detected regions as circles, you can use the function show all circles in the code

directory of hw2.zip (or feel free to search for a suitable MATLAB function or write your own).

Hint: Don't forget that there is a multiplication factor that relates the scale at which a region is

detected to the radius of the circle that most closely "approximates" the region.

2

For extra credit

- Implement the difference-of-Gaussian pyramid as mentioned in class and described in David Lowe's

paper[3]. Compare the results and the running time to the direct Laplacian implementation.

- Implement the affine adaptation[4] step to turn circular blobs into ellipses as shown in class (just one

iteration is sufficient). The selection of the correct window function is essential here. You should use a

Gaussian window that is a factor of 1.5 or 2 larger than the characteristic scale of the blob. Note that

the lecture slides show how to find the relative shape of the second moment ellipse, but not the absolute

scale (i.e., the axis lengths are defined up to some arbitrary constant multiplier). A good choice for

the absolute scale is to set the sum of the major and minor axis half-lengths to the diameter of the

corresponding Laplacian circle. To display the resulting ellipses, you should modify my circle-drawing

function or look for a better function in the MATLAB documentation or on the Internet.

- The Laplacian has a strong response not only at blobs, but also along edges. However, recall from the

class lecture that edge points are not "repeatable". So, implement an additional thresholding step that

computes the Harris response[1] at each detected Laplacian region and rejects the regions that have

only one dominant gradient orientation (i.e., regions along edges). If you have implemented the affine

adaptation step, these would be the regions whose characteristic ellipses are close to being degenerate

(i.e., one of the eigenvalues is close to zero). Show both "before" and "after" detection results.

Helpful resources

- Sample Harris detector code is provided as function harris in the code directory of hw2.zip.

- Blob detection on Wikipedia.

- David G Lowe. Distinctive image features from scale-invariant keypoints. International Journal of

Computer Vision, 60(2):91--110, 2004. This paper contains details about efficient implementation of a

Difference-of-Gaussians scale space.

- Tony Lindeberg. Feature detection with automatic scale selection. International Journal of Computer

Vision, 30(2):79--116, 1998. This is advanced reading for those of you who are really interested in the

gory mathematical details.

- Krystian Mikolajczyk and Cordelia Schmid. Scale & affine invariant interest point detectors. Inter-

national Journal of Computer Vision, 60(1):63--86, 2004. This paper provides the details of affine

adaption for the second extra credit option.

Grading Checklist

You must turn in both your report and your code. Your report will be graded based on the following items:

1\. The output of your circle detector on all the images (four provided and four of your own choice), together

with a comparison of running times for both the "efficient" and the "inefficient" implementation. (The

comparison is graded, not the running times.)

2\. An explanation of any "interesting" implementation choices that you made.

3\. An explanation of parameter values you have tried and which ones you found to be optimal.

4\. Discussion and results of any extensions or bonus features you have implemented.

3

Instructions for Submitting the Assignment

Your submission should consist of the following:

- All your MATLAB code and output images in a single zip file with subdirectories matlab and output.

The filename should be

yourPersonNUmber hw2.zip.

- A brief report in a single PDF file with all your results and discussion. The filename should be

yourPersonNUmber hw2.pdf.

- The files will be submitted through UBlearns.

Multiple attempts will be allowed but by default, only your last submission will be graded. We reserve

the right to take off points for not following directions.

Late policy: You lose 50% of the points for every day the assignment is late. (Any genuine emergency

situations will be handled on an individual basis.)

Academic integrity: Feel free to discuss the assignment with each other in general terms, and to search

the Web for general guidance (not for complete solutions). Coding should be done individually. If you make

substantial use of some code snippets or information from outside sources, be sure to acknowledge the sources

in your report.

References

[1] Chris Harris and Mike Stephens. A combined corner and edge detector. In Alvey Vision Conference,

volume 15, pages 10--5244. Manchester, UK, 1988.

[2] Tony Lindeberg. Feature detection with automatic scale selection. International Journal of Computer

Vision, 30(2):79--116, 1998.

[3] David G Lowe. Distinctive image features from scale-invariant keypoints. International Journal of

Computer Vision, 60(2):91--110, 2004.

[4] Krystian Mikolajczyk and Cordelia Schmid. Scale & affine invariant interest point detectors. International

Journal of Computer Vision, 60(1):63--86, 2004
