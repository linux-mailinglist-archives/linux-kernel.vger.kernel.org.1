Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103F829E9E1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 12:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgJ2LCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 07:02:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:39330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbgJ2LCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 07:02:32 -0400
Received: from gaia (unknown [95.145.162.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0AB520735;
        Thu, 29 Oct 2020 11:02:24 +0000 (UTC)
Date:   Thu, 29 Oct 2020 11:02:22 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        systemd-devel@lists.freedesktop.org,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, toiwoton@gmail.com,
        libc-alpha@sourceware.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: BTI interaction between seccomp filters in systemd and glibc
 mprotect calls, causing service failures
Message-ID: <20201029110220.GC10776@gaia>
References: <8584c14f-5c28-9d70-c054-7c78127d84ea@arm.com>
 <20201026162410.GB27285@arm.com>
 <20201026165755.GV3819@arm.com>
 <20201026175230.GC27285@arm.com>
 <45c64b49-a38b-4b0c-d9cf-6c586dacbcc9@arm.com>
 <20201027141522.GD27285@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027141522.GD27285@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 02:15:22PM +0000, Dave P Martin wrote:
> I also wonder whether we actually care whether the pages are marked
> executable or not here; probably the flags can just be independent.  This
> rather depends on whether the how the architecture treats the BTI (a.k.a
> GP) pagetable bit for non-executable pages.  I have a feeling we already
> allow PROT_BTI && !PROT_EXEC through anyway.
> 
> 
> What about a generic-ish set/clear interface that still works by just
> adding a couple of PROT_ flags:
> 
> 	switch (flags & (PROT_SET | PROT_CLEAR)) {
> 	case PROT_SET: prot |= flags; break;
> 	case PROT_CLEAR: prot &= ~flags; break;
> 	case 0: prot = flags; break;
> 
> 	default:
> 		return -EINVAL;
> 	}
> 
> This can't atomically set some flags while clearing some others, but for
> simple stuff it seems sufficient and shouldn't be too invasive on the
> kernel side.
> 
> We will still have to take the mm lock when doing a SET or CLEAR, but
> not for the non-set/clear case.
> 
> 
> Anyway, libc could now do:
> 
> 	mprotect(addr, len, PROT_SET | PROT_BTI);
> 
> with much the same effect as your PROT_BTI_IF_X.
> 
> 
> JITting or breakpoint setting code that wants to change the permissions
> temporarily, without needing to know whether PROT_BTI is set, say:
> 
> 	mprotect(addr, len, PROT_SET | PROT_WRITE);
> 	*addr = BKPT_INSN;
> 	mprotect(addr, len, PROT_CLEAR | PROT_WRITE);

The problem with this approach is that you can't catch
PROT_EXEC|PROT_WRITE mappings via seccomp. So you'd have to limit it to
some harmless PROT_ flags only. I don't like this limitation, nor the
PROT_BTI_IF_X approach.

The only generic solutions I see are to either use a stateful filter in
systemd or pass the old state to the kernel in a cmpxchg style so that
seccomp can check it (I think you suggest this at some point).

The latter requires a new syscall which is not something we can address
as a quick, back-portable fix here. If systemd cannot be changed to use
a stateful filter for w^x detection, my suggestion is to go for the
kernel setting PROT_BTI on the main executable with glibc changed to
tolerate EPERM on mprotect(). I don't mind adding an AT_FLAGS bit if
needed but I don't think it buys us much.

Once the current problem is fixed, we can look at a better solution
longer term as a new syscall.

-- 
Catalin
