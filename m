Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C9227A6A6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 06:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgI1EnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 00:43:06 -0400
Received: from cmta16.telus.net ([209.171.16.89]:35234 "EHLO cmta16.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbgI1EnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 00:43:06 -0400
Received: from [192.168.20.38] ([209.89.189.71])
        by cmsmtp with SMTP
        id Ml0Akg3yNjZ98Ml0Bk0TOL; Sun, 27 Sep 2020 22:43:03 -0600
X-Telus-Authed: Z2lsbGI0
X-Authority-Analysis: v=2.4 cv=RrsAkAqK c=1 sm=1 tr=0 ts=5f7169d8
 a=lXP6RixAJDH2mbiCOq84ew==:117 a=lXP6RixAJDH2mbiCOq84ew==:17
 a=IkcTkHD0fZMA:10 a=PSyD-g9mAAAA:8 a=aR16PxjQAAAA:8 a=zOZrIaTg6BG2q1aj_QIA:9
 a=QEXdDO2ut3YA:10 a=0Ls0ismJgpSOqONfKPYe:22 a=zbFvvTOBjyH4ze5LlUjX:22
To:     linux-kernel@vger.kernel.org
From:   bob <gillb4@telusplanet.net>
Subject: nouveau in kernel v5.9-rc7
Message-ID: <db2e72e4-48bc-48c0-0f83-de0f731163b3@telusplanet.net>
Date:   Sun, 27 Sep 2020 22:43:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CMAE-Envelope: MS4xfPm6qBP8WZ66UvXCUcSrHRvpKZn9bB0080+Jv3Hm4IlUwGWkMoN30j+puRGqMSouOsYRPbQ8ZyCqLwNVY0l5eB43J6IjB7qyxCBT+CpPHBcJ0TiZg3dX
 BM/IPItEiFUHCPqYCsPhkyoqKdiax99PX08qV/hCm3wXMLFoSqDCjzCsUJxKHmSKdLY8KMOKbr4RS8dGGTMkZz9wgyKnMn8wf4c=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.  Just built kernel 5.9-rc7, and ran it for about 30 minutes.  
Moved the mouse and saw it was jumping (pointer not moving smoothly).  
Dmesg showed:

5409.255054] nouveau 0000:02:00.0: DRM: base-0: timeout
[ 5411.380728] nouveau 0000:02:00.0: DRM: base-0: timeout
[ 5413.430281] nouveau 0000:02:00.0: DRM: base-0: timeout
[ 5415.443402] nouveau 0000:02:00.0: DRM: base-0: timeout
[ 5417.452150] nouveau 0000:02:00.0: DRM: base-0: timeout
[ 5419.470247] nouveau 0000:02:00.0: DRM: base-0: timeout
[ 5421.492721] nouveau 0000:02:00.0: DRM: base-0: timeout
[ 5423.507895] nouveau 0000:02:00.0: DRM: base-0: timeout
[ 5425.518642] nouveau 0000:02:00.0: DRM: base-0: timeout
[ 5427.535112] nouveau 0000:02:00.0: DRM: base-0: timeout
[ 5429.552140] nouveau 0000:02:00.0: DRM: base-0: timeout
[ 5429.704813] nouveau 0000:02:00.0: disp: ERROR 5 [INVALID_STATE] 0b [] 
chid 1 mthd 0080 data 00000001
[ 5429.704835] nouveau 0000:02:00.0: disp: Base 1:
[ 5429.704841] nouveau 0000:02:00.0: disp:     0084: 00000000
[ 5429.704846] nouveau 0000:02:00.0: disp:     0088: 00000000
[ 5429.704851] nouveau 0000:02:00.0: disp:     008c: 00000000
[ 5429.704856] nouveau 0000:02:00.0: disp:     0090: 00000000
[ 5429.704863] nouveau 0000:02:00.0: disp:     0094: 00000000
[ 5429.704871] nouveau 0000:02:00.0: disp:     00a0: 00000060
[ 5429.704879] nouveau 0000:02:00.0: disp:     00a4: f0000000
[ 5429.704886] nouveau 0000:02:00.0: disp:     00c0: fb0000fe
[ 5429.704894] nouveau 0000:02:00.0: disp:     00c4: 00000000
[ 5429.704902] nouveau 0000:02:00.0: disp:     00c8: 00000000
[ 5429.704909] nouveau 0000:02:00.0: disp:     00cc: 00000000
[ 5429.704917] nouveau 0000:02:00.0: disp:     00e0: 40000000
[ 5429.704924] nouveau 0000:02:00.0: disp:     00e4: 00000000
[ 5429.704933] nouveau 0000:02:00.0: disp:     00e8: 00000000
[ 5429.704940] nouveau 0000:02:00.0: disp:     00ec: 00000000
[ 5429.704948] nouveau 0000:02:00.0: disp:     00fc: 00000000
[ 5429.704955] nouveau 0000:02:00.0: disp:     0100: fffe0000
[ 5429.704963] nouveau 0000:02:00.0: disp:     0104: 00000000
[ 5429.704970] nouveau 0000:02:00.0: disp:     0110: 00000000
[ 5429.704978] nouveau 0000:02:00.0: disp:     0114: 00000000
[ 5429.704982] nouveau 0000:02:00.0: disp: Base 1 - Image 0:
[ 5429.704990] nouveau 0000:02:00.0: disp:     0800: 00032c00 -> 0005ca00
[ 5429.704998] nouveau 0000:02:00.0: disp:     0804: 00000000
[ 5429.705005] nouveau 0000:02:00.0: disp:     0808: 04380f00
[ 5429.705013] nouveau 0000:02:00.0: disp:     080c: 0000f004
[ 5429.705021] nouveau 0000:02:00.0: disp:     0810: 0000cf00
[ 5429.705024] nouveau 0000:02:00.0: disp: Base 1 - Image 1:
[ 5429.705032] nouveau 0000:02:00.0: disp:     0c00: 00032c00 -> 0005ca00
[ 5429.705040] nouveau 0000:02:00.0: disp:     0c04: 00000000
[ 5429.705048] nouveau 0000:02:00.0: disp:     0c08: 04380f00
[ 5429.705055] nouveau 0000:02:00.0: disp:     0c0c: 0000f004
[ 5429.705063] nouveau 0000:02:00.0: disp:     0c10: 0000cf00


