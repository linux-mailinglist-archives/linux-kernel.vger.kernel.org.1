Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87B029F165
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 17:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgJ2Q1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 12:27:31 -0400
Received: from foss.arm.com ([217.140.110.172]:40382 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726806AbgJ2Q1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:27:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE7BD13D5;
        Thu, 29 Oct 2020 09:27:30 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6B1A3F66E;
        Thu, 29 Oct 2020 09:27:28 -0700 (PDT)
References: <20201023101158.088940906@infradead.org> <20201023102347.697960969@infradead.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com,
        tj@kernel.org, ouwen210@hotmail.com
Subject: Re: [PATCH v4 17/19] sched: Add migrate_disable() tracepoints
In-reply-to: <20201023102347.697960969@infradead.org>
Date:   Thu, 29 Oct 2020 16:27:26 +0000
Message-ID: <jhja6w5ov4h.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23/10/20 11:12, Peter Zijlstra wrote:
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1732,6 +1732,8 @@ void migrate_disable(void)
>               return;
>       }
>
> +	trace_sched_migrate_disable_tp(p);
> +
>       preempt_disable();
>       this_rq()->nr_pinned++;
>       p->migration_disabled = 1;
> @@ -1764,6 +1766,8 @@ void migrate_enable(void)
>       p->migration_disabled = 0;
>       this_rq()->nr_pinned--;
>       preempt_enable();
> +
> +	trace_sched_migrate_enable_tp(p);

Don't you want those directly after the ->migration_disabled write?
esp. for migrate_enable(), if that preempt_enable() leads to a context
switch then the disable->enable deltas won't reflect the kernel view.

That delta may indeed include the time it took to run the stopper and
fix the task's affinity on migrate_enable(), but it could include all
sorts of other higher-priority tasks.

>  }
>  EXPORT_SYMBOL_GPL(migrate_enable);
