Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF46729F162
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 17:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgJ2Q1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 12:27:22 -0400
Received: from foss.arm.com ([217.140.110.172]:40360 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbgJ2Q1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:27:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCC5313A1;
        Thu, 29 Oct 2020 09:27:20 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C3E063F66E;
        Thu, 29 Oct 2020 09:27:18 -0700 (PDT)
References: <20201023101158.088940906@infradead.org> <20201023102347.406912197@infradead.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com,
        tj@kernel.org, ouwen210@hotmail.com
Subject: Re: [PATCH v4 14/19] sched, lockdep: Annotate ->pi_lock recursion
In-reply-to: <20201023102347.406912197@infradead.org>
Date:   Thu, 29 Oct 2020 16:27:16 +0000
Message-ID: <jhjblglov4r.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23/10/20 11:12, Peter Zijlstra wrote:
> @@ -2617,6 +2618,20 @@ void sched_set_stop_task(int cpu, struct
>               sched_setscheduler_nocheck(stop, SCHED_FIFO, &param);
>
>               stop->sched_class = &stop_sched_class;
> +
> +		/*
> +		 * The PI code calls rt_mutex_setprio() with ->pi_lock held to
> +		 * adjust the effective priority of a task. As a result,
> +		 * rt_mutex_setprio() can trigger (RT) balancing operations,
> +		 * which can then trigger wakeups of the stop thread to push
> +		 * around the current task.
> +		 *
> +		 * The stop task itself will never be part of the PI-chain, it
> +		 * never blocks, therefore that ->pi_lock recursion is safe.

Isn't it that the stopper task can only run when preemption is re-enabled,
and the ->pi_lock is dropped before then?

If we were to have an SCA-like function that would kick the stopper but
"forget" to release the pi_lock, then we would very much like lockdep to
complain, right? Or is that something else entirely?

> +		 * Tell lockdep about this by placing the stop->pi_lock in its
> +		 * own class.
> +		 */
> +		lockdep_set_class(&stop->pi_lock, &stop_pi_lock);
>       }
>
>       cpu_rq(cpu)->stop = stop;
