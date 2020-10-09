Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0ED28801E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 03:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730742AbgJIBxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 21:53:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726499AbgJIBxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 21:53:44 -0400
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A63522253
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 01:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602208423;
        bh=jCIrFu87d+E1x9HacgfDZzXwSuHK9+KJTI3Z1+eyGrg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vQlab+a1/Cl38vpMTmcKxX9R/giFpyoI0LiOj/h3Pml0/SnJP40BkruI/oFIdEIxE
         1qc0P16buykkFgbPa+WyCs5ETRMcz13PzMr9eRhYQJsvuuOAD+B3P1qSEXph36jBCA
         lXAh0sPnVLNPjo/lYtJN4ayqZgdkeYyJaAqL3YmU=
Received: by mail-lj1-f171.google.com with SMTP id f21so7971083ljh.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 18:53:43 -0700 (PDT)
X-Gm-Message-State: AOAM533vlCrzyXhNJTrDKwhVllMhkROETAebkx6PuW3lQlZkh0yTSejJ
        r4JDvJt3KslrCCyRMoUTY2DpYDdglPlnBIHVCO0=
X-Google-Smtp-Source: ABdhPJzRIpxykDRUax0a099/OVW8djIDlZt78680SFqpzIGdY54NwH7FhXdSJmz/fQfLlDZtH7SeSsV3EHpAHsu5oas=
X-Received: by 2002:a05:651c:510:: with SMTP id o16mr3940739ljp.79.1602208421742;
 Thu, 08 Oct 2020 18:53:41 -0700 (PDT)
