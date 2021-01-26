Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4F63040C4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 15:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405964AbhAZOqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 09:46:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:60180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405107AbhAZOqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 09:46:21 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 786172251F;
        Tue, 26 Jan 2021 14:45:40 +0000 (UTC)
Date:   Tue, 26 Jan 2021 09:45:39 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Viktor Rosendahl <Viktor.Rosendahl@bmw.de>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [RFC PATCH 1/2] Use pause-on-trace with the latency tracers
Message-ID: <20210126094539.4969c357@gandalf.local.home>
In-Reply-To: <20210119164344.37500-2-Viktor.Rosendahl@bmw.de>
References: <20210119164344.37500-1-Viktor.Rosendahl@bmw.de>
        <20210119164344.37500-2-Viktor.Rosendahl@bmw.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry for the late reply.

On Tue, 19 Jan 2021 17:43:43 +0100
Viktor Rosendahl <Viktor.Rosendahl@bmw.de> wrote:

> Eaerlier, tracing was disabled when reading the trace file. This behavior
> was changed with:
> 
> commit 06e0a548bad0 ("tracing: Do not disable tracing when reading the
> trace file").
> 
> This doesn't seem to work with the latency tracers.
> 
> The above mentioned commit dit not only change the behavior but also added
> an option to emulate the old behavior. The idea with this patch is to
> enable this pause-on-trace option when the latency tracers are used.
> 
> This is a workaround, perhaps it would be better to make the latency
> tracers work without pausing but I am not sure how to do that, or even
> how feasible it is without significant rework.

I think this is a fine workaround. The latency tracers are rather "special"
and some options just don't make sense for them. There's some things I wish
I had done different with them, but we can't fix because of backward
compatibility reasons.

I'll take a look at these today. Thanks.

-- Steve

> 
> Signed-off-by: Viktor Rosendahl <Viktor.Rosendahl@bmw.de>
> ---
>  kernel/trace/trace_irqsoff.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
> index d06aab4dcbb8..6756379b661f 100644
> --- a/kernel/trace/trace_irqsoff.c
> +++ b/kernel/trace/trace_irqsoff.c
> @@ -562,6 +562,8 @@ static int __irqsoff_tracer_init(struct trace_array *tr)
>  	/* non overwrite screws up the latency tracers */
>  	set_tracer_flag(tr, TRACE_ITER_OVERWRITE, 1);
>  	set_tracer_flag(tr, TRACE_ITER_LATENCY_FMT, 1);
> +	/* without pause, we will produce garbage if another latency occurs */
> +	set_tracer_flag(tr, TRACE_ITER_PAUSE_ON_TRACE, 1);
>  
>  	tr->max_latency = 0;
>  	irqsoff_trace = tr;
> @@ -583,11 +585,13 @@ static void __irqsoff_tracer_reset(struct trace_array *tr)
>  {
>  	int lat_flag = save_flags & TRACE_ITER_LATENCY_FMT;
>  	int overwrite_flag = save_flags & TRACE_ITER_OVERWRITE;
> +	int pause_flag = save_flags & TRACE_ITER_PAUSE_ON_TRACE;
>  
>  	stop_irqsoff_tracer(tr, is_graph(tr));
>  
>  	set_tracer_flag(tr, TRACE_ITER_LATENCY_FMT, lat_flag);
>  	set_tracer_flag(tr, TRACE_ITER_OVERWRITE, overwrite_flag);
> +	set_tracer_flag(tr, TRACE_ITER_PAUSE_ON_TRACE, pause_flag);
>  	ftrace_reset_array_ops(tr);
>  
>  	irqsoff_busy = false;

