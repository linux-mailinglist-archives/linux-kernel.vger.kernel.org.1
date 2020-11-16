Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A9A2B43AA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 13:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730069AbgKPM0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 07:26:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:46098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727184AbgKPM0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 07:26:21 -0500
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35DCF238E6;
        Mon, 16 Nov 2020 12:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605529247;
        bh=t8CW0VqToG5Ia0rzv8KHE1i/dtre8EYiH2P9zWVK1hg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oD554eGgVNSInP1q3WteeCA4G5VE8ZHpNmgXCIAww6/D7InyRPNyjVuG/5/FN5Ght
         gH8dY6lJFlopE9+3bqaPg/vjgcnyG9TCbpU8Q7bvKHJkOy16xC5BZpyimPk1djeGrL
         miNSx+KnzLFFtn2AH2tmDdx7VQODWmjwP/AX+psY=
Received: by mail-oi1-f180.google.com with SMTP id w188so18568385oib.1;
        Mon, 16 Nov 2020 04:20:47 -0800 (PST)
X-Gm-Message-State: AOAM532kaVR5eXcM3fBHDwt1hV2OGPOshSEoBTsS3E/Tw6Zi/HP55cV9
        2RAMfQTdAw5sbrgprgVGkwmuRuDfVwHoOfDOs+4=
X-Google-Smtp-Source: ABdhPJzMPfQ4rLbkYCS9iOpXeVVIVQ9lJgCb5B2p6vxY1ApryCUK3LH0D/g2M3KPhC+ROfE9Ok2yCC9M5nm9v/GR/gk=
X-Received: by 2002:aca:d583:: with SMTP id m125mr8805902oig.47.1605529234751;
 Mon, 16 Nov 2020 04:20:34 -0800 (PST)
MIME-Version: 1.0
References: <5fadef1f.1c69fb81.9166e.093c@mx.google.com> <e16e2ce5-dc21-d159-ecf2-e0a430d772e1@collabora.com>
 <CAMj1kXFrxYqTARLprws6ja2=C1xZNC+TNr0Vvayr6sReqsUhyg@mail.gmail.com>
 <ce91a878-5ce3-614d-d10c-569b891b12d0@collabora.com> <20201113155825.GD1551@shell.armlinux.org.uk>
 <CAMj1kXHMBNK4ke3j0=h-xkxR9sWe3x_D2TLsPtDZv-sWCW4eWQ@mail.gmail.com>
 <CAMj1kXH6_-tNuhOVDJA4mhEUQBDTDLjJA8CUkb4mRFsAZSy9ig@mail.gmail.com>
 <CAMj1kXEFMgRZ1QgaAfwvg7Um-=UdiG-THGAySwrBHhQX=tMPeQ@mail.gmail.com> <CAMj1kXE-c+7yFwqxZ2WDBG5LOtLbnSgacuGgG1P+CY3PUwu+GA@mail.gmail.com>
In-Reply-To: <CAMj1kXE-c+7yFwqxZ2WDBG5LOtLbnSgacuGgG1P+CY3PUwu+GA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 16 Nov 2020 13:20:22 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH-BKvykS0wL5BCv5Eh4FWMZxHmM6nHV8MeRACUbWjCPw@mail.gmail.com>
Message-ID: <CAMj1kXH-BKvykS0wL5BCv5Eh4FWMZxHmM6nHV8MeRACUbWjCPw@mail.gmail.com>
Subject: Re: rmk/for-next bisection: baseline.login on bcm2836-rpi-2-b
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernelci-results@groups.io,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Olof Johansson <olof@lixom.net>,
        Mike Rapoport <rppt@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Collabora Kernel ML <kernel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Nov 2020 at 12:20, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Sun, 15 Nov 2020 at 15:11, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Fri, 13 Nov 2020 at 17:25, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Fri, 13 Nov 2020 at 17:15, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >
