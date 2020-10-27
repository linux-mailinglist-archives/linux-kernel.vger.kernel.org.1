Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B03129ABFB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 13:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751273AbgJ0MWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 08:22:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:39232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750915AbgJ0MWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 08:22:45 -0400
Received: from localhost (i16-lef01-ix2-212-195-25-126.ft.lns.abo.bbox.fr [212.195.25.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03601218AC;
        Tue, 27 Oct 2020 12:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603801364;
        bh=Q5FbWv+W8QbPaNeXDWZaFyh4QTMfeQUS6T0xUbSD2Rw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n6WLyEqz+t0pUmuorI1HA4q5K3WArPR8j1+K7YcGQlh7eH3xP8vt4dBTLTp/aehll
         R8xE6PPp3SIevyKbwH8rQVX18hJuCBIW+0bf4PasI4aDISwZJ463iZH2RHkKGjckLb
         rDY3LcocXXV+2Y6EyCXX3bnbPQN2FUD4qffQZeKs=
Date:   Tue, 27 Oct 2020 13:22:41 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20201027122241.GA140902@lothringen>
References: <20201009122926.29962-1-mhocko@kernel.org>
 <20201009174554.GS2611@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009174554.GS2611@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 07:45:54PM +0200, Peter Zijlstra wrote:
> +DEFINE_STATIC_KEY_TRUE(irq_preemption_key);
> +
> +/*
> + * SC:cond_resched
> + * SC:might_resched
> + * SC:preempt_schedule
> + * SC:preempt_schedule_notrace
> + * SB:irq_preemption_key
> + *
> + *
> + * ZERO
> + *   cond_resched             <- RET0
> + *   might_resched            <- NOP
> + *   preempt_schedule         <- NOP
> + *   preempt_schedule_notrace <- NOP
> + *   irq_preemption_key       <- false
> + *
> + * NONE:
> + *   cond_resched             <- __cond_resched
> + *   might_resched            <- NOP
> + *   preempt_schedule         <- NOP
> + *   preempt_schedule_notrace <- NOP
> + *   irq_preemption_key       <- false
> + *
> + * VOLUNTARY:
> + *   cond_resched             <- __cond_resched
> + *   might_resched            <- __might_resched
> + *   preempt_schedule         <- NOP
> + *   preempt_schedule_notrace <- NOP
> + *   irq_preemption_key       <- false
> + *
> + * FULL:
> + *   cond_resched             <- RET0
> + *   might_resched            <- NOP
> + *   preempt_schedule         <- preempt_schedule
> + *   preempt_schedule_notrace <- preempt_schedule_notrace
> + *   irq_preemption_key       <- true
> + */

That's cute! I'll try to end up to that result.

> +static int __init setup_preempt_mode(char *str)
> +{
> +	if (!strcmp(str, "zero")) {
> +		static_call_update(cond_resched, __static_call_return0);
> +		static_call_update(might_resched, (void (*)(void))NULL);
> +		static_call_update(preempt_schedule, (void (*)(void))NULL);
> +		static_call_update(preempt_schedule_notrace, (void (*)(void))NULL);
> +		static_branch_disable(&irq_preemption_key);
> +		printk("XXX PREEMPT: %s\n", str);
> +	} else if (!strcmp(str, "none")) {
> +		static_call_update(cond_resched, __cond_resched);
> +		static_call_update(might_resched, (void (*)(void))NULL);
> +		static_call_update(preempt_schedule, (void (*)(void))NULL);
> +		static_call_update(preempt_schedule_notrace, (void (*)(void))NULL);
> +		static_branch_disable(&irq_preemption_key);
> +		printk("XXX PREEMPT: %s\n", str);
> +	} else if (!strcmp(str, "voluntary")) {
> +		static_call_update(cond_resched, __cond_resched);
> +		static_call_update(might_resched, __might_resched);
> +		static_call_update(preempt_schedule, (void (*)(void))NULL);
> +		static_call_update(preempt_schedule_notrace, (void (*)(void))NULL);
> +		static_branch_disable(&irq_preemption_key);
> +		printk("XXX PREEMPT: %s\n", str);
> +	} else if (!strcmp(str, "ponies")) {
> +		static_call_update(cond_resched, __cond_resched);
> +		static_call_update(might_resched, (void (*)(void))NULL);
> +		static_call_update(preempt_schedule, preempt_schedule_thunk);
> +		static_call_update(preempt_schedule_notrace, preempt_schedule_notrace_thunk);
> +		static_branch_enable(&irq_preemption_key);
> +		printk("XXX PREEMPT: %s\n", str);

Why would we need that ponies version?

Thanks!