MIME-Version: 1.0
References: <1602083313-19239-2-git-send-email-guoren@kernel.org> <mhng-81dee5c2-f8ee-4ab5-92d7-0e46dc952e87@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-81dee5c2-f8ee-4ab5-92d7-0e46dc952e87@palmerdabbelt-glaptop1>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 9 Oct 2020 09:53:30 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS2fTQNYAtK=FfVHR8g49vfm7mQPe72xD+RRpa4C3T9Dw@mail.gmail.com>
Message-ID: <CAJF2gTS2fTQNYAtK=FfVHR8g49vfm7mQPe72xD+RRpa4C3T9Dw@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: Fixup static_obj() fail v2
To:     Palmer Dabbelt <palmerdabbelt@google.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Andreas Schwab <schwab@linux-m68k.org>, aurelien@aurel32.net,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 8, 2020 at 11:54 AM Palmer Dabbelt <palmerdabbelt@google.com> wrote:
>
> On Wed, 07 Oct 2020 08:08:33 PDT (-0700), guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > v1 is commit: 6184358da0004c8fd940afda6c0a0fa4027dc911 which has
> > been reverted.
> >
> > When enable LOCKDEP, static_obj() will cause error:
> >
> > [    0.067192] INFO: trying to register non-static key.
> > [    0.067325] the code is fine but needs lockdep annotation.
> > [    0.067449] turning off the locking correctness validator.
> > [    0.067718] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.7.0-rc7-dirty #44
> > [    0.067945] Call Trace:
> > [    0.068369] [<ffffffe00020323c>] walk_stackframe+0x0/0xa4
> > [    0.068506] [<ffffffe000203422>] show_stack+0x2a/0x34
> > [    0.068631] [<ffffffe000521e4e>] dump_stack+0x94/0xca
> > [    0.068757] [<ffffffe000255a4e>] register_lock_class+0x5b8/0x5bc
> > [    0.068969] [<ffffffe000255abe>] __lock_acquire+0x6c/0x1d5c
> > [    0.069101] [<ffffffe0002550fe>] lock_acquire+0xae/0x312
> > [    0.069228] [<ffffffe000989a8e>] _raw_spin_lock_irqsave+0x40/0x5a
> > [    0.069357] [<ffffffe000247c64>] complete+0x1e/0x50
> > [    0.069479] [<ffffffe000984c38>] rest_init+0x1b0/0x28a
> > [    0.069660] [<ffffffe0000016a2>] 0xffffffe0000016a2
> > [    0.069779] [<ffffffe000001b84>] 0xffffffe000001b84
> > [    0.069953] [<ffffffe000001092>] 0xffffffe000001092
> >
> > Because some __initdata static variables is before _stext:
> >
> > static int static_obj(const void *obj)
> > {
> >         unsigned long start = (unsigned long) &_stext,
> >                       end   = (unsigned long) &_end,
> >                       addr  = (unsigned long) obj;
> >
> >         /*
> >          * static variable?
> >          */
> >         if ((addr >= start) && (addr < end))
> >                 return 1;
> >
> >       if (arch_is_kernel_data(addr))
> >               return 1;
> >
> > We could implement arch_is_kernel_data to fixup it.
> >
> > Link: https://lore.kernel.org/linux-riscv/1593266228-61125-1-git-send-email-guoren@kernel.org/T/#t
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Reported-by: Aurelien Jarno <aurelien@aurel32.net>
> > Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> > Cc: Atish Patra <atishp@atishpatra.org>
> > Cc: Andreas Schwab <schwab@linux-m68k.org>
> > Cc: Aurelien Jarno <aurelien@aurel32.net>
> > ---
> >  arch/riscv/include/asm/sections.h | 20 ++++++++++++++++++++
> >  arch/riscv/kernel/setup.c         |  9 +++++++++
> >  2 files changed, 29 insertions(+)
> >  create mode 100644 arch/riscv/include/asm/sections.h
> >
> > diff --git a/arch/riscv/include/asm/sections.h b/arch/riscv/include/asm/sections.h
> > new file mode 100644
> > index 00000000..2317b9e
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/sections.h
> > @@ -0,0 +1,20 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +
> > +#ifndef _ASM_RISCV_SECTIONS_H
> > +#define _ASM_RISCV_SECTIONS_H
> > +
> > +#define arch_is_kernel_data arch_is_kernel_data
> > +
> > +#include <asm-generic/sections.h>
> > +
> > +extern bool init_mem_is_free;
> > +
> > +static inline int arch_is_kernel_data(unsigned long addr)
> > +{
> > +     if (init_mem_is_free)
> > +             return 0;
> > +
> > +     return addr >= (unsigned long)__init_begin &&
> > +             addr < (unsigned long)__init_end;
> > +}
> > +#endif /* _ASM_RISCV_SECTIONS_H */
> > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > index 2c6dd32..9ebd5eb4 100644
> > --- a/arch/riscv/kernel/setup.c
> > +++ b/arch/riscv/kernel/setup.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/sched/task.h>
> >  #include <linux/swiotlb.h>
> >  #include <linux/smp.h>
> > +#include <linux/poison.h>
> >
> >  #include <asm/cpu_ops.h>
> >  #include <asm/setup.h>
> > @@ -112,3 +113,11 @@ static int __init topology_init(void)
> >       return 0;
> >  }
> >  subsys_initcall(topology_init);
> > +
> > +bool init_mem_is_free = false;
> > +
> > +void free_initmem(void)
> > +{
> > +     free_initmem_default(POISON_FREE_INITMEM);
> > +     init_mem_is_free = true;
> > +}
>
> I'm a bit confused as to what you're trying to do here.  Yesterday I got
> another version of this patch set that moves init data around, today a
> different one.  Yesterday's is tested and simpler, and given it's so late in
> the process I'm inclined to take that as I don't want to break anything.
>
> Right now I have
>
> 84814460eef9 ("riscv: Fixup bootup failure with HARDENED_USERCOPY")
> a78c6f5956a9 ("RISC-V: Make sure memblock reserves the memory containing DT")
> 549738f15da0 ("Linux 5.9-rc8")
>
> Unless there's some functional bug, that's what I'm going to send out for 5.9
> -- I'm not all that worried about lacking the ability to free init data.  The
> above seems like fine 5.10 material.
>
> Let me know if I'm missing something here.
84814460eef9 could resolve the problem and Atish ask for any other
idea? So It's another choice, I forgot RFC in prefix.

6184358da0004c8fd940afda6c0a0fa4027dc911("riscv: Fixup static_obj()
fail") is a sloppy patch that introduces another problem. Sorry about
that.

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
