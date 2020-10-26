Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7203429924F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1785811AbgJZQYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:24:18 -0400
Received: from foss.arm.com ([217.140.110.172]:44116 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1775757AbgJZQYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:24:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCF4411FB;
        Mon, 26 Oct 2020 09:24:15 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 62F2E3F719;
        Mon, 26 Oct 2020 09:24:14 -0700 (PDT)
Date:   Mon, 26 Oct 2020 16:24:11 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, libc-alpha@sourceware.org,
        systemd-devel@lists.freedesktop.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Brown <broonie@kernel.org>, toiwoton@gmail.com
Subject: Re: BTI interaction between seccomp filters in systemd and glibc
 mprotect calls, causing service failures
Message-ID: <20201026162410.GB27285@arm.com>
References: <8584c14f-5c28-9d70-c054-7c78127d84ea@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8584c14f-5c28-9d70-c054-7c78127d84ea@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 10:44:46PM -0500, Jeremy Linton via Libc-alpha wrote:
> Hi,
> 
> There is a problem with glibc+systemd on BTI enabled systems. Systemd
> has a service flag "MemoryDenyWriteExecute" which uses seccomp to deny
> PROT_EXEC changes. Glibc enables BTI only on segments which are marked as
> being BTI compatible by calling mprotect PROT_EXEC|PROT_BTI. That call is
> caught by the seccomp filter, resulting in service failures.
> 
> So, at the moment one has to pick either denying PROT_EXEC changes, or BTI.
> This is obviously not desirable.
> 
> Various changes have been suggested, replacing the mprotect with mmap calls
> having PROT_BTI set on the original mapping, re-mmapping the segments,
> implying PROT_EXEC on mprotect PROT_BTI calls when VM_EXEC is already set,
> and various modification to seccomp to allow particular mprotect cases to
> bypass the filters. In each case there seems to be an undesirable attribute
> to the solution.
> 
> So, whats the best solution?

Unrolling this discussion a bit, this problem comes from a few sources:

1) systemd is trying to implement a policy that doesn't fit SECCOMP
syscall filtering very well.

2) The program is trying to do something not expressible through the
syscall interface: really the intent is to set PROT_BTI on the page,
with no intent to set PROT_EXEC on any page that didn't already have it
set.


This limitation of mprotect() was known when I originally added PROT_BTI,
but at that time we weren't aware of a clear use case that would fail.


Would it now help to add something like:

int mchangeprot(void *addr, size_t len, int old_flags, int new_flags)
{
	int ret = -EINVAL;
	mmap_write_lock(current->mm);
	if (all vmas in [addr .. addr + len) have
			their mprotect flags set to old_flags) {

		ret = mprotect(addr, len, new_flags);
	}
	
	mmap_write_unlock(current->mm);
	return ret;
}


libc would now be able to do

	mchangeprot(addr, len, PROT_EXEC | PROT_READ,
		PROT_EXEC | PROT_READ | PROT_BTI);

while systemd's MDWX filter would reject the call if

	(new_flags & PROT_EXEC) &&
		(!(old_flags & PROT_EXEC) || (new_flags & PROT_WRITE)



This won't magically fix current code, but something along these lines
might be better going forward.


Thoughts?

---Dave
