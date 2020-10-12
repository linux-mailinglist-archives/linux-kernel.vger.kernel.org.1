Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCA0328B96D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 16:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390071AbgJLOAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 10:00:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:38438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389424AbgJLN77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:59:59 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A0252076E;
        Mon, 12 Oct 2020 13:59:57 +0000 (UTC)
Date:   Mon, 12 Oct 2020 09:59:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ilias Stamatis <stamatis.iliass@gmail.com>,
        Liang Chen <cl@rock-chips.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: Re: [PATCH] kthread: Add kthread_work tracepoints
Message-ID: <20201012095955.0741313b@gandalf.local.home>
In-Reply-To: <20201010180323.126634-1-robdclark@gmail.com>
References: <20201010180323.126634-1-robdclark@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Oct 2020 11:03:22 -0700
Rob Clark <robdclark@gmail.com> wrote:

> /**
> + * sched_kthread_work_execute_start - called immediately before the work callback
> + * @work:	pointer to struct kthread_work
> + *
> + * Allows to track kthread work execution.
> + */
> +TRACE_EVENT(sched_kthread_work_execute_start,
> +
> +	TP_PROTO(struct kthread_work *work),
> +
> +	TP_ARGS(work),
> +
> +	TP_STRUCT__entry(
> +		__field( void *,	work	)
> +		__field( void *,	function)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->work		= work;
> +		__entry->function	= work->func;
> +	),
> +
> +	TP_printk("work struct %p: function %ps", __entry->work, __entry->function)
> +);
> +
> +/**
> + * sched_kthread_work_execute_end - called immediately after the work callback
> + * @work:	pointer to struct work_struct
> + * @function:   pointer to worker function
> + *
> + * Allows to track workqueue execution.
> + */
> +TRACE_EVENT(sched_kthread_work_execute_end,
> +
> +	TP_PROTO(struct kthread_work *work, kthread_work_func_t function),
> +
> +	TP_ARGS(work, function),
> +
> +	TP_STRUCT__entry(
> +		__field( void *,	work	)
> +		__field( void *,	function)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->work		= work;
> +		__entry->function	= function;
> +	),
> +
> +	TP_printk("work struct %p: function %ps", __entry->work, __entry->function)
> +);
> +


Please combine the above into:

DECLARE_EVENT_CLASS(sched_kthread_work_execute_template,

	TP_PROTO(struct kthread_work *work),

	TP_ARGS(work),

	TP_STRUCT__entry(
		__field( void *,	work	)
		__field( void *,	function)
	),

	TP_fast_assign(
		__entry->work		= work;
		__entry->function	= work->func;
	),

	TP_printk("work struct %p: function %ps", __entry->work, __entry->function)
);

DEFINE_EVENT(sched_kthread_work_execute_template, sched_kthread_work_execute_start,
	TP_PROTO(struct kthread_work *work),
	TP_ARGS(work));

DEFINE_EVENT(sched_kthread_work_execute_template, sched_kthread_work_execute_end,
	TP_PROTO(struct kthread_work *work),
	TP_ARGS(work));

As events are cheap, classes are expensive (size wise), and a TRACE_EVENT()
is really just a CLASS and EVENT for a single instance.

-- Steve
