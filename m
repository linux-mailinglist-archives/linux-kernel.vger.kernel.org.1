Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168F8284AC0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 13:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgJFLUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 07:20:39 -0400
Received: from foss.arm.com ([217.140.110.172]:45096 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbgJFLUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 07:20:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56B1F1476;
        Tue,  6 Oct 2020 04:20:31 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 558623F66B;
        Tue,  6 Oct 2020 04:20:29 -0700 (PDT)
References: <20201005145717.346020688@infradead.org> <20201005150921.859981475@infradead.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com,
        tj@kernel.org
Subject: Re: [PATCH -v2 09/17] sched: Add migrate_disable()
In-reply-to: <20201005150921.859981475@infradead.org>
Date:   Tue, 06 Oct 2020 12:20:27 +0100
Message-ID: <jhjwo03mwhw.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05/10/20 15:57, Peter Zijlstra wrote:
> Add the base migrate_disable() support (under protest).
>
> While migrate_disable() is (currently) required for PREEMPT_RT, it is
> also one of the biggest flaws in the system.
>
> Notably this is just the base implementation, it is broken vs
> sched_setaffinity() and hotplug, both solved in additional patches for
> ease of review.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
[...]
> @@ -2363,7 +2451,7 @@ int select_task_rq(struct task_struct *p
>  {
>       lockdep_assert_held(&p->pi_lock);
>
> -	if (p->nr_cpus_allowed > 1)
> +	if (p->nr_cpus_allowed > 1 && !is_migration_disabled(p))

So dissociating migrate_disable() from p->nr_cpus_allowed unlocks the whole
DL+RT push/pull thingie, but it also means we need to be somewhat careful
regarding checks like the above.

Looking at current p->nr_cpus_allowed readers, it's mostly DL/RT; I was
somewhat afraid CFS load balance would use it but turns out it doesn't. The
only borderline case I see is call_on_cpu(), and even then it would be just a
performance deal rather than a correctness one.

All that to say: it seems fine to me.

>               cpu = p->sched_class->select_task_rq(p, cpu, sd_flags, wake_flags);
>       else
>               cpu = cpumask_any(p->cpus_ptr);
