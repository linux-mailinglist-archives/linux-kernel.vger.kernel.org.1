Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8BCE266A01
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 23:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725856AbgIKVYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 17:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgIKVYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 17:24:40 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85691C061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 14:24:39 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id n13so11531208edo.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 14:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rJzQzacUbT/t90dFgLo1ukPLxxD0AZUfFpQIlkH2Pu8=;
        b=Kfa4UFPP3oHjaVD0CILlTHRNcuChEw8bWJOCJLzaE3/rn/2D5BnLQ1DunguYidZ4Vi
         YQi9nWj8TXg6lQGU8Tx2TEaHnunFQ+JtW4XSijFxCSC/dDjnyQihZcZFnOhIvgPxh7RP
         4uWx6WNTqiOuqjmB6prPo1EHOSw0SpSMGRaqeL08cCyEZmcSV3wmVzLIZfQ+dRbkhysh
         VVZeW84q/4GVlVuk2yMXMtsQRQtEuP5QTYDHcTujTWQpi9lXk+SZ/YlgWicwya8SL6un
         j2b4UzWJ4afAnP/L8L7UjO8a5jr/S+bPMRWUJrs65+EQMON3cyIykfQ9V1RmFMQFb4Om
         A3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rJzQzacUbT/t90dFgLo1ukPLxxD0AZUfFpQIlkH2Pu8=;
        b=e36muLdXUtbeKvI+xYsR1FNa7KPyzkMO3uxV4I+JHYwEhlJCmUjk9/QD3jmxI7sjV6
         Hwn/YHsBF6O52RgeV8Gwte3ie6/VLDIr/UZSzIDtMgMPJOUsp1qqItwEab/c58JK1Aip
         Jqwu4CZBLf8oici3l8GShmYd41I7gMSNofTYSzgiPd2rxOrkqEOj2EcVAGLWYBCcsVDO
         +ajDHV+uln+nB1k69zdrrO/3R/9XxLIXAJuGT7H0umhnZI0IxrrL8yKpW2N+94maDRk+
         6ZYpW9MHrHxe6v+p0XalcAhu0KP2huJd2L4ReYkDy0mdLC5XkgxuJZCnLiL6pY/iK1Kr
         h18A==
X-Gm-Message-State: AOAM531cH6Enpgx1SI2dox/Z7hke9vrk4TQqZ9zHyeefuodgEhzr/3GD
        om5EfCM2kurPVbeHf0Jx9UsyEV3rCUWiMeQRlhH73A==
X-Google-Smtp-Source: ABdhPJwOzb7RRun7xEaUZg0OezU66oiuDn3uNsy2bi1jbu8j7WAWUL2TDU2cG2bJYo1uIY2LeLjnq0zdWPejnJ6zJbM=
X-Received: by 2002:a05:6402:7d2:: with SMTP id u18mr4631955edy.69.1599859477898;
 Fri, 11 Sep 2020 14:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrWx66qLc-NiwKS_Zu=BP8JDTzfeUO7A2vDd01kXNmiNiA@mail.gmail.com>
 <20200817062355.2884-1-jiangshanlai@gmail.com> <20200817062355.2884-2-jiangshanlai@gmail.com>
In-Reply-To: <20200817062355.2884-2-jiangshanlai@gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 11 Sep 2020 23:24:11 +0200
Message-ID: <CAG48ez23rw8oj7gT6Kyj3epXsDze+Cq30Jj_pV7sa54gxKEOpQ@mail.gmail.com>
Subject: Re: [PATCH V3 1/3] x86/entry: avoid calling into sync_regs() when
 entering from userspace
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 8:23 AM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
> 7f2590a110b8("x86/entry/64: Use a per-CPU trampoline stack for IDT entries")
> made a change that when any exception happens on userspace, the
> entry code will save the pt_regs on the sp0 stack, and then copy it
> to the thread stack via sync_regs() and switch to thread stack
> afterward.
>
> And recent x86/entry work makes interrupt also use idtentry
> and makes all the interrupt code save the pt_regs on the sp0 stack
> and then copy it to the thread stack like exception.
>
> This is hot path (page fault, ipi), such overhead should be avoided.
> This patch borrows the way how original interrupt_entry handles it.
> It switches to the thread stack directly right away when comes
> from userspace.
>
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>

As far as I can see, on systems affected by Meltdown, this patch fixes
register state leakage between tasks because any data that is written
to the per-CPU trampoline stacks must be considered visible to all
userspace. I think that makes this a fix that should go into stable
kernels.

Therefore, please add:

