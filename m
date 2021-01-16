Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5D12F8A88
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 02:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbhAPBkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 20:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbhAPBkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 20:40:05 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FD8C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 17:39:24 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id e22so21801574iom.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 17:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e/4EufOTObHXM0rTx80uVaCTX7YuAKaU4BEuP78cHf4=;
        b=ldBKALM8g+X2GX3CRc8eQLfhqViKHTRNSaK0oEodm8JTqoYuBvb4zPfHQHgEYRvuQH
         Hyj2MUKK+m7EHYgUCzU2MKbdd0ncYmZNfJO+nehV0UJ1bqCIO7cxlDapK6fSAl8PKtD9
         w8nw5mNdralJ3tmGtPPAOjPROn+hOxMyn32pI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e/4EufOTObHXM0rTx80uVaCTX7YuAKaU4BEuP78cHf4=;
        b=lg6XjswKIAes8iRg7PlpjjhGEfzWDblEjsf2DWQsoesL+TOeaT31dLYOByjG78VCA1
         pmS6d4NkqUjksa1Frfv+DSvt+eZB/DwUMy0+uFi33LpunnLwZKLQaN0kFW7Iu30/mysE
         Jdg1WMvtHP5SahoVFMDLlwtqN4/UrXZ/F6YGEk7P9fJ6sScy/MR0A3lXCVIaKmPSqmrR
         ES0xLk5D+fEa+eUjdFe0FXNCSwy+8yw1/leptC1mDvdvdaUQ+SkgN9Nj7OT+jInRfRLq
         uz/o06aN7+ZpA05SsvPUm1kldfs0C48KqYwI+kUHHY0gcleB1B4x5QrIUDaURGDE6dNG
         pFpA==
X-Gm-Message-State: AOAM530akr18UPH2dcKEYVU3Of3cu/K0CFReBCMzdBDVZYT969Vob/5e
        QJ19NN9SAFTwgDzRL/PWujjUKiWHbLwuooUV5KWB
X-Google-Smtp-Source: ABdhPJzzdFwrDw9SiK/q+DIAIHxFu0mHFdNfa6wLm50s5Y+UbSLKZpMZVgn8CJyspeUuilAT6NvbUI8+SWjfdICgRNQ=
X-Received: by 2002:a92:6410:: with SMTP id y16mr13460228ilb.126.1610761164117;
 Fri, 15 Jan 2021 17:39:24 -0800 (PST)
MIME-Version: 1.0
References: <CAOnJCU+mCPwbeOQpmHmu3ar_17otmgftiKHLL+Z4_nExpj0=cA@mail.gmail.com>
 <mhng-4458ef4d-9443-491e-9118-aec3596058ed@penguin> <CAOnJCUJON3B6ugWDY1=rcDOMS2+m=SVBsiAEnwV=QDL7omnsfA@mail.gmail.com>
 <CAMuHMdXQr-qNQ2aNVmgQFfs_dJ8=A-xzrhxRf9VUmzFXx+2o_w@mail.gmail.com>
In-Reply-To: <CAMuHMdXQr-qNQ2aNVmgQFfs_dJ8=A-xzrhxRf9VUmzFXx+2o_w@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 15 Jan 2021 17:39:13 -0800
Message-ID: <CAOnJCUJys9gacJ7kgTBit9tq0M51c3jdoGjcGxtMFRgOhU9AwQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] RISC-V: Fix L1_CACHE_BYTES for RV32
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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

