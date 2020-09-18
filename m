Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85804270278
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 18:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgIRQqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 12:46:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:43414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbgIRQqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 12:46:04 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90C272078B;
        Fri, 18 Sep 2020 16:46:02 +0000 (UTC)
Date:   Fri, 18 Sep 2020 12:46:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mingo@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        will@kernel.org, romain.perier@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tasklet: Introduce tasklet tracepoints
Message-ID: <20200918124600.69e94b71@gandalf.local.home>
In-Reply-To: <20200905060412.88560-1-songmuchun@bytedance.com>
References: <20200905060412.88560-1-songmuchun@bytedance.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  5 Sep 2020 14:04:12 +0800
Muchun Song <songmuchun@bytedance.com> wrote:

> Introduce tracepoints for tasklets just like softirq does. In this case,
> we can calculate tasklet latency and know what tasklet run.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  include/trace/events/irq.h | 44 ++++++++++++++++++++++++++++++++++++++
>  kernel/softirq.c           |  2 ++
>  2 files changed, 46 insertions(+)
> 
> diff --git a/include/trace/events/irq.h b/include/trace/events/irq.h
> index eeceafaaea4c..69a16f3a21c2 100644
> --- a/include/trace/events/irq.h
> +++ b/include/trace/events/irq.h
> @@ -160,6 +160,50 @@ DEFINE_EVENT(softirq, softirq_raise,
>  	TP_ARGS(vec_nr)
>  );
>  
> +DECLARE_EVENT_CLASS(tasklet,
> +
> +	TP_PROTO(struct tasklet_struct *t),
> +
> +	TP_ARGS(t),
> +
> +	TP_STRUCT__entry(
> +		__field(	void *,	callback	)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->callback = t->callback;

I think you need to replicate the logic in the code:

		if (t->use_callback)
			__entry->callback = t->callback;
		else
			__entry->callback = t->func;

-- Steve

> +	),
> +
> +	TP_printk("callback=%ps", __entry->callback)
> +);
> +
> +/**
> + * tasklet_entry - called immediately before the tasklet handler
> + * @t: pointer to struct tasklet_struct
> + *
> + * When used in combination with the tasklet_exit tracepoint
> + * we can determine the tasklet handler routine.
> + */
> +DEFINE_EVENT(tasklet, tasklet_entry,
> +
> +	TP_PROTO(struct tasklet_struct *t),
> +
> +	TP_ARGS(t)
> +);
> +
> +/**
> + * tasklet_exit - called immediately after the tasklet handler returns
> + * @t: pointer to struct tasklet_struct
> + *
> + * When used in combination with the tasklet_entry tracepoint
> + * we can determine the tasklet handler routine.
> + */
> +DEFINE_EVENT(tasklet, tasklet_exit,
> +
> +	TP_PROTO(struct tasklet_struct *t),
> +
> +	TP_ARGS(t)
> +);
>  #endif /*  _TRACE_IRQ_H */
>  
>  /* This part must be outside protection */
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index bf88d7f62433..0f9f5b2cc3d3 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -553,10 +553,12 @@ static void tasklet_action_common(struct softirq_action *a,
>  				if (!test_and_clear_bit(TASKLET_STATE_SCHED,
>  							&t->state))
>  					BUG();
> +				trace_tasklet_entry(t);
>  				if (t->use_callback)
>  					t->callback(t);
>  				else
>  					t->func(t->data);
> +				trace_tasklet_exit(t);
>  				tasklet_unlock(t);
>  				continue;
>  			}

