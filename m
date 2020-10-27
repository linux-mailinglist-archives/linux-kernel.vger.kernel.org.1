Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 782DA29C790
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 19:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1828856AbgJ0SiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 14:38:20 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34271 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1825136AbgJ0SiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 14:38:19 -0400
Received: by mail-io1-f65.google.com with SMTP id z5so2665354iob.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 11:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UCeV65unwsLYxOzTOB3BRBkP8Z2XdKf6EfIzJhCT1+U=;
        b=AsmYr51yPBIwfMHIO8petPXL7JfYJ/VpHAqJUCOiePh7YLDW9yeflIYyEePpVi6D8L
         DUoEnKk8yKtjNmtua8cbgA0D5i5EJ8+XkMq33W/koUqI2J32mtfcXE0UInxQnmPz9h85
         mL+A+mDokZlYLofHxoj5QVBcdu858LsuKYaAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UCeV65unwsLYxOzTOB3BRBkP8Z2XdKf6EfIzJhCT1+U=;
        b=eNVhwPEtbB4FFGjN/r1IWfG7OUuEN+qo009qiaHC552euhaGx0pVg34XWyWV82zeB/
         Im5Kv28HmkLfNGfO0riksCVZX5X5ujO5DpixTNK3zkEZhP4kDxgKlj23B658ihXpKk/a
         rAaRy1QdwHp6jyUa5Y0/8qtNsGww6QY4oc2soQTzHjfv4HFWzhqyE0jVgi5jiu2QRQya
         tqtG5A6B5S3gbB+vRnvA1gtxxSLiuMyfv0StusbpBr9d8m4epZc6m4TLt0kE8OsfXZ4D
         VSSCbFdcnJVCMgBsl3f8Jdc9/MWn71lupJfCRbbrw47hH4SMeZWrppo0CnIeyzGbZp2V
         /LfQ==
X-Gm-Message-State: AOAM531Ri1c/Y0AHcq8OfrcLpvBHapaC7VRj+9kHh49g7RZWZJdLc/04
        LYRZZgxzhEF82487fQ2FZGZrgkQG5pU9Ess1s8ie
X-Google-Smtp-Source: ABdhPJzYNAKvjSpI/al4RHJT8K76IJtKOIqYle65oB1uWQwnl9Os1FT4XM7ZLKVnKT5CDKCl7DBXldaCSvKzwlTUvwE=
X-Received: by 2002:a05:6638:f81:: with SMTP id h1mr3813165jal.115.1603823896557;
 Tue, 27 Oct 2020 11:38:16 -0700 (PDT)
MIME-Version: 1.0
References: <20201026230254.911912-1-atish.patra@wdc.com> <20201026230254.911912-4-atish.patra@wdc.com>
 <20201027100040.GK1154158@kernel.org>
In-Reply-To: <20201027100040.GK1154158@kernel.org>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 27 Oct 2020 11:38:03 -0700
Message-ID: <CAOnJCU+KS+0OtKLwURx-y=NAZZ9QWPk7Kg5pkB5fp1bG8pO9EA@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] RISC-V: Enforce protections for kernel sections early
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>,
        Anup Patel <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Zong Li <zong.li@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>,
        Michel Lespinasse <walken@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 3:01 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> On Mon, Oct 26, 2020 at 04:02:51PM -0700, Atish Patra wrote:
> > Currently, all memblocks are mapped with PAGE_KERNEL_EXEC and the strict
> > permissions are only enforced after /init starts. This leaves the kernel
> > vulnerable from possible buggy built-in modules.
> >
> > Apply permissions to individual sections as early as possible.
> >
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > ---
> >  arch/riscv/include/asm/set_memory.h |  2 ++
> >  arch/riscv/kernel/setup.c           |  2 ++
> >  arch/riscv/mm/init.c                | 11 +++++++++--
> >  3 files changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm/set_memory.h
> > index 4c5bae7ca01c..4cc3a4e2afd3 100644
> > --- a/arch/riscv/include/asm/set_memory.h
> > +++ b/arch/riscv/include/asm/set_memory.h
> > @@ -15,11 +15,13 @@ int set_memory_ro(unsigned long addr, int numpages);
> >  int set_memory_rw(unsigned long addr, int numpages);
> >  int set_memory_x(unsigned long addr, int numpages);
> >  int set_memory_nx(unsigned long addr, int numpages);
> > +void protect_kernel_text_data(void);
> >  #else
> >  static inline int set_memory_ro(unsigned long addr, int numpages) { return 0; }
> >  static inline int set_memory_rw(unsigned long addr, int numpages) { return 0; }
> >  static inline int set_memory_x(unsigned long addr, int numpages) { return 0; }
> >  static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
> > +static inline void protect_kernel_text_data(void) {};
> >  #endif
> >
> >  int set_direct_map_invalid_noflush(struct page *page);
> > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > index 7d6a04ae3929..b722c5bf892c 100644
> > --- a/arch/riscv/kernel/setup.c
> > +++ b/arch/riscv/kernel/setup.c
> > @@ -22,6 +22,7 @@
> >  #include <asm/cpu_ops.h>
> >  #include <asm/early_ioremap.h>
> >  #include <asm/setup.h>
> > +#include <asm/set_memory.h>
> >  #include <asm/sections.h>
> >  #include <asm/sbi.h>
> >  #include <asm/tlbflush.h>
> > @@ -92,6 +93,7 @@ void __init setup_arch(char **cmdline_p)
> >  #if IS_ENABLED(CONFIG_RISCV_SBI)
> >       sbi_init();
> >  #endif
> > +     protect_kernel_text_data();
> >  #ifdef CONFIG_SWIOTLB
> >       swiotlb_init(1);
> >  #endif
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index ea933b789a88..5f196f8158d4 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -608,7 +608,7 @@ static inline void setup_vm_final(void)
> >  #endif /* CONFIG_MMU */
> >
> >  #ifdef CONFIG_STRICT_KERNEL_RWX
> > -void mark_rodata_ro(void)
> > +void protect_kernel_text_data(void)
> >  {
> >       unsigned long text_start = (unsigned long)_text;
> >       unsigned long text_end = (unsigned long)_etext;
> > @@ -617,9 +617,16 @@ void mark_rodata_ro(void)
> >       unsigned long max_low = (unsigned long)(__va(PFN_PHYS(max_low_pfn)));
> >
>
> A comment about that rodata permissions are set later would be nice
> here.
>

Sure. I will add that.

> >       set_memory_ro(text_start, (text_end - text_start) >> PAGE_SHIFT);
> > -     set_memory_ro(rodata_start, (data_start - rodata_start) >> PAGE_SHIFT);
> >       set_memory_nx(rodata_start, (data_start - rodata_start) >> PAGE_SHIFT);
> >       set_memory_nx(data_start, (max_low - data_start) >> PAGE_SHIFT);
> > +}
> > +
> > +void mark_rodata_ro(void)
> > +{
> > +     unsigned long rodata_start = (unsigned long)__start_rodata;
> > +     unsigned long data_start = (unsigned long)_data;
> > +
> > +     set_memory_ro(rodata_start, (data_start - rodata_start) >> PAGE_SHIFT);
> >
> >       debug_checkwx();
> >  }
> > --
> > 2.25.1
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
