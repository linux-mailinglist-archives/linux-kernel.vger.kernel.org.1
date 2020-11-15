Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4322B3537
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 15:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbgKOOLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 09:11:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:46788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726743AbgKOOLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 09:11:17 -0500
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8B2B2344C;
        Sun, 15 Nov 2020 14:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605449476;
        bh=W79SsNbfjzxWPr68MkFF7CwzXqxmFk8cyvy7xhSLVZQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=y/95aUzUTGGv0uhKX/ECj544rFNzQGaU0EDd0l53VcSd/4JKMKccFnY3EbGIrd/QB
         4iphERsVpcevCFP0a0k+skT1PFVcoBE/nPgU9/GurDDi3HGZl6y+zNTz4QMRNClKET
         BU6RxTQfIO5gd+VjQvhJljvc7+FpDrdwJ1duGelg=
Received: by mail-ot1-f54.google.com with SMTP id 79so13322805otc.7;
        Sun, 15 Nov 2020 06:11:16 -0800 (PST)
X-Gm-Message-State: AOAM531pbYnx1mht9J6n3RRKPZYjooll+Bf0LGzp66L9kWQgJ/ehksLh
        Lv6bthbI4eI9eqnHdHcrNnaNP0ICjrrGh8NweEk=
X-Google-Smtp-Source: ABdhPJyTPNVEaiqI65jKj6ofpnc68HWknI57qrxN0D6QNUJkPnSQRINil+Bq4EtPc6sB4yhS/1A4aX5j8HExZfTHozc=
X-Received: by 2002:a05:6830:214c:: with SMTP id r12mr7247607otd.90.1605449476122;
 Sun, 15 Nov 2020 06:11:16 -0800 (PST)
MIME-Version: 1.0
References: <5fadef1f.1c69fb81.9166e.093c@mx.google.com> <e16e2ce5-dc21-d159-ecf2-e0a430d772e1@collabora.com>
 <CAMj1kXFrxYqTARLprws6ja2=C1xZNC+TNr0Vvayr6sReqsUhyg@mail.gmail.com>
 <ce91a878-5ce3-614d-d10c-569b891b12d0@collabora.com> <20201113155825.GD1551@shell.armlinux.org.uk>
 <CAMj1kXHMBNK4ke3j0=h-xkxR9sWe3x_D2TLsPtDZv-sWCW4eWQ@mail.gmail.com> <CAMj1kXH6_-tNuhOVDJA4mhEUQBDTDLjJA8CUkb4mRFsAZSy9ig@mail.gmail.com>
In-Reply-To: <CAMj1kXH6_-tNuhOVDJA4mhEUQBDTDLjJA8CUkb4mRFsAZSy9ig@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 15 Nov 2020 15:11:03 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEFMgRZ1QgaAfwvg7Um-=UdiG-THGAySwrBHhQX=tMPeQ@mail.gmail.com>
Message-ID: <CAMj1kXEFMgRZ1QgaAfwvg7Um-=UdiG-THGAySwrBHhQX=tMPeQ@mail.gmail.com>
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

