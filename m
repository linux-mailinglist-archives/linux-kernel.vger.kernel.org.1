Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B34028EF34
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 11:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730543AbgJOJOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 05:14:34 -0400
Received: from foss.arm.com ([217.140.110.172]:50114 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgJOJOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 05:14:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9CC6D6E;
        Thu, 15 Oct 2020 02:14:32 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC8803F66B;
        Thu, 15 Oct 2020 02:14:30 -0700 (PDT)
References: <20201005145717.346020688@infradead.org> <20201013140116.26651-1-valentin.schneider@arm.com> <20201013141508.u7saiudjyuvihvcx@linutronix.de> <20201013142108.GD2594@hirez.programming.kicks-ass.net>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        qais.yousef@arm.com, swood@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org
Subject: Re: [PATCH 1/2] sched: Deny self-issued __set_cpus_allowed_ptr() when migrate_disable()
In-reply-to: <20201013142108.GD2594@hirez.programming.kicks-ass.net>
Date:   Thu, 15 Oct 2020 10:14:05 +0100
Message-ID: <jhjpn5jrgv6.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/10/20 15:21, Peter Zijlstra wrote:
> On Tue, Oct 13, 2020 at 04:15:08PM +0200, Sebastian Andrzej Siewior wrote:
>> On 2020-10-13 15:01:15 [+0100], Valentin Schneider wrote:
>> >   migrate_disable();
>> >   set_cpus_allowed_ptr(current, {something excluding task_cpu(current)});
>> >   affine_move_task(); <-- never returns
>> >
>> > Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
>> > ---
>> >  kernel/sched/core.c | 5 +++++
>> >  1 file changed, 5 insertions(+)
>> >
>> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> > index 4ccd1099adaa..7f4e38819de1 100644
>> > --- a/kernel/sched/core.c
>> > +++ b/kernel/sched/core.c
>> > @@ -2189,6 +2189,11 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
>> >    if (!(flags & SCA_MIGRATE_ENABLE) && cpumask_equal(&p->cpus_mask, new_mask))
>> >            goto out;
>> >
>> > +	if (p == current &&
>> > +	    is_migration_disabled(p) &&
>> > +	    !cpumask_test_cpu(task_cpu(p), new_mask))
>> > +		ret = -EBUSY;
>> > +
>>
>> This shouldn't happen, right? The function may sleep so it shouldn't be
>> entered with disabled migration. A WARN_ON might spot the bad caller.
>
> So yeah, I like detecting the case but agree with bigeasy that an
> additional WARN would make sense, lemme go add that.

Err, I've just realized that this will warn on migrate_enable() if there
are pending affinity changes, since p->migration_disabled is cleared
*after* the call to __set_cpus_allowed_ptr().

This wants:
---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d503d6cb8350..e8156e3d3b4a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2266,7 +2266,8 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
        if (!(flags & SCA_MIGRATE_ENABLE) && cpumask_equal(&p->cpus_mask, new_mask))
                goto out;

-	if (WARN_ON_ONCE(p == current &&
+	if (WARN_ON_ONCE(!(flags & SCA_MIGRATE_ENABLE) &&
+			 p == current &&
                         is_migration_disabled(p) &&
                         !cpumask_test_cpu(task_cpu(p), new_mask)))
                ret = -EBUSY;
---
