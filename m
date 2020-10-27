Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D852B29C5EC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 19:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1825176AbgJ0SJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 14:09:20 -0400
Received: from foss.arm.com ([217.140.110.172]:41304 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756976AbgJ0OPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 10:15:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8E1E150C;
        Tue, 27 Oct 2020 07:15:27 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 545943F719;
        Tue, 27 Oct 2020 07:15:26 -0700 (PDT)
Date:   Tue, 27 Oct 2020 14:15:22 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        systemd-devel@lists.freedesktop.org,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, toiwoton@gmail.com,
        libc-alpha@sourceware.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: BTI interaction between seccomp filters in systemd and glibc
 mprotect calls, causing service failures
Message-ID: <20201027141522.GD27285@arm.com>
References: <8584c14f-5c28-9d70-c054-7c78127d84ea@arm.com>
 <20201026162410.GB27285@arm.com>
 <20201026165755.GV3819@arm.com>
 <20201026175230.GC27285@arm.com>
 <45c64b49-a38b-4b0c-d9cf-6c586dacbcc9@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45c64b49-a38b-4b0c-d9cf-6c586dacbcc9@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 05:39:42PM -0500, Jeremy Linton via Libc-alpha wrote:
> Hi,
> 
> On 10/26/20 12:52 PM, Dave Martin wrote:
> >On Mon, Oct 26, 2020 at 04:57:55PM +0000, Szabolcs Nagy via Libc-alpha wrote:
> >>The 10/26/2020 16:24, Dave Martin via Libc-alpha wrote:
> >>>Unrolling this discussion a bit, this problem comes from a few sources:
> >>>
> >>>1) systemd is trying to implement a policy that doesn't fit SECCOMP
> >>>syscall filtering very well.
> >>>
> >>>2) The program is trying to do something not expressible through the
> >>>syscall interface: really the intent is to set PROT_BTI on the page,
> >>>with no intent to set PROT_EXEC on any page that didn't already have it
> >>>set.
> >>>
> >>>
> >>>This limitation of mprotect() was known when I originally added PROT_BTI,
> >>>but at that time we weren't aware of a clear use case that would fail.
> >>>
> >>>
> >>>Would it now help to add something like:
> >>>
> >>>int mchangeprot(void *addr, size_t len, int old_flags, int new_flags)
> >>>{
> >>>	int ret = -EINVAL;
> >>>	mmap_write_lock(current->mm);
> >>>	if (all vmas in [addr .. addr + len) have
> >>>			their mprotect flags set to old_flags) {
> >>>
> >>>		ret = mprotect(addr, len, new_flags);
> >>>	}
> >>>	
> >>>	mmap_write_unlock(current->mm);
> >>>	return ret;
> >>>}
> >>
> >>if more prot flags are introduced then the exact
> >>match for old_flags may be restrictive and currently
> >>there is no way to query these flags to figure out
> >>how to toggle one prot flag in a future proof way,
> >>so i don't think this solves the issue completely.
> >
> >Ack -- I illustrated this model because it makes the seccomp filter's
> >job easy, but it does have limitations.
> >
> >>i think we might need a new api, given that aarch64
> >>now has PROT_BTI and PROT_MTE while existing code
> >>expects RWX only, but i don't know what api is best.
> >
> >An alternative option would be a call that sets / clears chosen
> >flags and leaves others unchanged.
> 
> I tend to favor a set/clear API, but that could also just be done by
> creating a new PROT_BTI_IF_X which enables BTI for areas already set to
> _EXEC. That goes right by the seccomp filters too, and actually is closer to
> what glibc wants to do anyway.

That works, though I'm not so keen on teating PROT_BTI as a special case,
since the problem is likely to recur when other weird per-arch flags get
added...

I also wonder whether we actually care whether the pages are marked
executable or not here; probably the flags can just be independent.  This
rather depends on whether the how the architecture treats the BTI (a.k.a
GP) pagetable bit for non-executable pages.  I have a feeling we already
allow PROT_BTI && !PROT_EXEC through anyway.


What about a generic-ish set/clear interface that still works by just
adding a couple of PROT_ flags:

	switch (flags & (PROT_SET | PROT_CLEAR)) {
	case PROT_SET: prot |= flags; break;
	case PROT_CLEAR: prot &= ~flags; break;
	case 0: prot = flags; break;

	default:
		return -EINVAL;
	}

This can't atomically set some flags while clearing some others, but for
simple stuff it seems sufficient and shouldn't be too invasive on the
kernel side.

We will still have to take the mm lock when doing a SET or CLEAR, but
not for the non-set/clear case.


Anyway, libc could now do:

	mprotect(addr, len, PROT_SET | PROT_BTI);

with much the same effect as your PROT_BTI_IF_X.


JITting or breakpoint setting code that wants to change the permissions
temporarily, without needing to know whether PROT_BTI is set, say:

	mprotect(addr, len, PROT_SET | PROT_WRITE);
	*addr = BKPT_INSN;
	mprotect(addr, len, PROT_CLEAR | PROT_WRITE);


Thoughts?

I won't claim this doesn't still have some limitations...

Cheers
---Dave
