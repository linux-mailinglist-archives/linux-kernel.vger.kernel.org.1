Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9D3280DF9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 09:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgJBHTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 03:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgJBHTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 03:19:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5BCC0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 00:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=el05iBOvvAKgW6xE76yNMCqcJVx4BgYAQ4+5UZBzQoU=; b=YFe3SRHqZ5AeWzPZyrEVPxFfgz
        qKJcpDdtnyVUQoJkveclxgZJus/iHbRW6lUXKFelycIIgsm+6WhVBeyS9x/b3NIO5JtB7zMaEb+RH
        paQTeXkLLTnN/dyQMpqFwbhtkA2om6wtgF6GqkYE75Z6oSdPqiDwxzKcWu9xxqdHCGnCerIAstE/g
        D8FHfMogzoTGxv/Nnf2gwqWWLugAfaigkZ6aVjZ3xeBUdpdf/7h6P0jxNwFlGKOa2jw10WMmqpxUk
        +buZuENH4x3lyDu47IKUCDCXlLFu/VvM7VLny+awvc0w1v7feZWaMKGk1X6us4b0cTuv1Q5b/kzCx
        Oj6g1fpA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOFLA-0000mt-3O; Fri, 02 Oct 2020 07:18:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 52392304B92;
        Fri,  2 Oct 2020 09:18:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F1A4C2038FB7D; Fri,  2 Oct 2020 09:18:48 +0200 (CEST)
Date:   Fri, 2 Oct 2020 09:18:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH v2] tracepoint: Fix out of sync data passing by static
 caller
Message-ID: <20201002071848.GS2628@hirez.programming.kicks-ass.net>
References: <20201001212757.339a5520@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001212757.339a5520@oasis.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 09:27:57PM -0400, Steven Rostedt wrote:
> From: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> Naresh reported a bug discovered in linux-next that I can reliably
> trigger myself. It appears to be a side effect of the static calls. It
> happens when going from more than one tracepoint callback to a single
> one, and removing the first callback on the list. The list of
> tracepoint callbacks holds data and a function to call with the
> parameters of that tracepoint and a handler to the associated data.
> 
>  old_list:
> 	0: func = foo; data = NULL;
> 	1: func = bar; data = &bar_struct;
> 
>  new_list:
> 	0: func = bar; data = &bar_struct;
> 
> 
> 	CPU 0				CPU 1
> 	-----				-----
>    tp_funcs = old_list;
>    tp_static_caller = tp_interator
> 
>    __DO_TRACE()
>  
>     data = tp_funcs[0].data = NULL;
> 
> 				   tp_funcs = new_list;
> 				   tracepoint_update_call()
> 				      tp_static_caller = tp_funcs[0] = bar;
>     tp_static_caller(data)
>        bar(data)
>          x = data->item = NULL->item
> 
>        BOOM!

> To solve this, add a tracepoint_synchronize_unregister() between
> changing tp_funcs and updating the static tracepoint, that does both a
> synchronize_rcu() and synchronize_srcu(). This will ensure that when
> the static call is updated to the single callback that it will be
> receiving the data that it registered with.

> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Fixes: d25e37d89dd2f ("tracepoint: Optimize using static_call()")
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---

Urgh :/

I'll go stick this in tip/core/static_call.

> diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> index 1b4be44d1d2b..3f659f855074 100644
> --- a/kernel/tracepoint.c
> +++ b/kernel/tracepoint.c
> @@ -221,7 +221,7 @@ static void *func_remove(struct tracepoint_func **funcs,
>  	return old;
>  }
>  
> -static void tracepoint_update_call(struct tracepoint *tp, struct tracepoint_func *tp_funcs)
> +static void tracepoint_update_call(struct tracepoint *tp, struct tracepoint_func *tp_funcs, bool sync)
>  {
>  	void *func = tp->iterator;
>  
> @@ -229,8 +229,17 @@ static void tracepoint_update_call(struct tracepoint *tp, struct tracepoint_func
>  	if (!tp->static_call_key)
>  		return;
>  
> -	if (!tp_funcs[1].func)
> +	if (!tp_funcs[1].func) {
>  		func = tp_funcs[0].func;
> +		/*
> +		 * If going from the iterator back to a single caller,
> +		 * we need to synchronize with __DO_TRACE to make sure
> +		 * that the data passed to the callback is the one that
> +		 * belongs to that callback.
> +		 */
> +		if (sync)
> +			tracepoint_synchronize_unregister();
> +	}
>  
>  	__static_call_update(tp->static_call_key, tp->static_call_tramp, func);
>  }
> @@ -265,7 +274,7 @@ static int tracepoint_add_func(struct tracepoint *tp,
>  	 * include/linux/tracepoint.h using rcu_dereference_sched().
>  	 */
>  	rcu_assign_pointer(tp->funcs, tp_funcs);
> -	tracepoint_update_call(tp, tp_funcs);
> +	tracepoint_update_call(tp, tp_funcs, false);
>  	static_key_enable(&tp->key);
>  
>  	release_probes(old);
> @@ -297,11 +306,12 @@ static int tracepoint_remove_func(struct tracepoint *tp,
>  			tp->unregfunc();
>  
>  		static_key_disable(&tp->key);
> +		rcu_assign_pointer(tp->funcs, tp_funcs);
>  	} else {
> -		tracepoint_update_call(tp, tp_funcs);
> +		rcu_assign_pointer(tp->funcs, tp_funcs);
> +		tracepoint_update_call(tp, tp_funcs,
> +				       tp_funcs[0].func != old[0].func);
>  	}
> -
> -	rcu_assign_pointer(tp->funcs, tp_funcs);
>  	release_probes(old);
>  	return 0;
>  }
