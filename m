Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBA32C0C7E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 14:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbgKWNzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 08:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729792AbgKWNzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 08:55:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A859FC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 05:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uUPaDYAemmJYHuwFkYYuuftPgDPHYdEdgPTzaW0nVXY=; b=Uqui2mMbeRyawJOPg5AAfYJY6W
        WltTLAk6IRy2Og9Slxu+Cr4Vk1RASFdKjY3/ME8jJHcZZTU6HVCBE3IEvOejVJpbhukorM2v+LyPq
        ukts4lnW+9laDJmhDRum9/tDkxbZ1EVfG7CeQfFvkMkCCDpEVYbWRbKLH/YolaMY64FxnifCGB0VI
        9HRi0aw3IG6YEiE8GlEtKiW3TtBQYxWulLtRoXsLzAmNRmuPkzHQ+U22HcYSF63STEyajcW1GzJvi
        33vYzdpAw9plvIYTsrlMZkNQJwXv57OTZmpR66DeWB2n1pqKieG+uVrU5h/Rh2wKTZoc6pKNVsrWu
        U/zMrRiQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khCJE-0006V8-Ss; Mon, 23 Nov 2020 13:55:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7BF013069B1;
        Mon, 23 Nov 2020 14:55:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5D477201D16D7; Mon, 23 Nov 2020 14:55:12 +0100 (CET)
Date:   Mon, 23 Nov 2020 14:55:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     paulmck@kernel.org, will@kernel.org, tglx@linutronix.de,
        mingo@kernel.org, mark.rutland@arm.com, boqun.feng@gmail.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kcsan: Avoid scheduler recursion by using
 non-instrumented preempt_{disable,enable}()
Message-ID: <20201123135512.GM3021@hirez.programming.kicks-ass.net>
References: <20201123132300.1759342-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123132300.1759342-1-elver@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 02:23:00PM +0100, Marco Elver wrote:
> When enabling KCSAN for kernel/sched (remove KCSAN_SANITIZE := n from
> kernel/sched/Makefile), with CONFIG_DEBUG_PREEMPT=y, we can observe
> recursion due to:
> 
> 	check_access() [via instrumentation]
> 	  kcsan_setup_watchpoint()
> 	    reset_kcsan_skip()
> 	      kcsan_prandom_u32_max()
> 	        get_cpu_var()
> 		  preempt_disable()
> 		    preempt_count_add() [in kernel/sched/core.c]
> 		      check_access() [via instrumentation]
> 
> Avoid this by rewriting kcsan_prandom_u32_max() to only use safe
> versions of preempt_disable() and preempt_enable() that do not call into
> scheduler code.
> 
> Note, while this currently does not affect an unmodified kernel, it'd be
> good to keep a KCSAN kernel working when KCSAN_SANITIZE := n is removed
> from kernel/sched/Makefile to permit testing scheduler code with KCSAN
> if desired.
> 
> Fixes: cd290ec24633 ("kcsan: Use tracing-safe version of prandom")
> Signed-off-by: Marco Elver <elver@google.com>
> ---
> v2:
> * Update comment to also point out preempt_enable().
> ---
>  kernel/kcsan/core.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> index 3994a217bde7..10513f3e2349 100644
> --- a/kernel/kcsan/core.c
> +++ b/kernel/kcsan/core.c
> @@ -284,10 +284,19 @@ should_watch(const volatile void *ptr, size_t size, int type, struct kcsan_ctx *
>   */
>  static u32 kcsan_prandom_u32_max(u32 ep_ro)
>  {
> -	struct rnd_state *state = &get_cpu_var(kcsan_rand_state);
> -	const u32 res = prandom_u32_state(state);
> +	struct rnd_state *state;
> +	u32 res;
> +
> +	/*
> +	 * Avoid recursion with scheduler by using non-tracing versions of
> +	 * preempt_disable() and preempt_enable() that do not call into
> +	 * scheduler code.
> +	 */
> +	preempt_disable_notrace();
> +	state = raw_cpu_ptr(&kcsan_rand_state);
> +	res = prandom_u32_state(state);
> +	preempt_enable_no_resched_notrace();

This is a preemption bug. Does preempt_enable_notrace() not work?

>  
> -	put_cpu_var(kcsan_rand_state);
>  	return (u32)(((u64) res * ep_ro) >> 32);
>  }
>  
> -- 
> 2.29.2.454.gaff20da3a2-goog
> 
