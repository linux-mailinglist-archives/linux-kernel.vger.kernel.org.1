Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255352F94C2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 19:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbhAQS4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 13:56:23 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:34078 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729182AbhAQS4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 13:56:13 -0500
Received: by mail-ot1-f48.google.com with SMTP id a109so14206453otc.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 10:55:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ciY/9x8kUuaBeYyf+2YkcAZyzFDsQyL8uiXdT0ViaCA=;
        b=clrMBai/Vm/LqZ8ajhouI4ipjG46d+IoAn3RRPo7nb/1EQg+kSa3lQvbeobwpl6bVm
         5VOk1o6lsnwjBId9xoUF1vAXf6xt2nxIUQ6tTQziV+WDa5cWFdbAUFA4Qfsxo22dMqyL
         AjuTS3/hlcKVEjXjx3OrVGlMwsoQqrjaEkCbjgHeDjBawlF+bYFWWmGXIRt+ZyP9Qz3W
         UkAdGNolOSfhFE9FxjtEY4pQLsPPl9jy0sOzrZkOMWiWE4PjWBImILyainmaY26UGwa0
         yjvl6O80mt56rDzIOXEA0ntqZj0nXmSizeuk9lyvu8O20IXNrqB8Zj3dIi+4Xxp1zrV4
         uZMg==
X-Gm-Message-State: AOAM5337pcBFdIjvZc6UqQz05TstmjY6+ZD5gyxgBELltXtWoyM72VZN
        JiQVkuMzSkcNZ41Zf92yfBxQuJdPXCkU23DXH5I=
X-Google-Smtp-Source: ABdhPJypfkMhm7oJaM3WyIRHY/JImqdUuP9wXDsOxtIltstM1QporVf3PKM7Bs4SDUXjo7aRdQIlnCxIZdGuoH+uLqY=
X-Received: by 2002:a05:6830:1f5a:: with SMTP id u26mr15344536oth.250.1610909731958;
 Sun, 17 Jan 2021 10:55:31 -0800 (PST)
MIME-Version: 1.0
References: <CAOnJCU+mCPwbeOQpmHmu3ar_17otmgftiKHLL+Z4_nExpj0=cA@mail.gmail.com>
 <mhng-4458ef4d-9443-491e-9118-aec3596058ed@penguin> <CAOnJCUJON3B6ugWDY1=rcDOMS2+m=SVBsiAEnwV=QDL7omnsfA@mail.gmail.com>
 <CAMuHMdXQr-qNQ2aNVmgQFfs_dJ8=A-xzrhxRf9VUmzFXx+2o_w@mail.gmail.com> <CAOnJCUJys9gacJ7kgTBit9tq0M51c3jdoGjcGxtMFRgOhU9AwQ@mail.gmail.com>
In-Reply-To: <CAOnJCUJys9gacJ7kgTBit9tq0M51c3jdoGjcGxtMFRgOhU9AwQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 17 Jan 2021 19:55:20 +0100
Message-ID: <CAMuHMdUPQCk1WQOeenoTunw-d3bW6t3fKYnWo7uKtyamnC9dvg@mail.gmail.com>
Subject: Re: [PATCH 3/4] RISC-V: Fix L1_CACHE_BYTES for RV32
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Atish,

