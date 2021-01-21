Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 469A62FF5CE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 21:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbhAUU1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 15:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbhAUUZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 15:25:47 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A007C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 12:25:06 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id g12so4463811ejf.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 12:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=xcEz0hn0ppJ2zmlZeTS5s78l7N59XcxuLUcCTKluJso=;
        b=CF8HmASLgBSzIL6qYuHKaEOpgbVK0fmoPbv0U4PqtN83eoqldwvWCKOCElBeXRdHd/
         tYgOMqwvRZQm178VSi6dSvvGCVGHfCtgkgmos7QeUxj78zU7lBFNZmkpQZGLeMlm4bF1
         R/aZcJlv7evAHv+TZbyn3FE2MvE4oMsj9V0f928SUXQyR3xI3rveL/rebyZ0FM8nRwWB
         9N8uBmUzfWK9DWbCZnNVA4U1uCnJE3OMB1h+HYS7KE85gHc7s8BFb6CzPXxZTQ6ceedM
         d0xS5ckkCndoOJtEiNSDURFYyr2WHBwTvJ8sqtfrXsnavnNiClLgtRvspelJc+yX5Bqa
         OK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=xcEz0hn0ppJ2zmlZeTS5s78l7N59XcxuLUcCTKluJso=;
        b=L0qlu5SUWo6lIV4qxjyAtxVoHxJFjrF9Tanz0HAhzHcBZQTyeawj3/eT56C8w+2MxQ
         /9Lz1bT+/QDfXLr7JiDhUXcWF02wGeygaPJYI9MPwJvboT2o4otnSaFs+YDwOyG6jigv
         ghlyfe6NaMY9G2bInpMRKGx///hEP/8YYrzJC7w0tW2KlhV/AmORr/Nw4puhQYjr4Ba3
         fa5qy6mIhRp82NSSl2e+GvRz6BELA/yBtjSvYPFKJ+H1fsGgvIuJCeKY+n8eNYiUiSoQ
         NgayQJ+l8Q04EZX/LSBQwsAUd+CXHL6FubjtNrYiPwHuKRHTQ/F93qXqz21WTk7Wwpr8
         Z3iQ==
X-Gm-Message-State: AOAM533X19K0+UwD0VtejMhxNqFyFqPTOnVaXGSi7j7sdaPEa1vw3FGR
        qSbRnV3aTLO79wYJIGtqbICXDqnnC3CBxg==
X-Google-Smtp-Source: ABdhPJzC0leBP98p/bjwJEe33O+/AFfhKPzwbbM7jzJ4lEfI2rHVa/TS+G8hONRm3PJQ20qEYJ8mMg==
X-Received: by 2002:a17:906:40ca:: with SMTP id a10mr811974ejk.295.1611260704811;
        Thu, 21 Jan 2021 12:25:04 -0800 (PST)
Received: from [192.168.1.8] (host-n1-71-238.telpol.net.pl. [83.242.71.238])
        by smtp.gmail.com with ESMTPSA id cy13sm3366590edb.27.2021.01.21.12.25.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 12:25:04 -0800 (PST)
From:   =?UTF-8?Q?=c5=81ukasz_Czuja?= <lukasz.czuja@gmail.com>
Subject: Trying to get Sound Blaster Extigy to work under Kbuntu 20.10 kernel
 5.8.0-38
To:     linux-kernel@vger.kernel.org
Message-ID: <577d3031-79bd-08db-b182-8e729820a6f0@gmail.com>
Date:   Thu, 21 Jan 2021 21:25:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I don't know if its best place to ask for a little help in what I think 
are errors in linux audio driver, however I thought I ask for some 
assistance.

I found a very old Creative Sound Blaster Extigy device and connected it 
to my Acer Aspire e5-571g laptop. I was hopeful it would give me a 5.1 
surround sound from an USB 1.1 (full speed) connection which: pacmd 
list-cards command shows :

     index: 2
         name: 
