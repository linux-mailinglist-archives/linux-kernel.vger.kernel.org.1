Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79222681E8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 01:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbgIMXsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 19:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgIMXsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 19:48:04 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82256C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 16:48:03 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id d4so3626422wmd.5
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 16:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fzb4SDNhfhKuOAH2aTFB3ctXAAaT+cISGh+UPXFnYd4=;
        b=iIKSQgHrnqvxkICTPyxQchFi/Ywy8k/fbBjQkBw7PIqw9AwjZVzB6N5B+qqiud8is/
         G+tIlUHrDTIcu2hZitlR871CfiKHd2wHX4C0sMwttj0JmIfa53b2B2t3MpwoXr0VX5ZN
         Qij8W+M6S9SAtx1bwaQsTYErc5/ZWc7FuBPO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fzb4SDNhfhKuOAH2aTFB3ctXAAaT+cISGh+UPXFnYd4=;
        b=A8Jv2n6/CwRt1aycNqh6dHL2Mh4BYtIoE/JrUrH9W0+xiPU8QkWoNlJ+Mj7jY7CMSa
         JBoK1WSUrGe87WO72z+mD3P+5qCqdQr6SYu5Pe2MnU58GCAXJ3ptqSUIPOxY2D8pqU/R
         I9FKNo3eFOVgldxyP2P48289aDHq0T+9SQyQ3+PDQNPFA65kPO3CnbT7tEMxozyNi12d
         0N//2jl9559ZujSk3vch0CW87by8faOD1X34RsTC5USI2KluECbIiDaJQWeSpj18t34h
         DRvyo4/JmAY01mPXFVLJz9Ov2iWKaTKv6X39tT9ax4QfnSE7KwAjvsqnHqaOt7LE0e9v
         KGTQ==
X-Gm-Message-State: AOAM5330738OlDgqvYjU5i3GF500eQAJ38Ock1ogXntAwWJ85Bm0cADC
        sVf2P5Hvd/w7cdQAXRvbNxXTd70iMkF8lmun8QC2
X-Google-Smtp-Source: ABdhPJxgsRJWJfwm1VDVQWEIJcFvF7Fds8by50d7+KnmIFBk1mo0ysWPB710OqN7Ebv/cp6TY8xJUx0Wf42NnUaPd6Q=
X-Received: by 2002:a05:600c:2cc1:: with SMTP id l1mr12074737wmc.78.1600040882110;
 Sun, 13 Sep 2020 16:48:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200912002341.4869-1-atish.patra@wdc.com> <20200912104502.GF2142832@kernel.org>
In-Reply-To: <20200912104502.GF2142832@kernel.org>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Sun, 13 Sep 2020 16:47:50 -0700
Message-ID: <CAOnJCU+yK8uxFU-zv5BPTzmtxwiVpiPxGsNkVEtnTQ+64UU-ug@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Consider sparse memory while removing unusable memory
To:     Mike Rapoport <rppt@kernel.org>, Anup Patel <anup.patel@wdc.com>,
        Anup Patel <anup@brainfault.org>
Cc:     Atish Patra <atish.patra@wdc.com>,
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

On Sat, Sep 12, 2020 at 3:45 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> Hello Atish,
>
> On Fri, Sep 11, 2020 at 05:23:41PM -0700, Atish Patra wrote:
> > Currently, any usable memory area beyond page_offset is removed by adding the
> > memory sizes from each memblock. That may not work for sparse memory
> > as memory regions can be very far apart resulting incorrect removal of some
> > usable memory.
>
> If I understand correctly, the memory with physical addresses larger
> than (-PAGE_OFFSET) cannot be used. Since it was aready
> memblock_add()'ed during device tree parsing, you need to remove it from
> memblock.
>

IIRC, the original intention was to fix MAXPHYSMEM_2GB option for RV64
for the medlow model.
That's why the patch removed any memory beyond -PAGE_OFFSET.

> For that you can use memblock_enforce_memory_limit(-PAGE_OFFSET).
>
Thanks. I think we can just call memblock_enforce_memory_limit without
tracking the total memory size
and whether maximum memory described in DT is greater than  -PAGE_OFFSET.

@Anup Patel Was there any other reason for this change originally?

> > Just use the start of the first memory block and the end of the last memory
> > block to compute the size of the total memory that can be used.
> >
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > ---
> >  arch/riscv/mm/init.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index 787c75f751a5..188281fc2816 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -147,7 +147,6 @@ void __init setup_bootmem(void)
> >  {
> >       struct memblock_region *reg;
> >       phys_addr_t mem_size = 0;
> > -     phys_addr_t total_mem = 0;
> >       phys_addr_t mem_start, end = 0;
> >       phys_addr_t vmlinux_end = __pa_symbol(&_end);
> >       phys_addr_t vmlinux_start = __pa_symbol(&_start);
> > @@ -155,18 +154,17 @@ void __init setup_bootmem(void)
> >       /* Find the memory region containing the kernel */
> >       for_each_memblock(memory, reg) {
> >               end = reg->base + reg->size;
> > -             if (!total_mem)
> > +             if (!mem_start)
> >                       mem_start = reg->base;
> >               if (reg->base <= vmlinux_start && vmlinux_end <= end)
> >                       BUG_ON(reg->size == 0);
> > -             total_mem = total_mem + reg->size;
> >       }
> >
> >       /*
> >        * Remove memblock from the end of usable area to the
> >        * end of region
> >        */
> > -     mem_size = min(total_mem, (phys_addr_t)-PAGE_OFFSET);
> > +     mem_size = min(end - mem_start, (phys_addr_t)-PAGE_OFFSET);
> >       if (mem_start + mem_size < end)
> >               memblock_remove(mem_start + mem_size,
> >                               end - mem_start - mem_size);
> > --
> > 2.24.0
> >
>
> --
> Sincerely yours,
> Mike.
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish
