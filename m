Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 622B82861E8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 17:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbgJGPNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 11:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbgJGPNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 11:13:35 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954E0C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 08:13:34 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b26so1504124pff.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 08:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=60K5yQLXhOW5MXL15zEY/TQmlUvgIOWGlpkrxNn/bP0=;
        b=UClLUso3y8XQBRG2gsMSJPY7C8oBGFZZ23Pvv4Uup+/AYF+FqxxTJ1DEy3JlLlih8z
         YtE/eIxetbo2XJezeGL/NYU4Cilq+We6PXh5X/dCMi3yVHB2KRpYwCR0X36U7YrtX3LS
         Ax//T3LQLKIZ9meNevDaZg2c1j5ZvLSd0I3hpqI6im7mr03ebqqQ6Pr25/OaHkVT20Jy
         54IFmlUan0/+QLkRFQF4EaTn2T3f+VhvFTxf/OeXEEiuPAQ8D1RvkcaS5bAck/366YZt
         a1K0wAQDBfpRanRVVAhuLHXkw6JOQPxSrhAhE4jsTRfbYLRKoXNqu5AD4PGKrX6bMYbb
         gXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=60K5yQLXhOW5MXL15zEY/TQmlUvgIOWGlpkrxNn/bP0=;
        b=uL+3VTL3+mKcKiHNk2FVS6EmSs2kiwyIlDcHwFw6bMKAeZD6IPpHAziD1nrd4rm7eH
         eR7vLWTEeJKRBA6yVkTeeARgbeDNmNuBo+K/1xdCgKdLL4fp3IeNnJo7yTsFvlBeR4kS
         q5TcInona4VdAMkS3QQ91lG4HcOFElqyxE+4j772tXWT7Xl1gPFKQJr+dLg2LY+xqsTW
         3m6aWrutXvNwV07oVmVi+oVW327hrJ/tnMxXMHTbPWID4anXAYjSrgN2mLOjDI3jA2Qq
         PCKuIHk3fZWEPGcBX4HQ0PFxVMIeOGnfBjhhO3pAYOr0MSFRJknXKs9k131FHNaCoV0i
         Bxpw==
X-Gm-Message-State: AOAM532lzzD1KsZo0FtNuuQI8XSHFqmlXvKTGFpMXx3gkdbjsjht9ThY
        XzXY/YwG7KH6jlPpVwGiAHyWGZg+Gkg=
X-Google-Smtp-Source: ABdhPJwDztb4mE80dQC+DgQCr2f4tThm4WAbJ3Z693WKaslUGAJ1hmEfff/sNZwq8RGGEZmxEu7T0A==
X-Received: by 2002:a63:801:: with SMTP id 1mr3542319pgi.48.1602083613601;
        Wed, 07 Oct 2020 08:13:33 -0700 (PDT)
Received: from iZj6chx1xj0e0buvshuecpZ ([47.75.1.235])
        by smtp.gmail.com with ESMTPSA id j12sm2703948pjs.21.2020.10.07.08.13.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Oct 2020 08:13:32 -0700 (PDT)
Date:   Wed, 7 Oct 2020 23:13:28 +0800
From:   Peng Liu <iwtbavbm@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, valentin.schneider@arm.com, raistlin@linux.it,
        iwtbavbm@gmail.com
Subject: [PATCH v5 2/2] sched/deadline: Fix sched_dl_global_validate()
Message-ID: <c39cca24a4dfa0674b6b834ec31d20b83638b99a.1601993091.git.iwtbavbm@gmail.com>
References: <cover.1601993091.git.iwtbavbm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1601993091.git.iwtbavbm@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When change sched_rt_{runtime, period}_us, we validate that the new
settings should at least accommodate the currently allocated -dl
bandwidth:

  sched_rt_handler()
    -->	sched_dl_bandwidth_validate()
	{
		new_bw = global_rt_runtime()/global_rt_period();

		for_each_possible_cpu(cpu) {
			dl_b = dl_bw_of(cpu);
			if (new_bw < dl_b->total_bw)    <-------
				ret = -EBUSY;
		}
	}

But under CONFIG_SMP, dl_bw is per root domain , but not per CPU,
dl_b->total_bw is the allocated bandwidth of the whole root domain.
Instead, we should compare dl_b->total_bw against "cpus*new_bw",
where 'cpus' is the number of CPUs of the root domain.