<alsa_card.usb-Creative_Technology_Ltd._Sound_Blaster_Extigy-00>
         driver: <*module-alsa-card.c*>
         owner module: 32
         properties:
                 alsa.card = "2"
                 alsa.card_name = "Sound Blaster Extigy"
                 alsa.long_card_name = "Creative Technology Ltd. Sound 
Blaster Extigy at usb-0000:00:14.0-3, *full speed*"
                 alsa.driver_name = "*snd_usb_audio*"
                 device.bus_path = "pci-0000:00:14.0-usb-0:3:1.0"
                 sysfs.path = 
"/devices/pci0000:00/0000:00:14.0/usb2/2-3/2-3:1.0/sound/card2"
                 udev.id = 
"usb-Creative_Technology_Ltd._Sound_Blaster_Extigy-00"
                 device.bus = "usb"
                 device.vendor.id = "041e"
                 device.vendor.name = "Creative Technology, Ltd"
                 device.product.id = "3000"
                 device.product.name = "SoundBlaster Extigy"
                 device.serial = 
"Creative_Technology_Ltd._Sound_Blaster_Extigy"
                 device.string = "2"
                 device.description = "SoundBlaster Extigy"
                 module-udev-detect.discovered = "1"
                 device.icon_name = "audio-card-usb"
         profiles:
                 input:stereo-fallback: Wejście Stereo (priority 51, 
available: unknown)
                 input:multichannel-input: Wejście Wielokanałowe 
(priority 1, available: unknown)
*output:analog-stereo*: Wyjście Analogowe stereo (priority 6500, 
available: unknown)
                 output:analog-stereo+input:stereo-fallback: Wyjście 
Analogowe stereo + Wejście Stereo (priority 6551, available: unknown)
                 output:analog-stereo+input:multichannel-input: Wyjście 
Analogowe stereo + Wejście Wielokanałowe (priority 6501, available: unknown)
                 output:analog-surround-21: Wyjście Analogowe 
przestrzenne 2.1 (priority 1300, available: unknown)
                 output:analog-surround-21+input:stereo-fallback: 
Wyjście Analogowe przestrzenne 2.1 + Wejście Stereo (priority 1351, 
available: unknown)
output:analog-surround-21+input:multichannel-input: Wyjście Analogowe 
przestrzenne 2.1 + Wejście Wielokanałowe (priority 1301, available: unknown)
                 output:analog-surround-41: Wyjście Analogowe 
przestrzenne 4.1 (priority 1300, available: unknown)
                 output:analog-surround-41+input:stereo-fallback: 
Wyjście Analogowe przestrzenne 4.1 + Wejście Stereo (priority 1351, 
available: unknown)
output:analog-surround-41+input:multichannel-input: Wyjście Analogowe 
przestrzenne 4.1 + Wejście Wielokanałowe (priority 1301, available: unknown)
                 output:analog-surround-50: Wyjście Analogowe 
przestrzenne 5.0 (priority 1200, available: unknown)
                 output:analog-surround-50+input:stereo-fallback: 
Wyjście Analogowe przestrzenne 5.0 + Wejście Stereo (priority 1251, 
available: unknown)
output:analog-surround-50+input:multichannel-input: Wyjście Analogowe 
przestrzenne 5.0 + Wejście Wielokanałowe (priority 1201, available: unknown)
*output:analog-surround-51*: Wyjście Analogowe przestrzenne 5.1 
(priority 1300, available: unknown)
                 output:analog-surround-51+input:stereo-fallback: 
Wyjście Analogowe przestrzenne 5.1 + Wejście Stereo (priority 1351, 
available: unknown)
output:analog-surround-51+input:multichannel-input: Wyjście Analogowe 
przestrzenne 5.1 + Wejście Wielokanałowe (priority 1301, available: unknown)
*output:iec958-stereo*: Wyjście Cyfrowe stereo (IEC958) (priority 5500, 
available: unknown)
                 output:iec958-stereo+input:stereo-fallback: Wyjście 
Cyfrowe stereo (IEC958) + Wejście Stereo (priority 5551, available: unknown)
                 output:iec958-stereo+input:multichannel-input: Wyjście 
