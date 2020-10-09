Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B34C1289B3F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 23:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403776AbgJIVyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 17:54:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47599 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732056AbgJIVyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 17:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602280448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1DGRdcsDNGl9gVS7YYV990kOut6FXvc+T+EaiHpDxCk=;
        b=Vi6eAePQ+tlTPR1UmOiR77l2SuUIoQYF2iWflQYZNXAY0RlO9tXsFa4xq3zXtlAt4t+CHQ
        KlrRCxbaOJN+0EYYyU63HgjGf12T3Qh3i/wiRG24xBpb+FZg170UpkTCgV5SUts551JvnC
        08YeI6O512I29iFA2rEm+uq5W6gF0ZI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-DqVh-2ReNjCsDp4toyj79g-1; Fri, 09 Oct 2020 17:54:04 -0400
X-MC-Unique: DqVh-2ReNjCsDp4toyj79g-1
Received: by mail-qk1-f200.google.com with SMTP id u2so8104897qka.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 14:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1DGRdcsDNGl9gVS7YYV990kOut6FXvc+T+EaiHpDxCk=;
        b=d82CtGJ1mzAxitknbEF1aH8vn6V59BRmzQ8r3Smp125+lU/aRCQZvEEcaQienjCFJR
         dAqnwY4NztEZXl0TcF7Akaru0MyPvb71fKVGCm4S/6jbNkRPkV/6hOC7zxaVUeR/ApU1
         kJA/jB2qwaTpFnheeTI9di94pKALzGZzLdZ7qSEGGBFWm672g4cT3LIZ9HEiS4+0RMZo
         pKCvgcB+TcvmscLZA5TLXCWEKPzCldTo3LzA0A98YZ5dfD6pBnWnubY34LRRDYpEyqsx
         3oLDUQ5AqXLlo3MYF3FgIEiFdH+otXM/+CTzzoi04WnZv1BBf+0zU0A3t0JJ4pSwn16k
         fAXg==
X-Gm-Message-State: AOAM533XHO6/hLw4Qoye6kG/6+yQq9MjmfjuQxZl00e94YG1KP2RFqGY
        3qaz+jgvM33lLVO52xak/t1ZLJsc1uMJ58k2H7LxB+1VzKTsOgavpbjzLB9KcvxMDw/+UQPBiI2
        H1eR1GhFLzDcpSkz0h/zkHTUKseL+VKTTkmz+Huvh
X-Received: by 2002:a37:7805:: with SMTP id t5mr41024qkc.157.1602280443923;
        Fri, 09 Oct 2020 14:54:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKFe0fZM+UI+kwnaS3rhTnXdP4Ft6MV/RhHjc26A66FZKTRWIGz5gj2waLbdahUrnRKpEWmENOBiFZvhqso3g=
X-Received: by 2002:a37:7805:: with SMTP id t5mr41003qkc.157.1602280443645;
 Fri, 09 Oct 2020 14:54:03 -0700 (PDT)
MIME-Version: 1.0
References: <202010092326.20482.linux@zary.sk>
In-Reply-To: <202010092326.20482.linux@zary.sk>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 9 Oct 2020 23:53:52 +0200
Message-ID: <CACO55tuj_=PUYuBnJLZgCEize_8Po0VnuDVPtkHLEZxL3RgF7Q@mail.gmail.com>
Subject: Re: [Nouveau] nouveau broken on Riva TNT2 in 5.9.0-rc8: GPU not
 supported on big-endian
To:     Ondrej Zary <linux@zary.sk>
Cc:     Ben Skeggs <bskeggs@redhat.com>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 9, 2020 at 11:35 PM Ondrej Zary <linux@zary.sk> wrote:
>
> Hello,
> I'm testing 5.9.0-rc8 and found that Riva TNT2 stopped working:
> [    0.000000] Linux version 5.9.0-rc8+ (zary@gsql) (gcc (Debian 8.3.0-6) 8.3.0, GNU ld (GNU Binutils for Debian) 2.31.1) #326 SMP Fri Oct 9 22:31:40 CEST 2020
> ...
> [   14.771464] nouveau 0000:01:00.0: GPU not supported on big-endian
> [   14.771782] nouveau: probe of 0000:01:00.0 failed with error -38
>
> big-endian? WTF? The machine is x86.
>

