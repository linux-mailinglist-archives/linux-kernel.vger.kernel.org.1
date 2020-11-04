Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F642A6416
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 13:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbgKDMTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 07:19:02 -0500
Received: from foss.arm.com ([217.140.110.172]:36142 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbgKDMTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 07:19:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CEBCB1474;
        Wed,  4 Nov 2020 04:19:01 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 651B63F719;
        Wed,  4 Nov 2020 04:19:00 -0800 (PST)
Date:   Wed, 4 Nov 2020 12:18:56 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        systemd-devel@lists.freedesktop.org,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Mark Brown <broonie@kernel.org>, toiwoton@gmail.com,
        libc-alpha@sourceware.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: BTI interaction between seccomp filters in systemd and glibc
 mprotect calls, causing service failures
Message-ID: <20201104121855.GQ6882@arm.com>
References: <8584c14f-5c28-9d70-c054-7c78127d84ea@arm.com>
 <20201026162410.GB27285@arm.com>
 <20201026165755.GV3819@arm.com>
 <20201026175230.GC27285@arm.com>
 <45c64b49-a38b-4b0c-d9cf-6c586dacbcc9@arm.com>
 <20201027141522.GD27285@arm.com>
 <20201029110220.GC10776@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029110220.GC10776@gaia>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 11:02:22AM +0000, Catalin Marinas via Libc-alpha wrote:
> On Tue, Oct 27, 2020 at 02:15:22PM +0000, Dave P Martin wrote:
> > I also wonder whether we actually care whether the pages are marked
> > executable or not here; probably the flags can just be independent.  This
> > rather depends on whether the how the architecture treats the BTI (a.k.a
> > GP) pagetable bit for non-executable pages.  I have a feeling we already
> > allow PROT_BTI && !PROT_EXEC through anyway.
> > 
> > 
> > What about a generic-ish set/clear interface that still works by just
> > adding a couple of PROT_ flags:
> > 
> > 	switch (flags & (PROT_SET | PROT_CLEAR)) {
> > 	case PROT_SET: prot |= flags; break;
> > 	case PROT_CLEAR: prot &= ~flags; break;
> > 	case 0: prot = flags; break;
> > 
> > 	default:
> > 		return -EINVAL;
> > 	}
> > 
> > This can't atomically set some flags while clearing some others, but for
> > simple stuff it seems sufficient and shouldn't be too invasive on the
> > kernel side.
> > 
> > We will still have to take the mm lock when doing a SET or CLEAR, but
> > not for the non-set/clear case.
> > 
> > 
> > Anyway, libc could now do:
> > 
> > 	mprotect(addr, len, PROT_SET | PROT_BTI);
> > 
> > with much the same effect as your PROT_BTI_IF_X.
> > 
> > 
> > JITting or breakpoint setting code that wants to change the permissions
> > temporarily, without needing to know whether PROT_BTI is set, say:
> > 
> > 	mprotect(addr, len, PROT_SET | PROT_WRITE);
> > 	*addr = BKPT_INSN;
> > 	mprotect(addr, len, PROT_CLEAR | PROT_WRITE);
> 
> The problem with this approach is that you can't catch
> PROT_EXEC|PROT_WRITE mappings via seccomp. So you'd have to limit it to
> some harmless PROT_ flags only. I don't like this limitation, nor the
> PROT_BTI_IF_X approach.

Ack; this is just one flavour of interface, and every approach seems to
have some shortcomings.

> The only generic solutions I see are to either use a stateful filter in
> systemd or pass the old state to the kernel in a cmpxchg style so that
> seccomp can check it (I think you suggest this at some point).

The "cmpxchg" option has the disadvantage that the caller needs to know
the original permissions.  It seems that glibc is prepared to work
around this, but it won't always be feasible in ancillary /
instrumentation code or libraries.

IMHO it would be preferable to apply a policy to mmap/mprotect in the
kernel proper rather then BPF being the only way to do it -- in any
case, the required checks seem to be out of the scope of what can be
done efficiently (or perhaps at all) in a syscall filter.

> The latter requires a new syscall which is not something we can address
> as a quick, back-portable fix here. If systemd cannot be changed to use
> a stateful filter for w^x detection, my suggestion is to go for the
> kernel setting PROT_BTI on the main executable with glibc changed to
> tolerate EPERM on mprotect(). I don't mind adding an AT_FLAGS bit if
> needed but I don't think it buys us much.

I agree, this seems the best short-term approach.

> Once the current problem is fixed, we can look at a better solution
> longer term as a new syscall.

Agreed, I think if we try to rush the addition of new syscalls, the
chance of coming up with a bad design is high...

Cheers
---Dave
