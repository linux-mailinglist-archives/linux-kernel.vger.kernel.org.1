Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 188412AD7EC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 14:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730244AbgKJNpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 08:45:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:52442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbgKJNpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 08:45:06 -0500
Received: from localhost (unknown [176.177.120.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 671FB20731;
        Tue, 10 Nov 2020 13:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605015906;
        bh=oPXeABMP7i9R4jHhuiCy07IHgieCSj28tnLN/HIYQXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rET6opyncGZnHbHWGBVBr6LRixrJw5ioCcNsFz5GfvM4g/o9U6/ixmEKSrVom36xD
         uLvj1aOqGlAaAb/Qa37GjTqME6qv3IWZBYuf8ZTDdJeH+hPyQ3OIFbd3DEhLDN7TH0
         Yq26VYeYkafvCuFx/0nkeI0SkmE+9Q9O5l7xzq4k=
Date:   Tue, 10 Nov 2020 14:45:03 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH 6/7] preempt/dynamic: Provide
 irqentry_exit_cond_resched() static call
Message-ID: <20201110134503.GC48886@lothringen>
References: <20201110005609.40989-1-frederic@kernel.org>
 <20201110005609.40989-7-frederic@kernel.org>
 <20201110103221.GC2594@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110103221.GC2594@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 11:32:21AM +0100, Peter Zijlstra wrote:
> On Tue, Nov 10, 2020 at 01:56:08AM +0100, Frederic Weisbecker wrote:
> > [convert from static key to static call, only define static call when
> > PREEMPT_DYNAMIC]
> 
> >  noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
> >  {
> > @@ -383,8 +386,13 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
> >  		}
> >  
> >  		instrumentation_begin();
> > -		if (IS_ENABLED(CONFIG_PREEMPTION))
> > +		if (IS_ENABLED(CONFIG_PREEMPTION)) {
> > +#ifdef CONFIG_PREEMT_DYNAMIC
> > +			static_call(irqentry_exit_cond_resched)();
> > +#else
> >  			irqentry_exit_cond_resched();
> > +#endif
> > +		}
> >  		/* Covers both tracing and lockdep */
> >  		trace_hardirqs_on();
> >  		instrumentation_end();
> 
> The reason I had this a static_branch() is that because if you look at
> the code-gen of this function, you'll find it will inline the call.
> 
> Not sure it matters much, but it avoids a CALL+RET.

I wouldn't mind turning it to a static key but that adds one more
requirement for the architectures that want this, namely proper
support for static key. Now probably architectures supporting
static call inline (for now only x86) will have proper static
key support as well. So this probably doesn't matter after all.

Thanks.
