Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB42E288603
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 11:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733109AbgJIJhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 05:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgJIJhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 05:37:09 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68ABC0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 02:37:08 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id c22so12189151ejx.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 02:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cSEiJZUmKGV2L+qNQffmWmUhz6cfOEfnx9drTKYVJXY=;
        b=CgzgYHZAFXxGWaahBEbp1dJVIqI1KF0t+zob3nWZ0l9whn1TlDJIN1kmUwrDfCxjpt
         38Z/r2amWKIEVRbh/grwSQNrjD/nfaWfF91jow48WOzEz4h0qXgq9ID08SsYvmhp02CL
         3apu+jT0rg6K9E5oMhgQswO9XpetGkgLEJFAvGN3AM+pJaNrMsr0GL9xU8fxHB+B8jqr
         COp3j+p9yJQ7y8kcYS3534HaAZFA4sbt3tvs9noavrvnbkWVyFjh+XhtpfFu6KcehFuG
         ucRUuI19keSpWs1zfxs5tItBGDuJQUqVAJAxW8YFXnuQo+5gv/9nqhEoQyVwuDFa3Arh
         1ckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cSEiJZUmKGV2L+qNQffmWmUhz6cfOEfnx9drTKYVJXY=;
        b=jY9gXz1cTKhoh4Yy49zQEDojAOU95yzseUmvv4DSar4uDxyLaZGdTpgaj+5dGNmZ9H
         97rvGj1OW8t4OHh2nfBYv8ixvTfzk3c/lH79ercuAoUyQkT1FyusJ7Q76OHsRs+/aKeU
         DswGOIImY+PK0cfHtDJFkJK/HTgLB4immHtJgAwHbBXRn+QuV5kt0nGL50Byq9BVRVDL
         uykpfZdPdUN7UjjG8ER3PK+GJ9O5L3HcIxuhjHxbRJOaZIHfmHPQSgxbBx0mEEY70dqx
         7XDiEJva2OksseEeIg4f6inzN6EJ4W+CylyVYJmBoIaSIjeC4F5sySkluOgOW+9QRrb5
         NP4A==
X-Gm-Message-State: AOAM5317tNt9qlrDByUxfE6Nh9EBYVTAZz8VaF75D14oUqy/XADs1Lqi
        RHzZwkjZ1ll1eU+I9/z/LKLyq3TiucxbaEk2dFc=
X-Google-Smtp-Source: ABdhPJzy4UYqxpTn9JQ3t51pBf4z6TWE+9AxxTF2qa4g0tGa/Nlyyt3NgDvd1RmxLJiWIgULtigNU84N5g3X5TJ6wJ4=
X-Received: by 2002:a17:906:3092:: with SMTP id 18mr12990403ejv.43.1602236227376;
 Fri, 09 Oct 2020 02:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <CADpTngV5uuDTxVOOOSxc3wh8pP64Gyjtt48HgWrhNrQDrnK3UQ@mail.gmail.com>
 <8c351a09-759a-62f3-1f8c-d61f53d991fc@canonical.com>
In-Reply-To: <8c351a09-759a-62f3-1f8c-d61f53d991fc@canonical.com>
From:   Fabio Coatti <fabio.coatti@gmail.com>
Date:   Fri, 9 Oct 2020 11:36:56 +0200
Message-ID: <CADpTngVptd9P14SXBXLiiYO7EYD0i4cYz2zpb45MzbfptjfFmA@mail.gmail.com>
Subject: Re: Lenovo P50 headphone issue
To:     Hui Wang <hui.wang@canonical.com>, oder_chiou@realtek.com
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,
I opened a bugzilla entry here:
https://bugzilla.kernel.org/show_bug.cgi?id=3D209595
and CC'ed current realtek maintainer.

Many thanks for the suggestion.

