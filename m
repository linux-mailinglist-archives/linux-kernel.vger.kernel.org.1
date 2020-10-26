Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA34B299460
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 18:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1788590AbgJZRwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 13:52:40 -0400
Received: from foss.arm.com ([217.140.110.172]:46326 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1788579AbgJZRwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 13:52:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43CD7139F;
        Mon, 26 Oct 2020 10:52:36 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2B113F66E;
        Mon, 26 Oct 2020 10:52:34 -0700 (PDT)
Date:   Mon, 26 Oct 2020 17:52:31 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        systemd-devel@lists.freedesktop.org,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Mark Brown <broonie@kernel.org>, toiwoton@gmail.com,
        libc-alpha@sourceware.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: BTI interaction between seccomp filters in systemd and glibc
 mprotect calls, causing service failures
Message-ID: <20201026175230.GC27285@arm.com>
References: <8584c14f-5c28-9d70-c054-7c78127d84ea@arm.com>
 <20201026162410.GB27285@arm.com>
 <20201026165755.GV3819@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026165755.GV3819@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 04:57:55PM +0000, Szabolcs Nagy via Libc-alpha wrote:
> The 10/26/2020 16:24, Dave Martin via Libc-alpha wrote:
> > Unrolling this discussion a bit, this problem comes from a few sources:
> > 
> > 1) systemd is trying to implement a policy that doesn't fit SECCOMP
> > syscall filtering very well.
> > 
> > 2) The program is trying to do something not expressible through the
> > syscall interface: really the intent is to set PROT_BTI on the page,
> > with no intent to set PROT_EXEC on any page that didn't already have it
> > set.
> > 
> > 
> > This limitation of mprotect() was known when I originally added PROT_BTI,
> > but at that time we weren't aware of a clear use case that would fail.
> > 
> > 
> > Would it now help to add something like:
> > 
> > int mchangeprot(void *addr, size_t len, int old_flags, int new_flags)
> > {
> > 	int ret = -EINVAL;
> > 	mmap_write_lock(current->mm);
> > 	if (all vmas in [addr .. addr + len) have
> > 			their mprotect flags set to old_flags) {
> > 
> > 		ret = mprotect(addr, len, new_flags);
> > 	}
> > 	
> > 	mmap_write_unlock(current->mm);
> > 	return ret;
> > }
> 
> if more prot flags are introduced then the exact
> match for old_flags may be restrictive and currently
> there is no way to query these flags to figure out
> how to toggle one prot flag in a future proof way,
> so i don't think this solves the issue completely.

Ack -- I illustrated this model because it makes the seccomp filter's
job easy, but it does have limitations.

> i think we might need a new api, given that aarch64
> now has PROT_BTI and PROT_MTE while existing code
> expects RWX only, but i don't know what api is best.

An alternative option would be a call that sets / clears chosen
flags and leaves others unchanged.

The trouble with that is that the MDWX policy then becomes hard to
implement again.


But policies might be best set via another route, such as a prctl,
rather than being implemented completely in a seccomp filter.

Cheers
---Dave