On Fri, 13 Nov 2020 at 17:25, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Fri, 13 Nov 2020 at 17:15, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Fri, 13 Nov 2020 at 16:58, Russell King - ARM Linux admin
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Fri, Nov 13, 2020 at 03:43:27PM +0000, Guillaume Tucker wrote:
> > > > On 13/11/2020 10:35, Ard Biesheuvel wrote:
> > > > > On Fri, 13 Nov 2020 at 11:31, Guillaume Tucker
> > > > > <guillaume.tucker@collabora.com> wrote:
> > > > >>
> > > > >> Hi Ard,
> > > > >>
> > > > >> Please see the bisection report below about a boot failure on
> > > > >> RPi-2b.
> > > > >>
> > > > >> Reports aren't automatically sent to the public while we're
> > > > >> trialing new bisection features on kernelci.org but this one
> > > > >> looks valid.
> > > > >>
> > > > >> There's nothing in the serial console log, probably because it's
> > > > >> crashing too early during boot.  I'm not sure if other platforms
> > > > >> on kernelci.org were hit by this in the same way, but there
> > > > >> doesn't seem to be any.
> > > > >>
> > > > >> The same regression can be see on rmk's for-next branch as well
> > > > >> as in linux-next.  It happens with both bcm2835_defconfig and
> > > > >> multi_v7_defconfig.
> > > > >>
> > > > >> Some more details can be found here:
> > > > >>
> > > > >>   https://kernelci.org/test/case/id/5fae44823818ee918adb8864/
> > > > >>
> > > > >> If this looks like a real issue but you don't have a platform at
> > > > >> hand to reproduce it, please let us know if you would like the
> > > > >> KernelCI test to be re-run with earlyprintk or some debug config
> > > > >> turned on, or if you have a fix to try.
> > > > >>
> > > > >> Best wishes,
> > > > >> Guillaume
> > > > >>
> > > > >
> > > > > Hello Guillaume,
> > > > >
> > > > > That patch did have an issue, but it was already fixed by
> > > > >
> > > > > https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=9020/1
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=fc2933c133744305236793025b00c2f7d258b687
> > > > >
> > > > > Could you please double check whether cherry-picking that on top of
> > > > > the first bad commit fixes the problem?
> > > >
> > > > Sadly this doesn't appear to be fixing the issue.  I've
> > > > cherry-picked your patch on top of the commit found by the
> > > > bisection but it still didn't boot, here's the git log
> > > >
> > > > cbb9656e83ca ARM: 9020/1: mm: use correct section size macro to describe the FDT virtual address
> > > > 7a1be318f579 ARM: 9012/1: move device tree mapping out of linear region
> > > > e9a2f8b599d0 ARM: 9011/1: centralize phys-to-virt conversion of DT/ATAGS address
> > > > 3650b228f83a Linux 5.10-rc1
> > > >
> > > > Test log: https://people.collabora.com/~gtucker/lava/boot/rpi-2-b/v5.10-rc1-3-gcbb9656e83ca/
> > > >
> > > > There's no output so it's hard to tell what is going on, but
> > > > reverting the bad commmit does make the board to boot (that's
> > > > what "revert: PASS" means in the bisect report).  So it's
> > > > unlikely that there is another issue causing the boot failure.
> > >
> > > These silent boot failures are precisely what the DEBUG_LL stuff (and
> > > early_printk) is supposed to help with - getting the kernel messages
> > > out when there is an oops before the serial console is initialised.
> > >
> >
> > If this is indeed related to the FDT mapping, I would assume
> > earlycon=... to be usable here.
> >
> > I will try to reproduce this on a RPi3 but I don't have a RPi2 at
> > hand, unfortunately.
> >
> > Would you mind having a quick try whether you can reproduce this on
> > QEMU, using the raspi2 machine model? If so, that would be a *lot*
> > easier to diagnose.
>
> Also, please have a go with 'earlycon=pl011,0x3f201000' added to the
> kernel command line.

I cannot reproduce this - I don't have the exact same hardware, but
for booting the kernel, I think RPi2 and RPi3 should be sufficiently
similar, and I can boot on Rpi3 using a u-boot built for rpi2 using
your provided dtb for RPi2.

What puzzles me is that u-boot reports itself as

U-Boot 2016.03-rc1-00131-g39af3d8-dirty

RPI Model B+ (0x10)

which is the ARMv6 model not the ARMv7, but then the kernel reports

CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c53c7d

So even though I am perfectly willing to accept that there is
something wrong with the patch in question that needs to be fixed,
trying to reproduce this using an ancient rc1 u-boot with local
changes that identifies the platform incorrectly may be asking a bit
much.

Also, I did manage to get earlycon working with those zImages you
provided, so please give that a go. And if you have any contacts that
could lend me a RPi2, that would be very helpful (e.g., the BayLibre
office is down the road from where I live)
