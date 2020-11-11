Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F992AF3A0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 15:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgKKOc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 09:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgKKOc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 09:32:27 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A831C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 06:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TtCOeNfbgyHwaJMtNOuyf1yYRBxmDFdk4H1h/0tq1mc=; b=fT24rdha+MjBwGsRfXVOMJ9For
        ubSu7UxjKQp9j3ik1tVzsOrOXL5GgPSRIXz9y5S702YU4Al7SLZKnaEgMTq4GPWqjT29OHGe0jMik
        bsAslQdCz6xWgKanm02h+0T37cWAG9b8mrLqA9ZNESn37uerGttkGw+q0vqu+Y5ngSmQuASnNyOnT
        YXrIFse1pktx5U66VUfIqdTZR2+45S8ec6QzObs280vFZUfxvDBAD27dxQ7QPkLAUnm8ZeYJmU0A4
        oyxfF80Hnivf58s9JraxihJsXNUis7pXolXsqSEsOe+31mAKinez+atjqxQpSC1F5I5YuPvc8pyHn
        TqFdiyzA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcrAb-0007Ei-7T; Wed, 11 Nov 2020 14:32:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A6408304D58;
        Wed, 11 Nov 2020 15:32:18 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 891152BDF96A2; Wed, 11 Nov 2020 15:32:18 +0100 (CET)
Date:   Wed, 11 Nov 2020 15:32:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 2/5] context_tracking:  Don't implement
 exception_enter/exit() on CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK
Message-ID: <20201111143218.GU2611@hirez.programming.kicks-ass.net>
References: <20201027150827.148821-1-frederic@kernel.org>
 <20201027150827.148821-3-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027150827.148821-3-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 04:08:24PM +0100, Frederic Weisbecker wrote:
> An architecture that provides this Kconfig feature doesn't need to
> store the context tracking state on the task stack because its entry
> code has been sanitized such that fragile path aren't preemptible
> and special use of tracing and RCU read side critical sections in these
> areas have been explicitly annotated.
> 
> Hence the exception_enter()/exception_exit() couple doesn't need to be
> implemented in this case.

Could you please explain what exception_{enter,exit}() actually do, then
explain what is required to make it superfluous? Because as is, I don't
have enough information to verify the claims made.

> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Marcelo Tosatti <mtosatti@redhat.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Phil Auld <pauld@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/linux/context_tracking.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
> index d53cd331c4dd..bceb06498521 100644
> --- a/include/linux/context_tracking.h
> +++ b/include/linux/context_tracking.h
> @@ -51,7 +51,8 @@ static inline enum ctx_state exception_enter(void)
>  {
>  	enum ctx_state prev_ctx;
>  
> -	if (!context_tracking_enabled())
> +	if (IS_ENABLED(CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK) ||
> +	    !context_tracking_enabled())
>  		return 0;
>  
>  	prev_ctx = this_cpu_read(context_tracking.state);
> @@ -63,7 +64,8 @@ static inline enum ctx_state exception_enter(void)
>  
>  static inline void exception_exit(enum ctx_state prev_ctx)
>  {
> -	if (context_tracking_enabled()) {
> +	if (!IS_ENABLED(CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK) &&
> +	    context_tracking_enabled()) {
>  		if (prev_ctx != CONTEXT_KERNEL)
>  			context_tracking_enter(prev_ctx);
>  	}
> -- 
> 2.25.1
> 