Il giorno ven 9 ott 2020 alle ore 10:06 Hui Wang
<hui.wang@canonical.com> ha scritto:
>
> Hi Fabio,
>
> Looks like the P50 has a different codec, it is alc298, and I don't have
> the P50 to debug. It is better to report a bug to bugzilla against the
> upstream kernel and cc the realtek engineers to take a look.
>
> Regards,
>
> Hui.
>
> On 2020/10/9 =E4=B8=8B=E5=8D=883:14, Fabio Coatti wrote:
> > Hi All,
> > I'm experiencing issues with a Lenovo P50 regarding headphones. It has
> > some similarities with the issue fixed in 5.8.13 with
> > commit ad0643252831ede7d6ab7b70a4f03768e032e6b4
> > Author: Hui Wang <hui.wang@canonical.com>
> > Date:   Mon Sep 14 14:51:18 2020 +0800
> >
> >      ALSA: hda/realtek - Couldn't detect Mic if booting with headset pl=
ugged
> >
> > I've been seeing this behavior since some time and now I'm running 5.8.=
14
> > Description: sometimes when I start the laptop with headphones plugged
> > in, no sound comes out of the headphones. The only thing I can hear is
> > the "usual" click when the kernel boots. Sound config in the gui
> > reports headphones plugged, nothing seems really wrong but no sound.
> > Removing headphones does not help: sound can be heard from laptop
> > loudspeakers but  to get back the sound on headphones I have to unplug
> > the jack, reboot the laptop and once booted, inserting the headphones
> > makes everything work as  expected. Gui tools report everything as
> > expected: headphones inserted, volume is ok and so on.
> > Below you can find the dmesg boot messages related to sound devices.
> > If you need more details please let me know.
> > If I picked the wrong address to report the issue please let me know,
> > I'll try to contact the relevant sources.
> > Please note that I'm not subscribed to this list even though I monitor
> > it, so being in CC: will be really appreciated.
> > Many thanks for any answer.
> > [Fri Oct  9 08:20:05 2020] snd_hda_codec_realtek hdaudioC0D0:
> > autoconfig for ALC298: line_outs=3D1 (0x14/0x0/0x0/0x0/0x0) type:speake=
r
> > [Fri Oct  9 08:20:05 2020] snd_hda_codec_realtek hdaudioC0D0:
> > speaker_outs=3D0 (0x0/0x0/0x0/0x0/0x0)
> > [Fri Oct  9 08:20:05 2020] snd_hda_codec_realtek hdaudioC0D0:
> > hp_outs=3D2 (0x17/0x21/0x0/0x0/0x0)
> > [Fri Oct  9 08:20:05 2020] snd_hda_codec_realtek hdaudioC0D0:    mono:
> > mono_out=3D0x0
> > [Fri Oct  9 08:20:05 2020] snd_hda_codec_realtek hdaudioC0D0:    inputs=
:
> > [Fri Oct  9 08:20:05 2020] snd_hda_codec_realtek hdaudioC0D0:      Mic=
=3D0x18
> > [Fri Oct  9 08:20:05 2020] snd_hda_codec_realtek hdaudioC0D0:      Dock=
 Mic=3D0x19
> > [Fri Oct  9 08:20:05 2020] snd_hda_codec_realtek hdaudioC0D0:
> > Internal Mic=3D0x12
> > [Fri Oct  9 08:20:05 2020] videodev: Linux video capture interface: v2.=
00
> > [Fri Oct  9 08:20:05 2020] input: HDA NVidia HDMI/DP,pcm=3D3 as
> > /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input15
> > [Fri Oct  9 08:20:05 2020] input: HDA NVidia HDMI/DP,pcm=3D7 as
> > /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input16
> > [Fri Oct  9 08:20:05 2020] input: HDA NVidia HDMI/DP,pcm=3D8 as
> > /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input17
> > [Fri Oct  9 08:20:05 2020] input: HDA NVidia HDMI/DP,pcm=3D9 as
> > /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input18
> > [Fri Oct  9 08:20:05 2020] input: HDA NVidia HDMI/DP,pcm=3D10 as
> > /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input19
> > [Fri Oct  9 08:20:05 2020] input: HDA NVidia HDMI/DP,pcm=3D11 as
> > /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input20
> > [Fri Oct  9 08:20:05 2020] input: HDA Intel PCH Mic as
> > /devices/pci0000:00/0000:00:1f.3/sound/card0/input22
> > [Fri Oct  9 08:20:05 2020] input: HDA Intel PCH Dock Mic as
> > /devices/pci0000:00/0000:00:1f.3/sound/card0/input23
> > [Fri Oct  9 08:20:05 2020] input: HDA Intel PCH Dock Headphone as
> > /devices/pci0000:00/0000:00:1f.3/sound/card0/input24
> > [Fri Oct  9 08:20:05 2020] input: HDA Intel PCH Headphone as
> > /devices/pci0000:00/0000:00:1f.3/sound/card0/input25
> > --
> > Fabio



--=20
Fabio
