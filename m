Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF5028F400
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 15:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387867AbgJONzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 09:55:02 -0400
Received: from foss.arm.com ([217.140.110.172]:44636 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729679AbgJONzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 09:55:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B750B13D5;
        Thu, 15 Oct 2020 06:55:01 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DD3A3F719;
        Thu, 15 Oct 2020 06:54:59 -0700 (PDT)
References: <20201015110532.738127234@infradead.org> <20201015110923.910090294@infradead.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com,
        tj@kernel.org, ouwen210@hotmail.com
Subject: Re: [PATCH v3 10/19] sched: Fix migrate_disable() vs set_cpus_allowed_ptr()
In-reply-to: <20201015110923.910090294@infradead.org>
Date:   Thu, 15 Oct 2020 14:54:53 +0100
Message-ID: <jhjo8l3r3v6.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 15/10/20 12:05, Peter Zijlstra wrote:
> +static int affine_move_task(struct rq *rq, struct rq_flags *rf,
> +			    struct task_struct *p, int dest_cpu, unsigned int flags)
> +{
> +	struct set_affinity_pending my_pending = { }, *pending = NULL;
> +	struct migration_arg arg = {
> +		.task = p,
> +		.dest_cpu = dest_cpu,
> +	};
> +	bool complete = false;
> +
> +	/* Can the task run on the task's current CPU? If so, we're done */
> +	if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask)) {
> +		pending = p->migration_pending;
> +		if (pending) {
> +			p->migration_pending = NULL;
> +			complete = true;

Deciphering my TLA+ deadlock traces leads me to think this needs

                        refcount_inc(&pending->refs);

because the 'goto do_complete' leads us to an unconditional decrement.

> +		}
> +		task_rq_unlock(rq, p, rf);
> +
> +		if (complete)
> +			goto do_complete;
                        ^^^^
                       that here

> +
> +		return 0;
> +	}
> +

[...]

> +do_complete:
> +		if (complete)
> +			complete_all(&pending->done);
> +	}
> +
> +	wait_for_completion(&pending->done);
> +
> +	if (refcount_dec_and_test(&pending->refs))
           ^^^^^^^^^^^^^^^^^^^^^^^
           leads to this guy there

> +		wake_up_var(&pending->refs);
> +
> +	wait_var_event(&my_pending.refs, !refcount_read(&my_pending.refs));
> +
> +	return 0;
> +}
