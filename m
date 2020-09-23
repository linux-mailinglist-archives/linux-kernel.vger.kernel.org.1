Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E5C2764BB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 01:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgIWXwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 19:52:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbgIWXwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 19:52:18 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0084620C56;
        Wed, 23 Sep 2020 23:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600905137;
        bh=6zFWXkkFznLvhQ+/b7puuq4ataR9mBVYGxbSgkiiGes=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rWUFgSCHpAgplUWlnRMzA2hySnbGhWmFNAB+9+O7gph/+Jd9d4CZZSZbqYus430n7
         jKTveOOD5+ZWn+SoeP2KbVkE3qFj3Q7fPSJCjmS8zhiT0miP86EpEfRkwkyFgiwWw3
         JsS56pNs8B822v7pcqDtYtsBRiglXpCO4d7c9i0w=
Date:   Thu, 24 Sep 2020 08:52:14 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [for-next][PATCH 24/26] tracing: Enable creating new instance
 early boot
Message-Id: <20200924085214.f2e901534037bede0bb55447@kernel.org>
In-Reply-To: <20200922012453.507002285@goodmis.org>
References: <20200922012414.115238201@goodmis.org>
        <20200922012453.507002285@goodmis.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

Sorry, I found that this is not enough for setting up the instance.
It seems that an instance is created but the events of the instance
are not created (and maybe reset when initializing the tracefs).
Let me fix it.

Thank you,