When running kernel 5.8.0, my card information is:

Direct Rendering
direct rendering: Yes
     GL_AMD_gpu_shader_int64, GL_AMD_multi_draw_indirect,
     GL_ARB_depth_clamp, GL_ARB_derivative_control, 
GL_ARB_direct_state_access,
     GL_ARB_draw_elements_base_vertex, GL_ARB_draw_indirect,
     GL_ARB_indirect_parameters, GL_ARB_instanced_arrays,
     GL_ARB_map_buffer_range, GL_ARB_multi_bind, 
GL_ARB_multi_draw_indirect,
     GL_AMD_multi_draw_indirect, GL_AMD_performance_monitor,
     GL_ARB_direct_state_access, GL_ARB_draw_buffers,
     GL_ARB_draw_indirect, GL_ARB_draw_instanced, GL_ARB_enhanced_layouts,
     GL_ARB_indirect_parameters, GL_ARB_instanced_arrays,
     GL_ARB_map_buffer_range, GL_ARB_multi_bind, 
GL_ARB_multi_draw_indirect,
     GL_EXT_direct_state_access, GL_EXT_draw_buffers2, 
GL_EXT_draw_instanced,
Clocks
03: core 50 MHz memory 135 MHz
07: core 405 MHz memory 324 MHz
0f: core 810 MHz memory 700 MHz
AC: core 405 MHz memory 324 MHz
loaded video module parameters and values
name:           video
brightness_switch_enabled: (bool)
allow_duplicates: (bool)
disable_backlight_sysfs_if: (int)
report_key_events:0: none, 1: output changes, 2: brightness changes, 3: 
all (int)
hw_changes_brightness:Set this to 1 on buggy hw which changes the 
brightness itself when a hotkey is pressed: -1: auto, 0: normal 1: 
hw-changes-brightness (int)
device_id_scheme: (bool)
only_lcd: (int)
OpenGL vendor string: nouveau
OpenGL renderer string: NVC1
OpenGL core profile version string: 4.3 (Core Profile) Mesa 20.0.8
OpenGL core profile shading language version string: 4.30
OpenGL core profile context flags: (none)
OpenGL core profile profile mask: core profile
OpenGL core profile extensions:
OpenGL version string: 4.3 (Compatibility Profile) Mesa 20.0.8
OpenGL shading language version string: 4.30
OpenGL context flags: (none)
OpenGL profile mask: compatibility profile
OpenGL extensions:
OpenGL ES profile version string: OpenGL ES 3.1 Mesa 20.0.8
OpenGL ES profile shading language version string: OpenGL ES GLSL ES 3.10
OpenGL ES profile extensions:
display: :0   screen: 0
API version: 1
Information string: G3DVL VDPAU Driver Shared Library version 1.0

Video surface:

name   width height types
-------------------------------------------
420    16384 16384  NV12 YV12
422    16384 16384  UYVY YUYV
444    16384 16384  Y8U8V8A8 V8U8Y8A8

Decoder capabilities:

name                        level macbs width height
----------------------------------------------------
MPEG1                           0 16384  2048  2048
MPEG2_SIMPLE                    3 16384  2048  2048
MPEG2_MAIN                      3 16384  2048  2048
H264_BASELINE                  41 16384  2048  2048
H264_MAIN                      41 16384  2048  2048
H264_HIGH                      41 16384  2048  2048
VC1_SIMPLE                      1 16384  2048  2048
VC1_MAIN                        2 16384  2048  2048
VC1_ADVANCED                    4 16384  2048  2048
MPEG4_PART2_SP                  3 16384  2048  2048
MPEG4_PART2_ASP                 5 16384  2048  2048
DIVX4_QMOBILE                  --- not supported ---
DIVX4_MOBILE                   --- not supported ---
DIVX4_HOME_THEATER             --- not supported ---
DIVX4_HD_1080P                 --- not supported ---
DIVX5_QMOBILE                  --- not supported ---
DIVX5_MOBILE                   --- not supported ---
DIVX5_HOME_THEATER             --- not supported ---
DIVX5_HD_1080P                 --- not supported ---
H264_CONSTRAINED_BASELINE       0 16384  2048  2048
H264_EXTENDED                  --- not supported ---
H264_PROGRESSIVE_HIGH          --- not supported ---
H264_CONSTRAINED_HIGH          --- not supported ---
H264_HIGH_444_PREDICTIVE       --- not supported ---
HEVC_MAIN                      --- not supported ---
HEVC_MAIN_10                   --- not supported ---
HEVC_MAIN_STILL                --- not supported ---
HEVC_MAIN_12                   --- not supported ---
HEVC_MAIN_444                  --- not supported ---

