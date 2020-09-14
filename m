Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0CD2269434
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 19:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgINRxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 13:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgINRxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 13:53:14 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACBBC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 10:53:13 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id q9so879219wmj.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 10:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZKhv5rTCRwwZYJ4fJZiFA0QJHdmQ369d7Ye56iqS39I=;
        b=LSYBezCbF3qD2J1/hnvedLtI3NNJxjkCI3H7K3OpFvBX9JZU0AhCfLK8/EptPQIA1x
         AzWCI/TnXymeOP930uBLk0o6wdCrYsuqj1ik1lCEEVx3QSZI4XJkHJ61lRT4e5wbGq9z
         hlCIWs01gU+mS+7JoC9yORjrjQkPCTlgo2oho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZKhv5rTCRwwZYJ4fJZiFA0QJHdmQ369d7Ye56iqS39I=;
        b=oq4lbHsgm8cq32u/wZF0v0a/mBn9LxvDebQi31+ZU0HLvs9y0SlWaf6xpVk4t+XvwR
         SKa8YTMtgsQIANud7tP8AmGMzPN1wv2eiNp0GOjaIhYKnU1MLMlv3iJTmJ12VDv3DsPF
         DvC/TF2yVhKGSOwsZtLBHIx7q1pCdfGyMQA8szECEkGfgKNn8cIYmMdr9INpbSEtxFlH
         ZjENjzBG0oiPQiqdbzxip/imXEhB9FYZfuHp/ORKKx4DGArUHRsbnvyHvpLrQcZM7C4s
         PyBAhhvn49VVm3QXy9mdxMuywzmTR0fC/nREPTH2z1MGtGnu+LP4dma2+ve2qB9HVKeg
         fD3Q==
X-Gm-Message-State: AOAM531ctUZ46Hv8FnTKc6tD2t8BmWgmtY5iWFN7PMrjlo2xJSket+jy
        9EkGlcNKf3zCmWi3kN2vOhj9ekXpXSYU+HV9IGp+
X-Google-Smtp-Source: ABdhPJxw1Qpj5A7GWHWLHZ09ZPMi/B/UvNz/rjGtLMnwaH4Nhx+vHKTB51J5Q9V4CbzLicMUN+/4uZ5UPpaX2uHHBfE=
X-Received: by 2002:a05:600c:2215:: with SMTP id z21mr531634wml.176.1600105992277;
 Mon, 14 Sep 2020 10:53:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200912002341.4869-1-atish.patra@wdc.com> <20200912104502.GF2142832@kernel.org>
 <CAOnJCU+yK8uxFU-zv5BPTzmtxwiVpiPxGsNkVEtnTQ+64UU-ug@mail.gmail.com> <CAAhSdy0cudvf4Lc3YaSc7MH5oGH1V60C3rToMUZU01LPxRWLKQ@mail.gmail.com>
In-Reply-To: <CAAhSdy0cudvf4Lc3YaSc7MH5oGH1V60C3rToMUZU01LPxRWLKQ@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 14 Sep 2020 10:53:00 -0700
Message-ID: <CAOnJCUKqUZVTKzgjK0=Kj_WCZU+hP27SX8V0mvT+2AVk_MMC5w@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Consider sparse memory while removing unusable memory
To:     Anup Patel <anup@brainfault.org>
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

On Mon, Sep 14, 2020 at 4:52 AM Anup Patel <anup@brainfault.org> wrote:
>
> On Mon, Sep 14, 2020 at 5:18 AM Atish Patra <atishp@atishpatra.org> wrote:
> >
> > On Sat, Sep 12, 2020 at 3:45 AM Mike Rapoport <rppt@kernel.org> wrote:
> > >
> > > Hello Atish,
> > >
> > > On Fri, Sep 11, 2020 at 05:23:41PM -0700, Atish Patra wrote:
> > > > Currently, any usable memory area beyond page_offset is removed by adding the
> > > > memory sizes from each memblock. That may not work for sparse memory
> > > > as memory regions can be very far apart resulting incorrect removal of some
> > > > usable memory.
> > >
> > > If I understand correctly, the memory with physical addresses larger
> > > than (-PAGE_OFFSET) cannot be used. Since it was aready
> > > memblock_add()'ed during device tree parsing, you need to remove it from
> > > memblock.
> > >
> >
> > IIRC, the original intention was to fix MAXPHYSMEM_2GB option for RV64
> > for the medlow model.
> > That's why the patch removed any memory beyond -PAGE_OFFSET.
> >
> > > For that you can use memblock_enforce_memory_limit(-PAGE_OFFSET).
> > >
> > Thanks. I think we can just call memblock_enforce_memory_limit without
> > tracking the total memory size
> > and whether maximum memory described in DT is greater than  -PAGE_OFFSET.
> >
> > @Anup Patel Was there any other reason for this change originally?
>
> No other reason. We just wanted to ensure that amount of memory addressable
> by kernel (i.e. -PAGE_OFFSET) is also considered when removing memblock.
>

It looks like we have an agreement here then. I will update the patch
to directly call
memblock_enforce_memory_limit as suggested by Mike.

> Regards,
> Anup
>
> >
> > > > Just use the start of the first memory block and the end of the last memory
> > > > block to compute the size of the total memory that can be used.
> > > >
> > > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > > ---
> > > >  arch/riscv/mm/init.c | 6 ++----
> > > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > > > index 787c75f751a5..188281fc2816 100644
> > > > --- a/arch/riscv/mm/init.c
> > > > +++ b/arch/riscv/mm/init.c
> > > > @@ -147,7 +147,6 @@ void __init setup_bootmem(void)
> > > >  {
> > > >       struct memblock_region *reg;
> > > >       phys_addr_t mem_size = 0;
> > > > -     phys_addr_t total_mem = 0;
> > > >       phys_addr_t mem_start, end = 0;
> > > >       phys_addr_t vmlinux_end = __pa_symbol(&_end);
> > > >       phys_addr_t vmlinux_start = __pa_symbol(&_start);
> > > > @@ -155,18 +154,17 @@ void __init setup_bootmem(void)
> > > >       /* Find the memory region containing the kernel */
> > > >       for_each_memblock(memory, reg) {
> > > >               end = reg->base + reg->size;
> > > > -             if (!total_mem)
> > > > +             if (!mem_start)
> > > >                       mem_start = reg->base;
> > > >               if (reg->base <= vmlinux_start && vmlinux_end <= end)
> > > >                       BUG_ON(reg->size == 0);
> > > > -             total_mem = total_mem + reg->size;
> > > >       }
> > > >
> > > >       /*
> > > >        * Remove memblock from the end of usable area to the
> > > >        * end of region
> > > >        */
> > > > -     mem_size = min(total_mem, (phys_addr_t)-PAGE_OFFSET);
> > > > +     mem_size = min(end - mem_start, (phys_addr_t)-PAGE_OFFSET);
> > > >       if (mem_start + mem_size < end)
> > > >               memblock_remove(mem_start + mem_size,
> > > >                               end - mem_start - mem_size);
> > > > --
> > > > 2.24.0
> > > >
> > >
> > > --
> > > Sincerely yours,
> > > Mike.
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
> >
> >
> > --
> > Regards,
> > Atish



-- 
Regards,
Atish
