Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3EB288352
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 09:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731076AbgJIHPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 03:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgJIHPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 03:15:06 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A449C0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 00:15:06 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id h24so11604042ejg.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 00:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=8Oa68Dwvz/I7hc5gLl4a6ZH9ks7ayAb8wm2amPdlQxQ=;
        b=gJw44XwxJU0QsCaJFLzOshUTwt15ZWENvi2dDVOdFyKlwYA6wzprqDBqEZPp8cYb9m
         bkN39xT/72q9bqXgSHB99KP3AmCKAg5Zs6ApGKk5o6Yoy9N6AsiSQ0Lvy+SW2jyUc/tV
         ai2xmKseCCvyzEdRtaeRCxTaKVL70SXI4b/SrXFO/fXAZ/WR+WhxFoGO6FDukq4G4UHm
         iAinWCwEDb1ZHbV4JQicu4IrOvPZBk4F7eGJUeaWxTTjeY5fItCeTmNP5ddMyY7sUPmd
         3xpd7PFYjOoCq222WzvYH4o16t1liaJ+tjiCSMffuyscSk1F4qZeLAEEH/jE6sPvkzPm
         ne3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8Oa68Dwvz/I7hc5gLl4a6ZH9ks7ayAb8wm2amPdlQxQ=;
        b=rEsj/dxBG8IYZMh4hY23r8mE1Ce/grrT+BMjyO+QqmbwBM1fTy74cHagNR91ZTxw5s
         JZV9CIQDqZvReGREQ3e6FOTBOHkhh5IqkGE69rjVXPgrjZhXEIdTZqoKnixpwzyjzLtD
         oica0rxLeOFXKCf5Ef+bjshHkFipd6PEXjBtwD0II66Vy6EV9IsmGzHnIR7l24TZX7DO
         R/tjlo/zHrwckOORQgaKQfZ8QjQ761mKLdQ4Eq8CSbBTD5dmUPPX/8IzYoUF5+wAL2FI
         w6aLv3IuisefZUviCzfu4rYFLLh9FhRN+m25qSF7petVT/O4dYH/CJD8HcKcklpiqsN4
         t9Zg==
X-Gm-Message-State: AOAM531+81fNGw4rf0RVAGdKHtuQz2v5iPdy/QqADASdRft2doKjMArs
        RbiM+FnXE6MnWdbOPFv0jNB5Eldr1asqdhrPIvr5kDfu3660UQ==
X-Google-Smtp-Source: ABdhPJzeBXij/GspUpa/5GfeNRPBThbO39tbmz31A1ZTEqRDC/QoVtRsReCbI0R5TMqmBBkDNhzYTJHkIyJjuh5p6WQ=
X-Received: by 2002:a17:906:5613:: with SMTP id f19mr12610251ejq.441.1602227704761;
 Fri, 09 Oct 2020 00:15:04 -0700 (PDT)
MIME-Version: 1.0
From:   Fabio Coatti <fabio.coatti@gmail.com>
Date:   Fri, 9 Oct 2020 09:14:53 +0200
Message-ID: <CADpTngV5uuDTxVOOOSxc3wh8pP64Gyjtt48HgWrhNrQDrnK3UQ@mail.gmail.com>
Subject: Lenovo P50 headphone issue
To:     LKML <linux-kernel@vger.kernel.org>, hui.wang@canonical.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
I'm experiencing issues with a Lenovo P50 regarding headphones. It has
some similarities with the issue fixed in 5.8.13 with
commit ad0643252831ede7d6ab7b70a4f03768e032e6b4
Author: Hui Wang <hui.wang@canonical.com>
Date:   Mon Sep 14 14:51:18 2020 +0800

    ALSA: hda/realtek - Couldn't detect Mic if booting with headset plugged

I've been seeing this behavior since some time and now I'm running 5.8.14
Description: sometimes when I start the laptop with headphones plugged
in, no sound comes out of the headphones. The only thing I can hear is
the "usual" click when the kernel boots. Sound config in the gui
reports headphones plugged, nothing seems really wrong but no sound.
Removing headphones does not help: sound can be heard from laptop
loudspeakers but  to get back the sound on headphones I have to unplug
the jack, reboot the laptop and once booted, inserting the headphones
makes everything work as  expected. Gui tools report everything as
expected: headphones inserted, volume is ok and so on.
Below you can find the dmesg boot messages related to sound devices.
If you need more details please let me know.
If I picked the wrong address to report the issue please let me know,
I'll try to contact the relevant sources.
Please note that I'm not subscribed to this list even though I monitor
it, so being in CC: will be really appreciated.
Many thanks for any answer.
[Fri Oct  9 08:20:05 2020] snd_hda_codec_realtek hdaudioC0D0:
autoconfig for ALC298: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[Fri Oct  9 08:20:05 2020] snd_hda_codec_realtek hdaudioC0D0:
speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[Fri Oct  9 08:20:05 2020] snd_hda_codec_realtek hdaudioC0D0:
hp_outs=2 (0x17/0x21/0x0/0x0/0x0)
[Fri Oct  9 08:20:05 2020] snd_hda_codec_realtek hdaudioC0D0:    mono:
mono_out=0x0
[Fri Oct  9 08:20:05 2020] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[Fri Oct  9 08:20:05 2020] snd_hda_codec_realtek hdaudioC0D0:      Mic=0x18
[Fri Oct  9 08:20:05 2020] snd_hda_codec_realtek hdaudioC0D0:      Dock Mic=0x19
[Fri Oct  9 08:20:05 2020] snd_hda_codec_realtek hdaudioC0D0:
Internal Mic=0x12
[Fri Oct  9 08:20:05 2020] videodev: Linux video capture interface: v2.00
[Fri Oct  9 08:20:05 2020] input: HDA NVidia HDMI/DP,pcm=3 as
/devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input15
[Fri Oct  9 08:20:05 2020] input: HDA NVidia HDMI/DP,pcm=7 as
/devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input16
[Fri Oct  9 08:20:05 2020] input: HDA NVidia HDMI/DP,pcm=8 as
/devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input17
[Fri Oct  9 08:20:05 2020] input: HDA NVidia HDMI/DP,pcm=9 as
/devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input18
[Fri Oct  9 08:20:05 2020] input: HDA NVidia HDMI/DP,pcm=10 as
/devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input19
[Fri Oct  9 08:20:05 2020] input: HDA NVidia HDMI/DP,pcm=11 as
/devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input20
[Fri Oct  9 08:20:05 2020] input: HDA Intel PCH Mic as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input22
[Fri Oct  9 08:20:05 2020] input: HDA Intel PCH Dock Mic as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input23
[Fri Oct  9 08:20:05 2020] input: HDA Intel PCH Dock Headphone as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input24
[Fri Oct  9 08:20:05 2020] input: HDA Intel PCH Headphone as
/devices/pci0000:00/0000:00:1f.3/sound/card0/input25
--
Fabio
