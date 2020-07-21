Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3522287F7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 20:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730240AbgGUSFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 14:05:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbgGUSFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 14:05:48 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 254D9206F5;
        Tue, 21 Jul 2020 18:05:47 +0000 (UTC)
Date:   Tue, 21 Jul 2020 14:05:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Oscar Carter <oscar.carter@gmx.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 2/2] kernel/trace: Remove function callback casts
Message-ID: <20200721140545.445f0258@oasis.local.home>
In-Reply-To: <20200719155033.24201-3-oscar.carter@gmx.com>
References: <20200719155033.24201-1-oscar.carter@gmx.com>
        <20200719155033.24201-3-oscar.carter@gmx.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jul 2020 17:50:33 +0200
Oscar Carter <oscar.carter@gmx.com> wrote:

> In an effort to enable -Wcast-function-type in the top-level Makefile to
> support Control Flow Integrity builds, there are the need to remove all
> the function callback casts.
> 
> ftrace_ops_list_func() can no longer be defined as ftrace_ops_no_ops().
> The reason for ftrace_ops_no_ops() is to use that when an architecture
> calls ftrace_ops_list_func() with only two parameters (called from
> assembly). And to make sure there's no C side-effects, those archs call
> ftrace_ops_no_ops() which only has two parameters, as the function
> ftrace_ops_list_func() has four parameters.
> 
> This patch removes the no longer needed function ftrace_ops_no_ops() and
> all the function callback casts using the previous defined ftrace_func
> union and the two function helpers called ftrace_set_ufunc() and
> ftrace_same_address_ufunc().

Ug, I think I prefer the linker trick better.

