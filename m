Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E5929DED2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731858AbgJ2A4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:56:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:60522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731624AbgJ1WRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:36 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FA4F24690;
        Wed, 28 Oct 2020 09:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603876832;
        bh=PtxDrfqt+WMwYqudTh7lCnycOZs+RJntD2Bu0nbEDcI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AFHBTDvjUn1/Ldgo8ZNM2CEBAOgbASwEWSF5fibbKtSMf/8hcEUXcVkLI7P07/T9K
         R+Qj6sgIgjhGoCVYFfnEP0XDsOmFDwuxoaK2MXvqbiRF7e+JwQ0zaRBIV/EZb7sGOU
         ftlp7Vs8vf8xQXy4abSmWZk00m4X9xyE7LlTj4x0=
Date:   Wed, 28 Oct 2020 18:20:25 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, luto@kernel.org, me@kylehuey.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, rocallahan@gmail.com,
        alexandre.chartre@oracle.com, paulmck@kernel.org,
        frederic@kernel.org, pbonzini@redhat.com,
        sean.j.christopherson@intel.com, mhiramat@kernel.org,
        pmladek@suse.com, joel@joelfernandes.org, rostedt@goodmis.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, brgerst@gmail.com,
        jpoimboe@redhat.com, daniel.thompson@linaro.org,
        julliard@winehq.org, pgofman@codeweavers.com
Subject: Re: [PATCH 1/3] x86/debug: Fix BTF handling
Message-Id: <20201028182025.4bb6d633719d7ce76300aafa@kernel.org>
In-Reply-To: <20201027194126.GR2628@hirez.programming.kicks-ass.net>
References: <20201027091504.712183781@infradead.org>
        <20201027093607.956147736@infradead.org>
        <20201027194126.GR2628@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Oct 2020 20:41:26 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Oct 27, 2020 at 10:15:05AM +0100, Peter Zijlstra wrote:
> 
> > @@ -873,6 +866,20 @@ static __always_inline void exc_debug_ke
> >  	 */
> >  	WARN_ON_ONCE(user_mode(regs));
> >  
> > +	if (test_thread_flag(TIF_BLOCKSTEP)) {
> > +		/*
> > +		 * The SDM says "The processor clears the BTF flag when it
> > +		 * generates a debug exception." but PTRACE_BLOCKSTEP requested
> > +		 * it for userspace, but we just took a kernel #DB, so re-set
> > +		 * BTF.
> > +		 */
> > +		unsigned long debugctl;
> > +
> > +		rdmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
> > +		debugctl |= DEBUGCTLMSR_BTF;
> > +		wrmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
> > +	}
> > +
> >  	/*
> >  	 * Catch SYSENTER with TF set and clear DR_STEP. If this hit a
> >  	 * watchpoint at the same time then that will still be handled.
> 
> Masami, how does BTF interact with !optimized kprobes that single-step?

Good question, BTF is cleared right before single-stepping and restored
after single-stepping. It will be done accoding to TIF_BLOCKSTEP bit as below.

(in arch/x86/kernel/kprobes/core.c)

static nokprobe_inline void clear_btf(void)
{
        if (test_thread_flag(TIF_BLOCKSTEP)) {
                unsigned long debugctl = get_debugctlmsr();

                debugctl &= ~DEBUGCTLMSR_BTF;
                update_debugctlmsr(debugctl);
        }
}

static nokprobe_inline void restore_btf(void)
{
        if (test_thread_flag(TIF_BLOCKSTEP)) {
                unsigned long debugctl = get_debugctlmsr();

                debugctl |= DEBUGCTLMSR_BTF;
                update_debugctlmsr(debugctl);
        }
}

Hrm, so it seems that we do same ... maybe we don't need clear_btf() too?

> 
> The best answer I can come up with is 'poorly' :/

Is this what you expected? :)

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