Cyfrowe stereo (IEC958) + Wejście Wielokanałowe (priority 5501, 
available: unknown)
                 off: Wyłączone (priority 0, available: unknown)
         active profile: <output:analog-stereo+input:stereo-fallback>
         sinks:
alsa_output.usb-Creative_Technology_Ltd._Sound_Blaster_Extigy-00.analog-stereo/#2: 
SoundBlaster Extigy Analogowe stereo
         sources:
alsa_output.usb-Creative_Technology_Ltd._Sound_Blaster_Extigy-00.analog-stereo.monitor/#6: 
Monitor of SoundBlaster Extigy Analogowe stereo
alsa_input.usb-Creative_Technology_Ltd._Sound_Blaster_Extigy-00.stereo-fallback/#7: 
SoundBlaster Extigy Stereo
         ports:
                 analog-input-mic: Microphone (priority 8700, latency 
offset 0 usec, available: unknown)
                         properties:
                                 device.icon_name = "audio-input-microphone"
                 analog-input-linein: Line In (priority 8100, latency 
offset 0 usec, available: unknown)
                         properties:

                 multichannel-input: Multichannel Input (priority 0, 
latency offset 0 usec, available: unknown)
                         properties:

*analog-output-speaker*: Speakers (priority 10000, latency offset 0 
usec, available: unknown)
                         properties:
                                 device.icon_name = "audio-speakers"
*iec958-stereo-output*: Digital Output (S/PDIF) (priority 0, latency 
offset 0 usec, available: unknown)
                         properties:


What seems to work is output:iec958-stereo, a 2.0 digital stereo and 
output:analog-stereo, 2.0 analog stereo.

When I switch to any multichannel output the sound that comes out of 
most speakers seems to be delayed and is interrupted by "mettalic" noise.

lsusb: Bus 002 Device 006: ID 041e:3000 Creative Technology, Ltd 
SoundBlaster Extigy

lsmod | grep snd
*snd_usb_audio*         286720  4
snd_usbmidi_lib        36864  1 snd_usb_audio
snd_seq_dummy          16384  0
snd_hrtimer            16384  1
snd_hda_codec_realtek   131072  1
snd_hda_codec_generic    81920  1 snd_hda_codec_realtek
ledtrig_audio          16384  1 snd_hda_codec_generic
snd_hda_codec_hdmi     61440  1
snd_hda_intel          53248  4
snd_intel_dspcfg       24576  1 snd_hda_intel
snd_hda_codec         143360  4 
snd_hda_codec_generic,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec_realtek
snd_hda_core           94208  5 
snd_hda_codec_generic,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,snd_hda_codec_realtek
snd_hwdep              20480  2 snd_usb_audio,snd_hda_codec
snd_pcm               118784  6 
snd_hda_codec_hdmi,snd_hda_intel,snd_usb_audio,snd_hda_codec,snd_hda_core
snd_seq_midi           20480  0
snd_seq_midi_event     16384  1 snd_seq_midi
snd_rawmidi            36864  2 snd_seq_midi,snd_usbmidi_lib
snd_seq                73728  9 
snd_seq_midi,snd_seq_midi_event,snd_seq_dummy
snd_seq_device         16384  3 snd_seq,snd_seq_midi,snd_rawmidi
snd_timer              40960  3 snd_seq,snd_hrtimer,snd_pcm
mc                     57344  5 
videodev,snd_usb_audio,videobuf2_v4l2,uvcvideo,videobuf2_common
snd                    94208  31 
snd_hda_codec_generic,snd_seq,snd_seq_device,snd_hda_codec_hdmi,snd_hwdep,snd_hda_intel,snd_usb_audio,snd_usbmidi_lib,snd_hda_codec,snd_hda_codec_realtek,snd_timer,snd_pcm,snd_rawmidi
soundcore              16384  1 snd

It may be the case that USB 1.1 here is a limitation. Also maybe some 
inkernel changes over the years made some impact on Extigy's driver. Can 
any one help out what should I look for to get it to work?

Thanks,

Łukasz Czuja