> > > > On Fri, 13 Nov 2020 at 16:58, Russell King - ARM Linux admin
> > > > <linux@armlinux.org.uk> wrote:
> > > > >
> > > > > On Fri, Nov 13, 2020 at 03:43:27PM +0000, Guillaume Tucker wrote:
> > > > > > On 13/11/2020 10:35, Ard Biesheuvel wrote:
> > > > > > > On Fri, 13 Nov 2020 at 11:31, Guillaume Tucker
> > > > > > > <guillaume.tucker@collabora.com> wrote:
> > > > > > >>
> > > > > > >> Hi Ard,
> > > > > > >>
> > > > > > >> Please see the bisection report below about a boot failure on
> > > > > > >> RPi-2b.
> > > > > > >>
> > > > > > >> Reports aren't automatically sent to the public while we're
> > > > > > >> trialing new bisection features on kernelci.org but this one
> > > > > > >> looks valid.
> > > > > > >>
> > > > > > >> There's nothing in the serial console log, probably because it's
> > > > > > >> crashing too early during boot.  I'm not sure if other platforms
> > > > > > >> on kernelci.org were hit by this in the same way, but there
> > > > > > >> doesn't seem to be any.
> > > > > > >>
> > > > > > >> The same regression can be see on rmk's for-next branch as well
> > > > > > >> as in linux-next.  It happens with both bcm2835_defconfig and
> > > > > > >> multi_v7_defconfig.
> > > > > > >>
> > > > > > >> Some more details can be found here:
> > > > > > >>
> > > > > > >>   https://kernelci.org/test/case/id/5fae44823818ee918adb8864/
> > > > > > >>
> > > > > > >> If this looks like a real issue but you don't have a platform at
> > > > > > >> hand to reproduce it, please let us know if you would like the
> > > > > > >> KernelCI test to be re-run with earlyprintk or some debug config
> > > > > > >> turned on, or if you have a fix to try.
> > > > > > >>
> > > > > > >> Best wishes,
> > > > > > >> Guillaume
> > > > > > >>
> > > > > > >
> > > > > > > Hello Guillaume,
> > > > > > >
> > > > > > > That patch did have an issue, but it was already fixed by
> > > > > > >
> > > > > > > https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=9020/1
> > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=fc2933c133744305236793025b00c2f7d258b687
> > > > > > >
> > > > > > > Could you please double check whether cherry-picking that on top of
> > > > > > > the first bad commit fixes the problem?
> > > > > >
> > > > > > Sadly this doesn't appear to be fixing the issue.  I've
> > > > > > cherry-picked your patch on top of the commit found by the
> > > > > > bisection but it still didn't boot, here's the git log
> > > > > >
> > > > > > cbb9656e83ca ARM: 9020/1: mm: use correct section size macro to describe the FDT virtual address
> > > > > > 7a1be318f579 ARM: 9012/1: move device tree mapping out of linear region
> > > > > > e9a2f8b599d0 ARM: 9011/1: centralize phys-to-virt conversion of DT/ATAGS address
> > > > > > 3650b228f83a Linux 5.10-rc1
> > > > > >
> > > > > > Test log: https://people.collabora.com/~gtucker/lava/boot/rpi-2-b/v5.10-rc1-3-gcbb9656e83ca/
> > > > > >
> > > > > > There's no output so it's hard to tell what is going on, but
> > > > > > reverting the bad commmit does make the board to boot (that's
> > > > > > what "revert: PASS" means in the bisect report).  So it's
> > > > > > unlikely that there is another issue causing the boot failure.
> > > > >
> > > > > These silent boot failures are precisely what the DEBUG_LL stuff (and
> > > > > early_printk) is supposed to help with - getting the kernel messages
> > > > > out when there is an oops before the serial console is initialised.
> > > > >
> > > >
> > > > If this is indeed related to the FDT mapping, I would assume
> > > > earlycon=... to be usable here.
> > > >
> > > > I will try to reproduce this on a RPi3 but I don't have a RPi2 at
> > > > hand, unfortunately.
> > > >
> > > > Would you mind having a quick try whether you can reproduce this on
> > > > QEMU, using the raspi2 machine model? If so, that would be a *lot*
> > > > easier to diagnose.
> > >
> > > Also, please have a go with 'earlycon=pl011,0x3f201000' added to the
> > > kernel command line.
> >
> > I cannot reproduce this - I don't have the exact same hardware, but
> > for booting the kernel, I think RPi2 and RPi3 should be sufficiently
> > similar, and I can boot on Rpi3 using a u-boot built for rpi2 using
> > your provided dtb for RPi2.
> >
> > What puzzles me is that u-boot reports itself as
> >
> > U-Boot 2016.03-rc1-00131-g39af3d8-dirty
> >
> > RPI Model B+ (0x10)
> >
> > which is the ARMv6 model not the ARMv7, but then the kernel reports
> >
> > CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c53c7d
> >
>
> Another thing I noticed is that the bootloader on these boards loads
> the FDT at address 0x100, which is described by the FDT itself as
> reserved memory, and which typically holds the spin tables used for
> SMP boot.
>
> Could you try loading the DT elsewhere, and see if that changes anything?

I think I narrowed this down to the early DT mapping code, which
considers any DT address that falls inside the first section as 'no
DT', and then relies on the first section mapping of the decompressed
kernel to cover it instead.

Could you please try the following change?


diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 28687fd1240a..7f62c5eccdf3 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -265,10 +265,10 @@ __create_page_tables:
         * We map 2 sections in case the ATAGs/DTB crosses a section boundary.
         */
        mov     r0, r2, lsr #SECTION_SHIFT
-       movs    r0, r0, lsl #SECTION_SHIFT
+       cmp     r2, #0
        ldrne   r3, =FDT_FIXED_BASE >> (SECTION_SHIFT - PMD_ORDER)
        addne   r3, r3, r4
-       orrne   r6, r7, r0
+       orrne   r6, r7, r0, lsl #SECTION_SHIFT
        strne   r6, [r3], #1 << PMD_ORDER
        addne   r6, r6, #1 << SECTION_SHIFT
        strne   r6, [r3]
