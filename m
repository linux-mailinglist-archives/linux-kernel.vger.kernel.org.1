Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D96328780B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 17:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbgJHPts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 11:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgJHPts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 11:49:48 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856A9C061755
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 08:49:48 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id y14so4616335pgf.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 08:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XrVI6qb2D27XbnTtXAbBJwgv62WwM2IIEoNGdboUmaM=;
        b=WLCVGWn8IidhSWiytc0e9YZ3TNG6WSFYJehTlGVcPrCyM11AysFiajfHJv50zWdWFd
         Fmj+vEZ3mZxlVJVVVH+d85VdUc4Ki4BYMz2NjaGVMqNgJq8H1hVkbymMMKzwmChzM6Re
         d0Fm/JZhuOj1NAMjGOg52RpGn71rE4lnqIrczrAQ/nmNyyF7yanmlLARLOs4nHWFgZzr
         3uYhBZVvjdB8l78XLxSgNPiikCM/nKqZCEvTpT2ltVWwyJAZIgyhlpWw/HckEil0ZhCj
         JsYrxp688q9SsVBR8+qFKfX0SYVNC2zUuYjoQBOzHMeC4uNLm+WrPkFLgTaJu16pO+Xw
         F4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XrVI6qb2D27XbnTtXAbBJwgv62WwM2IIEoNGdboUmaM=;
        b=R/tJCbxRVg20X7tZzV1cxX7fv2k0bzY520NO72ZM7EVyhHrc0ZoMfndE9yf6RwNQ1X
         av95dcG1aL43OB5Uuidtg2NRO8YBmKE+WT7qAxEyhSSPooQ1TtQj5sCR4yqkQkNBmc78
         Uo5lJR5RCdH+uJT2A+3YFqfFfEVEpKLRMEAFQU0JRuHLyrgrlR6RtL9U2+wkrvHqX5Vg
         C6fpGBa8uSBBT6n3jchBUsMfZN5E71I8zVv+0qNLhUThWqN/0cmyfjL/w/1bEAVBmpWV
         VLfynp7WMxuftTh872oLO1jICf5yjkuOw/QIY/ap9vO+nJ1KzQytEN5t14cLUZaUsq/O
         uZ2A==
X-Gm-Message-State: AOAM530Hk06GqmmekWs4UPhyKzfNZcK0B+rZK13UezVikmlZKP8euzpK
        dzUBOfftywAqSGZwfF7vZzHTpPLHL3s=
X-Google-Smtp-Source: ABdhPJzQeTuhmm/OzvIAK9UnXJy6IdwVXye9C0x3RiyAfb0f4RSOJzq7eBQggIIeRQfZlHQ8wwWNng==
X-Received: by 2002:aa7:8397:0:b029:13e:d13d:a07c with SMTP id u23-20020aa783970000b029013ed13da07cmr7779429pfm.19.1602172187484;
        Thu, 08 Oct 2020 08:49:47 -0700 (PDT)
Received: from iZj6chx1xj0e0buvshuecpZ ([47.75.1.235])
        by smtp.gmail.com with ESMTPSA id mt2sm7765250pjb.17.2020.10.08.08.49.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Oct 2020 08:49:46 -0700 (PDT)
Date:   Thu, 8 Oct 2020 23:49:42 +0800
From:   Peng Liu <iwtbavbm@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, valentin.schneider@arm.com, raistlin@linux.it,
        iwtbavbm@gmail.com
Subject: [PATCH v6 2/2] sched/deadline: Fix sched_dl_global_validate()
Message-ID: <db6bbda316048cda7a1bbc9571defde193a8d67e.1602171061.git.iwtbavbm@gmail.com>
References: <cover.1602171061.git.iwtbavbm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1602171061.git.iwtbavbm@gmail.com>
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
index 365e5fec8c28..ac0c53672e83 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2540,7 +2540,7 @@ int sched_dl_global_validate(void)
 	u64 new_bw = to_ratio(period, runtime);
 	u64 gen = ++dl_generation;
 	struct dl_bw *dl_b;
-	int cpu, ret = 0;
+	int cpu, cpus, ret = 0;
 	unsigned long flags;
 
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
index ce527b981e61..5076ea05b2e0 100644
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

