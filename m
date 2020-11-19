Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9577E2B89BD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 02:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgKSBtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 20:49:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:51690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbgKSBtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 20:49:41 -0500
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64D37246DC
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 01:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605750580;
        bh=V+kGQcpllChEzBR+FQTF7rNiN3nV/l7bJ7lkb+HDBv8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pE0wytQxbqwzRc4RLjCgM7BregjkmAiHbKy2dOiUYPZdHAAkDcdj/qfr7yzs5Lb7t
         jmKHJkk0M7Sumxw3Z3MDpYc+lEwKv1rKTENRHXaRQeNNO6k8nPLT5vhe1KMTP6sDGE
         9gRoqNKhuTZI6nPugbitkDYC/APMGkGz4bXko3WI=
Received: by mail-wr1-f54.google.com with SMTP id p8so4798784wrx.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 17:49:40 -0800 (PST)
X-Gm-Message-State: AOAM53312LruVdnT0tnV9EBII+lEdLYWXa77DTVkUew8A4u9Y1QwHi5a
        ghxeM4+8hUuQuOtrNIQpk7gLOGmEdyxM6uKN/17WUA==
X-Google-Smtp-Source: ABdhPJyHOoLnxNIuntxtbXp1DEitUu3Z8qhFXoVwNPAojfsJHOf70SlrURFUhUQCner7uN3c8BSZWJqoUv9NiKuV4A8=
X-Received: by 2002:a5d:49ce:: with SMTP id t14mr7391178wrs.75.1605750578731;
 Wed, 18 Nov 2020 17:49:38 -0800 (PST)
MIME-Version: 1.0
References: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
 <20201116144757.1920077-13-alexandre.chartre@oracle.com> <CALCETrUSCwtR41CCo_cAQf_BwG7istH6fM=bxWh_VfOjSNFmSw@mail.gmail.com>
 <bc8a254e-deaa-388e-99ea-0291f5625b5b@oracle.com> <CALCETrUJQJRi6fE=bs3iAySgM8wjmGU1f464FqOuU+PiBwwnQQ@mail.gmail.com>
 <bf919e4b-d56f-711d-f7ae-b463b8fdadfd@oracle.com> <CALCETrWS8_yugbLGFpGUbj2Z5bV04jnCNcnc40QUXWCdmJQU-g@mail.gmail.com>
 <6f513efb-cde8-50f4-7872-13a18a10c4a6@oracle.com>
In-Reply-To: <6f513efb-cde8-50f4-7872-13a18a10c4a6@oracle.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 18 Nov 2020 17:49:22 -0800
X-Gmail-Original-Message-ID: <CALCETrWBwFifg3mniUcdB7PO1CgzcxaNPYuWK3c7zK9H-hv=6Q@mail.gmail.com>
Message-ID: <CALCETrWBwFifg3mniUcdB7PO1CgzcxaNPYuWK3c7zK9H-hv=6Q@mail.gmail.com>
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

On Tue, Nov 17, 2020 at 8:59 AM Alexandre Chartre
<alexandre.chartre@oracle.com> wrote:
>
>
>
> On 11/17/20 4:52 PM, Andy Lutomirski wrote:
> > On Tue, Nov 17, 2020 at 7:07 AM Alexandre Chartre
> > <alexandre.chartre@oracle.com> wrote:
> >>
> >>
> >>
> >> On 11/16/20 7:34 PM, Andy Lutomirski wrote:
> >>> On Mon, Nov 16, 2020 at 10:10 AM Alexandre Chartre
> >>> <alexandre.chartre@oracle.com> wrote:
> >>>>
> >>>>
> >>>> On 11/16/20 5:57 PM, Andy Lutomirski wrote:
> >>>>> On Mon, Nov 16, 2020 at 6:47 AM Alexandre Chartre
> >>>>> <alexandre.chartre@oracle.com> wrote:
> >>>>>>
> >>>>>> When entering the kernel from userland, use the per-task PTI stack
> >>>>>> instead of the per-cpu trampoline stack. Like the trampoline stack,
> >>>>>> the PTI stack is mapped both in the kernel and in the user page-table.
> >>>>>> Using a per-task stack which is mapped into the kernel and the user
> >>>>>> page-table instead of a per-cpu stack will allow executing more code
> >>>>>> before switching to the kernel stack and to the kernel page-table.
> >>>>>
> >>>>> Why?
> >>>>
> >>>> When executing more code in the kernel, we are likely to reach a point
> >>>> where we need to sleep while we are using the user page-table, so we need
> >>>> to be using a per-thread stack.
> >>>>
> >>>>> I can't immediately evaluate how nasty the page table setup is because
> >>>>> it's not in this patch.
> >>>>
> >>>> The page-table is the regular page-table as introduced by PTI. It is just
> >>>> augmented with a few additional mapping which are in patch 11 (x86/pti:
> >>>> Extend PTI user mappings).
> >>>>
> >>>>>    But AFAICS the only thing that this enables is sleeping with user pagetables.
> >>>>
> >>>> That's precisely the point, it allows to sleep with the user page-table.
> >>>>
> >>>>> Do we really need to do that?
> >>>>
> >>>> Actually, probably not with this particular patchset, because I do the page-table
> >>>> switch at the very beginning and end of the C handler. I had some code where I
> >>>> moved the page-table switch deeper in the kernel handler where you definitively
> >>>> can sleep (for example, if you switch back to the user page-table before
> >>>> exit_to_user_mode_prepare()).
> >>>>
> >>>> So a first step should probably be to not introduce the per-task PTI trampoline stack,
> >>>> and stick with the existing trampoline stack. The per-task PTI trampoline stack can
> >>>> be introduced later when the page-table switch is moved deeper in the C handler and
> >>>> we can effectively sleep while using the user page-table.
> >>>
> >>> Seems reasonable.
> >>>
> >>
> >> I finally remember why I have introduced a per-task PTI trampoline stack right now:
> >> that's to be able to move the CR3 switch anywhere in the C handler. To do so, we need
> >> a per-task stack to enter (and return) from the C handler as the handler can potentially
> >> go to sleep.
> >>
> >> Without a per-task trampoline stack, we would be limited to call the switch CR3 functions
> >> from the assembly entry code before and after calling the C function handler (also called
> >> from assembly).
> >
> > The noinstr part of the C entry code won't sleep.
> >
>
> But the noinstr part of the handler can sleep, and if it does we will need to
> preserve the trampoline stack (even if we switch to the per-task kernel stack to
> execute the noinstr part).
>
> Example:
>
> #define DEFINE_IDTENTRY(func)                                           \
> static __always_inline void __##func(struct pt_regs *regs);             \
>                                                                          \
> __visible noinstr void func(struct pt_regs *regs)                       \
> {                                                                       \
>          irqentry_state_t state;         -+                              \
>                                           |                              \
>          user_pagetable_escape(regs);     | use trampoline stack (1)
>          state = irqentry_enter(regs);    |                              \
>          instrumentation_begin();        -+                              \
>          run_idt(__##func, regs);       |===| run __func() on kernel stack (this can sleep)
>          instrumentation_end();          -+                              \
>          irqentry_exit(regs, state);      | use trampoline stack (2)
>          user_pagetable_return(regs);    -+                              \
> }
>
> Between (1) and (2) we need to preserve and use the same trampoline stack
> in case __func() went sleeping.
>

Why?  Right now, we have the percpu entry stack, and we do just fine
if we enter on one percpu stack and exit from a different one.  We
would need to call from asm to C on the entry stack, return back to
asm, and then switch stacks.
