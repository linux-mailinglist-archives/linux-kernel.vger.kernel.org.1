Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6462302063
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 03:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbhAYC0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 21:26:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:46336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726655AbhAYCZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 21:25:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC6A222583
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 02:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611541494;
        bh=PMUtc8ramdjFAhXDvA8OVyeNRmvyYJo3NxET2hG1ovI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SG/R8BaCuLilyumdQ6P4CH1KE9VA00oR4MRYzn5TH4/4M5Mel7vJpfdJF5P/AimZg
         owQtlCvnhq+aciE9n4eJk9+VhxNP/d5xT7k75jmKoxFHCmflTn68N6HENCzRDJ8bLq
         0e6eINj6Me8uhUexVLAxYeTJ5xcX1S8ldUr0+kXZ+dDmzRSyMqyxbxjQscD0PJvIt/
         bslpR3HIxclz6kp+Ijk5XmZrg6dryHJrdQM+0JhRFQvzbvwbDSzzxrj8H4AxHnSmxf
         5ZSEGoEeN57T55H4Ki0DO48BA/6e1bFwx7Au25p1GnBss6VvzaNUznlzvAhHEyHUSi
         FJ7rQ6toxZ0Ug==
Received: by mail-ed1-f50.google.com with SMTP id dj23so13378425edb.13
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 18:24:54 -0800 (PST)
X-Gm-Message-State: AOAM533q5uwRMBAdFiRQFtrWtgvkJyFy4856cHF3AQdYXwBFWEGsQtG1
        XUXlA4QA1S0WjBo9nTixcE1aYhQKfnWxPF3RhulPeg==
X-Google-Smtp-Source: ABdhPJyhbh+MX2QIqSlwwD6QBegzoHEwBKxCvczmWJ6rqCqYA73n+rCPejQl9e/md2sRqtTJJI6RnBbs/GTsNv/C1L0=
X-Received: by 2002:aa7:c384:: with SMTP id k4mr216772edq.23.1611541493273;
 Sun, 24 Jan 2021 18:24:53 -0800 (PST)
MIME-Version: 1.0
References: <20210123084900.3118-1-jiangshanlai@gmail.com>
In-Reply-To: <20210123084900.3118-1-jiangshanlai@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 24 Jan 2021 18:24:42 -0800
X-Gmail-Original-Message-ID: <CALCETrWPnvNr9S2hsxL+pbhNWv0OOL7tBq1XmABPjYK7zZSJbw@mail.gmail.com>
Message-ID: <CALCETrWPnvNr9S2hsxL+pbhNWv0OOL7tBq1XmABPjYK7zZSJbw@mail.gmail.com>
Subject: Re: [PATCH] x86_64: move cpu_current_top_of_stack out of TSS
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Joerg Roedel <jroedel@suse.de>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Kees Cook <keescook@chromium.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Andi Kleen <ak@linux.intel.com>,
        Mike Rapoport <rppt@kernel.org>, Mike Hommey <mh@glandium.org>,
        Mark Gross <mgross@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Anthony Steinhauser <asteinhauser@google.com>,
        Jay Lang <jaytlang@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 11:48 PM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
>
> From: Lai Jiangshan <laijs@linux.alibaba.com>
>
> When X86_BUG_CPU_MELTDOWN & KPTI, cpu_current_top_of_stack lives in the
> TSS which is also in the user CR3 and it becomes a coveted fruit.  An
> attacker can fetch the kernel stack top from it and continue next steps
> of actions based on the kernel stack.
>
> The address might not be very usefull for attacker, but it is not so
> necessary to be in TSS either.  It is only accessed when CR3 is kernel CR3
> and gs_base is kernel gs_base which means it can be in any percpu variable.
>
> The major reason it is in TSS might be performance because it is hot in
> cache and tlb since we just access sp2 as the scratch space in syscall.
>
> So we can move it to a percpu variable near other hot percpu variables,
> such as current_task, __preempt_count, and they are in the same
> cache line.
>
> tools/testing/selftests/seccomp/seccomp_benchmark desn't show any
> performance lost in "getpid native" result.  And actually, the result
> changes from 93ns before patch to 92ns after patch when !KPTI, and the
> test is very stable although the test desn't show a higher degree of
> precision but enough to know it doesn't cause degression for the test.

