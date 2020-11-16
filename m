Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2052B3EDB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 09:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgKPIhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 03:37:24 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35131 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbgKPIhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 03:37:23 -0500
Received: by mail-oi1-f195.google.com with SMTP id c80so17980455oib.2;
        Mon, 16 Nov 2020 00:37:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sMAhQkMAAOEMNQyayOFVrz9HDzB5B1saaNRynPQauKE=;
        b=rvX9kXs+kZKvRqUOcyR4ZurijsTnYt2cbYjDI7/LWsextDIUa3Pi7i8vBgN+GNgWC4
         Qa/aMcIk3ez5xVNHVlx/Nx/7ggIFPiOUcELhrGxOGy0+tv5QeUuNy8nwrYkQ7XI24YS3
         XCfLCHPBRnPjQpNhuVR0GifYlhM4CddMv2wEroqgEES0/l2EZCJBU0pkYHNK6aOMvZtP
         OGTAO2C1TsMKY/19+8PM48SGPQp4qwoVSFF8aYsM5kr1Hom6Qs6i0dcb/J+gb5Zo7xqj
         +AXrMoEKbqHVNDAwcykpmiCoFlcQfsHS1g+baMGtSjiZfJQq80F0SKp2leI3npcrvWM5
         9zQA==
X-Gm-Message-State: AOAM531IMe/dwLS/Bg1xAoav6KUJRRDmny/yh+7BuDKt78Lf/3rE6klr
        RmsJvWaj4VbgpjtcikGtBXF+m72AFgjysmdfUQM=
X-Google-Smtp-Source: ABdhPJx6nHkxuSRkza+OXKOcoHRWVcsf2G4ohOl/VDjcl4+DJy7v11xLEXODuqNdvAzIwd85TnREGZTTRY3AtVI3lnM=
X-Received: by 2002:aca:4bc3:: with SMTP id y186mr8580446oia.153.1605515842617;
 Mon, 16 Nov 2020 00:37:22 -0800 (PST)
MIME-Version: 1.0
References: <202011140757.5QyVghe2-lkp@intel.com> <4f6f2244-033c-8413-818d-0b9c1b0b33ae@infradead.org>
 <CAK8P3a0w5MpvExp1jShAhqZ3Z08HjMALic6x2K+1_0eqFUi5QA@mail.gmail.com>
In-Reply-To: <CAK8P3a0w5MpvExp1jShAhqZ3Z08HjMALic6x2K+1_0eqFUi5QA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 16 Nov 2020 09:37:11 +0100
Message-ID: <CAMuHMdU2L5GcEHdCHh_1-WaVVQNGkm0-CwFW5D1KS0dkqBQ3zw@mail.gmail.com>
Subject: Re: irq-loongson-pch-pic.c:undefined reference to `of_iomap'
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, kbuild-all@lists.01.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Mon, Nov 16, 2020 at 9:33 AM Arnd Bergmann <arnd@kernel.org> wrote:
> On Mon, Nov 16, 2020 at 5:33 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> > On 11/13/20 3:27 PM, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   9e6a39eae450b81c8b2c8cbbfbdf8218e9b40c81
> > > commit: ef8c01eb64ca6719da449dab0aa9424e13c58bd0 irqchip: Add Loongson PCH PIC controller
> > > date:   6 months ago
> > > config: s390-randconfig-r022-20201113 (attached as .config)
> > > compiler: s390-linux-gcc (GCC) 9.3.0
> > > reproduce (this is a W=1 build):
> > >          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >          chmod +x ~/bin/make.cross
> > >          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ef8c01eb64ca6719da449dab0aa9424e13c58bd0
> > >          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > >          git fetch --no-tags linus master
> > >          git checkout ef8c01eb64ca6719da449dab0aa9424e13c58bd0
> > >          # save the attached .config to linux build tree
> > >          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=s390
> > >
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> >
> > Hi lkp (ktr) et al,
> >
> > arch/s390/Kconfig says that HAS_IOMEM depends on CONFIG_PCI and the
> > supplied .config.gz file has
> > # CONFIG_PCI is not set
> >
> > Does that mean that all of these drivers should have an additional
> >         depends on HAS_IOMEM
> > in their Kconfig entries?
> >
> > That's what it would take for them to have access to all of the
> > devm_platform_iomap* type functions.
> >
> > For most ARCHes, OF_ADDRESS also depends on HAS_IOMEM, so that's why
> > of_iomap() is not available.
>
> (adding s390 folks to cc)
>
> I think fixing this requires a larger-scale effort. I tried building
> an s390 allmodconfig
> with CONFIG_PCI disabled, and got warnings and failures in many other places,
> see full log at the end of this mail.
>
> While in theory, all of those should depend on 'HAS_IOMEM' or some other symbol,
> keeping these dependencies sounds like an uphill battle, and there is not much
> to be gained from building the drivers for s390 on top of compile-testing them
> on more conventional architectures.

Don't we need the dependencies on HAS_IOMEM for the CONFIG_UML=y
case, too?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
