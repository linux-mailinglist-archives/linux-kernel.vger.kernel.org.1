Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF4F2A7CBE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 12:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbgKELP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 06:15:59 -0500
Received: from foss.arm.com ([217.140.110.172]:57754 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgKELP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 06:15:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55E9E142F;
        Thu,  5 Nov 2020 03:15:58 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.58.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5A9E3F719;
        Thu,  5 Nov 2020 03:15:55 -0800 (PST)
Date:   Thu, 5 Nov 2020 11:15:52 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] kfence: Use pt_regs to generate stack trace on faults
Message-ID: <20201105111552.GD82102@C02TD0UTHF1T.local>
References: <20201105092133.2075331-1-elver@google.com>
 <20201105105241.GC82102@C02TD0UTHF1T.local>
 <CANpmjNP+QOJrfJHC2P-9gFfB6wdnr9c9gPDgVFdgzbrCcG-nog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNP+QOJrfJHC2P-9gFfB6wdnr9c9gPDgVFdgzbrCcG-nog@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 12:11:19PM +0100, Marco Elver wrote:
> On Thu, 5 Nov 2020 at 11:52, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Thu, Nov 05, 2020 at 10:21:33AM +0100, Marco Elver wrote:
> > > Instead of removing the fault handling portion of the stack trace based
> > > on the fault handler's name, just use struct pt_regs directly.
> > >
> > > Change kfence_handle_page_fault() to take a struct pt_regs, and plumb it
> > > through to kfence_report_error() for out-of-bounds, use-after-free, or
> > > invalid access errors, where pt_regs is used to generate the stack
> > > trace.
> > >
> > > If the kernel is a DEBUG_KERNEL, also show registers for more
> > > information.
> > >
> > > Suggested-by: Mark Rutland <mark.rutland@arm.com>
> > > Signed-off-by: Marco Elver <elver@google.com>
> >
> > Wow; I wasn't expecting this to be put together so quickly, thanks for
> > doing this!
> >
> > From a scan, this looks good to me -- just one question below.
> >
> > > diff --git a/include/linux/kfence.h b/include/linux/kfence.h
> > > index ed2d48acdafe..98a97f9d43cd 100644
> > > --- a/include/linux/kfence.h
> > > +++ b/include/linux/kfence.h
> > > @@ -171,6 +171,7 @@ static __always_inline __must_check bool kfence_free(void *addr)
> > >  /**
> > >   * kfence_handle_page_fault() - perform page fault handling for KFENCE pages
> > >   * @addr: faulting address
> > > + * @regs: current struct pt_regs (can be NULL, but shows full stack trace)
> > >   *
> > >   * Return:
> > >   * * false - address outside KFENCE pool,
> >
> > > @@ -44,8 +44,12 @@ static int get_stack_skipnr(const unsigned long stack_entries[], int num_entries
> > >               case KFENCE_ERROR_UAF:
> > >               case KFENCE_ERROR_OOB:
> > >               case KFENCE_ERROR_INVALID:
> > > -                     is_access_fault = true;
> > > -                     break;
> > > +                     /*
> > > +                      * kfence_handle_page_fault() may be called with pt_regs
> > > +                      * set to NULL; in that case we'll simply show the full
> > > +                      * stack trace.
> > > +                      */
> > > +                     return 0;
> >
> > For both the above comments, when/where is kfence_handle_page_fault()
> > called with regs set to NULL? I couldn't spot that in this patch, so
> > unless I mised it I'm guessing that's somewhere outside of the patch
> > context?
> 
> Right, currently it's not expected to happen, but I'd like to permit
> this function being called not from fault handlers, for use-cases like
> this:
> 
>  https://lkml.kernel.org/r/CANpmjNNxAvembOetv15FfZ=04mpj0Qwx+1tnn22tABaHHRRv=Q@mail.gmail.com
> 
> The revised recommendation when trying to get KFENCE to give us more
> information about allocation/free stacks after refcount underflow
> (like what Paul was trying to do) would be to call
> kfence_handle_page_fault(addr, NULL).
> 
> > If this is a case we don't expect to happen, maybe add a WARN_ON_ONCE()?
> 
> While it's currently not expected, I don't see why we should make this
> WARN and limit the potential uses of the API if it works just fine if
> we pass regs set to NULL. Although arguably the name
> kfence_handle_page_fault() might be confusing for such uses, for now,
> until more widespread use is evident (if at all) I'd say let's keep
> as-is, but simply not prevent such use-cases.

Fair enough! I guess in future we could always revise that anyhow.

FWIW, for this as-is:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.
