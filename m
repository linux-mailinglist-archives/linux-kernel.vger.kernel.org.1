Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58B53277053
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 13:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbgIXLxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 07:53:31 -0400
Received: from foss.arm.com ([217.140.110.172]:43622 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgIXLxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 07:53:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1375113E;
        Thu, 24 Sep 2020 04:53:29 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A3CB3F73B;
        Thu, 24 Sep 2020 04:53:27 -0700 (PDT)
References: <20200921163557.234036895@infradead.org> <20200921163845.769861942@infradead.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com
Subject: Re: [PATCH 7/9] sched: Add migrate_disable()
In-reply-to: <20200921163845.769861942@infradead.org>
Date:   Thu, 24 Sep 2020 12:53:25 +0100
Message-ID: <jhj5z83mlvu.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Still trying to digest 8/9, but have some comments before I next get
preempted :)

On 21/09/20 17:36, Peter Zijlstra wrote:

[...]

> +void migrate_enable(void)
> +{
> +	if (--current->migration_disabled)
> +		return;
> +
> +	barrier();
> +
> +	if (p->cpus_ptr == &p->cpus_mask)
> +		return;

If we get to here this means we're the migrate_enable() invocation that
marks the end of the migration_disabled region. How can cpus_ptr already
point back to current's cpus_mask?

Also, this is fixed in 8/9 but this here wants an s/p/current/

> +
> +	__set_cpus_allowed_ptr(p, &p->cpus_mask, SCA_MIGRATE_ENABLE);
> +}

[...]

> @@ -1830,8 +1892,19 @@ static int migration_cpu_stop(void *data
>   */
>  void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_mask, u32 flags)
>  {
> -	cpumask_copy(&p->cpus_mask, new_mask);
> -	p->nr_cpus_allowed = cpumask_weight(new_mask);
> +	if (flags & SCA_MIGRATE_DISABLE) {
> +		p->cpus_ptr = new_mask;
> +		p->nr_cpus_allowed = 1;
> +		return;
> +	}
> +
> +	if (flags & SCA_MIGRATE_ENABLE)
> +		p->cpus_ptr = &p->cpus_mask;

There's that check in __set_cpus_allowed_ptr() that new_mask *must* be
p->cpus_mask when SCA_MIGRATE_ENABLE; that means we could mayhaps shuffle
that to:

---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7cb13df48366..e0e4e42c5e32 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1892,18 +1892,14 @@ static int migration_cpu_stop(void *data)
  */
 void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_mask, u32 flags)
 {
-	if (flags & SCA_MIGRATE_DISABLE) {
+	if (flags & (SCA_MIGRATE_DISABLE | SCA_MIGRATE_ENABLE))
                p->cpus_ptr = new_mask;
-		p->nr_cpus_allowed = 1;
-		return;
-	}
-
-	if (flags & SCA_MIGRATE_ENABLE)
-		p->cpus_ptr = &p->cpus_mask;
        else
                cpumask_copy(&p->cpus_mask, new_mask);

-	if (p->cpus_ptr == &p->cpus_mask)
+	if (flags & SCA_MIGRATE_DISABLE)
+		p->nr_cpus_allowed = 1;
+	else if (p->cpus_ptr == &p->cpus_mask)
                p->nr_cpus_allowed = cpumask_weight(p->cpus_ptr);
 }

---

> +	else
> +		cpumask_copy(&p->cpus_mask, new_mask);
> +
> +	if (p->cpus_ptr == &p->cpus_mask)
> +		p->nr_cpus_allowed = cpumask_weight(p->cpus_ptr);
>  }
>
>  static void

[...]

> @@ -1891,9 +1979,14 @@ static int __set_cpus_allowed_ptr(struct
>       rq = task_rq_lock(p, &rf);
>       update_rq_clock(rq);
>
> -	if (p->flags & PF_KTHREAD) {
> +	if (p->flags & PF_KTHREAD || is_migration_disabled(p)) {
>               /*
> -		 * Kernel threads are allowed on online && !active CPUs
> +		 * Kernel threads are allowed on online && !active CPUs.
> +		 *
> +		 * Specifically, migration_disabled() tasks must not fail the
> +		 * cpumask_and_and_distribute() pick below, esp. so on

s/and_and/and/

> +		 * SCA_MIGRATE_ENABLE, otherwise we'll not call
> +		 * set_cpus_allowed_common() and actually reset p->cpus_ptr.
>                */
>               cpu_valid_mask = cpu_online_mask;
>       }
