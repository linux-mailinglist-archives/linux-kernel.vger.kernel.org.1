Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B85D12FFFCE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 11:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbhAVKIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 05:08:11 -0500
Received: from audible.transient.net ([24.143.126.66]:37056 "HELO
        audible.transient.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727390AbhAVKEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 05:04:54 -0500
Received: (qmail 29783 invoked from network); 22 Jan 2021 10:03:49 -0000
Received: from cucamonga.audible.transient.net (192.168.2.5)
  by canarsie.audible.transient.net with QMQP; 22 Jan 2021 10:03:49 -0000
Received: (nullmailer pid 3399 invoked by uid 1000);
        Fri, 22 Jan 2021 10:03:48 -0000
Date:   Fri, 22 Jan 2021 10:03:48 +0000
From:   Jamie Heilman <jamie@audible.transient.net>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     tiwai@suse.com, linux-kernel@vger.kernel.org
Subject: Re: bisected regression in v5.11-rc1 snd-usb-audio
Message-ID: <YAqjBLt3eLG5GY/4@audible.transient.net>
Mail-Followup-To: Takashi Iwai <tiwai@suse.de>, tiwai@suse.com,
        linux-kernel@vger.kernel.org
References: <YAqIJHzE3UG51G/U@audible.transient.net>
 <s5hzh118ioz.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2DP8zP51ciBpu7PO"
Content-Disposition: inline
In-Reply-To: <s5hzh118ioz.wl-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2DP8zP51ciBpu7PO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Takashi Iwai wrote:
> You seem hitting a firmware bug, and it doesn't look like the only
> case.  Interestingly, the backport of 5.11 USB-audio stuff on 5.3
> kernel on openSUSE Leap 15.2 caused a similar bug on Steinberg device,
> while it worked with 5.11-rc.  So I thought this specific with the
> older kernel (in USB core changes or such), but my guess seems wrong,
> and the bug looks remaining in 5.11 for some cases.
> 
> Below is the fix patch.  Please give it a try.
> 
> 
> thanks,
> 
> Takashi
> 
> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: usb-audio: workaround for iface reset issue
> 
> The recently introduced sample rate validation code seems causing a
> problem on some devices; namely, after performing this, the bus gets
> screwed and it influences even on other USB devices.
> As a quick workaround, perform it only for the necessary devices;
> currently MOTU devices are known to need the valid altset checks, so
> filter out other devices.
> 
> Fixes: 93db51d06b32 ("ALSA: usb-audio: Check valid altsetting at parsing rates for UAC2/3")
> Reported-by: Jamie Heilman <jamie@audible.transient.net>
> BugLink: https://bugzilla.suse.com/show_bug.cgi?id=1178203
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/usb/format.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/sound/usb/format.c b/sound/usb/format.c
> index 9ebc5d202c87..e6ff317a6785 100644
> --- a/sound/usb/format.c
> +++ b/sound/usb/format.c
> @@ -466,6 +466,17 @@ static int validate_sample_rate_table_v2v3(struct snd_usb_audio *chip,
>  	unsigned int nr_rates;
>  	int i, err;
>  
> +	/* performing the rate verification may lead to unexpected USB bus
> +	 * behavior afterwards by some unknown reason.  Do this only for the
> +	 * known devices.
> +	 */
> +	switch (USB_ID_VENDOR(chip->usb_id)) {
> +	case 0x07fd: /* MOTU */
> +		break;
> +	default:
> +		return 0; /* don't perform the validation as default */
> +	}
> +
>  	table = kcalloc(fp->nr_rates, sizeof(*table), GFP_KERNEL);
>  	if (!table)
>  		return -ENOMEM;

Well, with this patch, while I can get it to seemingly initialize
without errors by replugging, I can't actually get it to work.  Jack
says:

Starting jack server...
JACK server starting in realtime mode with priority 10
self-connect-mode is "Don't restrict self connect requests"
Acquired audio card Audio1
creating alsa driver ... hw:CARD=hiFace2,DEV=0|-|1024|3|96000|0|0|nomon|swmeter|-|32bit
ERROR: ALSA: Cannot open PCM device alsa_pcm for playback. Falling back to capture-only mode
Released audio card Audio1
ERROR: Cannot initialize driver
ERROR: JackServer::Open failed with -1
ERROR: Failed to open server

here's what aplay does when it tries:

aplay: main:830: audio open error: Invalid argument

strace of that says:
openat(AT_FDCWD, "/dev/snd/pcmC1D0p", O_RDWR|O_NONBLOCK|O_CLOEXEC) = -1 EINVAL (Invalid argument)

I dug up a different USB sound device (bithead) and plugged it in, it
still works just fine with the same commands.

The only difference I see in the alsa-info output is that

        control.7 {
                iface CARD
                name 'Keep Interface'
                value false
                comment {
                        access 'read write'
                        type BOOLEAN
                        count 1
                }
        }

has gone missing.  I've attached it incase you can spot something I
didn't (obviously the cards are in a different order which makes
things somewhat tedious for a direct comparison).  Apart from the
device number on the usb bus, the lsusb -vvv output is the same as
it was in with 5.10.9.

-- 
Jamie Heilman                     http://audible.transient.net/~jamie/

--2DP8zP51ciBpu7PO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="v5.11.0-rc4-00164-g83d09ad4b950-dirty-alsa-info.txt"

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.65
!!################################

!!Script ran on: Fri Jan 22 09:51:41 UTC 2021


!!Linux Distribution
!!------------------

Debian GNU/Linux bullseye/sid \n \l PRETTY_NAME="Debian GNU/Linux bullseye/sid" NAME="Debian GNU/Linux" ID=debian HOME_URL="https://www.debian.org/" SUPPORT_URL="https://www.debian.org/support" BUG_REPORT_URL="https://bugs.debian.org/"


!!DMI Information
!!---------------

Manufacturer:      Dell Inc.
Product Name:      Precision WorkStation T3400  
Product Version:   
Firmware Version:  A14
System SKU:        
Board Vendor:      Dell Inc.
Board Name:        0TP412


!!ACPI Device Status Information
!!---------------

/sys/bus/acpi/devices/PNP0401:00/status 	 15
/sys/bus/acpi/devices/PNP0501:00/status 	 15
/sys/bus/acpi/devices/PNP0700:00/status 	 15
/sys/bus/acpi/devices/PNP0C0F:00/status 	 9
/sys/bus/acpi/devices/PNP0C0F:01/status 	 9
/sys/bus/acpi/devices/PNP0C0F:02/status 	 9
/sys/bus/acpi/devices/PNP0C0F:03/status 	 9
/sys/bus/acpi/devices/PNP0C0F:04/status 	 9
/sys/bus/acpi/devices/PNP0C0F:05/status 	 9
/sys/bus/acpi/devices/PNP0C0F:06/status 	 9
/sys/bus/acpi/devices/PNP0C0F:07/status 	 9
/sys/bus/acpi/devices/PNP0F13:00/status 	 15
/sys/bus/acpi/devices/SMO1200:00/status 	 15
/sys/bus/acpi/devices/device:07/status 	 15
/sys/bus/acpi/devices/device:08/status 	 15
/sys/bus/acpi/devices/device:09/status 	 15
/sys/bus/acpi/devices/device:0a/status 	 15
/sys/bus/acpi/devices/device:0b/status 	 15
/sys/bus/acpi/devices/device:0c/status 	 15


!!Kernel Information
!!------------------

Kernel release:    5.11.0-rc4-00164-g83d09ad4b950-dirty
Operating System:  GNU/Linux
Architecture:      x86_64
Processor:         unknown
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     k5.11.0-rc4-00164-g83d09ad4b950-dirty
Library version:    1.2.4
Utilities version:  1.2.4


!!Loaded ALSA modules
!!-------------------

snd_hda_intel
snd_usb_audio
snd_usb_audio


!!Sound Servers on this system
!!----------------------------

Pulseaudio:
      Installed - Yes (/usr/bin/pulseaudio)
      Running - No

Jack:
      Installed - Yes (/usr/bin/jackd)
      Running - No


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0xfdffc000 irq 30
 1 [hiFace2        ]: USB-Audio - M2Tech USB Audio 2.0
                      M2Tech M2Tech USB Audio 2.0 at usb-0000:00:1a.7-1.1.2, high speed
 2 [bithead        ]: USB-Audio - USB Audio CODEC
                      Burr-Brown from TI USB Audio CODEC at usb-0000:00:1a.7-1.1.4, full speed


!!PCI Soundcards installed in the system
!!--------------------------------------

00:1b.0 Audio device [0403]: Intel Corporation 82801I (ICH9 Family) HD Audio Controller [8086:293e] (rev 02)
	Subsystem: Dell 82801I (ICH9 Family) HD Audio Controller [1028:0214]


!!Modprobe options (Sound related)
!!--------------------------------

snd_pcsp: index=-2
snd_usb_audio: index=-2
snd_atiixp_modem: index=-2
snd_intel8x0m: index=-2
snd_via82xx_modem: index=-2
snd_hda_intel: model=dell_desktop
snd_usb_audio: vid=0x08bb,0x08bb,0x249c pid=0x2902,0x2707,0x930b id=bithead,bDAC,hiFace2


!!Loaded sound module options
!!---------------------------

!!Module: snd_hda_intel
	align_buffer_size : -1
	bdl_pos_adj : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	beep_mode : N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N
	dmic_detect : Y
	enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
	enable_msi : -1
	id : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	index : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	jackpoll_ms : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	model : dell_desktop,(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	patch : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	pm_blacklist : Y
	position_fix : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	power_save : 0
	power_save_controller : Y
	probe_mask : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	probe_only : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	single_cmd : -1
	snoop : -1

!!Module: snd_usb_audio
	autoclock : Y
	delayed_register : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	device_setup : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
	id : bithead,bDAC,hiFace2,(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	ignore_ctl_error : N
	implicit_fb : N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N
	index : -2,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	pid : 10498,9991,37643,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	quirk_alias : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	skip_validation : N
	use_vmalloc : Y
	vid : 2235,2235,9372,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1

!!Module: snd_usb_audio
	autoclock : Y
	delayed_register : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	device_setup : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
	id : bithead,bDAC,hiFace2,(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	ignore_ctl_error : N
	implicit_fb : N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N
	index : -2,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	pid : 10498,9991,37643,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	quirk_alias : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	skip_validation : N
	use_vmalloc : Y
	vid : 2235,2235,9372,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: Analog Devices AD1984
Address: 0
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x11d41984
Subsystem Id: 0x10280214
Revision Id: 0x100400
No Modem Function Group found
Default PCM:
    rates [0x7ff]: 8000 11025 16000 22050 32000 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
Default Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=0
State of AFG node 0x01:
  Power states:  D0 D3
  Power: setting=D0, actual=D0
GPIO: io=3, o=0, i=0, unsolicited=1, wake=0
  IO[0]: enable=0, dir=0, wake=0, sticky=0, data=1, unsol=0
  IO[1]: enable=1, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[2]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
Node 0x02 [Audio Output] wcaps 0x30311: Stereo Digital
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Delay: 3 samples
  Connection: 3
     0x01* 0x08 0x09
Node 0x03 [Audio Output] wcaps 0x405: Stereo Amp-Out
  Control: name="Headphone Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Device: name="AD1984 Alt Analog", type="Audio", device=2
  Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=0
  Amp-Out vals:  [0x22 0x22]
  Converter: stream=0, channel=0
  Power states:  D0 D3
  Power: setting=D0, actual=D0
Node 0x04 [Audio Output] wcaps 0x405: Stereo Amp-Out
  Control: name="Line Out Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Device: name="AD1984 Analog", type="Audio", device=0
  Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=0
  Amp-Out vals:  [0x22 0x22]
  Converter: stream=0, channel=0
  Power states:  D0 D3
  Power: setting=D0, actual=D0
Node 0x05 [Audio Input] wcaps 0x10050b: Stereo Amp-In
  Amp-In caps: ofs=0x27, nsteps=0x36, stepsize=0x05, mute=1
  Amp-In vals:  [0xa7 0xa7]
  Converter: stream=0, channel=0
  SDI-Select: 0
  Power states:  D0 D3
  Power: setting=D0, actual=D0
  Connection: 1
     0x17
Node 0x06 [Audio Input] wcaps 0x10050b: Stereo Amp-In
  Amp-In caps: ofs=0x27, nsteps=0x36, stepsize=0x05, mute=1
  Amp-In vals:  [0xa7 0xa7]
  Converter: stream=0, channel=0
  SDI-Select: 0
  Power states:  D0 D3
  Power: setting=D0, actual=D0
  Connection: 1
     0x18
Node 0x07 [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x80 0x80]
  Connection: 2
     0x22 0x21
Node 0x08 [Audio Input] wcaps 0x100501: Stereo
  Device: name="AD1984 Analog", type="Audio", device=0
  Converter: stream=0, channel=0
  SDI-Select: 0
  Power states:  D0 D3
  Power: setting=D0, actual=D0
  Connection: 1
     0x0c
Node 0x09 [Audio Input] wcaps 0x100501: Stereo
  Device: name="AD1984 Alt Analog", type="Audio", device=2
  Converter: stream=0, channel=0
  SDI-Select: 0
  Power states:  D0 D3
  Power: setting=D0, actual=D0
  Connection: 1
     0x0d
Node 0x0a [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x80 0x80]
  Connection: 2
     0x04 0x21
Node 0x0b [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80]
  Connection: 2
     0x0f 0x21
Node 0x0c [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Control: name="Capture Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Capture Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x27, nsteps=0x36, stepsize=0x05, mute=1
  Amp-Out vals:  [0x2f 0x2f]
  Connection: 5
     0x14* 0x15 0x16 0x20 0x25
Node 0x0d [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Control: name="Capture Volume", index=1, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Capture Switch", index=1, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x27, nsteps=0x36, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 5
     0x14* 0x15 0x16 0x20 0x25
Node 0x0e [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x03 0x04*
Node 0x0f [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x03* 0x04
Node 0x10 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Control: name="Beep Playback Volume", index=0, device=0
    ControlAmp: chs=1, dir=Out, idx=0, ofs=0
  Control: name="Beep Playback Switch", index=0, device=0
    ControlAmp: chs=1, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x0f, nsteps=0x0f, stepsize=0x0b, mute=1
  Amp-Out vals:  [0x8f]
Node 0x11 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Control: name="Headphone Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000001f: OUT HP Detect Trigger ImpSense
  Pin Default 0x02214040: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Green
    DefAssociation = 0x4, Sequence = 0x0
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=01, enabled=1
  Connection: 1
     0x07
Node 0x12 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Control: name="Line Out Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0001001f: OUT HP EAPD Detect Trigger ImpSense
  EAPD 0x2: EAPD
  Pin Default 0x01014010: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Green
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=02, enabled=1
  Power states:  D0 D3
  Power: setting=D0, actual=D0
  Connection: 1
     0x0a
Node 0x13 [Pin Complex] wcaps 0x40050c: Mono Amp-Out
  Control: name="Speaker Playback Volume", index=0, device=0
    ControlAmp: chs=1, dir=Out, idx=0, ofs=0
  Control: name="Speaker Playback Switch", index=0, device=0
    ControlAmp: chs=1, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x1a]
  Pincap 0x00010010: OUT EAPD
  EAPD 0x0:
  Pin Default 0x991301f0: [Fixed] Speaker at Int ATAPI
    Conn = ATAPI, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
  Power states:  D0 D3
  Power: setting=D0, actual=D0
  Connection: 1
     0x1f
Node 0x14 [Pin Complex] wcaps 0x40008b: Stereo Amp-In
  Control: name="Mic Boost Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00003727: IN Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x02a19020: [Jack] Mic at Ext Front
    Conn = 1/8, Color = Pink
    DefAssociation = 0x2, Sequence = 0x0
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=03, enabled=1
Node 0x15 [Pin Complex] wcaps 0x40008b: Stereo Amp-In
  Control: name="Line Boost Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00003727: IN Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x01813030: [Jack] Line In at Ext Rear
    Conn = 1/8, Color = Blue
    DefAssociation = 0x3, Sequence = 0x0
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=04, enabled=1
Node 0x16 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00000037: IN OUT Detect Trigger ImpSense
  Pin Default 0x413301f0: [N/A] CD at Ext Rear
    Conn = ATAPI, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x0b
Node 0x17 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x00000020: IN
  Pin Default 0x41a601f0: [N/A] Mic at Ext Rear
    Conn = Digital, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
Node 0x18 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x00000020: IN
  Pin Default 0x41a601f0: [N/A] Mic at Ext Rear
    Conn = Digital, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
Node 0x19 [Power Widget] wcaps 0x500500: Mono
  Power states:  D0 D3
  Power: setting=D0, actual=D0
  Connection: 2
     0x20 0x21
Node 0x1a [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x00000020: IN
  Pin Default 0x41f301f0: [N/A] Other at Ext Rear
    Conn = ATAPI, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
Node 0x1b [Pin Complex] wcaps 0x40030d: Stereo Digital Amp-Out
  Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=1
  Amp-Out vals:  [0xa7 0xa7]
  Pincap 0x00000010: OUT
  Pin Default 0x414511f0: [N/A] SPDIF Out at Ext Rear
    Conn = Optical, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x02
Node 0x1c [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00003737: IN OUT Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x41a190f0: [N/A] Mic at Ext Rear
    Conn = 1/8, Color = Pink
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00: VREF_HIZ
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x24
Node 0x1d [Vendor Defined Widget] wcaps 0xf00100: Mono
  Connection: 25
     0x07* 0x19 0x0a 0x0b 0x0c 0x0d 0x0e 0x0f 0x1a 0x1c 0x11 0x12 0x13 0x14 0x15 0x16 0x1e 0x1f 0x20 0x21 0x22 0x23 0x24 0x25 0x26
Node 0x1e [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x80 0x80]
  Connection: 2
     0x0e 0x21
Node 0x1f [Audio Mixer] wcaps 0x200100: Mono
  Connection: 1
     0x1e
Node 0x20 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Control: name="Mic Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Mic Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Line Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=1, ofs=0
  Control: name="Line Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=1, ofs=0
  Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Connection: 5
     0x14 0x15 0x16 0x1a 0x25
Node 0x21 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x1f 0x1f]
  Connection: 1
     0x20
Node 0x22 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x03* 0x04
Node 0x23 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x03* 0x04
Node 0x24 [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80]
  Connection: 2
     0x23 0x21
Node 0x25 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 1
     0x1c
Node 0x26 [Vendor Defined Widget] wcaps 0xf00100: Mono
  Connection: 3
     0x14* 0x15 0x1c
--endcollapse--


!!USB Mixer information
!!---------------------
--startcollapse--

USB Mixer: usb_id=0x249c930b, ctrlif=0, ctlerr=0
Card: M2Tech M2Tech USB Audio 2.0 at usb-0000:00:1a.7-1.1.2, high speed
  Unit: 10
    Control: name="M2Tech Audio 2.0 Output Playback Volume", index=1
    Info: id=10, control=2, cmask=0x0, channels=1, type="S16"
    Volume: min=-32512, max=0, dBmin=-12700, dBmax=0
  Unit: 10
    Control: name="M2Tech Audio 2.0 Output Playback Volume", index=0
    Info: id=10, control=2, cmask=0x3, channels=2, type="S16"
    Volume: min=-32512, max=0, dBmin=-12700, dBmax=0
  Unit: 10
    Control: name="M2Tech Audio 2.0 Output Playback Switch", index=1
    Info: id=10, control=1, cmask=0x0, channels=1, type="INV_BOOLEAN"
    Volume: min=0, max=1, dBmin=0, dBmax=0
  Unit: 10
    Control: name="M2Tech Audio 2.0 Output Playback Switch", index=0
    Info: id=10, control=1, cmask=0x3, channels=2, type="INV_BOOLEAN"
    Volume: min=0, max=1, dBmin=0, dBmax=0
  Unit: 41
    Control: name="M2Tech Internal Clock Validity", index=0
    Info: id=41, control=2, cmask=0x0, channels=1, type="BOOLEAN"
    Volume: min=0, max=1, dBmin=0, dBmax=0
USB Mixer: usb_id=0x08bb2902, ctrlif=0, ctlerr=0
Card: Burr-Brown from TI USB Audio CODEC at usb-0000:00:1a.7-1.1.4, full speed
  Unit: 3
    Control: name="PCM Playback Volume", index=0
    Info: id=3, control=2, cmask=0x3, channels=2, type="S16"
    Volume: min=-32768, max=0, dBmin=-12800, dBmax=0
  Unit: 3
    Control: name="PCM Playback Switch", index=0
    Info: id=3, control=1, cmask=0x0, channels=1, type="INV_BOOLEAN"
    Volume: min=0, max=1, dBmin=0, dBmax=0
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw---- 1 root audio 116,  7 Jan 22 09:27 /dev/snd/controlC0
crw-rw---- 1 root audio 116,  9 Jan 22 09:28 /dev/snd/controlC1
crw-rw---- 1 root audio 116, 12 Jan 22 09:41 /dev/snd/controlC2
crw-rw---- 1 root audio 116,  6 Jan 22 09:27 /dev/snd/hwC0D0
crw-rw---- 1 root audio 116,  3 Jan 22 09:31 /dev/snd/pcmC0D0c
crw-rw---- 1 root audio 116,  2 Jan 22 09:39 /dev/snd/pcmC0D0p
crw-rw---- 1 root audio 116,  5 Jan 22 09:27 /dev/snd/pcmC0D2c
crw-rw---- 1 root audio 116,  4 Jan 22 09:27 /dev/snd/pcmC0D2p
crw-rw---- 1 root audio 116,  8 Jan 22 09:28 /dev/snd/pcmC1D0p
crw-rw---- 1 root audio 116, 11 Jan 22 09:41 /dev/snd/pcmC2D0c
crw-rw---- 1 root audio 116, 10 Jan 22 09:43 /dev/snd/pcmC2D0p
crw-rw---- 1 root audio 116,  1 Jan 22 09:27 /dev/snd/seq
crw-rw---- 1 root audio 116, 33 Jan 22 09:27 /dev/snd/timer

/dev/snd/by-id:
total 0
drwxr-xr-x 2 root root  80 Jan 22 09:41 .
drwxr-xr-x 4 root root 340 Jan 22 09:41 ..
lrwxrwxrwx 1 root root  12 Jan 22 09:41 usb-Burr-Brown_from_TI_USB_Audio_CODEC-00 -> ../controlC2
lrwxrwxrwx 1 root root  12 Jan 22 09:28 usb-M2Tech_M2Tech_USB_Audio_2.0_0000-00 -> ../controlC1

/dev/snd/by-path:
total 0
drwxr-xr-x 2 root root 100 Jan 22 09:41 .
drwxr-xr-x 4 root root 340 Jan 22 09:41 ..
lrwxrwxrwx 1 root root  12 Jan 22 09:28 pci-0000:00:1a.7-usb-0:1.1.2:1.0 -> ../controlC1
lrwxrwxrwx 1 root root  12 Jan 22 09:41 pci-0000:00:1a.7-usb-0:1.1.4:1.0 -> ../controlC2
lrwxrwxrwx 1 root root  12 Jan 22 09:27 pci-0000:00:1b.0 -> ../controlC0


!!Aplay/Arecord output
!!--------------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: AD1984 Analog [AD1984 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 2: AD1984 Alt Analog [AD1984 Alt Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: hiFace2 [M2Tech USB Audio 2.0], device 0: USB Audio [USB Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 2: bithead [USB Audio CODEC], device 0: USB Audio [USB Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: Intel [HDA Intel], device 0: AD1984 Analog [AD1984 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 2: AD1984 Alt Analog [AD1984 Alt Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 2: bithead [USB Audio CODEC], device 0: USB Audio [USB Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card Intel

Card hw:0 'Intel'/'HDA Intel at 0xfdffc000 irq 30'
  Mixer name	: 'Analog Devices AD1984'
  Components	: 'HDA:11d41984,10280214,00100400'
  Controls      : 35
  Simple ctrls  : 17
Simple mixer control 'Master',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 39
  Mono: Playback 34 [87%] [-7.50dB] [on]
Simple mixer control 'Headphone',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 39
  Mono:
  Front Left: Playback 39 [100%] [0.00dB] [on]
  Front Right: Playback 39 [100%] [0.00dB] [on]
Simple mixer control 'Speaker',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 31
  Mono: Playback 31 [100%] [0.00dB] [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 255 [100%] [0.00dB]
  Front Right: Playback 255 [100%] [0.00dB]
Simple mixer control 'Line',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 0 [0%] [-34.50dB] [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off]
Simple mixer control 'Line Boost',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 3
  Front Left: 0 [0%] [0.00dB]
  Front Right: 0 [0%] [0.00dB]
Simple mixer control 'Line Out',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 39
  Mono:
  Front Left: Playback 39 [100%] [0.00dB] [on]
  Front Right: Playback 39 [100%] [0.00dB] [on]
Simple mixer control 'Mic',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 0 [0%] [-34.50dB] [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off]
Simple mixer control 'Mic Boost',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 3
  Front Left: 0 [0%] [0.00dB]
  Front Right: 0 [0%] [0.00dB]
Simple mixer control 'Beep',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 15
  Mono: Playback 15 [100%] [0.00dB] [off]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 54
  Front Left: Capture 47 [87%] [12.00dB] [on]
  Front Right: Capture 47 [87%] [12.00dB] [on]
Simple mixer control 'Capture',1
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 54
  Front Left: Capture 0 [0%] [-58.50dB] [off]
  Front Right: Capture 0 [0%] [-58.50dB] [off]
Simple mixer control 'Auto-Mute Mode',0
  Capabilities: enum
  Items: 'Disabled' 'Speaker Only' 'Line Out+Speaker'
  Item0: 'Line Out+Speaker'
Simple mixer control 'Independent HP',0
  Capabilities: enum
  Items: 'Disabled' 'Enabled'
  Item0: 'Disabled'
Simple mixer control 'Input Source',0
  Capabilities: cenum
  Items: 'Mic' 'Line' 'Stereo Mix'
  Item0: 'Mic'
Simple mixer control 'Input Source',1
  Capabilities: cenum
  Items: 'Mic' 'Line' 'Stereo Mix'
  Item0: 'Mic'
Simple mixer control 'Loopback Mixing',0
  Capabilities: enum
  Items: 'Disabled' 'Enabled'
  Item0: 'Disabled'

!!-------Mixer controls for card hiFace2

Card hw:1 'hiFace2'/'M2Tech M2Tech USB Audio 2.0 at usb-0000:00:1a.7-1.1.2, high speed'
  Mixer name	: 'USB Mixer'
  Components	: 'USB249c:930b'
  Controls      : 6
  Simple ctrls  : 2
Simple mixer control 'M2Tech Audio 2.0 Output',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 127
  Mono:
  Front Left: Playback 127 [100%] [0.00dB] [on]
  Front Right: Playback 127 [100%] [0.00dB] [on]
Simple mixer control 'M2Tech Audio 2.0 Output',1
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 127
  Mono: Playback 127 [100%] [0.00dB] [on]

!!-------Mixer controls for card bithead

Card hw:2 'bithead'/'Burr-Brown from TI USB Audio CODEC at usb-0000:00:1a.7-1.1.4, full speed'
  Mixer name	: 'USB Mixer'
  Components	: 'USB08bb:2902'
  Controls      : 4
  Simple ctrls  : 1
Simple mixer control 'PCM',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 128
  Mono:
  Front Left: Playback 108 [84%] [-20.00dB] [on]
  Front Right: Playback 108 [84%] [-20.00dB] [on]


!!Alsactl output
!!--------------

--startcollapse--
state.Intel {
	control.1 {
		iface MIXER
		name 'Line Out Playback Volume'
		value.0 39
		value.1 39
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 39'
			dbmin -5850
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.2 {
		iface MIXER
		name 'Line Out Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.3 {
		iface MIXER
		name 'Headphone Playback Volume'
		value.0 39
		value.1 39
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 39'
			dbmin -5850
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.4 {
		iface MIXER
		name 'Headphone Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.5 {
		iface MIXER
		name 'Speaker Playback Volume'
		value 31
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 31'
			dbmin -4650
			dbmax 0
			dbvalue.0 0
		}
	}
	control.6 {
		iface MIXER
		name 'Speaker Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.7 {
		iface MIXER
		name 'Independent HP'
		value Disabled
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 Disabled
			item.1 Enabled
		}
	}
	control.8 {
		iface MIXER
		name 'Loopback Mixing'
		value Disabled
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 Disabled
			item.1 Enabled
		}
	}
	control.9 {
		iface MIXER
		name 'Mic Playback Volume'
		value.0 0
		value.1 0
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 31'
			dbmin -3450
			dbmax 1200
			dbvalue.0 -3450
			dbvalue.1 -3450
		}
	}
	control.10 {
		iface MIXER
		name 'Mic Playback Switch'
		value.0 false
		value.1 false
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.11 {
		iface MIXER
		name 'Line Playback Volume'
		value.0 0
		value.1 0
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 31'
			dbmin -3450
			dbmax 1200
			dbvalue.0 -3450
			dbvalue.1 -3450
		}
	}
	control.12 {
		iface MIXER
		name 'Line Playback Switch'
		value.0 false
		value.1 false
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.13 {
		iface MIXER
		name 'Auto-Mute Mode'
		value 'Line Out+Speaker'
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 Disabled
			item.1 'Speaker Only'
			item.2 'Line Out+Speaker'
		}
	}
	control.14 {
		iface MIXER
		name 'Input Source'
		value Mic
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 Mic
			item.1 Line
			item.2 'Stereo Mix'
		}
	}
	control.15 {
		iface MIXER
		name 'Input Source'
		index 1
		value Mic
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 Mic
			item.1 Line
			item.2 'Stereo Mix'
		}
	}
	control.16 {
		iface MIXER
		name 'Capture Volume'
		value.0 47
		value.1 47
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 54'
			dbmin -5850
			dbmax 2250
			dbvalue.0 1200
			dbvalue.1 1200
		}
	}
	control.17 {
		iface MIXER
		name 'Capture Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.18 {
		iface MIXER
		name 'Capture Volume'
		index 1
		value.0 0
		value.1 0
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 54'
			dbmin -5850
			dbmax 2250
			dbvalue.0 -5850
			dbvalue.1 -5850
		}
	}
	control.19 {
		iface MIXER
		name 'Capture Switch'
		index 1
		value.0 false
		value.1 false
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.20 {
		iface MIXER
		name 'Mic Boost Volume'
		value.0 0
		value.1 0
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 3'
			dbmin 0
			dbmax 3000
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.21 {
		iface MIXER
		name 'Line Boost Volume'
		value.0 0
		value.1 0
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 3'
			dbmin 0
			dbmax 3000
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.22 {
		iface MIXER
		name 'Master Playback Volume'
		value 34
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 39'
			dbmin -5850
			dbmax 0
			dbvalue.0 -750
		}
	}
	control.23 {
		iface MIXER
		name 'Master Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.24 {
		iface CARD
		name 'Mic Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.25 {
		iface CARD
		name 'Line Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.26 {
		iface CARD
		name 'Line Out Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.27 {
		iface CARD
		name 'Front Headphone Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.28 {
		iface CARD
		name 'Speaker Phantom Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.29 {
		iface MIXER
		name 'Beep Playback Volume'
		value 15
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 15'
			dbmin -4500
			dbmax 0
			dbvalue.0 0
		}
	}
	control.30 {
		iface MIXER
		name 'Beep Playback Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.31 {
		iface PCM
		name 'Playback Channel Map'
		value.0 0
		value.1 0
		comment {
			access read
			type INTEGER
			count 2
			range '0 - 36'
		}
	}
	control.32 {
		iface PCM
		name 'Capture Channel Map'
		value.0 0
		value.1 0
		comment {
			access read
			type INTEGER
			count 2
			range '0 - 36'
		}
	}
	control.33 {
		iface PCM
		device 2
		name 'Playback Channel Map'
		value.0 0
		value.1 0
		comment {
			access read
			type INTEGER
			count 2
			range '0 - 36'
		}
	}
	control.34 {
		iface PCM
		device 2
		name 'Capture Channel Map'
		value.0 0
		value.1 0
		comment {
			access read
			type INTEGER
			count 2
			range '0 - 36'
		}
	}
	control.35 {
		iface MIXER
		name 'PCM Playback Volume'
		value.0 255
		value.1 255
		comment {
			access 'read write user'
			type INTEGER
			count 2
			range '0 - 255'
			tlv '0000000100000008ffffec1400000014'
			dbmin -5100
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
}
state.hiFace2 {
	control.1 {
		iface PCM
		name 'Playback Channel Map'
		value.0 0
		value.1 0
		comment {
			access read
			type INTEGER
			count 2
			range '0 - 36'
		}
	}
	control.2 {
		iface MIXER
		name 'M2Tech Audio 2.0 Output Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.3 {
		iface MIXER
		name 'M2Tech Audio 2.0 Output Playback Switch'
		index 1
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.4 {
		iface MIXER
		name 'M2Tech Audio 2.0 Output Playback Volume'
		value.0 127
		value.1 127
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 127'
			dbmin -12700
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.5 {
		iface MIXER
		name 'M2Tech Audio 2.0 Output Playback Volume'
		index 1
		value 127
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 127'
			dbmin -12700
			dbmax 0
			dbvalue.0 0
		}
	}
	control.6 {
		iface CARD
		name 'M2Tech Internal Clock Validity'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
}
state.bithead {
	control.1 {
		iface PCM
		name 'Playback Channel Map'
		value.0 0
		value.1 0
		comment {
			access read
			type INTEGER
			count 2
			range '0 - 36'
		}
	}
	control.2 {
		iface PCM
		name 'Capture Channel Map'
		value.0 0
		value.1 0
		comment {
			access read
			type INTEGER
			count 2
			range '0 - 36'
		}
	}
	control.3 {
		iface MIXER
		name 'PCM Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.4 {
		iface MIXER
		name 'PCM Playback Volume'
		value.0 108
		value.1 108
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 128'
			dbmin -12800
			dbmax 0
			dbvalue.0 -2000
			dbvalue.1 -2000
		}
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

adiantum
aes_generic
auth_rpcgss
autofs4
bridge
cdrom
chacha_generic
chacha_x86_64
cpufreq_conservative
cpufreq_ondemand
cpufreq_powersave
cpufreq_userspace
dcdbas
dm_crypt
dm_mod
evdev
fan
floppy
fscache
grace
irqbypass
kvm
kvm_intel
libaes
libchacha
libpoly1305
llc
lockd
md_mod
nfs
nfs_ssc
nfsd
nfsv4
nhpoly1305
nhpoly1305_sse2
psmouse
raid1
sg
snd
snd_hda_codec
snd_hda_codec_analog
snd_hda_codec_generic
snd_hda_core
snd_hda_intel
snd_hwdep
snd_intel_dspcfg
snd_pcm
snd_rawmidi
snd_seq_device
snd_timer
snd_usb_audio
snd_usbmidi_lib
soundcore
sr_mod
stp
sunrpc
tap
tg3
tun
usb_storage
vhost
vhost_iotlb
vhost_net
xfs


!!Sysfs Files
!!-----------

/sys/class/sound/hwC0D0/init_pin_configs:
0x11 0x02214040
0x12 0x01014010
0x13 0x991301f0
0x14 0x02a19020
0x15 0x01813030
0x16 0x413301f0
0x17 0x41a601f0
0x18 0x41a601f0
0x1a 0x41f301f0
0x1b 0x414511f0
0x1c 0x41a190f0

/sys/class/sound/hwC0D0/driver_pin_configs:

/sys/class/sound/hwC0D0/user_pin_configs:

/sys/class/sound/hwC0D0/init_verbs:

/sys/class/sound/hwC0D0/hints:


!!ALSA/HDA dmesg
!!--------------

[    3.707953] ACPI: Added _OSI(Linux-Dell-Video)
[    3.707953] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    3.708739] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
--
[   13.554333] usbcore: registered new interface driver usb-storage
[   13.706277] snd_hda_codec_analog hdaudioC0D0: autoconfig for AD1984: line_outs=1 (0x12/0x0/0x0/0x0/0x0) type:line
[   13.706588] snd_hda_codec_analog hdaudioC0D0:    speaker_outs=1 (0x13/0x0/0x0/0x0/0x0)
[   13.707138] snd_hda_codec_analog hdaudioC0D0:    hp_outs=1 (0x11/0x0/0x0/0x0/0x0)
[   13.707893] snd_hda_codec_analog hdaudioC0D0:    mono: mono_out=0x0
[   13.708652] snd_hda_codec_analog hdaudioC0D0:    inputs:
[   13.709417] snd_hda_codec_analog hdaudioC0D0:      Mic=0x14
[   13.710168] snd_hda_codec_analog hdaudioC0D0:      Line=0x15
[   13.719874] input: HDA Intel Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input9
[   13.720221] input: HDA Intel Line as /devices/pci0000:00/0000:00:1b.0/sound/card0/input10
[   13.720732] input: HDA Intel Line Out as /devices/pci0000:00/0000:00:1b.0/sound/card0/input11
[   13.721449] input: HDA Intel Front Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input12
[   14.611934] scsi 6:0:0:0: Direct-Access     SMSC     223 U HS-CF      3.60 PQ: 0 ANSI: 0
--
[  100.612371] sd 6:0:0:3: [sdh] Attached SCSI removable disk
[  100.615932] usbcore: registered new interface driver snd-usb-audio
[  859.524565] usb 1-1.1.4: new full-speed USB device number 14 using ehci-pci


!!Packages installed
!!--------------------

ii  alsa-utils                                       1.2.4-1                             amd64        Utilities for configuring and using ALSA


--2DP8zP51ciBpu7PO--
