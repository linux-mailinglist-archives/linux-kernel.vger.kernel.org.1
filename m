Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF722CC766
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 21:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731232AbgLBUDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 15:03:53 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50214 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729304AbgLBUDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:03:52 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5436DFD5B6;
        Wed,  2 Dec 2020 15:03:06 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=bBIuNaNXCoxrC1Or6o8GInkYmVQ=; b=WMV49c
        H/fdBImQ10kburu++8LqB/TzYs8XY8dAXhvwH1zp/KwH/OTqlg5/BgenLfVCmTOR
        arlXoxSf1QZDC/FbZ3s49y6cv6b89S5+g7AuDGan7H+Jmxhghl6NmGxIvi8Hr+d4
        p9ExsjYGXv30gb3JfvBCOkhTfg8/DEkQENcFo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4C934FD5B5;
        Wed,  2 Dec 2020 15:03:06 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=LiILUzwhqrFKVhBF/6z0N+B1dqKmy2+793gMCx1UQG0=; b=jj31JKGSbsWB9cs8u79OrUIKBFbHRPPPItq83KX/2bc4Hi9ztwDLZLvddSSv7nu89aidB1hnzRQcVa4JeFQ75B4OOfJQwvkgs2h6PUt2eKiP5a/J4YwMB+SM/v4c0Nu4hoR8wdhwkrm9FoZXBiOC7PJVwvLXRbmxBtfnybCnZ58=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3B1D7FD5B1;
        Wed,  2 Dec 2020 15:03:03 -0500 (EST)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 4BB1F2DA0208;
        Wed,  2 Dec 2020 15:03:01 -0500 (EST)
Date:   Wed, 2 Dec 2020 15:03:01 -0500 (EST)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Vitaly Wool <vitaly.wool@konsulko.com>
cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bin Meng <bin.meng@windriver.com>,
        Anup Patel <anup@brainfault.org>,
        Alistair Francis <alistair.francis@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: Re: [PATCH] arch/riscv: enable XIP
In-Reply-To: <CAM4kBBLSy=TJEFmzrdYCGHNLBBtnYYh64pFeYdh2Q7ytJvBwGg@mail.gmail.com>
Message-ID: <rnn9n519-pq72-7r3-57q3-3rns2s50s049@syhkavp.arg>
References: <20201202150130.16936-1-vitaly.wool@konsulko.com> <5916q277-o720-n6q-9o2-oo9nsqr6q63q@syhkavp.arg> <CAM4kBBLSy=TJEFmzrdYCGHNLBBtnYYh64pFeYdh2Q7ytJvBwGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 62A661B8-34D9-11EB-BCF4-D609E328BF65-78420484!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Dec 2020, Vitaly Wool wrote:

> On Wed, Dec 2, 2020 at 7:06 PM Nicolas Pitre <nico@fluxnic.net> wrote:
> >
> > On Wed, 2 Dec 2020, Vitaly Wool wrote:
> >
> > > Introduce XIP (eXecute In Place) support for RISC-V platforms.
> > > It allows code to be executed directly from non-volatile storage
> > > directly addressable by the CPU, such as QSPI NOR flash which can
> > > be found on many RISC-V platforms. This makes way for significant
> > > optimization of RAM footprint. The XIP kernel is not compressed
> > > since it has to run directly from flash, so it will occupy more
> > > space on the non-volatile storage to The physical flash address
> > > used to link the kernel object files and for storing it has to
> > > be known at compile time and is represented by a Kconfig option.
> > >
> > > XIP on RISC-V will currently only work on MMU-enabled kernels.
> > >
> > > Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>
> >
> > That's nice!
> >
> > Suggestion for a future enhancement:
> > To save on ROM storage, and given that the .data segment has to be
> > copied to RAM anyway, you could store .data compressed and decompress it
> > to RAM instead. See commit ca8b5d97d6bf for inspiration. In fact, many
> > parts there could be shared.
> 
> Thanks! That's in my TODO list.
> 
> > More comments below.
> >
> > > +#define __XIP_FIXUP(addr) \
> > > +     (((long)(addr) >= CONFIG_XIP_PHYS_ADDR && \
> > > +       (long)(addr) <= CONFIG_XIP_PHYS_ADDR + SZ_16M) ? \
> > > +     (long)(addr) - CONFIG_XIP_PHYS_ADDR + CONFIG_XIP_PHYS_RAM_BASE - XIP_OFFSET : \
> > > +     (long)(addr))
> >
> > Here you should cast to unsigned long instead.
> 
> Right, or (just thought of it) uintptr_t for that matter. Does that sound right?

