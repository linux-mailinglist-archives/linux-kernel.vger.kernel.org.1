Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B0A29F161
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 17:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgJ2Q1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 12:27:14 -0400
Received: from foss.arm.com ([217.140.110.172]:40338 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbgJ2Q1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:27:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64FA0139F;
        Thu, 29 Oct 2020 09:27:13 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 48CAE3F66E;
        Thu, 29 Oct 2020 09:27:11 -0700 (PDT)
References: <20201023101158.088940906@infradead.org> <20201023102347.067278757@infradead.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com,
        tj@kernel.org, ouwen210@hotmail.com
Subject: Re: [PATCH v4 11/19] sched/core: Make migrate disable and CPU hotplug cooperative
In-reply-to: <20201023102347.067278757@infradead.org>
Date:   Thu, 29 Oct 2020 16:27:09 +0000
Message-ID: <jhjd011ov4y.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23/10/20 11:12, Peter Zijlstra wrote:
> @@ -7006,15 +7024,20 @@ static bool balance_push(struct rq *rq)
>        * Both the cpu-hotplug and stop task are in this case and are
>        * required to complete the hotplug process.
>        */
> -	if (is_per_cpu_kthread(push_task)) {
> +	if (is_per_cpu_kthread(push_task) || is_migration_disabled(push_task)) {

is_migration_disabled(p) implies rq_has_pinned_tasks(task_rq(p)), right?

So having a "simple"

  if (is_migration_disabled(push_task))
        return;

would help simpletons like me trying to read through this.

>               /*
>                * If this is the idle task on the outgoing CPU try to wake
>                * up the hotplug control thread which might wait for the
>                * last task to vanish. The rcuwait_active() check is
>                * accurate here because the waiter is pinned on this CPU
>                * and can't obviously be running in parallel.
> +		 *
> +		 * On RT kernels this also has to check whether there are
> +		 * pinned and scheduled out tasks on the runqueue. They
> +		 * need to leave the migrate disabled section first.
>                */
> -		if (!rq->nr_running && rcuwait_active(&rq->hotplug_wait)) {
> +		if (!rq->nr_running && !rq_has_pinned_tasks(rq) &&
> +		    rcuwait_active(&rq->hotplug_wait)) {
>                       raw_spin_unlock(&rq->lock);
>                       rcuwait_wake_up(&rq->hotplug_wait);
>                       raw_spin_lock(&rq->lock);