Also, below annotation(in kernel/sched/sched.h) implied implementation
only appeared in SCHED_DEADLINE v2[1], then deadline scheduler kept
evolving till got merged(v9), but the annotation remains unchanged,
meaningless and misleading, update it.

* With respect to SMP, the bandwidth is given on a per-CPU basis,
* meaning that:
*  - dl_bw (< 100%) is the bandwidth of the system (group) on each CPU;
*  - dl_total_bw array contains, in the i-eth element, the currently
*    allocated bandwidth on the i-eth CPU.

[1]: https://lore.kernel.org/lkml/1267385230.13676.101.camel@Palantir/

Fixes: 332ac17ef5bf ("sched/deadline: Add bandwidth management for SCHED_DEADLINE tasks")
Signed-off-by: Peng Liu <iwtbavbm@gmail.com>
---
 kernel/sched/deadline.c |  5 +++--
 kernel/sched/sched.h    | 42 ++++++++++++++++++-----------------------
 2 files changed, 21 insertions(+), 26 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 5200e185923f..e32715db7119 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2540,7 +2540,7 @@ int sched_dl_global_validate(void)
 	u64 new_bw = to_ratio(period, runtime);
 	struct dl_bw *dl_b;
 	unsigned long flags;
-	int cpu, ret = 0;
+	int cpu, cpus, ret = 0;
 	u32 gen = ++dl_generation;
 
 	/*
@@ -2555,9 +2555,10 @@ int sched_dl_global_validate(void)
 			goto next;
 
 		dl_b = dl_bw_of(cpu);
+		cpus = dl_bw_cpus(cpu);
 
 		raw_spin_lock_irqsave(&dl_b->lock, flags);
-		if (new_bw < dl_b->total_bw)
+		if (new_bw * cpus < dl_b->total_bw)
 			ret = -EBUSY;
 		raw_spin_unlock_irqrestore(&dl_b->lock, flags);
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 53477e8b26b0..b407e7af8e09 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -257,30 +257,6 @@ struct rt_bandwidth {
 
 void __dl_clear_params(struct task_struct *p);
 
-/*
- * To keep the bandwidth of -deadline tasks and groups under control
- * we need some place where:
- *  - store the maximum -deadline bandwidth of the system (the group);
- *  - cache the fraction of that bandwidth that is currently allocated.
- *
- * This is all done in the data structure below. It is similar to the
- * one used for RT-throttling (rt_bandwidth), with the main difference
- * that, since here we are only interested in admission control, we
- * do not decrease any runtime while the group "executes", neither we
- * need a timer to replenish it.
- *
- * With respect to SMP, the bandwidth is given on a per-CPU basis,
- * meaning that:
- *  - dl_bw (< 100%) is the bandwidth of the system (group) on each CPU;
- *  - dl_total_bw array contains, in the i-eth element, the currently
- *    allocated bandwidth on the i-eth CPU.
- * Moreover, groups consume bandwidth on each CPU, while tasks only
- * consume bandwidth on the CPU they're running on.
- * Finally, dl_total_bw_cpu is used to cache the index of dl_total_bw
- * that will be shown the next time the proc or cgroup controls will
- * be red. It on its turn can be changed by writing on its own
- * control.
- */
 struct dl_bandwidth {
 	raw_spinlock_t		dl_runtime_lock;
 	u64			dl_runtime;
@@ -292,6 +268,24 @@ static inline int dl_bandwidth_enabled(void)
 	return sysctl_sched_rt_runtime >= 0;
 }
 
+/*
+ * To keep the bandwidth of -deadline tasks under control
+ * we need some place where:
+ *  - store the maximum -deadline bandwidth of each cpu;
+ *  - cache the fraction of bandwidth that is currently allocated in
+ *    each root domain;
+ *
+ * This is all done in the data structure below. It is similar to the
+ * one used for RT-throttling (rt_bandwidth), with the main difference
+ * that, since here we are only interested in admission control, we
+ * do not decrease any runtime while the group "executes", neither we
+ * need a timer to replenish it.
+ *
+ * With respect to SMP, bandwidth is given on a per root domain basis,
+ * meaning that:
+ *  - bw (< 100%) is the deadline bandwidth of each CPU;
+ *  - total_bw is the currently allocated bandwidth in each root domain;
+ */
 struct dl_bw {
 	raw_spinlock_t		lock;
 	u64			bw;
-- 
2.20.1