Sure.

> > > +#ifdef CONFIG_XIP_KERNEL
> > > +     la a0, _trampoline_pg_dir
> > > +     lw t0, _xip_fixup
> > > +     add a0, a0, t0
> > [...]
> > > +_xip_fixup:
> > > +     .dword CONFIG_XIP_PHYS_RAM_BASE - CONFIG_XIP_PHYS_ADDR - XIP_OFFSET
> > > +#endif
> >
> > Here _xip_fixup is a dword but you're loading it as a word.
> > This won't work for both rv32 and rv64.
> 
> Well, at this point I believe it does, as long as we use little
> endian.

... and the fixup is not larger than 32 bits.

> 64-bit version has been verified.

Won't work if ROM and RAM are far-enough apart.

> I do not argue though that it isn't nice and should be fixed.
> 
> > > +SECTIONS
> > > +{
> > > +     /* Beginning of code and text segment */
> > > +     . = XIP_VIRT_ADDR(CONFIG_XIP_PHYS_ADDR);
> > > +     _xiprom = .;
> > > +     _start = .;
> > > +     HEAD_TEXT_SECTION
> > > +     INIT_TEXT_SECTION(PAGE_SIZE)
> > > +     /* we have to discard exit text and such at runtime, not link time */
> > > +     .exit.text :
> > > +     {
> > > +             EXIT_TEXT
> > > +     }
> > > +
> > > +     .text : {
> > > +             _text = .;
> > > +             _stext = .;
> > > +             TEXT_TEXT
> > > +             SCHED_TEXT
> > > +             CPUIDLE_TEXT
> > > +             LOCK_TEXT
> > > +             KPROBES_TEXT
> > > +             ENTRY_TEXT
> > > +             IRQENTRY_TEXT
> > > +             SOFTIRQENTRY_TEXT
> > > +             *(.fixup)
> > > +             _etext = .;
> > > +     }
> > > +     RO_DATA(L1_CACHE_BYTES)
> > > +     .srodata : {
> > > +             *(.srodata*)
> > > +     }
> > > +     .init.rodata : {
> > > +             INIT_SETUP(16)
> > > +             INIT_CALLS
> > > +             CON_INITCALL
> > > +             INIT_RAM_FS
> > > +     }
> > > +     _exiprom = ALIGN(PAGE_SIZE);            /* End of XIP ROM area */
> >
> > Why do you align this to a page size?
> 
> TBH I just cut the corners here and below, did not have to worry about
> partial pages and such.

You're wasting ROM space though.

> > > +
> > > +
> > > +/*
> > > + * From this point, stuff is considered writable and will be copied to RAM
> > > + */
> > > +     __data_loc = ALIGN(PAGE_SIZE);  /* location in file */
> >
> > Same question here?
> >
> > > +     . = PAGE_OFFSET;                /* location in memory */
> > > +
> > > +     _sdata = .;                     /* Start of data section */
> > > +     _data = .;
> > > +     RW_DATA(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
> > > +     _edata = .;
> > > +     __start_ro_after_init = .;
> > > +     .data.ro_after_init : AT(ADDR(.data.ro_after_init) - LOAD_OFFSET) {
> > > +             *(.data..ro_after_init)
> > > +     }
> > > +     __end_ro_after_init = .;
> > > +
> > > +     . = ALIGN(PAGE_SIZE);
> >
> > And again here?

Forget this particular one. It is fine.


Nicolas
