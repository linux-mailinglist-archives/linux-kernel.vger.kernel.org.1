Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4186029B0C1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 15:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758735AbgJ0OXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 10:23:14 -0400
Received: from foss.arm.com ([217.140.110.172]:41606 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758711AbgJ0OWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 10:22:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D98BC13D5;
        Tue, 27 Oct 2020 07:22:23 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 542CD3F719;
        Tue, 27 Oct 2020 07:22:22 -0700 (PDT)
Date:   Tue, 27 Oct 2020 14:22:19 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Dave Martin via Libc-alpha <libc-alpha@sourceware.org>,
        Mark Rutland <mark.rutland@arm.com>,
        systemd-devel@lists.freedesktop.org,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Mark Brown <broonie@kernel.org>, toiwoton@gmail.com,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: BTI interaction between seccomp filters in systemd and glibc
 mprotect calls, causing service failures
Message-ID: <20201027142218.GE27285@arm.com>
References: <8584c14f-5c28-9d70-c054-7c78127d84ea@arm.com>
 <20201026162410.GB27285@arm.com>
 <87r1pl9brd.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1pl9brd.fsf@oldenburg2.str.redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 05:45:42PM +0100, Florian Weimer via Libc-alpha wrote:
> * Dave Martin via Libc-alpha:
> 
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
> I suggested something similar as well.  Ideally, the interface would
> subsume pkey_mprotect, though, and have a separate flags argument from
> the protection flags.  But then we run into argument list length limits.
>
> Thanks,
> Florian

I suppose.  Assuming that a syscall filter can inspect memory, we might
be able to bundle arguments into a struct if necessary.

[...]

Cheers
---Dave