mhh, we reworked the endianess checks a bit and apparently that broke
something... I will give it some thoughts, but could you be so kind
and create an mmiotrace under 5.9 with nouveau? You won't need to
start X or anything while doing it. Just enable the trace and modprobe
nouveau and collect the trace.

> It works fine with Debian 5.7 kernel (5.7.10-1~bpo10+1):
> [    0.000000] Linux version 5.7.0-0.bpo.2-686 (debian-kernel@lists.debian.org) (gcc version 8.3.0 (Debian 8.3.0-6), GNU ld (GNU Binutils for Debian) 2.31.1) #1 SMP Debian 5.7.10-1~bpo10+1 (2020-07-30)
> ...
> [   23.266196] nouveau 0000:01:00.0: NVIDIA NV05 (20154000)
> [   23.288582] nouveau 0000:01:00.0: bios: version 02.05.20.02.00
> [   23.288869] nouveau 0000:01:00.0: bios: DCB table not found
> [   23.289595] nouveau 0000:01:00.0: bios: DCB table not found
> [   23.289956] nouveau 0000:01:00.0: bios: DCB table not found
> [   23.290015] nouveau 0000:01:00.0: bios: DCB table not found
> [   23.290215] agpgart-intel 0000:00:00.0: AGP 3.0 bridge
> [   23.290287] agpgart-intel 0000:00:00.0: bridge is in legacy mode, falling back to 2.x
> [   23.290351] agpgart-intel 0000:00:00.0: putting AGP V2 device into 4x mode
> [   23.290430] nouveau 0000:01:00.0: putting AGP V2 device into 4x mode
> [   23.290565] agpgart-intel 0000:00:00.0: AGP 3.0 bridge
> [   23.290627] agpgart-intel 0000:00:00.0: bridge is in legacy mode, falling back to 2.x
> [   23.290690] agpgart-intel 0000:00:00.0: putting AGP V2 device into 4x mode
> [   23.290768] nouveau 0000:01:00.0: putting AGP V2 device into 4x mode
> [   23.290830] nouveau 0000:01:00.0: tmr: unknown input clock freq
> [   23.293026] nouveau 0000:01:00.0: fb: 32 MiB SDRAM
> [   23.301269] [TTM] Zone  kernel: Available graphics memory: 382728 KiB
> [   23.301327] [TTM] Initializing pool allocator
> [   23.301414] nouveau 0000:01:00.0: DRM: VRAM: 31 MiB
> [   23.301465] nouveau 0000:01:00.0: DRM: GART: 128 MiB
> [   23.301518] nouveau 0000:01:00.0: DRM: BMP version 5.6
> [   23.301570] nouveau 0000:01:00.0: DRM: No DCB data found in VBIOS
> [   23.303594] nouveau 0000:01:00.0: DRM: MM: using M2MF for buffer copies
> [   23.303719] nouveau 0000:01:00.0: bios: DCB table not found
> [   23.304904] nouveau 0000:01:00.0: DRM: Saving VGA fonts
> [   23.349089] nouveau 0000:01:00.0: DRM: No DCB data found in VBIOS
> [   23.349681] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> [   23.383066] nouveau 0000:01:00.0: DRM: allocated 1280x1024 fb: 0x4000, bo b10d2f17
> [   23.413903] fbcon: nouveaudrmfb (fb0) is primary device
> [   23.569851] Console: switching to colour frame buffer device 160x64
> [   23.571050] nouveau 0000:01:00.0: fb0: nouveaudrmfb frame buffer device
>
>
> --
> Ondrej Zary
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
>

