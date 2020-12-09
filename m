Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFE32D4339
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 14:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732381AbgLIN22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 08:28:28 -0500
Received: from foss.arm.com ([217.140.110.172]:34654 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732358AbgLIN2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 08:28:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6032831B;
        Wed,  9 Dec 2020 05:27:20 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.26.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F7983F66B;
        Wed,  9 Dec 2020 05:27:17 -0800 (PST)
Date:   Wed, 9 Dec 2020 13:27:10 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "VMware, Inc." <pv-drivers@vmware.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH v2 05/12] x86: rework arch_local_irq_restore() to not use
 popf
Message-ID: <20201209132710.GA8566@C02TD0UTHF1T.local>
References: <20201120114630.13552-1-jgross@suse.com>
 <20201120114630.13552-6-jgross@suse.com>
 <20201120115943.GD3021@hirez.programming.kicks-ass.net>
 <eb05e878-6334-8d19-496b-6572df67fc56@suse.com>
 <CALCETrXOGhXoOJpzhAMqD7iibi09WzbGk9SWVH7JzA=d5uarWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrXOGhXoOJpzhAMqD7iibi09WzbGk9SWVH7JzA=d5uarWA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 22, 2020 at 01:44:53PM -0800, Andy Lutomirski wrote:
> On Sat, Nov 21, 2020 at 10:55 PM Jürgen Groß <jgross@suse.com> wrote:
> >
> > On 20.11.20 12:59, Peter Zijlstra wrote:
> > > On Fri, Nov 20, 2020 at 12:46:23PM +0100, Juergen Gross wrote:
> > >> +static __always_inline void arch_local_irq_restore(unsigned long flags)
> > >> +{
> > >> +    if (!arch_irqs_disabled_flags(flags))
> > >> +            arch_local_irq_enable();
> > >> +}
> > >
> > > If someone were to write horrible code like:
> > >
> > >       local_irq_disable();
> > >       local_irq_save(flags);
> > >       local_irq_enable();
> > >       local_irq_restore(flags);
> > >
> > > we'd be up some creek without a paddle... now I don't _think_ we have
> > > genius code like that, but I'd feel saver if we can haz an assertion in
> > > there somewhere...
> > >
> > > Maybe something like:
> > >
> > > #ifdef CONFIG_DEBUG_ENTRY // for lack of something saner
> > >       WARN_ON_ONCE((arch_local_save_flags() ^ flags) & X86_EFLAGS_IF);
> > > #endif
> > >
> > > At the end?
> >
> > I'd like to, but using WARN_ON_ONCE() in include/asm/irqflags.h sounds
> > like a perfect receipt for include dependency hell.
> >
> > We could use a plain asm("ud2") instead.
> 
> How about out-of-lining it:
> 
> #ifdef CONFIG_DEBUG_ENTRY
> extern void warn_bogus_irqrestore();
> #endif
> 
> static __always_inline void arch_local_irq_restore(unsigned long flags)
> {
>        if (!arch_irqs_disabled_flags(flags)) {
>                arch_local_irq_enable();
>        } else {
> #ifdef CONFIG_DEBUG_ENTRY
>                if (unlikely(arch_local_irq_save() & X86_EFLAGS_IF))
>                     warn_bogus_irqrestore();
> #endif
> }

I was just talking to Peter on IRC about implementing the same thing for
arm64, so could we put this in the generic irqflags code? IIUC we can
use raw_irqs_disabled() to do the check.

As this isn't really entry specific (and IIUC the cases this should
catch would break lockdep today), maybe we should add a new
DEBUG_IRQFLAGS for this, that DEBUG_LOCKDEP can also select?

Something like:

#define local_irq_restore(flags)                               \
       do {                                                    \
               if (!raw_irqs_disabled_flags(flags)) {          \
                       trace_hardirqs_on();                    \
               } else if (IS_ENABLED(CONFIG_DEBUG_IRQFLAGS) {  \
                       if (unlikely(raw_irqs_disabled())       \
                               warn_bogus_irqrestore();        \
               }                                               \
               raw_local_irq_restore(flags);                   \
        } while (0)

... perhaps? (ignoring however we deal with once-ness).

Thanks,
Mark.
