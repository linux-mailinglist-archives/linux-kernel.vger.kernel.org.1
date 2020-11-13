Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C342B1FDC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 17:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgKMQPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 11:15:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:37320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbgKMQPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 11:15:44 -0500
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B6BB22240;
        Fri, 13 Nov 2020 16:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605284144;
        bh=GGyRYnSoS42WQUAfiaG/s5znyNvq3J3TU68pQuWBU1w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q/NB1Q9psh7pe4faosNZ93FvGhpqFOxHTGWUOu7YcQDJ+E8V9MLTcCt1PwpbtsRk5
         E5O1+dd5t8DHKGcyLEfRsWS179kr5PHwNSUlyykbtru4PgCv1RTUcKt54D+xSX9g2q
         fdGBsEJEgUnKVvLiA4J3tnxdB2LuzVKx7NAHUONI=
Received: by mail-ot1-f47.google.com with SMTP id k3so9356489otp.12;
        Fri, 13 Nov 2020 08:15:44 -0800 (PST)
X-Gm-Message-State: AOAM533+wL0VaOASoSx0KwR1qr9APQo0B/E3uAT3lbk6injEtnyA/LtP
        cYaAFEqWweuzNvWRZhH9dzCVj9wCYxLvBhQS/3U=
X-Google-Smtp-Source: ABdhPJx/Upgfk8BPIgAy+R/sMDl/ZcPw5mfg4AqSsyR3pjW336eHhUV8ZrJ82Nry7Se9Fkng0C5J9RUYDTOiHd6Hpb0=
X-Received: by 2002:a05:6830:214c:: with SMTP id r12mr1949863otd.90.1605284138559;
 Fri, 13 Nov 2020 08:15:38 -0800 (PST)
MIME-Version: 1.0
References: <5fadef1f.1c69fb81.9166e.093c@mx.google.com> <e16e2ce5-dc21-d159-ecf2-e0a430d772e1@collabora.com>
 <CAMj1kXFrxYqTARLprws6ja2=C1xZNC+TNr0Vvayr6sReqsUhyg@mail.gmail.com>
 <ce91a878-5ce3-614d-d10c-569b891b12d0@collabora.com> <20201113155825.GD1551@shell.armlinux.org.uk>
In-Reply-To: <20201113155825.GD1551@shell.armlinux.org.uk>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 13 Nov 2020 17:15:25 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHMBNK4ke3j0=h-xkxR9sWe3x_D2TLsPtDZv-sWCW4eWQ@mail.gmail.com>
Message-ID: <CAMj1kXHMBNK4ke3j0=h-xkxR9sWe3x_D2TLsPtDZv-sWCW4eWQ@mail.gmail.com>
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

On Fri, 13 Nov 2020 at 16:58, Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Fri, Nov 13, 2020 at 03:43:27PM +0000, Guillaume Tucker wrote:
> > On 13/11/2020 10:35, Ard Biesheuvel wrote:
> > > On Fri, 13 Nov 2020 at 11:31, Guillaume Tucker
> > > <guillaume.tucker@collabora.com> wrote:
> > >>
> > >> Hi Ard,
> > >>
> > >> Please see the bisection report below about a boot failure on
> > >> RPi-2b.
> > >>
> > >> Reports aren't automatically sent to the public while we're
> > >> trialing new bisection features on kernelci.org but this one
> > >> looks valid.
> > >>
> > >> There's nothing in the serial console log, probably because it's
> > >> crashing too early during boot.  I'm not sure if other platforms
> > >> on kernelci.org were hit by this in the same way, but there
> > >> doesn't seem to be any.
> > >>
> > >> The same regression can be see on rmk's for-next branch as well
> > >> as in linux-next.  It happens with both bcm2835_defconfig and
> > >> multi_v7_defconfig.
> > >>
> > >> Some more details can be found here:
> > >>
> > >>   https://kernelci.org/test/case/id/5fae44823818ee918adb8864/
> > >>
> > >> If this looks like a real issue but you don't have a platform at
> > >> hand to reproduce it, please let us know if you would like the
> > >> KernelCI test to be re-run with earlyprintk or some debug config
> > >> turned on, or if you have a fix to try.
> > >>
> > >> Best wishes,
> > >> Guillaume
> > >>
> > >
> > > Hello Guillaume,
> > >
> > > That patch did have an issue, but it was already fixed by
> > >
> > > https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=9020/1
> > > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=fc2933c133744305236793025b00c2f7d258b687
> > >
> > > Could you please double check whether cherry-picking that on top of
> > > the first bad commit fixes the problem?
> >
> > Sadly this doesn't appear to be fixing the issue.  I've
> > cherry-picked your patch on top of the commit found by the
> > bisection but it still didn't boot, here's the git log
> >
> > cbb9656e83ca ARM: 9020/1: mm: use correct section size macro to describe the FDT virtual address
> > 7a1be318f579 ARM: 9012/1: move device tree mapping out of linear region
> > e9a2f8b599d0 ARM: 9011/1: centralize phys-to-virt conversion of DT/ATAGS address
> > 3650b228f83a Linux 5.10-rc1
> >
> > Test log: https://people.collabora.com/~gtucker/lava/boot/rpi-2-b/v5.10-rc1-3-gcbb9656e83ca/
> >
> > There's no output so it's hard to tell what is going on, but
> > reverting the bad commmit does make the board to boot (that's
> > what "revert: PASS" means in the bisect report).  So it's
> > unlikely that there is another issue causing the boot failure.
>
> These silent boot failures are precisely what the DEBUG_LL stuff (and
> early_printk) is supposed to help with - getting the kernel messages
> out when there is an oops before the serial console is initialised.
>

If this is indeed related to the FDT mapping, I would assume
earlycon=... to be usable here.

I will try to reproduce this on a RPi3 but I don't have a RPi2 at
hand, unfortunately.

Would you mind having a quick try whether you can reproduce this on
QEMU, using the raspi2 machine model? If so, that would be a *lot*
easier to diagnose.
