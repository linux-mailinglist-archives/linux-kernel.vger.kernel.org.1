Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C048286176
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 16:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbgJGOpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 10:45:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:43992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728674AbgJGOpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 10:45:42 -0400
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E310A2176B;
        Wed,  7 Oct 2020 14:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602081941;
        bh=HqHWoEb0KM+2Iv1t78qbp26pS5O6oD/T7GrrvprJ3Ls=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Kztaml6Cz72XpOSd+pf8PAok5QQ7VX456uJ6Ycdyz3w1hJjfEbHRI+xiszhbgGJzm
         E77z0vT5POzt6mTx7K+FhuplGiIfFbLaVUlHslxTYJK6RRQKf6eoZCRJMoKqjMliKV
         d+26T+SdKnbfnukuxOImHq4fXZfj982V0dRbgyJQ=
Received: by mail-lf1-f47.google.com with SMTP id b22so2555528lfs.13;
        Wed, 07 Oct 2020 07:45:40 -0700 (PDT)
X-Gm-Message-State: AOAM530XbLeokdQllgxZPjLY9Oh+G5DungdqID5UtWgnucOUtd9v1WBm
        bR+x2p/QV9ZyJRMFhqy0P3Lqrcr7oTFdwxU/Ats=
X-Google-Smtp-Source: ABdhPJyFrX7LvRQmTVje0bCmurpdxswldnNK6zrOwIjljf3kA88E42dK7RkSl+E3U0ZrG56ef4D/d7WypwZFHj1BvOY=
X-Received: by 2002:ac2:4d10:: with SMTP id r16mr1003603lfi.58.1602081939013;
 Wed, 07 Oct 2020 07:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <1593266228-61125-1-git-send-email-guoren@kernel.org>
 <1593266228-61125-2-git-send-email-guoren@kernel.org> <20200911204512.GA2705@aurel32.net>
 <CAJF2gTQiLV8sDE5cnvP=aBog4zaiMvMeieg_JtXwRODky1u3Hg@mail.gmail.com>
 <20200914103836.GB2705@aurel32.net> <87lfgzeidk.fsf@igel.home>
 <CAJF2gTQ8ONde3GRhQgx2Nqvb5X20nTmW8jZEemZKhezRDzP3aQ@mail.gmail.com>
 <CAOnJCUJhb2K89pRETbfTJ=5jHQhWfyfrOUu8zOE77j+id6OpSA@mail.gmail.com>
 <CAJF2gTRc-RUBiQ=ZE7BT8tABHu3=Bcmuc+ADyBLZ7r7fozwahg@mail.gmail.com> <CAOnJCUKi-bzEvYWw3BxBbGe6ODHEzdjTWsfrmS54qEk1i1Kr8Q@mail.gmail.com>
