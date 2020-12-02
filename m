Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4762CC6E9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 20:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389565AbgLBToy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 14:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387728AbgLBTox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 14:44:53 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DB7C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 11:44:13 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id s9so5145519ljo.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 11:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ASo7cCqcXZyF27JshUw9tbkwxz92r4JHPfrQwN2UAE=;
        b=imIWWEY0mN5B3vHaxTEjaQvhrDUR7Tu0ByKnzZSGuva5rE3l9WXlvNpn1pRZJHStz4
         7g/xc562ilJ/AKXLELFcWxann4x/PVmMDwiWOTxTLO37kyVi8tY/0QKVBAwYeZL7anec
         TyCLA/vl33wJhVYCS/mWWUbKGMfz5kismNzuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ASo7cCqcXZyF27JshUw9tbkwxz92r4JHPfrQwN2UAE=;
        b=gznOFqEnqKkG0wTzCzIzMLExdKH0ojb3Y95TI+BZC1qydzDTaXnBnu9y5OgjFk8Nrh
         LQRP/SZ+sOznKLECRsuT2I3Eum8aPzArKbRlqTa53ZuLOOODz1e3ZThRnX7jxfO7Q6O6
         rxZ8JjItBa3CC+SqQgg2TldlB/giGrRXp5yTJFosUKiI5zzyPhsPN2GzjDfFKFnNkJ59
         f1/nAz1Vf6CRKOIxhw8YTVA8gRrlmoEQrrZ6hsgoCaVDGVlUXwPVe4Dcv0TWV7KfJ5hI
         +Ifq07K/CyiHdMPZUe0VNwY+LBGAXMDyRqpsSpoXMfWmfFw5JhNJGtiOcVazvKL/UYxE
         jEIQ==
X-Gm-Message-State: AOAM533wHyOtn4hDdkpOK/MVBHPNbnB5XFAauMGZrWK92Jnij0JTUgQH
        FlHbIPpELlBFGWyJFWbq3BG+xQRZuilxwTYHczcQTOPVhKnJT3ZU
X-Google-Smtp-Source: ABdhPJyb+Dc0VoTJrskKvre9Qz0z9lKQ/4uBTZcMF4TgMgma6EUQFJNr4Juf0rM8GGGrk1EMcgt0GjGMp3jZ6+Ef570=
X-Received: by 2002:a2e:8183:: with SMTP id e3mr1941702ljg.267.1606938251755;
 Wed, 02 Dec 2020 11:44:11 -0800 (PST)
MIME-Version: 1.0
References: <20201202150130.16936-1-vitaly.wool@konsulko.com> <5916q277-o720-n6q-9o2-oo9nsqr6q63q@syhkavp.arg>
In-Reply-To: <5916q277-o720-n6q-9o2-oo9nsqr6q63q@syhkavp.arg>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Wed, 2 Dec 2020 20:44:00 +0100
Message-ID: <CAM4kBBLSy=TJEFmzrdYCGHNLBBtnYYh64pFeYdh2Q7ytJvBwGg@mail.gmail.com>
Subject: Re: [PATCH] arch/riscv: enable XIP
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bin Meng <bin.meng@windriver.com>,
        Anup Patel <anup@brainfault.org>,
        Alistair Francis <alistair.francis@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 2, 2020 at 7:06 PM Nicolas Pitre <nico@fluxnic.net> wrote:
>
> On Wed, 2 Dec 2020, Vitaly Wool wrote:
>
> > Introduce XIP (eXecute In Place) support for RISC-V platforms.
> > It allows code to be executed directly from non-volatile storage
> > directly addressable by the CPU, such as QSPI NOR flash which can
> > be found on many RISC-V platforms. This makes way for significant
> > optimization of RAM footprint. The XIP kernel is not compressed
> > since it has to run directly from flash, so it will occupy more
> > space on the non-volatile storage to The physical flash address
> > used to link the kernel object files and for storing it has to
> > be known at compile time and is represented by a Kconfig option.
> >
> > XIP on RISC-V will currently only work on MMU-enabled kernels.
> >
> > Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>
>
> That's nice!
>
> Suggestion for a future enhancement:
> To save on ROM storage, and given that the .data segment has to be
> copied to RAM anyway, you could store .data compressed and decompress it
> to RAM instead. See commit ca8b5d97d6bf for inspiration. In fact, many
> parts there could be shared.

Thanks! That's in my TODO list.

