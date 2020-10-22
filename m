Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B38295BD3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 11:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895985AbgJVJbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 05:31:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:53288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2509974AbgJVJbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 05:31:13 -0400
Received: from gaia (unknown [95.145.162.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1281222E9;
        Thu, 22 Oct 2020 09:31:07 +0000 (UTC)
Date:   Thu, 22 Oct 2020 10:31:05 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Lennart Poettering <mzxreary@0pointer.de>
Cc:     Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Topi Miettinen <toiwoton@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        systemd-devel@lists.freedesktop.org,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, libc-alpha@sourceware.org,
        Dave Martin <dave.martin@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [systemd-devel] BTI interaction between seccomp filters in
 systemd and glibc mprotect calls, causing service failures
Message-ID: <20201022093104.GB1229@gaia>
References: <8584c14f-5c28-9d70-c054-7c78127d84ea@arm.com>
 <20201022071812.GA324655@gardel-login>
 <87sga6snjn.fsf@oldenburg2.str.redhat.com>
 <511318fd-efde-f2fc-9159-9d16ac8d33a7@gmail.com>
 <20201022082912.GQ3819@arm.com>
 <20201022083823.GA324825@gardel-login>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022083823.GA324825@gardel-login>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 10:38:23AM +0200, Lennart Poettering wrote:
> On Do, 22.10.20 09:29, Szabolcs Nagy (szabolcs.nagy@arm.com) wrote:
> > > > The dynamic loader has to process the LOAD segments to get to the ELF
> > > > note that says to enable BTI.  Maybe we could do a first pass and load
> > > > only the segments that cover notes.  But that requires lots of changes
> > > > to generic code in the loader.
> > >
> > > What if the loader always enabled BTI for PROT_EXEC pages, but then when
> > > discovering that this was a mistake, mprotect() the pages without BTI? Then
> > > both BTI and MDWX would work and the penalty of not getting MDWX would fall
> > > to non-BTI programs. What's the expected proportion of BTI enabled code vs.
> > > disabled in the future, is it perhaps expected that a distro would enable
> > > the flag globally so eventually only a few legacy programs might be
> > > unprotected?
> >
> > i thought mprotect(PROT_EXEC) would get filtered
> > with or without bti, is that not the case?
> 
> We can adjust the filter in systemd to match any combination of
> flags to allow and to deny.

Yes but Szabolcs' point to Topi was that if we can adjust the filters to
allow mprotect(PROT_EXEC), why not allow mprotect(PROT_EXEC|PROT_BTI)
instead? Anyway, I see the MDWX and BTI as complementary policies so
ideally we shouldn't have to choose between one or the other. If we
allow mprotect(PROT_EXEC), that would override MDWX and also disable
BTI.

IIUC, the problem is with the main executable which is mapped by the
kernel without PROT_BTI. The dynamic loader wants to set PROT_BTI but
does not have the original file descriptor to be able to remap. Its only
choice is mprotect() and this fails because of the MDWX policy.

Not sure whether the kernel has the right information but could it map
the main executable with PROT_BTI if the corresponding PT_GNU_PROPERTY
is found? The current ABI states it only sets PROT_BTI for the
interpreter who'd be responsible for setting the PROT_BTI on the main
executable. I can't tell whether it would break anything but it's worth
a try:

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 4784011cecac..0a08fb9133e8 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -730,14 +730,6 @@ asmlinkage void __sched arm64_preempt_schedule_irq(void)
 int arch_elf_adjust_prot(int prot, const struct arch_elf_state *state,
 			 bool has_interp, bool is_interp)
 {
-	/*
-	 * For dynamically linked executables the interpreter is
-	 * responsible for setting PROT_BTI on everything except
-	 * itself.
-	 */
-	if (is_interp != has_interp)
-		return prot;
-
 	if (!(state->flags & ARM64_ELF_BTI))
 		return prot;
 

-- 
Catalin