I'm okay with this concept, and it's a decent cleanup.  But the patch
is incomplete.  There are a whole bunch of other sp1 users in
arch/x86, and we should get rid of all of them at once.  Most notably,
the 32-bit code uses both the percpu variable and sp1 right now, and
that should be cleaned up.  (It's also quite obfuscated in the current
code.)

See below for minor additional comments.

>
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---
>  arch/x86/include/asm/processor.h   | 10 ----------
>  arch/x86/include/asm/switch_to.h   |  7 +------
>  arch/x86/include/asm/thread_info.h |  6 ------
>  arch/x86/kernel/cpu/common.c       |  3 +++
>  arch/x86/kernel/process.c          |  8 ++------
>  arch/x86/mm/pti.c                  |  7 +++----
>  6 files changed, 9 insertions(+), 32 deletions(-)
>
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index c20a52b5534b..886d32da1318 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -314,11 +314,6 @@ struct x86_hw_tss {
>  struct x86_hw_tss {
>         u32                     reserved1;
>         u64                     sp0;
> -
> -       /*
> -        * We store cpu_current_top_of_stack in sp1 so it's always accessible.
> -        * Linux does not use ring 1, so sp1 is not otherwise needed.
> -        */
>         u64                     sp1;
>
>         /*
> @@ -428,12 +423,7 @@ struct irq_stack {
>
>  DECLARE_PER_CPU(struct irq_stack *, hardirq_stack_ptr);
>
> -#ifdef CONFIG_X86_32
>  DECLARE_PER_CPU(unsigned long, cpu_current_top_of_stack);
> -#else
> -/* The RO copy can't be accessed with this_cpu_xyz(), so use the RW copy. */
> -#define cpu_current_top_of_stack cpu_tss_rw.x86_tss.sp1
> -#endif
>
>  #ifdef CONFIG_X86_64
>  struct fixed_percpu_data {
> diff --git a/arch/x86/include/asm/switch_to.h b/arch/x86/include/asm/switch_to.h
> index 9f69cc497f4b..4f0bc8533a54 100644
> --- a/arch/x86/include/asm/switch_to.h
> +++ b/arch/x86/include/asm/switch_to.h
> @@ -71,12 +71,7 @@ static inline void update_task_stack(struct task_struct *task)
>         else
>                 this_cpu_write(cpu_tss_rw.x86_tss.sp1, task->thread.sp0);
>  #else
> -       /*
> -        * x86-64 updates x86_tss.sp1 via cpu_current_top_of_stack. That
> -        * doesn't work on x86-32 because sp1 and
> -        * cpu_current_top_of_stack have different values (because of
> -        * the non-zero stack-padding on 32bit).
> -        */
> +       /* XENPV keeps its entry stack to be kernel stack.  */

How about:

Xen PV enters the kernel on the thread stack.

>         if (static_cpu_has(X86_FEATURE_XENPV))
>                 load_sp0(task_top_of_stack(task));
>  #endif
> diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
> index 0d751d5da702..3dc93d8df425 100644
> --- a/arch/x86/include/asm/thread_info.h
> +++ b/arch/x86/include/asm/thread_info.h
> @@ -197,12 +197,6 @@ static inline int arch_within_stack_frames(const void * const stack,
>  #endif
>  }
>
> -#else /* !__ASSEMBLY__ */
> -
> -#ifdef CONFIG_X86_64
> -# define cpu_current_top_of_stack (cpu_tss_rw + TSS_sp1)

A complete patch would also remove TSS_sp1 from asm-offsets.
