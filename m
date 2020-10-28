Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65CEE29D38C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgJ1Vo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:44:58 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60020 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgJ1VoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:44:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xY3C1MfwWaVkJFZQ4gUxChwkBICC+P3nwJwtX8Z5mVY=; b=NuI0lJ3CvGoEGadyjRzNV1yd1R
        cadYSZ14mGo40AKLivhm4qUibkgYyx9YgiUjp0zCaMGjmbvvhAD2k6i2OpJLFoKp8nwMYTGtoMGEV
        I9TLnG89dYKOdA+y/aUU3+gT8wKA79figZGE9OqA19Aj5r7Yu7GB/84rEcGcIWfoZ2cgv3jXRsEPx
        yp8Xn74LBQ93K7TbT41EOJjz/LcDevQciU1LsRJRYO2ddyvTdkiH/netarZ+jaW/iKRtZRA9lE8gQ
        84UhMKnoPZQFjkpjHtKzEbIPIf5Yt8dTlrLe4RLKyK5SSWLvt6szswrA9JGVELkry+Vu25K6VXTC3
        pw08WOvA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXiEl-0001QZ-2d; Wed, 28 Oct 2020 09:59:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EE5A830018A;
        Wed, 28 Oct 2020 10:59:19 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CF6872C0B525A; Wed, 28 Oct 2020 10:59:19 +0100 (CET)
Date:   Wed, 28 Oct 2020 10:59:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     tglx@linutronix.de, luto@kernel.org, me@kylehuey.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, rocallahan@gmail.com,
        alexandre.chartre@oracle.com, paulmck@kernel.org,
        frederic@kernel.org, pbonzini@redhat.com,
        sean.j.christopherson@intel.com, pmladek@suse.com,
        joel@joelfernandes.org, rostedt@goodmis.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, brgerst@gmail.com,
        jpoimboe@redhat.com, daniel.thompson@linaro.org,
        julliard@winehq.org, pgofman@codeweavers.com
Subject: Re: [PATCH 1/3] x86/debug: Fix BTF handling
Message-ID: <20201028095919.GX2628@hirez.programming.kicks-ass.net>
References: <20201027091504.712183781@infradead.org>
 <20201027093607.956147736@infradead.org>
 <20201027194126.GR2628@hirez.programming.kicks-ass.net>
 <20201028182025.4bb6d633719d7ce76300aafa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028182025.4bb6d633719d7ce76300aafa@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 06:20:25PM +0900, Masami Hiramatsu wrote:
> On Tue, 27 Oct 2020 20:41:26 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Tue, Oct 27, 2020 at 10:15:05AM +0100, Peter Zijlstra wrote:
> > 
> > > @@ -873,6 +866,20 @@ static __always_inline void exc_debug_ke
> > >  	 */
> > >  	WARN_ON_ONCE(user_mode(regs));
> > >  
> > > +	if (test_thread_flag(TIF_BLOCKSTEP)) {
> > > +		/*
> > > +		 * The SDM says "The processor clears the BTF flag when it
> > > +		 * generates a debug exception." but PTRACE_BLOCKSTEP requested
> > > +		 * it for userspace, but we just took a kernel #DB, so re-set
> > > +		 * BTF.
> > > +		 */
> > > +		unsigned long debugctl;
> > > +
> > > +		rdmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
> > > +		debugctl |= DEBUGCTLMSR_BTF;
> > > +		wrmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
> > > +	}
> > > +
> > >  	/*
> > >  	 * Catch SYSENTER with TF set and clear DR_STEP. If this hit a
> > >  	 * watchpoint at the same time then that will still be handled.
> > 
> > Masami, how does BTF interact with !optimized kprobes that single-step?
> 
> Good question, BTF is cleared right before single-stepping and restored
> after single-stepping. It will be done accoding to TIF_BLOCKSTEP bit as below.
> 
> (in arch/x86/kernel/kprobes/core.c)
> 
> static nokprobe_inline void clear_btf(void)
> {
>         if (test_thread_flag(TIF_BLOCKSTEP)) {
>                 unsigned long debugctl = get_debugctlmsr();
> 
>                 debugctl &= ~DEBUGCTLMSR_BTF;
>                 update_debugctlmsr(debugctl);
>         }
> }
> 
> static nokprobe_inline void restore_btf(void)
> {
>         if (test_thread_flag(TIF_BLOCKSTEP)) {
>                 unsigned long debugctl = get_debugctlmsr();
> 
>                 debugctl |= DEBUGCTLMSR_BTF;
>                 update_debugctlmsr(debugctl);
>         }
> }
> 
> Hrm, so it seems that we do same ... maybe we don't need clear_btf() too?

No, I think you do very much need clear_btf(). But with my patch perhaps
restore_btf() is no longer needed. Is there only a single single-step
between setup_singlestep() and resume_execution() ? (I think so).

Also, I note that we should employ get_debugctlmsr() more consistently.

> > The best answer I can come up with is 'poorly' :/
> 
> Is this what you expected? :)

Nah, I missed the above, you seems to do the right thing.
