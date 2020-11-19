Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3883D2B9766
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgKSQHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 11:07:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:51482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728363AbgKSQHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 11:07:00 -0500
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E67A7246F3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 16:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605802019;
        bh=Dd92FFIuRXBHMGaAzdZ5cuDCR91zcHARjWEocdLzJZ0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WehPU7c4mPGIF+KG0EuZeqAOmWuM0ytKOQpr4zffiAC21zeC61L3Lz4c3HKqMQtOD
         Rwj74yvhSn3ADl0+u13IsOh3VBJzcE4SRGgjLaZ3qsa5XRiY29jD/eUY0jxWgzr7Rh
         P+X0IVl1LiaJQR8+KC34w3UOMlMY+j8gBXpRW8Wo=
Received: by mail-wr1-f43.google.com with SMTP id l1so6968054wrb.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 08:06:58 -0800 (PST)
X-Gm-Message-State: AOAM5308Ef6uyx16oYazMnW8oyj0/s5u68eieI1yE3KiF+mTVmQoI5if
        CH9IVUzYhfs6o2Vwsn4UJzZV6SjhLVPxDYbXxXcHzw==
X-Google-Smtp-Source: ABdhPJwu0K2c75dDTm3npa7ZoE2rdBJ8aLL+ZSvLgaudewip3UzZdN/D6HZshQhDQoC52EYwz/ar8hmsXgdehR6l6bY=
X-Received: by 2002:adf:f0c2:: with SMTP id x2mr10877479wro.184.1605802017310;
 Thu, 19 Nov 2020 08:06:57 -0800 (PST)
MIME-Version: 1.0
References: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
 <20201116144757.1920077-13-alexandre.chartre@oracle.com> <CALCETrUSCwtR41CCo_cAQf_BwG7istH6fM=bxWh_VfOjSNFmSw@mail.gmail.com>
 <bc8a254e-deaa-388e-99ea-0291f5625b5b@oracle.com> <CALCETrUJQJRi6fE=bs3iAySgM8wjmGU1f464FqOuU+PiBwwnQQ@mail.gmail.com>
 <bf919e4b-d56f-711d-f7ae-b463b8fdadfd@oracle.com> <CALCETrWS8_yugbLGFpGUbj2Z5bV04jnCNcnc40QUXWCdmJQU-g@mail.gmail.com>
 <6f513efb-cde8-50f4-7872-13a18a10c4a6@oracle.com> <CALCETrWBwFifg3mniUcdB7PO1CgzcxaNPYuWK3c7zK9H-hv=6Q@mail.gmail.com>
 <2f6a446a-e656-627c-27f2-8411f318448c@oracle.com> <88bab705-4b33-bda9-3ece-563234822095@oracle.com>
In-Reply-To: <88bab705-4b33-bda9-3ece-563234822095@oracle.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 19 Nov 2020 08:06:42 -0800
X-Gmail-Original-Message-ID: <CALCETrV9ckeSwyjLn4hxuJeakxnkRQ71RAVf44nTWOFva9EJFA@mail.gmail.com>
Message-ID: <CALCETrV9ckeSwyjLn4hxuJeakxnkRQ71RAVf44nTWOFva9EJFA@mail.gmail.com>
Subject: Re: [RFC][PATCH v2 12/21] x86/pti: Use PTI stack instead of
 trampoline stack
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        jan.setjeeilers@oracle.com, Junaid Shahid <junaids@google.com>,
        oweisse@google.com, Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Alexander Graf <graf@amazon.de>, mgross@linux.intel.com,
        kuzuno@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 4:06 AM Alexandre Chartre
