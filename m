Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64FB82AD3D5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 11:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgKJKc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 05:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgKJKc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 05:32:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114F0C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 02:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+G6fBuOtqU1HeW2LUnaWWIVJQ66Ans4eFj5Ogkmq5iU=; b=BveCPG62vHuYOcMHfljitt++Zi
        fZGg7VimGetaAcse2kTNpx51om8/iUsMiBDNDJCEDzOOEkr3Cs9i+0KDxhqLIMmSfrzEKJTYXZ28w
        wS711PWXRP6CrCkaJc0edo+3/mJRe0HPL2UnXISYQmPYBeFnS+fQuAzfuvHor1TvNAqL8r5IIv7RB
        HEADBBWhilvyI2BqXBGsYY5U+4taLkSMV/MH4c6W7qUlmaGj8uRdhiHED30sogetyOSt7vxRy0YkX
        NYtdbxf0y3evIJmtD03tXtTIH0vc/gL5Ku1FoQjkaLKEALusm9LOY8TnCTlNy1WeeDpn7TWuybJeN
        ee6E0naA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcQwp-00062p-4k; Tue, 10 Nov 2020 10:32:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 26AA13006E0;
        Tue, 10 Nov 2020 11:32:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0FBC12BD3DF71; Tue, 10 Nov 2020 11:32:22 +0100 (CET)
Date:   Tue, 10 Nov 2020 11:32:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH 6/7] preempt/dynamic: Provide
 irqentry_exit_cond_resched() static call
Message-ID: <20201110103221.GC2594@hirez.programming.kicks-ass.net>
References: <20201110005609.40989-1-frederic@kernel.org>
 <20201110005609.40989-7-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110005609.40989-7-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 01:56:08AM +0100, Frederic Weisbecker wrote:
> [convert from static key to static call, only define static call when
> PREEMPT_DYNAMIC]

>  noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
>  {
> @@ -383,8 +386,13 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
>  		}
>  
>  		instrumentation_begin();
> -		if (IS_ENABLED(CONFIG_PREEMPTION))
> +		if (IS_ENABLED(CONFIG_PREEMPTION)) {
> +#ifdef CONFIG_PREEMT_DYNAMIC
> +			static_call(irqentry_exit_cond_resched)();
> +#else
>  			irqentry_exit_cond_resched();
> +#endif
> +		}
>  		/* Covers both tracing and lockdep */
>  		trace_hardirqs_on();
>  		instrumentation_end();

The reason I had this a static_branch() is that because if you look at
the code-gen of this function, you'll find it will inline the call.

Not sure it matters much, but it avoids a CALL+RET.
