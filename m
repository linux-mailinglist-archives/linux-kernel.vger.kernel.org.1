Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1ACC19C883
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 20:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388764AbgDBSHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 14:07:03 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:41062 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728225AbgDBSHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 14:07:02 -0400
Received: by mail-lj1-f169.google.com with SMTP id n17so4229609lji.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 11:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=R/ynDCLZFAceZjP4WmDfZcVW2eoihPkt4LsJmvmk3eA=;
        b=epM4TAvrOMiZhuuBskUf15a2vfLekUnKXMsFrRFGg5RB2Y+q1FZnxN8xH4mvHk9ngR
         1EgK8NlZJNC9eXoU+/pKBs/IvhTeb/QkTOqM0D5AxMN7MYe2mP0G2k7Y4cNCRNJJZVNX
         vA9IPQWXvvdJbKBmslhnryYPk5j20SutrWo2eLRjDKsZHADRnJEYQqFMWuqqjRrCqaOz
         iawQIkNgB3dwKKHSedm6tSPmj55yKxp+txzvWp/tAXzGaQZoEcfJBVUjzIQ+CvZzqyA0
         0jnQ7wq/fwV4I+NRDvepeBEwXi7GiuTC3IutR9Ty4711ISf+r8/9+KkqF/PNtLe48G/T
         9MXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=R/ynDCLZFAceZjP4WmDfZcVW2eoihPkt4LsJmvmk3eA=;
        b=FEODOOApl21AKcpPy9DXLL3n3BB9KKGw/V9Yt13giY3Ewuvop4/lK0EwfsXqIrZtLw
         G6VEiETmuF38Enk3mlg/Inr0NA6hhKap/jtu1784k5IvS9G9Im1v0D9d8i9JPqxXYfgu
         DcIMyxKblYvUvtJB/RMyNy1g0vmJERfgOb2+AFyq0tyeZTbm8VQh6Za9VNLfialb0Wdp
         T0w5mywOYShdBlD/pDUHPeIFDHP6quRO6G4vy3eiFGXZhnTjR3EDVKnXlrKoGZPSC4/G
         ri75qUjK/SMr9SKPbn+99Jir3Ri8ZMxh2Nx/d36GJtS1Sc4C8nm4cCr44klyF+WL1SXf
         ZTwQ==
X-Gm-Message-State: AGi0PuYWMayTJfr57yNClpIz03IoSMzoaLSbiTJXjTd9JytSAywtzj0Z
        CZW81GpyYzUnovTsSFt1RiUZ/EMwYcJ92NWbiWc=
X-Google-Smtp-Source: APiQypL7qYYzhA03MM/t6atXvHwrjRXKZltTxYMktxRLDfIsxZ0vzdAexb/s0GenYqoKTtXcakf6DUNt3tpbL6yx8d8=
X-Received: by 2002:a2e:8693:: with SMTP id l19mr2915728lji.132.1585850820501;
 Thu, 02 Apr 2020 11:07:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:3f07:0:0:0:0:0 with HTTP; Thu, 2 Apr 2020 11:06:59 -0700 (PDT)
From:   Jari Ruusu <jari.ruusu@gmail.com>
Date:   Thu, 2 Apr 2020 21:06:59 +0300
Message-ID: <CACMCwJ++6kikxaEUon3xfwm1h3hTQ+V9BoJEAeToJQKwTufDsA@mail.gmail.com>
Subject: linux-4.14.175 broke audio
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

$ uname -s -r -m
Linux 4.14.175 x86_64
$ cat ${HOME}/.config/mpv/mpv.conf
ao=oss
vo=opengl
audio-channels=stereo
no-msg-color
$ mpv track18.mp3
Playing: track18.mp3
 (+) Audio --aid=1 (mp3)
[ao/oss] Can't set audio device to s16 output.
[ao/oss] Can't set audio device to u8 output.
[ao/oss] Can't set sample format.
[ao] Failed to initialize audio driver 'oss'
Could not open/initialize audio device -> no sound.
Audio: no audio


Reverting "ALSA: pcm: oss: Avoid plugin buffer overflow"
upstream commit f2ecf903ef06eb1bbbfa969db9889643d487e73a
restored audio back to normal working state.

-- 
Jari Ruusu  4096R/8132F189 12D6 4C3A DCDA 0AA4 27BD  ACDF F073 3C80 8132 F189