<alexandre.chartre@oracle.com> wrote:
>
>
>
> On 11/19/20 9:05 AM, Alexandre Chartre wrote:
> >>>>>>>>>
> >>>>>>>>> When entering the kernel from userland, use the per-task PTI stack
> >>>>>>>>> instead of the per-cpu trampoline stack. Like the trampoline stack,
> >>>>>>>>> the PTI stack is mapped both in the kernel and in the user page-table.
> >>>>>>>>> Using a per-task stack which is mapped into the kernel and the user
> >>>>>>>>> page-table instead of a per-cpu stack will allow executing more code
> >>>>>>>>> before switching to the kernel stack and to the kernel page-table.
> >>>>>>>>
> >>>>>>>> Why?
> >>>>>>>
> >>>>>>> When executing more code in the kernel, we are likely to reach a point
> >>>>>>> where we need to sleep while we are using the user page-table, so we need
> >>>>>>> to be using a per-thread stack.
> >>>>>>>
> >>>>>>>> I can't immediately evaluate how nasty the page table setup is because
> >>>>>>>> it's not in this patch.
> >>>>>>>
> >>>>>>> The page-table is the regular page-table as introduced by PTI. It is just
> >>>>>>> augmented with a few additional mapping which are in patch 11 (x86/pti:
> >>>>>>> Extend PTI user mappings).
> >>>>>>>
> >>>>>>>>     But AFAICS the only thing that this enables is sleeping with user pagetables.
> >>>>>>>
> >>>>>>> That's precisely the point, it allows to sleep with the user page-table.
> >>>>>>>
> >>>>>>>> Do we really need to do that?
> >>>>>>>
> >>>>>>> Actually, probably not with this particular patchset, because I do the page-table
> >>>>>>> switch at the very beginning and end of the C handler. I had some code where I
> >>>>>>> moved the page-table switch deeper in the kernel handler where you definitively
> >>>>>>> can sleep (for example, if you switch back to the user page-table before
> >>>>>>> exit_to_user_mode_prepare()).
> >>>>>>>
> >>>>>>> So a first step should probably be to not introduce the per-task PTI trampoline stack,
> >>>>>>> and stick with the existing trampoline stack. The per-task PTI trampoline stack can
> >>>>>>> be introduced later when the page-table switch is moved deeper in the C handler and
> >>>>>>> we can effectively sleep while using the user page-table.
> >>>>>>
> >>>>>> Seems reasonable.
> >>>>>>
> >>>>>
> >>>>> I finally remember why I have introduced a per-task PTI trampoline stack right now:
> >>>>> that's to be able to move the CR3 switch anywhere in the C handler. To do so, we need
> >>>>> a per-task stack to enter (and return) from the C handler as the handler can potentially
> >>>>> go to sleep.
> >>>>>
> >>>>> Without a per-task trampoline stack, we would be limited to call the switch CR3 functions
> >>>>> from the assembly entry code before and after calling the C function handler (also called
> >>>>> from assembly).
> >>>>
> >>>> The noinstr part of the C entry code won't sleep.
> >>>>
> >>>
> >>> But the noinstr part of the handler can sleep, and if it does we will need to
> >>> preserve the trampoline stack (even if we switch to the per-task kernel stack to
> >>> execute the noinstr part).
> >>>
> >>> Example:
> >>>
> >>> #define DEFINE_IDTENTRY(func)                                           \
> >>> static __always_inline void __##func(struct pt_regs *regs);             \
> >>>                                                                           \
> >>> __visible noinstr void func(struct pt_regs *regs)                       \
> >>> {                                                                       \
> >>>           irqentry_state_t state;         -+                              \
> >>>                                            |                              \
> >>>           user_pagetable_escape(regs);     | use trampoline stack (1)
> >>>           state = irqentry_enter(regs);    |                              \
> >>>           instrumentation_begin();        -+                              \
> >>>           run_idt(__##func, regs);       |===| run __func() on kernel stack (this can sleep)
> >>>           instrumentation_end();          -+                              \
> >>>           irqentry_exit(regs, state);      | use trampoline stack (2)
> >>>           user_pagetable_return(regs);    -+                              \
> >>> }
> >>>
> >>> Between (1) and (2) we need to preserve and use the same trampoline stack
> >>> in case __func() went sleeping.
> >>>
> >>
> >> Why?  Right now, we have the percpu entry stack, and we do just fine
> >> if we enter on one percpu stack and exit from a different one.
> >> We would need to call from asm to C on the entry stack, return back to
> >> asm, and then switch stacks.
> >>
> >
> > That's the problem: I didn't want to return back to asm, so that the pagetable
> > switch can be done anywhere in the C handler.
> >
> > So yes, returning to asm to switch the stack is the solution if we want to avoid
> > having per-task trampoline stack. The drawback is that this forces to do the
> > page-table switch at the beginning and end of the handler; the pagetable switch
> > cannot be moved deeper down into the C handler.
> >
> > But that's probably a good first step (effectively just moving CR3 switch to C
> > without adding per-task trampoline stack). I will update the patches to do that,
> > and we can defer the per-task trampoline stack to later if there's an effective
> > need for it.
> >
>
> That might not be a good first step after all... Calling CR3 switch C functions
> from assembly introduces extra pt_regs copies between the trampoline stack and the
> kernel stack.
>
> Currently when entering syscall, we immediately switches CR3 and builds pt_regs
> directly on the kernel stack. On return, registers are restored from pt_regs from
> the kernel stack, the return frame is built on the trampoline stack and then we
> switch CR3.
>
> To call CR3 switch C functions on syscall entry, we need to switch to the trampoline
> stack, build pt_regs on the trampoline stack, call CR3 switch, switch to the kernel
> stack, copy pt_regs to the kernel stack. On return, we have to copy pt_regs back to
> the trampoline stack, call CR3 switch, restore registers.
>
> This is less of an impact for interrupt because we enter on the trampoline stack and
> the current code already builds pt_regs on the trampoline stack and copies it to the
> kernel stack (although this can certainly be avoided in the current code).
>
> I am not comfortable adding these extra steps in syscall and interrupt as the current
> code is fairly optimized. With a per-task trampoline stack, we don't have extra copy
> because we can build pt_regs directly on the trampoline stack and it will preserved
> even when switching to the kernel stack. On syscall/interrupt return, it also saves
> a copy of the iret frame from the kernel stack to the trampoline stack.

IIRC during the early KPTI development, we went through a stage with
per-task stacks.  It was a mess, and we got rid of it for good reason.
Your series has a bad diffstat, is a lot of churn, doesn't even handle
the unmap part yet, and, by itself, adds basically no value.

We need to take a big step back and figure out what problem any of
this is solving.  As I understand it, most of the issue is that you
want to be able to switch between kernel and guest mode on one core
without exposing kernel memory to Meltdown or Spectre attacks from
guest code on another core.  If so, it seems to me that a much nicer
solution would be to use a per-cpu or per-vcpu stack for the vm entry.
It could plausibly even use the existing entry stack.  If you used a
per-vcpu stack, though, you could even sleep with some care.