In-Reply-To: <CAOnJCUKi-bzEvYWw3BxBbGe6ODHEzdjTWsfrmS54qEk1i1Kr8Q@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 7 Oct 2020 22:45:27 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRGZKU8aW+D1U6JWh55bdNVxXZmktMz69b25Ng0RUd-Mg@mail.gmail.com>
Message-ID: <CAJF2gTRGZKU8aW+D1U6JWh55bdNVxXZmktMz69b25Ng0RUd-Mg@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] riscv: Fixup static_obj() fail
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nick Hu <nickhu@andestech.com>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Zong Li <zong.li@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 7, 2020 at 4:39 AM Atish Patra <atishp@atishpatra.org> wrote:
>
> On Tue, Oct 6, 2020 at 9:46 AM Guo Ren <guoren@kernel.org> wrote:
> >
> > On Tue, Oct 6, 2020 at 3:14 AM Atish Patra <atishp@atishpatra.org> wrote:
> > >
> > > On Thu, Sep 24, 2020 at 9:19 AM Guo Ren <guoren@kernel.org> wrote:
> > > >
> > > > How about this, revert the commit and don't free INIT_DATA_SECTION. I
> > > > think the solution is safe enough, but wast a little memory.
> > > >
> > > > diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
> > > > index f3586e3..34d00d9 100644
> > > > --- a/arch/riscv/kernel/vmlinux.lds.S
> > > > +++ b/arch/riscv/kernel/vmlinux.lds.S
> > > > @@ -22,13 +22,11 @@ SECTIONS
> > > >         /* Beginning of code and text segment */
> > > >         . = LOAD_OFFSET;
> > > >         _start = .;
> > > > -       _stext = .;
> > > >         HEAD_TEXT_SECTION
> > > >         . = ALIGN(PAGE_SIZE);
> > > >
> > > >         __init_begin = .;
> > > >         INIT_TEXT_SECTION(PAGE_SIZE)
> > > > -       INIT_DATA_SECTION(16)
> > > >         . = ALIGN(8);
> > > >         __soc_early_init_table : {
> > > >                 __soc_early_init_table_start = .;
> > > > @@ -55,6 +53,7 @@ SECTIONS
> > > >         . = ALIGN(SECTION_ALIGN);
> > > >         .text : {
> > > >                 _text = .;
> > > > +               _stext = .;
> > > >                 TEXT_TEXT
> > > >                 SCHED_TEXT
> > > >                 CPUIDLE_TEXT
> > > > @@ -67,6 +66,8 @@ SECTIONS
> > > >                 _etext = .;
> > > >         }
> > > >
> > > > +       INIT_DATA_SECTION(16)
> > > > +
> > >
> > > I think you need to move EXIT_DATA as well. Currently, we have init
> > > data & text in one section.
> > It's not related to this issue. There is two check code problem:
>
> Yes. But we shouldn't move only INIT_DATA_SECTION out of __init section
> while leaving percpu & exit data in the __init section. Here is what I
> have in mind.
>
> diff --git a/arch/riscv/kernel/vmlinux.lds.S
> b/arch/riscv/kernel/vmlinux.lds.S
> index 9795359cb9da..4432cef8184e 100644
> --- a/arch/riscv/kernel/vmlinux.lds.S
> +++ b/arch/riscv/kernel/vmlinux.lds.S
> @@ -26,13 +26,11 @@ SECTIONS
>         /* Beginning of code and text segment */
>         . = LOAD_OFFSET;
>         _start = .;
>         _start = .;
> -       _stext = .;
>         HEAD_TEXT_SECTION
>         . = ALIGN(PAGE_SIZE);
>
>         __init_begin = .;
>         INIT_TEXT_SECTION(PAGE_SIZE)
> -       INIT_DATA_SECTION(16)
>         . = ALIGN(8);
>         __soc_early_init_table : {
>                 __soc_early_init_table_start = .;
> @@ -49,16 +47,13 @@ SECTIONS
>         {
>                 EXIT_TEXT
>         }
> -       .exit.data :
> -       {
> -               EXIT_DATA
> -       }
> -       PERCPU_SECTION(L1_CACHE_BYTES)
> +
>         __init_end = .;
>
>         . = ALIGN(SECTION_ALIGN);
>         .text : {
>                 _text = .;
> +               _stext = .;
>                 TEXT_TEXT
>                 SCHED_TEXT
>                 CPUIDLE_TEXT
> @@ -77,6 +72,17 @@ SECTIONS
>  #endif
>
>         /* Start of data section */
> +       __init_data_begin = .;
> +       INIT_DATA_SECTION(16)
> +       .exit.data :
> +       {
> +               EXIT_DATA
> +       }
> +
> +       PERCPU_SECTION(L1_CACHE_BYTES)
> +
> +       __init_data_end = .;
> +
>
> As you correctly pointed out, this wastes around ~200K init memory
> that is wasted.
> That is not an ideal solution.
>
> The other alternative is to move __init_text section after _text as
> well similar to other architectures. But that won't work
> for RISC-V as we jump from _start to __start_kernel(in __init section)
> in head.S.  A JAL instruction can't be fit because
> __start_kernel is now too far. We can't replace JAL with a JALR
> because that would require an additional
> instruction and violates image header format.
>
> Any other ideas to solve this problem without wasting memory ?
How about:

diff --git a/arch/riscv/include/asm/sections.h
b/arch/riscv/include/asm/sections.h
new file mode 100644
index 00000000..2317b9e
--- /dev/null
+++ b/arch/riscv/include/asm/sections.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _ASM_RISCV_SECTIONS_H
+#define _ASM_RISCV_SECTIONS_H
+
+#define arch_is_kernel_data arch_is_kernel_data
+
+#include <asm-generic/sections.h>
+
+extern bool init_mem_is_free;
+
+static inline int arch_is_kernel_data(unsigned long addr)
+{
+       if (init_mem_is_free)
+               return 0;
+
+       return addr >= (unsigned long)__init_begin &&
+               addr < (unsigned long)__init_end;
+}
+#endif /* _ASM_RISCV_SECTIONS_H */
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 2c6dd32..9ebd5eb4 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -17,6 +17,7 @@
 #include <linux/sched/task.h>
 #include <linux/swiotlb.h>
 #include <linux/smp.h>
+#include <linux/poison.h>

 #include <asm/cpu_ops.h>
 #include <asm/setup.h>
@@ -112,3 +113,11 @@ static int __init topology_init(void)
        return 0;
 }
 subsys_initcall(topology_init);
+
+bool init_mem_is_free = false;
+
+void free_initmem(void)
+{
+       free_initmem_default(POISON_FREE_INITMEM);
+       init_mem_is_free = true;
+}

>
> >  1.     static int static_obj(const void *obj)
> >     {
> >             unsigned long start = (unsigned long) &_stext,
> >                           end   = (unsigned long) &_end,
> >                           addr  = (unsigned long) obj;
> >
> >             /*
> >              * static variable?
> >              */
> >             if ((addr >= start) && (addr < end))
> >                     return 1;
> >
> >  2.     /* Is this address range in the kernel text area? */
> >     static inline void check_kernel_text_object(const unsigned long ptr,
> >                                                 unsigned long n, bool to_user)
> >     {
> >             unsigned long textlow = (unsigned long)_stext;
> >             unsigned long texthigh = (unsigned long)_etext;
> >             unsigned long textlow_linear, texthigh_linear;
> >
> >             if (overlaps(ptr, n, textlow, texthigh))
> >                     usercopy_abort("kernel text", NULL, to_user, ptr -
> > textlow, n);
> >
> > The patch of commit: a0fa4027dc911 (riscv: Fixup static_obj() fail) broke 2th.
> >
> > > In general it is better idea to separate those similar to ARM64.
> > > Additionally, ARM64 applies different mapping for init data & text
> > > as the init data section is marked as non-executable[1]
> > Yes, it's safer to protect init text & init data, but it's should be
> > another patch.
> >
>
> Yes. I will send the patch based on this fix.
>
> > >
> > > However, we don't modify any permission for any init sections. Should
> > > we do that as well ?
> > Agree, we should do that.
> >
> > >
> > > [1] https://patchwork.kernel.org/patch/9572869/
> > >
> > > >         /* Start of data section */
> > > >         _sdata = .;
> > > >         RO_DATA(SECTION_ALIGN)
> > > >
> > > > On Thu, Sep 24, 2020 at 3:36 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
> > > > >
> > > > > On Sep 14 2020, Aurelien Jarno wrote:
> > > > >
> > > > > > How should we proceed to get that fixed in time for 5.9? For the older
> > > > > > branches where it has been backported (so far 5.7 and 5.8), should we
> > > > > > just get that commit reverted instead?
> > > > >
> > > > > Can this please be resolved ASAP?
> > > > >
> > > > > Andreas.
> > > > >
> > > > > --
> > > > > Andreas Schwab, schwab@linux-m68k.org
> > > > > GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
> > > > > "And now for something completely different."
> > > >
> > > >
> > > >
> > > > --
> > > > Best Regards
> > > >  Guo Ren
> > > >
> > > > ML: https://lore.kernel.org/linux-csky/
> > > >
> > > > _______________________________________________
> > > > linux-riscv mailing list
> > > > linux-riscv@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> > >
> > >
> > >
> > > --
> > > Regards,
> > > Atish
> >
> >
> >
> > --
> > Best Regards
> >  Guo Ren
> >
> > ML: https://lore.kernel.org/linux-csky/
>
>
>
> --
> Regards,
> Atish



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
