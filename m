Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5571DAF9B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 12:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgETKDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 06:03:40 -0400
Received: from foss.arm.com ([217.140.110.172]:51960 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgETKDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 06:03:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF56531B;
        Wed, 20 May 2020 03:03:39 -0700 (PDT)
Received: from bogus (unknown [10.37.12.114])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A71583F68F;
        Wed, 20 May 2020 03:03:37 -0700 (PDT)
Date:   Wed, 20 May 2020 11:03:30 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, oleg@redhat.com,
        Keno Fischer <keno@juliacomputing.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: Fix PTRACE_SYSEMU semantics
Message-ID: <20200520100330.GA25430@bogus>
References: <20200515222253.GA38408@juliacomputing.com>
 <20200518114119.GB32394@willie-the-truck>
 <20200519120725.GA20313@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519120725.GA20313@gaia>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

On Tue, May 19, 2020 at 01:07:27PM +0100, Catalin Marinas wrote:
> On Mon, May 18, 2020 at 12:41:20PM +0100, Will Deacon wrote:
> > On Fri, May 15, 2020 at 06:22:53PM -0400, Keno Fischer wrote:
> > > Quoth the man page:
> > > ```
> > >        If the tracee was restarted by PTRACE_SYSCALL or PTRACE_SYSEMU, the
> > >        tracee enters syscall-enter-stop just prior to entering any system
> > >        call (which will not be executed if the restart was using
> > >        PTRACE_SYSEMU, regardless of any change made to registers at this
> > >        point or how the tracee is restarted after this stop).
> > > ```
> > >
> > > The parenthetical comment is currently true on x86 and powerpc,
> > > but not currently true on arm64. arm64 re-checks the _TIF_SYSCALL_EMU
> > > flag after the syscall entry ptrace stop. However, at this point,
> > > it reflects which method was used to re-start the syscall
> > > at the entry stop, rather than the method that was used to reach it.
> > > Fix that by recording the original flag before performing the ptrace
> > > stop, bringing the behavior in line with documentation and x86/powerpc.
> > >
> > > Signed-off-by: Keno Fischer <keno@juliacomputing.com>
> > > ---
> > >  arch/arm64/kernel/ptrace.c | 8 +++++---
> > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> > > index b3d3005d9515..b67b4d14aa17 100644
> > > --- a/arch/arm64/kernel/ptrace.c
> > > +++ b/arch/arm64/kernel/ptrace.c
> > > @@ -1829,10 +1829,12 @@ static void tracehook_report_syscall(struct pt_regs *regs,
> > >
> > >  int syscall_trace_enter(struct pt_regs *regs)
> > >  {
> > > -	if (test_thread_flag(TIF_SYSCALL_TRACE) ||
> > > -		test_thread_flag(TIF_SYSCALL_EMU)) {
> > > +	u32 flags = READ_ONCE(current_thread_info()->flags) &
> > > +		(_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE);
> > > +
> > > +	if (flags) {
> >
> > nit: but I'd rather the '&' operation was in the conditional so that the
> > 'flags' variable holds all of the flags.
> >
> > With that:
> >
> > Acked-by: Will Deacon <will@kernel.org>
> >
> > Also needs:
> >
> > Cc: <stable@vger.kernel.org>
> > Fixes: f086f67485c5 ("arm64: ptrace: add support for syscall emulation")
> >
> > Catalin -- can you pick this up for 5.7 please, with my 'nit' addressed?
>
> I'll queue it with the above addressed. I think flags also needs to be
> unsigned long rather than u32.
>
> However, before sending the pull request, I'd like Sudeep to confirm
> that it doesn't break his original use-case for this feature.
>

I just tested it with my simple programs I had before. I have also asked
teams working on gvisor to test. They have tested it and see no
regression. I will ask them to reply here.

Tested-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
