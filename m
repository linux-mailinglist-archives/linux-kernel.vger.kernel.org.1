Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA32286CC3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 04:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgJHCak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 22:30:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:34254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727253AbgJHCak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 22:30:40 -0400
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B9CF2145D
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 02:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602124239;
        bh=tHJb3mueFHF3ie2tCZCZmBSRR7A+YvcAIjejINpLILc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N/CoW0GNNxVUUHpGA0WvFml8+Sp0+8lA8m6NZIAakDLBFkPqIQ3PzcUHYCX6TA4M9
         QcmsYeMhOxB0Yse31e0UiN1f06s8RpUd4MngaGawsG1qfxR6wwvjKdbqvMlHi7XCxK
         JqXVEwkrgasBpyZmROYTLKapb42jhVtSiXBHoXHw=
Received: by mail-lj1-f174.google.com with SMTP id d24so1104008ljg.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 19:30:38 -0700 (PDT)
X-Gm-Message-State: AOAM530K+0OS5uUG0+wNLVLQTLVSIZWQl3u1fcZ9Eidc0Q9rXqgoDsYD
        J83Buwl84ZdvAJNlkvYtGSebrq7/UYj27gTRkMk=
X-Google-Smtp-Source: ABdhPJw2Ldv9SRuYUPdxQDut9elUb0E6sqEH/x598tBTYZMF0RG8TVWf9Og9Ua/GODwBnleetYvpvT8hEbBZ8UCE4lA=
X-Received: by 2002:a2e:6c08:: with SMTP id h8mr2128760ljc.66.1602124237280;
 Wed, 07 Oct 2020 19:30:37 -0700 (PDT)
MIME-Version: 1.0
References: <1602083313-19239-1-git-send-email-guoren@kernel.org>
 <1602083313-19239-2-git-send-email-guoren@kernel.org> <CAOnJCU+xwnQz9tbCDjBbstOzBFT-DU-uTcc0K_M7ppT_Z-V1Fg@mail.gmail.com>
In-Reply-To: <CAOnJCU+xwnQz9tbCDjBbstOzBFT-DU-uTcc0K_M7ppT_Z-V1Fg@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 8 Oct 2020 10:30:25 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRDh=U6sP_Usvwm9C53NNBc5k_Z8UbK3gQ5+zoAGvEqzg@mail.gmail.com>
Message-ID: <CAJF2gTRDh=U6sP_Usvwm9C53NNBc5k_Z8UbK3gQ5+zoAGvEqzg@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: Fixup static_obj() fail v2
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>, aurelien@aurel32.net,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 8, 2020 at 3:46 AM Atish Patra <atishp@atishpatra.org> wrote:
>
> On Wed, Oct 7, 2020 at 8:09 AM <guoren@kernel.org> wrote:
> >
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
> >         if (arch_is_kernel_data(addr))
> >                 return 1;
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
>
> You may want to rebase it on top of for-next as UEFI series also adds this file.
ok

> .
>
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
> > +       if (init_mem_is_free)
> > +               return 0;
> > +
> > +       return addr >= (unsigned long)__init_begin &&
> > +               addr < (unsigned long)__init_end;
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
> >         return 0;
> >  }
> >  subsys_initcall(topology_init);
> > +
> > +bool init_mem_is_free = false;
> > +
> > +void free_initmem(void)
> > +{
> > +       free_initmem_default(POISON_FREE_INITMEM);
> > +       init_mem_is_free = true;
> > +}
> > --
> > 2.7.4
> >
>
> Looks good. Much cleaner than the first approach.
> FYI: I am still looking into separating __init text & data so that
> different permissions can be applied to them.
> With this patch, we can just separate it on top of _stext.
>
>
> Reviewed-by: Atish Patra <atish.patra@wdc.com>
>
> --
> Regards,
> Atish



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