Fixes: 7f2590a110b8 ("x86/entry/64: Use a per-CPU trampoline stack for
IDT entries")
Cc: stable@vger.kernel.org


> ---
>  arch/x86/entry/entry_64.S | 43 +++++++++++++++++++++++++++++++--------
>  1 file changed, 34 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index 70dea9337816..1a7715430da3 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -928,19 +928,42 @@ SYM_CODE_END(paranoid_exit)
>  SYM_CODE_START_LOCAL(error_entry)
>         UNWIND_HINT_FUNC
>         cld
> -       PUSH_AND_CLEAR_REGS save_ret=1
> -       ENCODE_FRAME_POINTER 8
> -       testb   $3, CS+8(%rsp)
> +       testb   $3, CS-ORIG_RAX+8(%rsp)
>         jz      .Lerror_kernelspace
>
> -       /*
> -        * We entered from user mode or we're pretending to have entered
> -        * from user mode due to an IRET fault.
> -        */

As far as I can tell, this comment is still correct, and it is
helpful. Why are you removing it?

>         SWAPGS
>         FENCE_SWAPGS_USER_ENTRY
> -       /* We have user CR3.  Change to kernel CR3. */
> -       SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
> +       /*
> +        * Switch to the thread stack. The IRET frame and orig_ax are
> +        * on the stack, as well as the return address. RDI..R12 are

Did you mean RDI..R15?

> +        * not (yet) on the stack and space has not (yet) been
> +        * allocated for them.
> +        */
> +       pushq   %rdx
> +
> +       /* Need to switch before accessing the thread stack. */
> +       SWITCH_TO_KERNEL_CR3 scratch_reg=%rdx
> +       movq    %rsp, %rdx
> +       movq    PER_CPU_VAR(cpu_current_top_of_stack), %rsp

Can we avoid spilling %rdx to the meltdown-readable entry stack here?
We could do something similar to what entry_SYSCALL_64 does, roughly
like this:


/*
 * While there is an iret frame, it won't be easy to find for a
 * few instructions, so let's pretend it doesn't exist.
 */
UNWIND_HINT_EMPTY

/*
 * Switch to kernel CR3 and stack. To avoid spilling secret
 * userspace register state to the trampoline stack, we use
 * RSP as scratch - we can reconstruct the old RSP afterwards
 * using TSS_sp0.
 */
SWITCH_TO_KERNEL_CR3 scratch_reg=%rsp
movq    PER_CPU_VAR(cpu_current_top_of_stack), %rsp

pushq %rdx /* scratch, will be replaced with regs->ss later */
mov PER_CPU_VAR(cpu_tss_rw + TSS_sp0), %rdx
sub $7*8, %rdx /* return address, orig_ax, IRET frame */
/*
 * We have return address and orig_ax on the stack on
 * top of the IRET frame. That means offset=2*8
 */
UNWIND_HINT_IRET_REGS base=%rdx offset=-5*8

pushq   -2*8(%rdx)               /* regs->rsp */
pushq   -3*8(%rdx)               /* regs->eflags */
pushq   -4*8(%rdx)               /* regs->cs */
pushq   -5*8(%rdx)               /* regs->ip */
pushq   -6*8(%rdx)               /* regs->orig_ax */
pushq   -7*8(%rdx)               /* return address */
UNWIND_HINT_FUNC

PUSH_AND_CLEAR_REGS rdx=7*8(%rsp), save_ret=1

/* copy regs->ss from trampoline stack */
movq PER_CPU_VAR(cpu_tss_rw + TSS_sp0), %rax
mov -1*8(%rax), %rax
movq %rax, 20*8(%rsp)

ENCODE_FRAME_POINTER 8

ret


Does something like that seem like a reasonable idea?

> +        /*
> +         * We have RDX, return address, and orig_ax on the stack on
> +         * top of the IRET frame. That means offset=24
> +         */
> +       UNWIND_HINT_IRET_REGS base=%rdx offset=24
> +
> +       pushq   7*8(%rdx)               /* regs->ss */
> +       pushq   6*8(%rdx)               /* regs->rsp */
> +       pushq   5*8(%rdx)               /* regs->eflags */
> +       pushq   4*8(%rdx)               /* regs->cs */
> +       pushq   3*8(%rdx)               /* regs->ip */
> +       pushq   2*8(%rdx)               /* regs->orig_ax */
> +       pushq   8(%rdx)                 /* return address */
> +       UNWIND_HINT_FUNC
> +
> +       PUSH_AND_CLEAR_REGS rdx=(%rdx), save_ret=1
> +       ENCODE_FRAME_POINTER 8
> +       ret