> 
> Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
> ---
>  kernel/trace/ftrace.c | 48 ++++++++++++++++++++++++++-----------------
>  1 file changed, 29 insertions(+), 19 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index fd8fbb422860..124ccf914657 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -143,9 +143,7 @@ static inline bool ftrace_same_address_ufunc(union ftrace_func *ufunc,
>  	return (ufunc->ops == func);
>  }
>  #else
> -/* See comment below, where ftrace_ops_list_func is defined */
> -static void ftrace_ops_no_ops(unsigned long ip, unsigned long parent_ip);
> -#define ftrace_ops_list_func ((ftrace_func_t)ftrace_ops_no_ops)
> +static void ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip);
> 
>  static inline void ftrace_set_ufunc(union ftrace_func *ufunc,
>  				    ftrace_func_no_ops_t func)
> @@ -198,22 +196,29 @@ static void ftrace_sync_ipi(void *data)
>  	smp_rmb();
>  }
> 
> -static ftrace_func_t ftrace_ops_get_list_func(struct ftrace_ops *ops)
> +static union ftrace_func ftrace_ops_get_list_func(struct ftrace_ops *ops)
>  {
> +	union ftrace_func list_func;
> +
>  	/*
>  	 * If this is a dynamic, RCU, or per CPU ops, or we force list func,
>  	 * then it needs to call the list anyway.
>  	 */
>  	if (ops->flags & (FTRACE_OPS_FL_DYNAMIC | FTRACE_OPS_FL_RCU) ||
>  	    FTRACE_FORCE_LIST_FUNC)
> -		return ftrace_ops_list_func;
> +		ftrace_set_ufunc(&list_func, ftrace_ops_list_func);
> +	else
> +		list_func.ops = ftrace_ops_get_func(ops);
> 
> -	return ftrace_ops_get_func(ops);
> +	return list_func;

Is this the same as returning a pointer? It makes me very nervous about
returning a union. Can a compiler return something allocated on the stack?

Also, don't use "ufunc" as that makes me think its a user space variable.



>  }
> 
>  static void update_ftrace_function(void)
>  {
> -	ftrace_func_t func;
> +	union ftrace_func func;
> +#ifndef CONFIG_DYNAMIC_FTRACE
> +	union ftrace_func tmp;
> +#endif
> 
>  	/*
>  	 * Prepare the ftrace_ops that the arch callback will use.
> @@ -225,7 +230,7 @@ static void update_ftrace_function(void)
> 
>  	/* If there's no ftrace_ops registered, just call the stub function */
>  	if (set_function_trace_op == &ftrace_list_end) {
> -		func = ftrace_stub;
> +		func.ops = ftrace_stub;
> 
>  	/*
>  	 * If we are at the end of the list and this ops is
> @@ -239,21 +244,21 @@ static void update_ftrace_function(void)
>  	} else {
>  		/* Just use the default ftrace_ops */
>  		set_function_trace_op = &ftrace_list_end;
> -		func = ftrace_ops_list_func;
> +		ftrace_set_ufunc(&func, ftrace_ops_list_func);
>  	}
> 
>  	update_function_graph_func();
> 
>  	/* If there's no change, then do nothing more here */
> -	if (ftrace_trace_function == func)
> +	if (ftrace_trace_function == func.ops)
>  		return;
> 
>  	/*
>  	 * If we are using the list function, it doesn't care
>  	 * about the function_trace_ops.
>  	 */
> -	if (func == ftrace_ops_list_func) {
> -		ftrace_trace_function = func;
> +	if (ftrace_same_address_ufunc(&func, ftrace_ops_list_func)) {
> +		ftrace_trace_function = func.ops;
>  		/*
>  		 * Don't even bother setting function_trace_ops,
>  		 * it would be racy to do so anyway.
> @@ -272,7 +277,9 @@ static void update_ftrace_function(void)
>  	 * function we want, albeit indirectly, but it handles the
>  	 * ftrace_ops and doesn't depend on function_trace_op.
>  	 */
> -	ftrace_trace_function = ftrace_ops_list_func;
> +	ftrace_set_ufunc(&tmp, ftrace_ops_list_func);
> +	ftrace_trace_function = tmp.ops;
> +
>  	/*
>  	 * Make sure all CPUs see this. Yes this is slow, but static
>  	 * tracing is slow and nasty to have enabled.
> @@ -287,7 +294,7 @@ static void update_ftrace_function(void)
>  	/* OK, we are all set to update the ftrace_trace_function now! */
>  #endif /* !CONFIG_DYNAMIC_FTRACE */
> 
> -	ftrace_trace_function = func;
> +	ftrace_trace_function = func.ops;
>  }

This looks really intrusive for what it's trying to accomplish.

The linker trick is far less intrusive, and I believe less error prone.

-- Steve


> 
>  static void add_ftrace_ops(struct ftrace_ops __rcu **list,
> @@ -2680,6 +2687,7 @@ void ftrace_modify_all_code(int command)
>  	int update = command & FTRACE_UPDATE_TRACE_FUNC;
>  	int mod_flags = 0;
>  	int err = 0;
> +	union ftrace_func func;
> 
>  	if (command & FTRACE_MAY_SLEEP)
>  		mod_flags = FTRACE_MODIFY_MAY_SLEEP_FL;
> @@ -2695,7 +2703,8 @@ void ftrace_modify_all_code(int command)
>  	 * traced.
>  	 */
>  	if (update) {
> -		err = ftrace_update_ftrace_func(ftrace_ops_list_func);
> +		ftrace_set_ufunc(&func, ftrace_ops_list_func);
> +		err = ftrace_update_ftrace_func(func.ops);
>  		if (FTRACE_WARN_ON(err))
>  			return;
>  	}
> @@ -2705,7 +2714,9 @@ void ftrace_modify_all_code(int command)
>  	else if (command & FTRACE_DISABLE_CALLS)
>  		ftrace_replace_code(mod_flags);
> 
> -	if (update && ftrace_trace_function != ftrace_ops_list_func) {
> +	ftrace_set_ufunc(&func, ftrace_ops_list_func);
> +
> +	if (update && ftrace_trace_function != func.ops) {
>  		function_trace_op = set_function_trace_op;
>  		smp_wmb();
>  		/* If irqs are disabled, we are in stop machine */
> @@ -6890,14 +6901,13 @@ static void ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
>  {
>  	__ftrace_ops_list_func(ip, parent_ip, NULL, regs);
>  }
> -NOKPROBE_SYMBOL(ftrace_ops_list_func);
>  #else
> -static void ftrace_ops_no_ops(unsigned long ip, unsigned long parent_ip)
> +static void ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip)
>  {
>  	__ftrace_ops_list_func(ip, parent_ip, NULL, NULL);
>  }
> -NOKPROBE_SYMBOL(ftrace_ops_no_ops);
>  #endif
> +NOKPROBE_SYMBOL(ftrace_ops_list_func);
> 
>  /*
>   * If there's only one function registered but it does not support
> --
> 2.20.1