> More comments below.
>
> > +#define __XIP_FIXUP(addr) \
> > +     (((long)(addr) >= CONFIG_XIP_PHYS_ADDR && \
> > +       (long)(addr) <= CONFIG_XIP_PHYS_ADDR + SZ_16M) ? \
> > +     (long)(addr) - CONFIG_XIP_PHYS_ADDR + CONFIG_XIP_PHYS_RAM_BASE - XIP_OFFSET : \
> > +     (long)(addr))
>
> Here you should cast to unsigned long instead.

Right, or (just thought of it) uintptr_t for that matter. Does that sound right?

> > +#ifdef CONFIG_XIP_KERNEL
> > +     la a0, _trampoline_pg_dir
> > +     lw t0, _xip_fixup
> > +     add a0, a0, t0
> [...]
> > +_xip_fixup:
> > +     .dword CONFIG_XIP_PHYS_RAM_BASE - CONFIG_XIP_PHYS_ADDR - XIP_OFFSET
> > +#endif
>
> Here _xip_fixup is a dword but you're loading it as a word.
> This won't work for both rv32 and rv64.

Well, at this point I believe it does, as long as we use little
endian. 64-bit version has been verified.
I do not argue though that it isn't nice and should be fixed.

> > +SECTIONS
> > +{
> > +     /* Beginning of code and text segment */
> > +     . = XIP_VIRT_ADDR(CONFIG_XIP_PHYS_ADDR);
> > +     _xiprom = .;
> > +     _start = .;
> > +     HEAD_TEXT_SECTION
> > +     INIT_TEXT_SECTION(PAGE_SIZE)
> > +     /* we have to discard exit text and such at runtime, not link time */
> > +     .exit.text :
> > +     {
> > +             EXIT_TEXT
> > +     }
> > +
> > +     .text : {
> > +             _text = .;
> > +             _stext = .;
> > +             TEXT_TEXT
> > +             SCHED_TEXT
> > +             CPUIDLE_TEXT
> > +             LOCK_TEXT
> > +             KPROBES_TEXT
> > +             ENTRY_TEXT
> > +             IRQENTRY_TEXT
> > +             SOFTIRQENTRY_TEXT
> > +             *(.fixup)
> > +             _etext = .;
> > +     }
> > +     RO_DATA(L1_CACHE_BYTES)
> > +     .srodata : {
> > +             *(.srodata*)
> > +     }
> > +     .init.rodata : {
> > +             INIT_SETUP(16)
> > +             INIT_CALLS
> > +             CON_INITCALL
> > +             INIT_RAM_FS
> > +     }
> > +     _exiprom = ALIGN(PAGE_SIZE);            /* End of XIP ROM area */
>
> Why do you align this to a page size?

TBH I just cut the corners here and below, did not have to worry about
partial pages and such.


> > +
> > +
> > +/*
> > + * From this point, stuff is considered writable and will be copied to RAM
> > + */
> > +     __data_loc = ALIGN(PAGE_SIZE);  /* location in file */
>
> Same question here?
>
> > +     . = PAGE_OFFSET;                /* location in memory */
> > +
> > +     _sdata = .;                     /* Start of data section */
> > +     _data = .;
> > +     RW_DATA(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
> > +     _edata = .;
> > +     __start_ro_after_init = .;
> > +     .data.ro_after_init : AT(ADDR(.data.ro_after_init) - LOAD_OFFSET) {
> > +             *(.data..ro_after_init)
> > +     }
> > +     __end_ro_after_init = .;
> > +
> > +     . = ALIGN(PAGE_SIZE);
>
> And again here?
>
> > +#ifdef CONFIG_XIP_KERNEL
> > +/* called from head.S with MMU off */
> > +asmlinkage void __init __copy_data(void)
> > +{
> > +     void *from = (void *)(&_sdata);
> > +     void *end = (void *)(&_end);
> > +     void *to = (void *)CONFIG_XIP_PHYS_RAM_BASE;
> > +     size_t sz = (size_t)(end - from);
> > +
> > +     memcpy(to, from, sz);
> > +}
> > +#endif
>
> Where is the stack located when this executes? The stack for the init
> task is typically found within the .data area. At least on ARM it is.
> You don't want to overwrite your stack here.

sp is set to within the .data area later, we rely on the u-boot sp
setting which is outside of the destination area for the image parts
that are copied. I agree that this makes the implementation fragile
and will explicitly set sp in the next path version.

Best regards,
   Vitaly