On Sat, Jan 16, 2021 at 2:39 AM Atish Patra <atishp@atishpatra.org> wrote:
> On Thu, Jan 14, 2021 at 11:59 PM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Thu, Jan 14, 2021 at 10:11 PM Atish Patra <atishp@atishpatra.org> wrote:
> > > On Thu, Jan 14, 2021 at 11:46 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> > > > On Thu, 14 Jan 2021 10:33:01 PST (-0800), atishp@atishpatra.org wrote:
> > > > > On Wed, Jan 13, 2021 at 9:10 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> > > > >>
> > > > >> On Thu, 07 Jan 2021 01:26:51 PST (-0800), Atish Patra wrote:
> > > > >> > SMP_CACHE_BYTES/L1_CACHE_BYTES should be defined as 32 instead of
> > > > >> > 64 for RV32. Otherwise, there will be hole of 32 bytes with each memblock
> > > > >> > allocation if it is requested to be aligned with SMP_CACHE_BYTES.
> > > > >> >
> > > > >> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > > >> > ---
> > > > >> >  arch/riscv/include/asm/cache.h | 4 ++++
> > > > >> >  1 file changed, 4 insertions(+)
> > > > >> >
> > > > >> > diff --git a/arch/riscv/include/asm/cache.h b/arch/riscv/include/asm/cache.h
> > > > >> > index 9b58b104559e..c9c669ea2fe6 100644
> > > > >> > --- a/arch/riscv/include/asm/cache.h
> > > > >> > +++ b/arch/riscv/include/asm/cache.h
> > > > >> > @@ -7,7 +7,11 @@
> > > > >> >  #ifndef _ASM_RISCV_CACHE_H
> > > > >> >  #define _ASM_RISCV_CACHE_H
> > > > >> >
> > > > >> > +#ifdef CONFIG_64BIT
> > > > >> >  #define L1_CACHE_SHIFT               6
> > > > >> > +#else
> > > > >> > +#define L1_CACHE_SHIFT               5
> > > > >> > +#endif
> > > > >> >
> > > > >> >  #define L1_CACHE_BYTES               (1 << L1_CACHE_SHIFT)
> > > > >>
> > > > >> Should we not instead just
> > > > >>
> > > > >> #define SMP_CACHE_BYTES L1_CACHE_BYTES
> > > > >>
> > > > >> like a handful of architectures do?
> > > > >>
> > > > >
> > > > > The generic code already defines it that way in include/linux/cache.h
> > > > >
> > > > >> The cache size is sort of fake here, as we don't have any non-coherent
> > > > >> mechanisms, but IIRC we wrote somewhere that it's recommended to have 64-byte
> > > > >> cache lines in RISC-V implementations as software may assume that for
> > > > >> performance reasons.  Not really a strong reason, but I'd prefer to just make
> > > > >> these match.
> > > > >>
> > > > >
> > > > > If it is documented somewhere in the kernel, we should update that. I
> > > > > think SMP_CACHE_BYTES being 64
> > > > > actually degrades the performance as there will be a fragmented memory
> > > > > blocks with 32 bit bytes gap wherever
> > > > > SMP_CACHE_BYTES is used as an alignment requirement.
> > > >
> > > > I don't buy that: if you're trying to align to the cache size then the gaps are
> > > > the whole point.  IIUC the 64-byte cache lines come from DDR, not XLEN, so
> > > > there's really no reason for these to be different between the base ISAs.
> > > >
> > >
> > > Got your point. I noticed this when fixing the resource tree issue
> > > where the SMP_CACHE_BYTES
> > > alignment was not intentional but causing the issue. The real issue
> > > was solved via another patch in this series though.
> > >
> > > Just to clarify, if the allocation function intends to allocate
> > > consecutive memory, it should use 32 instead of SMP_CACHE_BYTES.
> > > This will lead to a #ifdef macro in the code.
> > >
> > > > > In addition to that, Geert Uytterhoeven mentioned some panic on vex32
> > > > > without this patch.
> > > > > I didn't see anything in Qemu though.
> > > >
> > > > Something like that is probably only going to show up on real hardware, QEMU
> > > > doesn't really do anything with the cache line size.  That said, as there's
> > > > nothing in our kernel now related to non-coherent memory there really should
> > > > only be performance issue (at least until we have non-coherent systems).
> > > >
> > > > I'd bet that the change is just masking some other bug, either in the software
> > > > or the hardware.  I'd prefer to root cause this rather than just working around
> > > > it, as it'll probably come back later and in a more difficult way to find.
> > > >
> > >
> > > Agreed. @Geert Uytterhoeven Can you do a further analysis of the panic
> > > you were saying ?
> > > We may need to change an alignment requirement to 32 for RV32 manually
> > > at some place in code.
> >
> > My findings were in
> > https://lore.kernel.org/linux-riscv/CAMuHMdWf6K-5y02+WJ6Khu1cD6P0n5x1wYQikrECkuNtAA1pgg@mail.gmail.com/
> >
> > Note that when the memblock.reserved list kept increasing, it kept on
> > adding the same entry to the list.  But that was fixed by "[PATCH 1/4]
> > RISC-V: Do not allocate memblock while iterating reserved memblocks".
> >
> > After that, only the (reproducible) "Unable to handle kernel paging
> > request at virtual address 61636473" was left, always at the same place.
> > No idea where the actual corruption happened.
> >
>
> Yes. I was asking about this panic. I don't have the litex fpga to
> reproduce this as well.
> Can you take a look at the epc & ra to figure out where exactly is the fault ?
>
> That will help to understand the real cause for this panic.

[...]
Freeing initrd memory: 8192K
workingset: timestamp_bits=30 max_order=15 bucket_order=0
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler mq-deadline registered
io scheduler kyber registered
Unable to handle kernel paging request at virtual address 61636473
Oops [#1]
CPU: 0 PID: 1 Comm: swapper/0 Not tainted
5.11.0-rc3-orangecrab-00068-g267ecb2e2e9d-dirty #37
epc: c000f8e4 ra : c00110e8 sp : c082bc70
 gp : c0665948 tp : c0830000 t0 : c08ba500
 t1 : 00000002 t2 : 00000000 s0 : c082bc80
 s1 : 00000000 a0 : c05e2dec a1 : c08ba4e0
 a2 : c0665d38 a3 : 61636473 a4 : f0004003
 a5 : f0004000 a6 : c7efffb8 a7 : c08ba4e0
 s2 : 01001f00 s3 : c0666000 s4 : c05e2e0c
 s5 : c0666000 s6 : 80000000 s7 : 00000006
 s8 : c05a4000 s9 : c08ba4e0 s10: c05e2dec
 s11: 00000000 t3 : c08ba500 t4 : 00000001
 t5 : 00076400 t6 : c08bbb5e
status: 00000120 badaddr: 61636473 cause: 0000000d
---[ end trace 50524759df172195 ]---
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
---[ end Kernel panic - not syncing: Attempted to kill init!
exitcode=0x0000000b ]---

Looking up epc and ra in System.map, closest symbols are:

    c000f8b0 t __request_resource
    c0010ff4 T __request_region

The above is with a kernel built from my own config, but using
litex_vexriscv_defconfig with https://github.com/geertu/linux branch
litex-v5.11 and commit 718aaf7d1c351035 ("RISC-V: Fix L1_CACHE_BYTES for
RV32") reverted gives the exact same results.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