On Thu, Jan 14, 2021 at 11:59 PM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Atish,
>
> On Thu, Jan 14, 2021 at 10:11 PM Atish Patra <atishp@atishpatra.org> wrote:
> > On Thu, Jan 14, 2021 at 11:46 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> > > On Thu, 14 Jan 2021 10:33:01 PST (-0800), atishp@atishpatra.org wrote:
> > > > On Wed, Jan 13, 2021 at 9:10 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> > > >>
> > > >> On Thu, 07 Jan 2021 01:26:51 PST (-0800), Atish Patra wrote:
> > > >> > SMP_CACHE_BYTES/L1_CACHE_BYTES should be defined as 32 instead of
> > > >> > 64 for RV32. Otherwise, there will be hole of 32 bytes with each memblock
> > > >> > allocation if it is requested to be aligned with SMP_CACHE_BYTES.
> > > >> >
> > > >> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > >> > ---
> > > >> >  arch/riscv/include/asm/cache.h | 4 ++++
> > > >> >  1 file changed, 4 insertions(+)
> > > >> >
> > > >> > diff --git a/arch/riscv/include/asm/cache.h b/arch/riscv/include/asm/cache.h
> > > >> > index 9b58b104559e..c9c669ea2fe6 100644
> > > >> > --- a/arch/riscv/include/asm/cache.h
> > > >> > +++ b/arch/riscv/include/asm/cache.h
> > > >> > @@ -7,7 +7,11 @@
> > > >> >  #ifndef _ASM_RISCV_CACHE_H
> > > >> >  #define _ASM_RISCV_CACHE_H
> > > >> >
> > > >> > +#ifdef CONFIG_64BIT
> > > >> >  #define L1_CACHE_SHIFT               6
> > > >> > +#else
> > > >> > +#define L1_CACHE_SHIFT               5
> > > >> > +#endif
> > > >> >
> > > >> >  #define L1_CACHE_BYTES               (1 << L1_CACHE_SHIFT)
> > > >>
> > > >> Should we not instead just
> > > >>
> > > >> #define SMP_CACHE_BYTES L1_CACHE_BYTES
> > > >>
> > > >> like a handful of architectures do?
> > > >>
> > > >
> > > > The generic code already defines it that way in include/linux/cache.h
> > > >
> > > >> The cache size is sort of fake here, as we don't have any non-coherent
> > > >> mechanisms, but IIRC we wrote somewhere that it's recommended to have 64-byte
> > > >> cache lines in RISC-V implementations as software may assume that for
> > > >> performance reasons.  Not really a strong reason, but I'd prefer to just make
> > > >> these match.
> > > >>
> > > >
> > > > If it is documented somewhere in the kernel, we should update that. I
> > > > think SMP_CACHE_BYTES being 64
> > > > actually degrades the performance as there will be a fragmented memory
> > > > blocks with 32 bit bytes gap wherever
> > > > SMP_CACHE_BYTES is used as an alignment requirement.
> > >
> > > I don't buy that: if you're trying to align to the cache size then the gaps are
> > > the whole point.  IIUC the 64-byte cache lines come from DDR, not XLEN, so
> > > there's really no reason for these to be different between the base ISAs.
> > >
> >
> > Got your point. I noticed this when fixing the resource tree issue
> > where the SMP_CACHE_BYTES
> > alignment was not intentional but causing the issue. The real issue
> > was solved via another patch in this series though.
> >
> > Just to clarify, if the allocation function intends to allocate
> > consecutive memory, it should use 32 instead of SMP_CACHE_BYTES.
> > This will lead to a #ifdef macro in the code.
> >
> > > > In addition to that, Geert Uytterhoeven mentioned some panic on vex32
> > > > without this patch.
> > > > I didn't see anything in Qemu though.
> > >
> > > Something like that is probably only going to show up on real hardware, QEMU
> > > doesn't really do anything with the cache line size.  That said, as there's
> > > nothing in our kernel now related to non-coherent memory there really should
> > > only be performance issue (at least until we have non-coherent systems).
> > >
> > > I'd bet that the change is just masking some other bug, either in the software
> > > or the hardware.  I'd prefer to root cause this rather than just working around
> > > it, as it'll probably come back later and in a more difficult way to find.
> > >
> >
> > Agreed. @Geert Uytterhoeven Can you do a further analysis of the panic
> > you were saying ?
> > We may need to change an alignment requirement to 32 for RV32 manually
> > at some place in code.
>
> My findings were in
> https://lore.kernel.org/linux-riscv/CAMuHMdWf6K-5y02+WJ6Khu1cD6P0n5x1wYQikrECkuNtAA1pgg@mail.gmail.com/
>
> Note that when the memblock.reserved list kept increasing, it kept on
> adding the same entry to the list.  But that was fixed by "[PATCH 1/4]
> RISC-V: Do not allocate memblock while iterating reserved memblocks".
>
> After that, only the (reproducible) "Unable to handle kernel paging
> request at virtual address 61636473" was left, always at the same place.
> No idea where the actual corruption happened.
>

Yes. I was asking about this panic. I don't have the litex fpga to
reproduce this as well.
Can you take a look at the epc & ra to figure out where exactly is the fault ?

That will help to understand the real cause for this panic.

> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds



-- 
Regards,
Atish
