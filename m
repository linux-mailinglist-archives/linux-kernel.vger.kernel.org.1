Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394D12791E8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 22:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbgIYUTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 16:19:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:43078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727733AbgIYURc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 16:17:32 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CDF42086A;
        Fri, 25 Sep 2020 19:37:55 +0000 (UTC)
Date:   Fri, 25 Sep 2020 15:37:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] tracing/boot: Initialize per-instance event list in
 early boot
Message-ID: <20200925153753.63c822ce@oasis.local.home>
In-Reply-To: <160096560826.182763.17110991546046128881.stgit@devnote2>
References: <20200924085214.f2e901534037bede0bb55447@kernel.org>
        <160096560826.182763.17110991546046128881.stgit@devnote2>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Sep 2020 01:40:08 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Initialize per-instance event list in early boot time (before
> initializing instance directory on tracefs). This fixes boot-time
> tracing to correctly handle the boot-time per-instance settings.
> 

I added:

Fixes: 4114fbfd02f1 ("tracing: Enable creating new instance early boot")

-- Steve

> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  kernel/trace/trace.c        |    3 ++-
>  kernel/trace/trace.h        |    1 +
>  kernel/trace/trace_events.c |   30 ++++++++++++++++--------------
>  3 files changed, 19 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index f7696db52e7d..400ed1ec3b64 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -8700,7 +8700,8 @@ static struct trace_array *trace_array_create(const char *name)
>  		ret = trace_array_create_dir(tr);
>  		if (ret)
>  			goto out_free_tr;
> -	}
> +	} else
> +		__trace_early_add_events(tr);
>  
>  	list_add(&tr->list, &ftrace_trace_arrays);
>  
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index e1b3061ce06d..5b887cfbe5ec 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -1658,6 +1658,7 @@ extern void trace_event_enable_tgid_record(bool enable);
>  extern int event_trace_init(void);
>  extern int event_trace_add_tracer(struct dentry *parent, struct trace_array *tr);
>  extern int event_trace_del_tracer(struct trace_array *tr);
> +extern void __trace_early_add_events(struct trace_array *tr);
>  
>  extern struct trace_event_file *__find_event_file(struct trace_array *tr,
>  						  const char *system,
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 720b0d72ea52..8ce334297bf3 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -3131,14 +3131,13 @@ static inline int register_event_cmds(void) { return 0; }
>  #endif /* CONFIG_DYNAMIC_FTRACE */
>  
>  /*
> - * The top level array has already had its trace_event_file
> - * descriptors created in order to allow for early events to
> - * be recorded. This function is called after the tracefs has been
> - * initialized, and we now have to create the files associated
> - * to the events.
> + * The top level array and trace arrays created by boot-time tracing
> + * have already had its trace_event_file descriptors created in order
> + * to allow for early events to be recorded.
> + * This function is called after the tracefs has been initialized,
> + * and we now have to create the files associated to the events.
>   */
> -static __init void
> -__trace_early_add_event_dirs(struct trace_array *tr)
> +static void __trace_early_add_event_dirs(struct trace_array *tr)
>  {
>  	struct trace_event_file *file;
>  	int ret;
> @@ -3153,13 +3152,12 @@ __trace_early_add_event_dirs(struct trace_array *tr)
>  }
>  
>  /*
> - * For early boot up, the top trace array requires to have
> - * a list of events that can be enabled. This must be done before
> - * the filesystem is set up in order to allow events to be traced
> - * early.
> + * For early boot up, the top trace array and the trace arrays created
> + * by boot-time tracing require to have a list of events that can be
> + * enabled. This must be done before the filesystem is set up in order
> + * to allow events to be traced early.
>   */
> -static __init void
> -__trace_early_add_events(struct trace_array *tr)
> +void __trace_early_add_events(struct trace_array *tr)
>  {
>  	struct trace_event_call *call;
>  	int ret;
> @@ -3290,7 +3288,11 @@ int event_trace_add_tracer(struct dentry *parent, struct trace_array *tr)
>  		goto out;
>  
>  	down_write(&trace_event_sem);
> -	__trace_add_event_dirs(tr);
> +	/* If tr already has the event list, it is initialized in early boot. */
> +	if (unlikely(!list_empty(&tr->events)))
> +		__trace_early_add_event_dirs(tr);
> +	else
> +		__trace_add_event_dirs(tr);
>  	up_write(&trace_event_sem);
>  
>   out:

