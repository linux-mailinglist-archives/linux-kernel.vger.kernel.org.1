Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326E426A044
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 09:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgIOH4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 03:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgIOH4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 03:56:04 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97CFC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 00:56:03 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id t13so2096726ile.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 00:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q95FFZbG53KDh7a5c+RjQioggK4iTKHG5jsnypqaUms=;
        b=CB0CJcuaSsi3BmkRmmZwphAQIgpIOJpah1d2xzs00L3Wmxe0elPm9p5m0gxdxp4opJ
         m8wci9I9iRtVayzGRP4yEKpmzK3rT9J1tgyDKU5L4tk8XBkzrBwVZgq+AoJ4e0e75H3D
         CAT+6/WBKAX99Ld59igiNzABOnBimkTqMdEd6Fw388nJ9FWlukrZZu1VsJxFHbsqoi7j
         2sWkiOy1qt7MWjGEaFZ937jnV/DBshPCmnSqQBwC8DGWytJ0s2x/vi1hp8HDY174/CG+
         V8hDjNpTpwbiurgT1Cjvcn9SoEv2lUd/j7VPNaFg3ssaRtf4QVt7GFuka9vE48ypL1a+
         K9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q95FFZbG53KDh7a5c+RjQioggK4iTKHG5jsnypqaUms=;
        b=CBQ4SmOlhbzT6pOoB5yH21j9mD7kDIaniNYpC/ER6KVCuMnN9jcqnAM/RHyuEq7+mw
         EYtSvZBYqe/AFlIc+5WXVDZ+xOCrjj+gSj25sLtiVNGbxrDszE7Wrw0ZI4LZ9ys6GWZ/
         IgpgkmpdaNncs024e6a6ymt8tBwzRyBOAsf9kddWhjlqGhhNoRZJ5QSaal4EY9G3r3jk
         QLdASQsCm3L80DTUtgPsAHvTXwpc8m83iWgUdtlSBTI5T5rPylGs95j7FsTYKLSI6y2x
         nu14reqfiGyaySinp1YJVOjPnrVgkgGATmcSwx74d18KvW39cEiZWAz8xKCRCkJWU2Nq
         l2oQ==
X-Gm-Message-State: AOAM532hvIOMzHF/3B0kN75RJUpz/jaHe2q8E8NlypFOgHyTqgo223I8
        xQAdXUHzBPTmxRw0C8weEVIyVYcPxU/k7lhdK78=
X-Google-Smtp-Source: ABdhPJzvzX7sQTdpGbeRM8/Ac1zNFhlZVUcQgpy06ZMkjhpw/W+JvT96VYlXY4o15pTzA+b6U6Lan/SOZI7hbaydyNU=
X-Received: by 2002:a92:6a08:: with SMTP id f8mr14072216ilc.94.1600156563053;
 Tue, 15 Sep 2020 00:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrWx66qLc-NiwKS_Zu=BP8JDTzfeUO7A2vDd01kXNmiNiA@mail.gmail.com>
 <20200817062355.2884-1-jiangshanlai@gmail.com> <20200817062355.2884-2-jiangshanlai@gmail.com>
 <CAG48ez23rw8oj7gT6Kyj3epXsDze+Cq30Jj_pV7sa54gxKEOpQ@mail.gmail.com>
In-Reply-To: <CAG48ez23rw8oj7gT6Kyj3epXsDze+Cq30Jj_pV7sa54gxKEOpQ@mail.gmail.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Tue, 15 Sep 2020 15:55:51 +0800
Message-ID: <CAJhGHyDL2SppJRL83JzKcEf_Zy9zDRMMW_1PrsEwu2ZaHQAkNQ@mail.gmail.com>
Subject: Re: [PATCH V3 1/3] x86/entry: avoid calling into sync_regs() when
 entering from userspace
To:     Jann Horn <jannh@google.com>
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

On Sat, Sep 12, 2020 at 5:24 AM Jann Horn <jannh@google.com> wrote:


Hello Jann

Thanks for your review.

> As far as I can see, on systems affected by Meltdown, this patch fixes
> register state leakage between tasks because any data that is written
> to the per-CPU trampoline stacks must be considered visible to all
> userspace. I think that makes this a fix that should go into stable
> kernels.

I know what you mean since I did similarly as you said in another
project. But I hesitated to claim that. Not everyone goes too
paranoid to hide all registers. I consider them a nice cleanup
the makes future entry_64.S better.

