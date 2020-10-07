Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB5128688A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 21:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgJGTq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 15:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgJGTq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 15:46:28 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C966BC061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 12:46:28 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id o9so3507128ilo.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 12:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JM6PxcQ3LGHks2+mGz99vC/06U4p761keHZ7ERniGBY=;
        b=OB47xNTS1zJv6s44IjAotftweuAKfy2y2v+sX2nYd26rFOIpOhdVVZUdCVjO+r9KDA
         MsasD6B8z2bGQOVcYu6zy5ZcBsSoHWM52A3aLPOq+m//HxowaJc/iDFp85eh14jQQppD
         o9ujPINYXfSwctbHtM7fXcDkMNPsDALnun0/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JM6PxcQ3LGHks2+mGz99vC/06U4p761keHZ7ERniGBY=;
        b=HLZhRDSUU2tERB+E4PLineadmnGA91ZGqgsDY8psnyPry0ZE5n1PwFAsFq2cWaA0GC
         /BqgE51QTvPw/aBjW0H9DTwilooC7NZRYrE/x1/jwb7PL2v+6cO+OA1Oj2FkOPa5Nv8M
         LlufbjGl2WQnyqc2XD2aAO3y8ry0vI7vnQxJW9woDdyRPJgoWRBhDh1yrnsYnlvXOnoG
         25BegdV/7USciA2rZnIg8I9UtHB+jrn9HWrdVqzq7DzrRMSp0QToCFKCUvhlNRg1gzTm
         u1DHU1l1BHjepVAcGcXcX75PLOwIByy2jN3iJw/+OkclWY6jc37E6dHBwOvIRTs1LfSU
         NjYA==
X-Gm-Message-State: AOAM5313mRXTuy4BuxhM+o96jDgmSHQuiE4GyKg5yOGCQqslh4qEBJVm
        hqWC1FVVrzNz/munMxMGOO8MRNJRCNMbQs3pope5
X-Google-Smtp-Source: ABdhPJxvJpcWYRR+CXcZhf02pO5Q0FuWDjQ3poFL2YnWfxqvvvzu2AoisfS6JoNWihbR4svKiMNb2c8lw+lmLPvbCYM=
X-Received: by 2002:a92:91db:: with SMTP id e88mr3847157ill.126.1602099988095;
 Wed, 07 Oct 2020 12:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <1602083313-19239-1-git-send-email-guoren@kernel.org> <1602083313-19239-2-git-send-email-guoren@kernel.org>
In-Reply-To: <1602083313-19239-2-git-send-email-guoren@kernel.org>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 7 Oct 2020 12:46:17 -0700
Message-ID: <CAOnJCU+xwnQz9tbCDjBbstOzBFT-DU-uTcc0K_M7ppT_Z-V1Fg@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: Fixup static_obj() fail v2
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>, aurelien@aurel32.net,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 7, 2020 at 8:09 AM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> v1 is commit: 6184358da0004c8fd940afda6c0a0fa4027dc911 which has
> been reverted.
>
> When enable LOCKDEP, static_obj() will cause error:
>
> [    0.067192] INFO: trying to register non-static key.
> [    0.067325] the code is fine but needs lockdep annotation.
> [    0.067449] turning off the locking correctness validator.
> [    0.067718] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.7.0-rc7-dirty #44
> [    0.067945] Call Trace:
> [    0.068369] [<ffffffe00020323c>] walk_stackframe+0x0/0xa4
> [    0.068506] [<ffffffe000203422>] show_stack+0x2a/0x34
> [    0.068631] [<ffffffe000521e4e>] dump_stack+0x94/0xca
> [    0.068757] [<ffffffe000255a4e>] register_lock_class+0x5b8/0x5bc
> [    0.068969] [<ffffffe000255abe>] __lock_acquire+0x6c/0x1d5c
> [    0.069101] [<ffffffe0002550fe>] lock_acquire+0xae/0x312
> [    0.069228] [<ffffffe000989a8e>] _raw_spin_lock_irqsave+0x40/0x5a
> [    0.069357] [<ffffffe000247c64>] complete+0x1e/0x50
> [    0.069479] [<ffffffe000984c38>] rest_init+0x1b0/0x28a
> [    0.069660] [<ffffffe0000016a2>] 0xffffffe0000016a2
> [    0.069779] [<ffffffe000001b84>] 0xffffffe000001b84
> [    0.069953] [<ffffffe000001092>] 0xffffffe000001092
>
> Because some __initdata static variables is before _stext:
>
> static int static_obj(const void *obj)
> {
>         unsigned long start = (unsigned long) &_stext,
>                       end   = (unsigned long) &_end,
>                       addr  = (unsigned long) obj;
>
>         /*
>          * static variable?
>          */
>         if ((addr >= start) && (addr < end))
>                 return 1;
>
>         if (arch_is_kernel_data(addr))
>                 return 1;
>
> We could implement arch_is_kernel_data to fixup it.
>
> Link: https://lore.kernel.org/linux-riscv/1593266228-61125-1-git-send-email-guoren@kernel.org/T/#t
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Reported-by: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> Cc: Atish Patra <atishp@atishpatra.org>
> Cc: Andreas Schwab <schwab@linux-m68k.org>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> ---
>  arch/riscv/include/asm/sections.h | 20 ++++++++++++++++++++
>  arch/riscv/kernel/setup.c         |  9 +++++++++
>  2 files changed, 29 insertions(+)
>  create mode 100644 arch/riscv/include/asm/sections.h
>
> diff --git a/arch/riscv/include/asm/sections.h b/arch/riscv/include/asm/sections.h
> new file mode 100644
> index 00000000..2317b9e
> --- /dev/null
> +++ b/arch/riscv/include/asm/sections.h

You may want to rebase it on top of for-next as UEFI series also adds this file.
.

> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef _ASM_RISCV_SECTIONS_H
> +#define _ASM_RISCV_SECTIONS_H
> +
> +#define arch_is_kernel_data arch_is_kernel_data
> +
> +#include <asm-generic/sections.h>
> +
> +extern bool init_mem_is_free;
> +
> +static inline int arch_is_kernel_data(unsigned long addr)
> +{
> +       if (init_mem_is_free)
> +               return 0;
> +
> +       return addr >= (unsigned long)__init_begin &&
> +               addr < (unsigned long)__init_end;
> +}
> +#endif /* _ASM_RISCV_SECTIONS_H */
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 2c6dd32..9ebd5eb4 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -17,6 +17,7 @@
>  #include <linux/sched/task.h>
>  #include <linux/swiotlb.h>
>  #include <linux/smp.h>
> +#include <linux/poison.h>
>
>  #include <asm/cpu_ops.h>
>  #include <asm/setup.h>
> @@ -112,3 +113,11 @@ static int __init topology_init(void)
>         return 0;
>  }
>  subsys_initcall(topology_init);
> +
> +bool init_mem_is_free = false;
> +
> +void free_initmem(void)
> +{
> +       free_initmem_default(POISON_FREE_INITMEM);
> +       init_mem_is_free = true;
> +}
> --
> 2.7.4
>

Looks good. Much cleaner than the first approach.
FYI: I am still looking into separating __init text & data so that
different permissions can be applied to them.
With this patch, we can just separate it on top of _stext.


Reviewed-by: Atish Patra <atish.patra@wdc.com>

-- 
Regards,
Atish