On Mon, 21 Sep 2020 21:24:38 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Enable creating new trace_array instance in early boot stage.
> If the instances directory is not created, postpone it until
> the tracefs is initialized.
> 
> Link: https://lkml.kernel.org/r/159974154763.478751.6289753509587233103.stgit@devnote2
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace.c           | 53 +++++++++++++++++++++++++++-------
>  kernel/trace/trace.h           |  7 +++++
>  kernel/trace/trace_functions.c | 22 +++++++++-----
>  3 files changed, 63 insertions(+), 19 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index c35fcd2f2529..6211a13b3327 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -8636,6 +8636,24 @@ struct trace_array *trace_array_find_get(const char *instance)
>  	return tr;
>  }
>  
> +static int trace_array_create_dir(struct trace_array *tr)
> +{
> +	int ret;
> +
> +	tr->dir = tracefs_create_dir(tr->name, trace_instance_dir);
> +	if (!tr->dir)
> +		return -EINVAL;
> +
> +	ret = event_trace_add_tracer(tr->dir, tr);
> +	if (ret)
> +		tracefs_remove(tr->dir);
> +
> +	init_tracer_tracefs(tr, tr->dir);
> +	__update_tracer_options(tr);
> +
> +	return ret;
> +}
> +
>  static struct trace_array *trace_array_create(const char *name)
>  {
>  	struct trace_array *tr;
> @@ -8671,30 +8689,27 @@ static struct trace_array *trace_array_create(const char *name)
>  	if (allocate_trace_buffers(tr, trace_buf_size) < 0)
>  		goto out_free_tr;
>  
> -	tr->dir = tracefs_create_dir(name, trace_instance_dir);
> -	if (!tr->dir)
> -		goto out_free_tr;
> -
> -	ret = event_trace_add_tracer(tr->dir, tr);
> -	if (ret) {
> -		tracefs_remove(tr->dir);
> +	if (ftrace_allocate_ftrace_ops(tr) < 0)
>  		goto out_free_tr;
> -	}
>  
>  	ftrace_init_trace_array(tr);
>  
> -	init_tracer_tracefs(tr, tr->dir);
>  	init_trace_flags_index(tr);
> -	__update_tracer_options(tr);
> +
> +	if (trace_instance_dir) {
> +		ret = trace_array_create_dir(tr);
> +		if (ret)
> +			goto out_free_tr;
> +	}
>  
>  	list_add(&tr->list, &ftrace_trace_arrays);
>  
>  	tr->ref++;
>  
> -
>  	return tr;
>  
>   out_free_tr:
> +	ftrace_free_ftrace_ops(tr);
>  	free_trace_buffers(tr);
>  	free_cpumask_var(tr->tracing_cpumask);
>  	kfree(tr->name);
> @@ -8852,11 +8867,27 @@ static int instance_rmdir(const char *name)
>  
>  static __init void create_trace_instances(struct dentry *d_tracer)
>  {
> +	struct trace_array *tr;
> +
>  	trace_instance_dir = tracefs_create_instance_dir("instances", d_tracer,
>  							 instance_mkdir,
>  							 instance_rmdir);
>  	if (MEM_FAIL(!trace_instance_dir, "Failed to create instances directory\n"))
>  		return;
> +
> +	mutex_lock(&event_mutex);
> +	mutex_lock(&trace_types_lock);
> +
> +	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
> +		if (!tr->name)
> +			continue;
> +		if (MEM_FAIL(trace_array_create_dir(tr) < 0,
> +			     "Failed to create instance directory\n"))
> +			break;
> +	}
> +
> +	mutex_unlock(&trace_types_lock);
> +	mutex_unlock(&event_mutex);
>  }
>  
>  static void
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 0d3a405fe446..525434145eea 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -1125,6 +1125,8 @@ extern int ftrace_is_dead(void);
>  int ftrace_create_function_files(struct trace_array *tr,
>  				 struct dentry *parent);
>  void ftrace_destroy_function_files(struct trace_array *tr);
> +int ftrace_allocate_ftrace_ops(struct trace_array *tr);
> +void ftrace_free_ftrace_ops(struct trace_array *tr);
>  void ftrace_init_global_array_ops(struct trace_array *tr);
>  void ftrace_init_array_ops(struct trace_array *tr, ftrace_func_t func);
>  void ftrace_reset_array_ops(struct trace_array *tr);
> @@ -1146,6 +1148,11 @@ ftrace_create_function_files(struct trace_array *tr,
>  {
>  	return 0;
>  }
> +static inline int ftrace_allocate_ftrace_ops(struct trace_array *tr)
> +{
> +	return 0;
> +}
> +static inline void ftrace_free_ftrace_ops(struct trace_array *tr) { }
>  static inline void ftrace_destroy_function_files(struct trace_array *tr) { }
>  static inline __init void
>  ftrace_init_global_array_ops(struct trace_array *tr) { }
> diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
> index dd4dff71d89a..2c2126e1871d 100644
> --- a/kernel/trace/trace_functions.c
> +++ b/kernel/trace/trace_functions.c
> @@ -34,10 +34,14 @@ enum {
>  	TRACE_FUNC_OPT_STACK	= 0x1,
>  };
>  
> -static int allocate_ftrace_ops(struct trace_array *tr)
> +int ftrace_allocate_ftrace_ops(struct trace_array *tr)
>  {
>  	struct ftrace_ops *ops;
>  
> +	/* The top level array uses the "global_ops" */
> +	if (tr->flags & TRACE_ARRAY_FL_GLOBAL)
> +		return 0;
> +
>  	ops = kzalloc(sizeof(*ops), GFP_KERNEL);
>  	if (!ops)
>  		return -ENOMEM;
> @@ -48,15 +52,19 @@ static int allocate_ftrace_ops(struct trace_array *tr)
>  
>  	tr->ops = ops;
>  	ops->private = tr;
> +
>  	return 0;
>  }
>  
> +void ftrace_free_ftrace_ops(struct trace_array *tr)
> +{
> +	kfree(tr->ops);
> +	tr->ops = NULL;
> +}
>  
>  int ftrace_create_function_files(struct trace_array *tr,
>  				 struct dentry *parent)
>  {
> -	int ret;
> -
>  	/*
>  	 * The top level array uses the "global_ops", and the files are
>  	 * created on boot up.
> @@ -64,9 +72,8 @@ int ftrace_create_function_files(struct trace_array *tr,
>  	if (tr->flags & TRACE_ARRAY_FL_GLOBAL)
>  		return 0;
>  
> -	ret = allocate_ftrace_ops(tr);
> -	if (ret)
> -		return ret;
> +	if (!tr->ops)
> +		return -EINVAL;
>  
>  	ftrace_create_filter_files(tr->ops, parent);
>  
> @@ -76,8 +83,7 @@ int ftrace_create_function_files(struct trace_array *tr,
>  void ftrace_destroy_function_files(struct trace_array *tr)
>  {
>  	ftrace_destroy_filter_files(tr->ops);
> -	kfree(tr->ops);
> -	tr->ops = NULL;
> +	ftrace_free_ftrace_ops(tr);
>  }
>  
>  static int function_trace_init(struct trace_array *tr)
> -- 
> 2.28.0
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
