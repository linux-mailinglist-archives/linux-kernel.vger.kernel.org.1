Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F5C3018B7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 23:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbhAWWln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 17:41:43 -0500
Received: from audible.transient.net ([24.143.126.66]:37096 "HELO
        audible.transient.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725922AbhAWWll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 17:41:41 -0500
Received: (qmail 8376 invoked from network); 23 Jan 2021 22:40:59 -0000
Received: from cucamonga.audible.transient.net (192.168.2.5)
  by canarsie.audible.transient.net with QMQP; 23 Jan 2021 22:40:59 -0000
Received: (nullmailer pid 2881 invoked by uid 1000);
        Sat, 23 Jan 2021 22:40:59 -0000
Date:   Sat, 23 Jan 2021 22:40:59 +0000
From:   Jamie Heilman <jamie@audible.transient.net>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: bisected regression in v5.11-rc1 snd-usb-audio
Message-ID: <YAyl+6XZHRjzDUcP@audible.transient.net>
Mail-Followup-To: Takashi Iwai <tiwai@suse.de>,
        linux-kernel@vger.kernel.org
References: <YAqIJHzE3UG51G/U@audible.transient.net>
 <s5hzh118ioz.wl-tiwai@suse.de>
 <YAqjBLt3eLG5GY/4@audible.transient.net>
 <s5him7p89oe.wl-tiwai@suse.de>
 <YAwDkhRVkrEna8pV@audible.transient.net>
 <s5hwnw36d0k.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hwnw36d0k.wl-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai wrote:
> On Sat, 23 Jan 2021 12:08:02 +0100,
> Jamie Heilman wrote:
> > 
> > > If the problem is still seen with the very latest Linus tree and the
> > > previous patch, please enable the dyndbg, e.g. pass dydbg=+p option to
> > > snd-usb-audio module, i.e. reload like
> > >    modprobe snd-usb-audio dydbg=+p
> > > or boot with
> > >    snd_usb_audio.dyndbg=+p
> > > boot option, retest, and give the kernel messages.
> > 
> > OK, updated to 5.11.0-rc4-00202-gfe75a21824e7, repatched & rebuilt with:
> > CONFIG_SND_DEBUG=y
> > CONFIG_SND_CTL_VALIDATION=y
> > CONFIG_DYNAMIC_DEBUG=y
> > CONFIG_DYNAMIC_DEBUG_CORE=y
> > 
> > and added dyndbg=+p to my snd-usb-audio options, dmesg after an
> > attempted aplay execution is attached.
> (snip)
> > [  108.941521] WARNING: CPU: 0 PID: 2776 at sound/core/pcm_lib.c:1148 snd_pcm_hw_rule_add+0xd3/0x160 [snd_pcm]
> 
> OK, this must be the culprit of the weird behavior.
> I totally overlooked that the max dependencies are three because of
> the terminator.
> 
> Could you try the patch below in addition?

Yep, this works now, thanks!  FWIW, here's what the debug output looks
like when its working, and I start jack now:

usb 1-1.1.2: 1:1: found sync_ep=0x81, iface=1, alt=1, implicit_fb=0
usb 1-1.1.2: 1:1: add audio endpoint 0x1
usb 1-1.1.2: Creating new data endpoint #1
usb 1-1.1.2: Creating new sync endpoint #81
usb 1-1.1.2: 1:1 Set sample rate 192000, clock 40
usb 1-1.1.2: [10] FU [M2Tech Audio 2.0 Output Playback Switch] ch = 2, val = 0/1/1
usb 1-1.1.2: [10] FU [M2Tech Audio 2.0 Output Playback Switch] ch = 1, val = 0/1/1
usb 1-1.1.2: RANGE setting not yet supported
usb 1-1.1.2: [10] FU [M2Tech Audio 2.0 Output Playback Volume] ch = 2, val = -32512/0/256
usb 1-1.1.2: RANGE setting not yet supported
usb 1-1.1.2: [10] FU [M2Tech Audio 2.0 Output Playback Volume] ch = 1, val = -32512/0/256
usb 1-1.1.2: Open EP 0x1, iface=1:1, idx=0
usb 1-1.1.2:   channels=2, rate=96000, format=S32_LE, period_bytes=8192, periods=3, implicit_fb=0
usb 1-1.1.2: Open EP 0x81, iface=1:1, idx=1
usb 1-1.1.2:   channels=2, rate=96000, format=S32_LE, period_bytes=8192, periods=3, implicit_fb=0
usb 1-1.1.2: Setting usb interface 1:0 for EP 0x1
usb 1-1.1.2: 1:1 Set sample rate 96000, clock 40
usb 1-1.1.2: Setting params for data EP 0x1, pipe 0x8600
usb 1-1.1.2: Set up 12 URBS, ret=0
usb 1-1.1.2: Setting usb interface 1:1 for EP 0x1
usb 1-1.1.2: Setting params for sync EP 0x81, pipe 0x8680
usb 1-1.1.2: Set up 4 URBS, ret=0
usb 1-1.1.2: Starting data EP 0x1 (running 0)
usb 1-1.1.2: 12 URBs submitted for EP 0x1
usb 1-1.1.2: Starting sync EP 0x81 (running 0)
usb 1-1.1.2: 4 URBs submitted for EP 0x81
usb 1-1.1.2: 1:1 Start Playback PCM


> --- a/include/sound/pcm.h
> +++ b/include/sound/pcm.h
> @@ -229,7 +229,7 @@ typedef int (*snd_pcm_hw_rule_func_t)(struct snd_pcm_hw_params *params,
>  struct snd_pcm_hw_rule {
>  	unsigned int cond;
>  	int var;
> -	int deps[4];
> +	int deps[5];
>  
>  	snd_pcm_hw_rule_func_t func;
>  	void *private;

-- 
Jamie Heilman                     http://audible.transient.net/~jamie/
