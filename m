Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 645522F6CEB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 22:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbhANVMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 16:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbhANVMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 16:12:06 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A62C061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 13:11:25 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id o6so14027975iob.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 13:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M8WYmU1OYy2bAwdAfp39SgsoayoGxiD9AS0X3mtcrDU=;
        b=e3m26mYJjCGBBdtqDDHsBYwE7TbY6swQ2IwrVvIrw742/+Pc51y1VHryFH/8mkKHa3
         r0i9z+Qm5krgPVFtetMDbxdLKAgZgAQoESA5W5DExpgIUL2QvmbPeIiM86+4GQKkW0vw
         cfF8R78HLM3uNjYI6HetbcovnaWzijtUJzZ/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M8WYmU1OYy2bAwdAfp39SgsoayoGxiD9AS0X3mtcrDU=;
        b=YzWo1+XfwRL+xMDP1hetLGVgHLHj6Smt31ljaHNLcJySfpGlzGQVmDkHdQONfFA3Z6
         7uX2idP2K93BTLqPWyX594Gwu53BLFmTqdx+rEJCcBRI/xYS7LQ5iwAYdm3GTIC28rB7
         /y/iJRU0Bm6Lzdc2y2fwPptZMuZoyfmXPejdtUD3thMIdU0JSoCQIp4AaTU+TqU0QBEz
         EhvnDcQ6Hfh5aSwTCF9TijCtL08OUsUrBieIG2KYG0qMkpVajlGXU2GLPmVUizI2k8ur
         TVcbKeA9se4BSF5DZWD13JhhPzdVxyDMBEiK93yDbgR/MDbBAmdgYnVOazDcgRw2pwzq
         UKOg==
X-Gm-Message-State: AOAM53147prdztA4GlrBdOyUmmR2fwjcCwHjOJP1LoPAnpA0G6nrzf42
        3wgAAIo/qGOyBGNWqC5ZIA/34pF/eRAaHnb0W1Fu
X-Google-Smtp-Source: ABdhPJyRJhPjAGjwKf+7QRz7LzAj+ARJ1RCho5T78E0d2vC821Cj5/V5y/gXoeFDnOHUkU3yGgT1ZaZOqJBkk2z3zhs=
X-Received: by 2002:a05:6638:13c6:: with SMTP id i6mr6096314jaj.141.1610658685204;
 Thu, 14 Jan 2021 13:11:25 -0800 (PST)
MIME-Version: 1.0
References: <CAOnJCU+mCPwbeOQpmHmu3ar_17otmgftiKHLL+Z4_nExpj0=cA@mail.gmail.com>
 <mhng-4458ef4d-9443-491e-9118-aec3596058ed@penguin>
In-Reply-To: <mhng-4458ef4d-9443-491e-9118-aec3596058ed@penguin>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 14 Jan 2021 13:11:14 -0800
Message-ID: <CAOnJCUJON3B6ugWDY1=rcDOMS2+m=SVBsiAEnwV=QDL7omnsfA@mail.gmail.com>
Subject: Re: [PATCH 3/4] RISC-V: Fix L1_CACHE_BYTES for RV32
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Atish Patra <Atish.Patra@wdc.com>,
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

On Thu, Jan 14, 2021 at 11:46 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Thu, 14 Jan 2021 10:33:01 PST (-0800), atishp@atishpatra.org wrote:
> > On Wed, Jan 13, 2021 at 9:10 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> >>
> >> On Thu, 07 Jan 2021 01:26:51 PST (-0800), Atish Patra wrote:
> >> > SMP_CACHE_BYTES/L1_CACHE_BYTES should be defined as 32 instead of
> >> > 64 for RV32. Otherwise, there will be hole of 32 bytes with each memblock
> >> > allocation if it is requested to be aligned with SMP_CACHE_BYTES.
> >> >
> >> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> >> > ---
> >> >  arch/riscv/include/asm/cache.h | 4 ++++
> >> >  1 file changed, 4 insertions(+)
> >> >
> >> > diff --git a/arch/riscv/include/asm/cache.h b/arch/riscv/include/asm/cache.h
> >> > index 9b58b104559e..c9c669ea2fe6 100644
> >> > --- a/arch/riscv/include/asm/cache.h
> >> > +++ b/arch/riscv/include/asm/cache.h
> >> > @@ -7,7 +7,11 @@
> >> >  #ifndef _ASM_RISCV_CACHE_H
> >> >  #define _ASM_RISCV_CACHE_H
> >> >
> >> > +#ifdef CONFIG_64BIT
> >> >  #define L1_CACHE_SHIFT               6
> >> > +#else
> >> > +#define L1_CACHE_SHIFT               5
> >> > +#endif
> >> >
> >> >  #define L1_CACHE_BYTES               (1 << L1_CACHE_SHIFT)
> >>
> >> Should we not instead just
> >>
> >> #define SMP_CACHE_BYTES L1_CACHE_BYTES
> >>
> >> like a handful of architectures do?
> >>
> >
> > The generic code already defines it that way in include/linux/cache.h
> >
> >> The cache size is sort of fake here, as we don't have any non-coherent
> >> mechanisms, but IIRC we wrote somewhere that it's recommended to have 64-byte
> >> cache lines in RISC-V implementations as software may assume that for
> >> performance reasons.  Not really a strong reason, but I'd prefer to just make
> >> these match.
> >>
> >
> > If it is documented somewhere in the kernel, we should update that. I
> > think SMP_CACHE_BYTES being 64
> > actually degrades the performance as there will be a fragmented memory
> > blocks with 32 bit bytes gap wherever
> > SMP_CACHE_BYTES is used as an alignment requirement.
>
> I don't buy that: if you're trying to align to the cache size then the gaps are
> the whole point.  IIUC the 64-byte cache lines come from DDR, not XLEN, so
> there's really no reason for these to be different between the base ISAs.
>

Got your point. I noticed this when fixing the resource tree issue
where the SMP_CACHE_BYTES
alignment was not intentional but causing the issue. The real issue
was solved via another patch in this series though.

Just to clarify, if the allocation function intends to allocate
consecutive memory, it should use 32 instead of SMP_CACHE_BYTES.
This will lead to a #ifdef macro in the code.

> > In addition to that, Geert Uytterhoeven mentioned some panic on vex32
> > without this patch.
> > I didn't see anything in Qemu though.
>
> Something like that is probably only going to show up on real hardware, QEMU
> doesn't really do anything with the cache line size.  That said, as there's
> nothing in our kernel now related to non-coherent memory there really should
> only be performance issue (at least until we have non-coherent systems).
>
> I'd bet that the change is just masking some other bug, either in the software
> or the hardware.  I'd prefer to root cause this rather than just working around
> it, as it'll probably come back later and in a more difficult way to find.
>

Agreed. @Geert Uytterhoeven Can you do a further analysis of the panic
you were saying ?
We may need to change an alignment requirement to 32 for RV32 manually
at some place in code.

> >> _______________________________________________
> >> linux-riscv mailing list
> >> linux-riscv@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish
