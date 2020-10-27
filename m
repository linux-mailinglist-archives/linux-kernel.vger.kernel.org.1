Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF94729AC09
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 13:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899834AbgJ0M2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 08:28:50 -0400
Received: from casper.infradead.org ([90.155.50.34]:39922 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2899714AbgJ0M2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 08:28:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XTAQQlA0WbRz5jiSk+bpjBrWCi9CcQ1Kg+3G/82T1os=; b=PAZCCQ/7JM0U/OQgGDz25uELuv
        4XQkVFPCCaNOP5+kr4ZTu4QrBAhbCu9e/aSKbES9FQtiPU2KGRCKUFBdtZ71ll6ilmzhk6ux8xT1K
        3PT/G5v9oiGSXobrbv1grQ2hTUhve+l0EzAICSi9kZV9iZhLjlWit228+laN8xWODFmh/BMz5NPEE
        jKwmt23aVQa6EUH5l53N6ZjMewu/iZQp6KaiSmstA85nTNqFyFZkvq+qmz3CUtWrzrUEQFgvEVdAw
        DknLn/+2/Oc0x7/tw4QKndPSL3yuNEnWGxkl8Uf9IMDBZmXuy960/8XY0UmcLhR7h61CBBpoQHTDm
        wDp7UExw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXO5h-0000nK-JJ; Tue, 27 Oct 2020 12:28:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2760B3006D0;
        Tue, 27 Oct 2020 13:28:41 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 13F6F2B851A29; Tue, 27 Oct 2020 13:28:41 +0100 (CET)
Date:   Tue, 27 Oct 2020 13:28:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@suse.de>,
        Frederic Weisbecker <fweisbecker@suse.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC PATCH v2 0/5] allow overriding default preempt mode from
 command line
Message-ID: <20201027122841.GK2628@hirez.programming.kicks-ass.net>
References: <20201009122926.29962-1-mhocko@kernel.org>
 <20201009174554.GS2611@hirez.programming.kicks-ass.net>
 <20201027122241.GA140902@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027122241.GA140902@lothringen>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 01:22:41PM +0100, Frederic Weisbecker wrote:
> On Fri, Oct 09, 2020 at 07:45:54PM +0200, Peter Zijlstra wrote:
> > +DEFINE_STATIC_KEY_TRUE(irq_preemption_key);
> > +
> > +/*
> > + * SC:cond_resched
> > + * SC:might_resched
> > + * SC:preempt_schedule
> > + * SC:preempt_schedule_notrace
> > + * SB:irq_preemption_key
> > + *
> > + *
> > + * ZERO
> > + *   cond_resched             <- RET0
> > + *   might_resched            <- NOP
> > + *   preempt_schedule         <- NOP
> > + *   preempt_schedule_notrace <- NOP
> > + *   irq_preemption_key       <- false
> > + *
> > + * NONE:
> > + *   cond_resched             <- __cond_resched
> > + *   might_resched            <- NOP
> > + *   preempt_schedule         <- NOP
> > + *   preempt_schedule_notrace <- NOP
> > + *   irq_preemption_key       <- false
> > + *
> > + * VOLUNTARY:
> > + *   cond_resched             <- __cond_resched
> > + *   might_resched            <- __might_resched
> > + *   preempt_schedule         <- NOP
> > + *   preempt_schedule_notrace <- NOP
> > + *   irq_preemption_key       <- false
> > + *
> > + * FULL:
> > + *   cond_resched             <- RET0
> > + *   might_resched            <- NOP
> > + *   preempt_schedule         <- preempt_schedule
> > + *   preempt_schedule_notrace <- preempt_schedule_notrace
> > + *   irq_preemption_key       <- true
> > + */
> 
> That's cute! I'll try to end up to that result.

Beware, ZERO is 'broken', I included it because I was curious what, if
anything, would happen :-)

> > +static int __init setup_preempt_mode(char *str)
> > +{
> > +	if (!strcmp(str, "zero")) {
> > +		static_call_update(cond_resched, __static_call_return0);
> > +		static_call_update(might_resched, (void (*)(void))NULL);
> > +		static_call_update(preempt_schedule, (void (*)(void))NULL);
> > +		static_call_update(preempt_schedule_notrace, (void (*)(void))NULL);
> > +		static_branch_disable(&irq_preemption_key);
> > +		printk("XXX PREEMPT: %s\n", str);
> > +	} else if (!strcmp(str, "none")) {
> > +		static_call_update(cond_resched, __cond_resched);
> > +		static_call_update(might_resched, (void (*)(void))NULL);
> > +		static_call_update(preempt_schedule, (void (*)(void))NULL);
> > +		static_call_update(preempt_schedule_notrace, (void (*)(void))NULL);
> > +		static_branch_disable(&irq_preemption_key);
> > +		printk("XXX PREEMPT: %s\n", str);
> > +	} else if (!strcmp(str, "voluntary")) {
> > +		static_call_update(cond_resched, __cond_resched);
> > +		static_call_update(might_resched, __might_resched);
> > +		static_call_update(preempt_schedule, (void (*)(void))NULL);
> > +		static_call_update(preempt_schedule_notrace, (void (*)(void))NULL);
> > +		static_branch_disable(&irq_preemption_key);
> > +		printk("XXX PREEMPT: %s\n", str);
> > +	} else if (!strcmp(str, "ponies")) {
> > +		static_call_update(cond_resched, __cond_resched);
> > +		static_call_update(might_resched, (void (*)(void))NULL);
> > +		static_call_update(preempt_schedule, preempt_schedule_thunk);
> > +		static_call_update(preempt_schedule_notrace, preempt_schedule_notrace_thunk);
> > +		static_branch_enable(&irq_preemption_key);
> > +		printk("XXX PREEMPT: %s\n", str);
> 
> Why would we need that ponies version?

We don't, but it was a missing combination (like ZERO), and I wanted to
test it worked (as expected, it does).

We'll only encounter it as an intermediate state when flipping states at
runtime, but unlike zero, it should work just fine.