>
> Therefore, please add:
>
> Fixes: 7f2590a110b8 ("x86/entry/64: Use a per-CPU trampoline stack for
> IDT entries")
> Cc: stable@vger.kernel.org
>
>
> > ---
> >  arch/x86/entry/entry_64.S | 43 +++++++++++++++++++++++++++++++--------
> >  1 file changed, 34 insertions(+), 9 deletions(-)
> >
> > diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> > index 70dea9337816..1a7715430da3 100644
> > --- a/arch/x86/entry/entry_64.S
> > +++ b/arch/x86/entry/entry_64.S
> > @@ -928,19 +928,42 @@ SYM_CODE_END(paranoid_exit)
> >  SYM_CODE_START_LOCAL(error_entry)
> >         UNWIND_HINT_FUNC
> >         cld
> > -       PUSH_AND_CLEAR_REGS save_ret=1
> > -       ENCODE_FRAME_POINTER 8
> > -       testb   $3, CS+8(%rsp)
> > +       testb   $3, CS-ORIG_RAX+8(%rsp)
> >         jz      .Lerror_kernelspace
> >
> > -       /*
> > -        * We entered from user mode or we're pretending to have entered
> > -        * from user mode due to an IRET fault.
> > -        */
>
> As far as I can tell, this comment is still correct, and it is
> helpful. Why are you removing it?

This comment actually describes .Lerror_entry_from_usermode_after_swapgs
which is kind of far from here.

"We entered from user mode" is already self-explained by the code above.

"we're pretending to have entered from user mode due to an IRET fault"
notes code reviewers that .Lerror_bad_iret can jump to
.Lerror_entry_from_usermode_after_swapgs.

.Lerror_entry_from_usermode_after_swapgs will be removed in the next
patch.

Since the comment is too far from its target, and the target
will be removed in the next patch, so I remove the comments.

Maybe I should move the removal of the comment in the next patch?
But should I rewrite the comments before that?

>
> >         SWAPGS
> >         FENCE_SWAPGS_USER_ENTRY
> > -       /* We have user CR3.  Change to kernel CR3. */
> > -       SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
> > +       /*
> > +        * Switch to the thread stack. The IRET frame and orig_ax are
> > +        * on the stack, as well as the return address. RDI..R12 are
>
> Did you mean RDI..R15?

Good catch!

The whole code along with the comments is copied from original
interrupt_entry. The "RDI..R12" in the comment has been moved
several times and can be traced back to 7f2590a110b8
("x86/entry/64: Use a per-CPU trampoline stack for IDT entries")
(You already just referred to this commit).

>
> > +        * not (yet) on the stack and space has not (yet) been
> > +        * allocated for them.
> > +        */
> > +       pushq   %rdx
> > +
> > +       /* Need to switch before accessing the thread stack. */
> > +       SWITCH_TO_KERNEL_CR3 scratch_reg=%rdx
> > +       movq    %rsp, %rdx
> > +       movq    PER_CPU_VAR(cpu_current_top_of_stack), %rsp
>
> Can we avoid spilling %rdx to the meltdown-readable entry stack here?
> We could do something similar to what entry_SYSCALL_64 does, roughly
> like this:

We must spill at least one register besides %rsp. I once used %rbp
for scratch_reg in a not-yet-opensourced project. I think
spilling %rbp is safer than spilling other registers, but I can't
find strong enough reasoning.

The feeble reason at hand is that %rbp is often used as the frame
pointer in userspace which is safer to be leaked since %rsp is
already leaked.

See https://github.com/google/gvisor/pull/2256#discussion_r399005782
("implement KPTI for gvisor")
I once recommended spilling %rbp in gVisor.
In the pull-request in gVisor, even Google didn't show their
eagerness to hide the kernel along with the registers from APPs.

If you also consider spilling %rbp is better than spilling
%rdx and other x86 people also want that, I can do it
in other patches.

1) This patch uses "PUSH_AND_CLEAR_REGS rdx=(%rdx), save_ret=1".
   And using %rbp needs to change PUSH_AND_CLEAR_REGS which
   is better to be in a separated commit.
2) The code in entry_64.S spills other %rdi %rdx etc. to
   entry stack. They need to be changed to %rbp too.

>
>
> /*
>  * While there is an iret frame, it won't be easy to find for a
>  * few instructions, so let's pretend it doesn't exist.
>  */
> UNWIND_HINT_EMPTY
>
> /*
>  * Switch to kernel CR3 and stack. To avoid spilling secret
>  * userspace register state to the trampoline stack, we use
>  * RSP as scratch - we can reconstruct the old RSP afterwards
>  * using TSS_sp0.
>  */
> SWITCH_TO_KERNEL_CR3 scratch_reg=%rsp

It is already in the fine state in the proper place
in the stack.

Abusing %rsp is the source of perdition. Linus, tglx and
many others who have been touched entry_64.S have hated
syscall instruction for not automatically switching %rsp
and it is the source of many hateful IST exceptions.

See https://lore.kernel.org/lkml/875z98jkof.fsf@nanos.tec.linutronix.de/

I would not like to raise any objection for this reason
since I also hate abusing %rsp.

I expected you to get tonnes of replies if tglx ever notices
your such suggestion.

> movq    PER_CPU_VAR(cpu_current_top_of_stack), %rsp
>
> pushq %rdx /* scratch, will be replaced with regs->ss later */
> mov PER_CPU_VAR(cpu_tss_rw + TSS_sp0), %rdx
> sub $7*8, %rdx /* return address, orig_ax, IRET frame */
> /*
>  * We have return address and orig_ax on the stack on
>  * top of the IRET frame. That means offset=2*8
>  */
> UNWIND_HINT_IRET_REGS base=%rdx offset=-5*8
>
> pushq   -2*8(%rdx)               /* regs->rsp */
> pushq   -3*8(%rdx)               /* regs->eflags */
> pushq   -4*8(%rdx)               /* regs->cs */
> pushq   -5*8(%rdx)               /* regs->ip */
> pushq   -6*8(%rdx)               /* regs->orig_ax */
> pushq   -7*8(%rdx)               /* return address */
> UNWIND_HINT_FUNC
>
> PUSH_AND_CLEAR_REGS rdx=7*8(%rsp), save_ret=1
>
> /* copy regs->ss from trampoline stack */
> movq PER_CPU_VAR(cpu_tss_rw + TSS_sp0), %rax
> mov -1*8(%rax), %rax
> movq %rax, 20*8(%rsp)
>
> ENCODE_FRAME_POINTER 8
>
> ret


Thanks for your review and your recommendations.

Lai.
