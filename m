Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A43882884E3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 10:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732649AbgJIIHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 04:07:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51545 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732614AbgJIIG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 04:06:59 -0400
Received: from [125.35.49.90] (helo=[10.1.1.101])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <hui.wang@canonical.com>)
        id 1kQnQW-0007ln-DI; Fri, 09 Oct 2020 08:06:56 +0000
Subject: Re: Lenovo P50 headphone issue
To:     Fabio Coatti <fabio.coatti@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <CADpTngV5uuDTxVOOOSxc3wh8pP64Gyjtt48HgWrhNrQDrnK3UQ@mail.gmail.com>
Cc:     Fabio Coatti <fabio.coatti@gmail.com>
From:   Hui Wang <hui.wang@canonical.com>
Message-ID: <8c351a09-759a-62f3-1f8c-d61f53d991fc@canonical.com>
Date:   Fri, 9 Oct 2020 16:06:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CADpTngV5uuDTxVOOOSxc3wh8pP64Gyjtt48HgWrhNrQDrnK3UQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

Looks like the P50 has a different codec, it is alc298, and I don't have 
the P50 to debug. It is better to report a bug to bugzilla against the 
upstream kernel and cc the realtek engineers to take a look.

Regards,

Hui.

On 2020/10/9 下午3:14, Fabio Coatti wrote:
> Hi All,
> I'm experiencing issues with a Lenovo P50 regarding headphones. It has
> some similarities with the issue fixed in 5.8.13 with
> commit ad0643252831ede7d6ab7b70a4f03768e032e6b4
> Author: Hui Wang <hui.wang@canonical.com>
> Date:   Mon Sep 14 14:51:18 2020 +0800
>
>      ALSA: hda/realtek - Couldn't detect Mic if booting with headset plugged
>
> I've been seeing this behavior since some time and now I'm running 5.8.14
> Description: sometimes when I start the laptop with headphones plugged
> in, no sound comes out of the headphones. The only thing I can hear is
> the "usual" click when the kernel boots. Sound config in the gui
> reports headphones plugged, nothing seems really wrong but no sound.
> Removing headphones does not help: sound can be heard from laptop
> loudspeakers but  to get back the sound on headphones I have to unplug
> the jack, reboot the laptop and once booted, inserting the headphones
> makes everything work as  expected. Gui tools report everything as
> expected: headphones inserted, volume is ok and so on.
> Below you can find the dmesg boot messages related to sound devices.
> If you need more details please let me know.
> If I picked the wrong address to report the issue please let me know,
> I'll try to contact the relevant sources.
> Please note that I'm not subscribed to this list even though I monitor
> it, so being in CC: will be really appreciated.
> Many thanks for any answer.
> [Fri Oct  9 08:20:05 2020] snd_hda_codec_realtek hdaudioC0D0:
> autoconfig for ALC298: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
> [Fri Oct  9 08:20:05 2020] snd_hda_codec_realtek hdaudioC0D0:
> speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
> [Fri Oct  9 08:20:05 2020] snd_hda_codec_realtek hdaudioC0D0:
> hp_outs=2 (0x17/0x21/0x0/0x0/0x0)
> [Fri Oct  9 08:20:05 2020] snd_hda_codec_realtek hdaudioC0D0:    mono:
> mono_out=0x0
> [Fri Oct  9 08:20:05 2020] snd_hda_codec_realtek hdaudioC0D0:    inputs:
> [Fri Oct  9 08:20:05 2020] snd_hda_codec_realtek hdaudioC0D0:      Mic=0x18
> [Fri Oct  9 08:20:05 2020] snd_hda_codec_realtek hdaudioC0D0:      Dock Mic=0x19
> [Fri Oct  9 08:20:05 2020] snd_hda_codec_realtek hdaudioC0D0:
> Internal Mic=0x12
> [Fri Oct  9 08:20:05 2020] videodev: Linux video capture interface: v2.00
> [Fri Oct  9 08:20:05 2020] input: HDA NVidia HDMI/DP,pcm=3 as
> /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input15
> [Fri Oct  9 08:20:05 2020] input: HDA NVidia HDMI/DP,pcm=7 as
> /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input16
> [Fri Oct  9 08:20:05 2020] input: HDA NVidia HDMI/DP,pcm=8 as
> /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input17
> [Fri Oct  9 08:20:05 2020] input: HDA NVidia HDMI/DP,pcm=9 as
> /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input18
> [Fri Oct  9 08:20:05 2020] input: HDA NVidia HDMI/DP,pcm=10 as
> /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input19
> [Fri Oct  9 08:20:05 2020] input: HDA NVidia HDMI/DP,pcm=11 as
> /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input20
> [Fri Oct  9 08:20:05 2020] input: HDA Intel PCH Mic as
> /devices/pci0000:00/0000:00:1f.3/sound/card0/input22
> [Fri Oct  9 08:20:05 2020] input: HDA Intel PCH Dock Mic as
> /devices/pci0000:00/0000:00:1f.3/sound/card0/input23
> [Fri Oct  9 08:20:05 2020] input: HDA Intel PCH Dock Headphone as
> /devices/pci0000:00/0000:00:1f.3/sound/card0/input24
> [Fri Oct  9 08:20:05 2020] input: HDA Intel PCH Headphone as
> /devices/pci0000:00/0000:00:1f.3/sound/card0/input25
> --
> Fabio