Output surface:

name              width height nat types
----------------------------------------------------
B8G8R8A8         16384 16384    y  NV12 YV12 UYVY YUYV Y8U8V8A8 V8U8Y8A8 
A4I4 I4A4 A8I8 I8A8
R8G8B8A8         16384 16384    y  NV12 YV12 UYVY YUYV Y8U8V8A8 V8U8Y8A8 
A4I4 I4A4 A8I8 I8A8
R10G10B10A2      16384 16384    y  NV12 YV12 UYVY YUYV Y8U8V8A8 V8U8Y8A8 
A4I4 I4A4 A8I8 I8A8
B10G10R10A2      16384 16384    y  NV12 YV12 UYVY YUYV Y8U8V8A8 V8U8Y8A8 
A4I4 I4A4 A8I8 I8A8

Bitmap surface:

name              width height
------------------------------
B8G8R8A8         16384 16384
R8G8B8A8         16384 16384
R10G10B10A2      16384 16384
B10G10R10A2      16384 16384
A8               16384 16384

Video mixer:

feature name                    sup
------------------------------------
DEINTERLACE_TEMPORAL             y
DEINTERLACE_TEMPORAL_SPATIAL     -
INVERSE_TELECINE                 -
NOISE_REDUCTION                  y
SHARPNESS                        y
LUMA_KEY                         y
HIGH QUALITY SCALING - L1        y
HIGH QUALITY SCALING - L2        -
HIGH QUALITY SCALING - L3        -
HIGH QUALITY SCALING - L4        -
HIGH QUALITY SCALING - L5        -
HIGH QUALITY SCALING - L6        -
HIGH QUALITY SCALING - L7        -
HIGH QUALITY SCALING - L8        -
HIGH QUALITY SCALING - L9        -

parameter name                  sup      min      max
-----------------------------------------------------
VIDEO_SURFACE_WIDTH              y        48     2048
VIDEO_SURFACE_HEIGHT             y        48     2048
CHROMA_TYPE                      y
LAYERS                           y         0        4

attribute name                  sup      min      max
-----------------------------------------------------
BACKGROUND_COLOR                 y
CSC_MATRIX                       y
NOISE_REDUCTION_LEVEL            y      0.00     1.00
SHARPNESS_LEVEL                  y     -1.00     1.00
LUMA_KEY_MIN_LUMA                y
LUMA_KEY_MAX_LUMA                y


libva info: VA-API version 1.7.0
libva info: Trying to open 
/usr/lib/x86_64-linux-gnu/dri/nouveau_drv_video.so
libva info: Found init function __vaDriverInit_1_7
libva info: va_openDriver() returns 0
vainfo: VA-API version: 1.7 (libva 2.6.0)
vainfo: Driver version: Mesa Gallium driver 20.0.8 for NVC1
vainfo: Supported profile and entrypoints
       VAProfileMPEG2Simple            :    VAEntrypointVLD
       VAProfileMPEG2Main              :    VAEntrypointVLD
       VAProfileVC1Simple              :    VAEntrypointVLD
       VAProfileVC1Main                :    VAEntrypointVLD
       VAProfileVC1Advanced            :    VAEntrypointVLD
       VAProfileH264ConstrainedBaseline:    VAEntrypointVLD
       VAProfileH264Main               :    VAEntrypointVLD
       VAProfileH264High               :    VAEntrypointVLD
       VAProfileNone                   :    VAEntrypointVideoProc
System:
   Host: freedom Kernel: 5.8.0 x86_64 bits: 64 compiler: N/A
   Desktop: MATE 1.24.0 Distro: Linux Mint 20 Ulyana base: Ubuntu 20.04 
focal
Graphics:
   Device-1: NVIDIA GF108 [GeForce GT 630] vendor: eVga.com. driver: 
nouveau
   v: kernel bus ID: 02:00.0
   Display: x11 server: X.Org 1.20.8 driver: modesetting unloaded: 
fbdev,vesa
   resolution: 1920x1080~60Hz, 1920x1080~60Hz
   OpenGL: renderer: NVC1 v: 4.3 Mesa 20.0.8 direct render: Yes


--------------------------------------------------------------------

Sorry for the long post, but I wanted to be complete.

For more information, you will have to contact me directly,

as I am not on the list,

Bob

