Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3010269407
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 19:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbgINRtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 13:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgINMDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 08:03:41 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8267CC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 04:52:44 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id y15so10953535wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 04:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PJ7iJNVDDaND4zplndsbl4Uby21iiMEjNanabMHyNa8=;
        b=YalQb9qXnij3jA+z9DcxOA6IfyTifBTo3+5ciDzFu0EX8HtYUQWiH1DfbNzkQ5E4Wg
         n9tEwxvm65+rVwSYeQMc2Aeh/gYDYfUiZN0Pn1sNa+UWyQH3JerLbfdSWlfaqGboTyxk
         cx3klAP3OoD3zNPoXyDGb7iQc4jb276bpjW/piZZahi+ZdAaHXAPMRzwePA2V73YOOi8
         YeF+3dio/BlVTJ9VLcik8+RQmy+l6AQFnUSvJQzDppohujPTTJT+i8wYKFDzOs/x3aQ4
         ZCHX3caFgONUgL5jSFttJNsV5c+i+7BQbP92MTWKyiAK/xiitzOqpv0wjUVqqur0EfGU
         QroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PJ7iJNVDDaND4zplndsbl4Uby21iiMEjNanabMHyNa8=;
        b=UbAh6ajpV5V4bqbF2NQcVVKEut5DSfqiPEzU/cz55bh1rPd5vzLlHZ+EFaIPRWtRTN
         3rcnolBjuyJ6XvVkktTHNDn0zAokiAlvOT+NBJHTekA20A+u9SRFKymYPQmGbAN1zZBS
         dHh+B0vRHPW4bbuexmynrPCnjCPLr0adzEvDl05uZ44TWL5xylJTTzPPXpI0GIKdqz1G
         OHWbATQEbMVIywNVch410TPHzwHL/t7ruPAvreeCgDk8OacDhuFHpfBzJeywPEmidGFd
         5l5vP7YZ9U/xhaf/ALLQ0m8/ICGPxsyPr7EJ+wDb3w5/H1pf8tD2YZ0WPmgZTvgnZIQn
         Drmw==
X-Gm-Message-State: AOAM531gRB6zBS63WAgwCBGqcTLcYKxn/1zReJCu4l1wig/Zz0Gn93df
        LMNMP0sn2GmB6lycirATB6MkO+5Wa6zehaCeP5makg==
X-Google-Smtp-Source: ABdhPJxRyS8Ai4E8v9nf+FcXijbMUkAsU+Eigzaf0copkXWk29uviSgjKvIWApV4fAHRX2LCjI94vgVq+VQJ/1zXIU0=
X-Received: by 2002:a7b:c0c5:: with SMTP id s5mr14501327wmh.152.1600084362966;
 Mon, 14 Sep 2020 04:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200912002341.4869-1-atish.patra@wdc.com> <20200912104502.GF2142832@kernel.org>
 <CAOnJCU+yK8uxFU-zv5BPTzmtxwiVpiPxGsNkVEtnTQ+64UU-ug@mail.gmail.com>
In-Reply-To: <CAOnJCU+yK8uxFU-zv5BPTzmtxwiVpiPxGsNkVEtnTQ+64UU-ug@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 14 Sep 2020 17:22:31 +0530
Message-ID: <CAAhSdy0cudvf4Lc3YaSc7MH5oGH1V60C3rToMUZU01LPxRWLKQ@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Consider sparse memory while removing unusable memory
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Mike Rapoport <rppt@kernel.org>, Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Zong Li <zong.li@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 5:18 AM Atish Patra <atishp@atishpatra.org> wrote:
>
> On Sat, Sep 12, 2020 at 3:45 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > Hello Atish,
> >
> > On Fri, Sep 11, 2020 at 05:23:41PM -0700, Atish Patra wrote:
> > > Currently, any usable memory area beyond page_offset is removed by adding the
> > > memory sizes from each memblock. That may not work for sparse memory
> > > as memory regions can be very far apart resulting incorrect removal of some
> > > usable memory.
> >
> > If I understand correctly, the memory with physical addresses larger
> > than (-PAGE_OFFSET) cannot be used. Since it was aready
> > memblock_add()'ed during device tree parsing, you need to remove it from
> > memblock.
> >
>
> IIRC, the original intention was to fix MAXPHYSMEM_2GB option for RV64
> for the medlow model.
> That's why the patch removed any memory beyond -PAGE_OFFSET.
>
> > For that you can use memblock_enforce_memory_limit(-PAGE_OFFSET).
> >
> Thanks. I think we can just call memblock_enforce_memory_limit without
> tracking the total memory size
> and whether maximum memory described in DT is greater than  -PAGE_OFFSET.
>
> @Anup Patel Was there any other reason for this change originally?

No other reason. We just wanted to ensure that amount of memory addressable
by kernel (i.e. -PAGE_OFFSET) is also considered when removing memblock.

Regards,
Anup

>
> > > Just use the start of the first memory block and the end of the last memory
> > > block to compute the size of the total memory that can be used.
> > >
> > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > ---
> > >  arch/riscv/mm/init.c | 6 ++----
> > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > > index 787c75f751a5..188281fc2816 100644
> > > --- a/arch/riscv/mm/init.c
> > > +++ b/arch/riscv/mm/init.c
> > > @@ -147,7 +147,6 @@ void __init setup_bootmem(void)
> > >  {
> > >       struct memblock_region *reg;
> > >       phys_addr_t mem_size = 0;
> > > -     phys_addr_t total_mem = 0;
> > >       phys_addr_t mem_start, end = 0;
> > >       phys_addr_t vmlinux_end = __pa_symbol(&_end);
> > >       phys_addr_t vmlinux_start = __pa_symbol(&_start);
> > > @@ -155,18 +154,17 @@ void __init setup_bootmem(void)
> > >       /* Find the memory region containing the kernel */
> > >       for_each_memblock(memory, reg) {
> > >               end = reg->base + reg->size;
> > > -             if (!total_mem)
> > > +             if (!mem_start)
> > >                       mem_start = reg->base;
> > >               if (reg->base <= vmlinux_start && vmlinux_end <= end)
> > >                       BUG_ON(reg->size == 0);
> > > -             total_mem = total_mem + reg->size;
> > >       }
> > >
> > >       /*
> > >        * Remove memblock from the end of usable area to the
> > >        * end of region
> > >        */
> > > -     mem_size = min(total_mem, (phys_addr_t)-PAGE_OFFSET);
> > > +     mem_size = min(end - mem_start, (phys_addr_t)-PAGE_OFFSET);
> > >       if (mem_start + mem_size < end)
> > >               memblock_remove(mem_start + mem_size,
> > >                               end - mem_start - mem_size);
> > > --
> > > 2.24.0
> > >
> >
> > --
> > Sincerely yours,
> > Mike.
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>
>
>
> --
> Regards,
> Atish
