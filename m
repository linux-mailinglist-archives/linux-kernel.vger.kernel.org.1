Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 992532AF779
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 18:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbgKKRlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 12:41:16 -0500
Received: from foss.arm.com ([217.140.110.172]:58898 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727103AbgKKRlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 12:41:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FBC41396;
        Wed, 11 Nov 2020 09:41:14 -0800 (PST)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 614BF3F6CF;
        Wed, 11 Nov 2020 09:41:13 -0800 (PST)
Subject: Re: [PATCH v5 1/1] sched/uclamp: add SCHED_FLAG_UTIL_CLAMP_RESET flag
 to reset uclamp
To:     Peter Zijlstra <peterz@infradead.org>,
        Yun Hsiang <hsiang023167@gmail.com>
Cc:     linux-kernel@vger.kernel.org, qais.yousef@arm.com,
        patrick.bellasi@matbug.net, kernel test robot <lkp@intel.com>
References: <20201103023756.1012088-1-hsiang023167@gmail.com>
 <20201110122108.GG2594@hirez.programming.kicks-ass.net>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <f3b59aad-3d5d-039b-205d-024308b609a1@arm.com>
Date:   Wed, 11 Nov 2020 18:41:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201110122108.GG2594@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/2020 13:21, Peter Zijlstra wrote:
> On Tue, Nov 03, 2020 at 10:37:56AM +0800, Yun Hsiang wrote:
>> If the user wants to stop controlling uclamp and let the task inherit
>> the value from the group, we need a method to reset.
>>
>> Add SCHED_FLAG_UTIL_CLAMP_RESET flag to allow the user to reset uclamp via
>> sched_setattr syscall.
>>
>> The policy is
>> _CLAMP_RESET                           => reset both min and max
>> _CLAMP_RESET | _CLAMP_MIN              => reset min value
>> _CLAMP_RESET | _CLAMP_MAX              => reset max value
>> _CLAMP_RESET | _CLAMP_MIN | _CLAMP_MAX => reset both min and max
>>
> 
> The obvious alternative would be to use a magic value in
> sched_util_{min,max} to indicate reset. After all, we strictly enforce
> the values are inside [0,1024], which leaves us with many unused values.
> 
> Specifically -1 comes to mind. It would allow doing this without an
> extra flag, OTOH the explicit flag is well, more explicit.
> 
> I don't have a strong preference either way, but I wanted to make sure
> it was considered, and perhaps we can record why this isn't as nice a
> solution, dunno.

IMHO the '-1'  magic value approach is cleaner. Did some light testing on it.

From 2e6a64fac4f2f66a2c6246de33db22c467fa7d33 Mon Sep 17 00:00:00 2001
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Date: Wed, 11 Nov 2020 01:14:33 +0100
Subject: [PATCH] sched/uclamp: Allow to reset a task uclamp constraint value

In case the user wants to stop controlling a uclamp constraint value
for a task, use the magic value -1 in sched_util_{min,max} with the
appropriate sched_flags (SCHED_FLAG_UTIL_CLAMP_{MIN,MAX}) to indicate
the reset.

The advantage over the 'additional flag' approach (i.e. introducing
SCHED_FLAG_UTIL_CLAMP_RESET) is that no additional flag has to be
exported via uapi. This avoids the need to document how this new flag
has be used in conjunction with the existing uclamp related flags.

The following subtle issue is fixed as well. When a uclamp constraint
value is set on a !user_defined uclamp_se it is currently first reset
and then set.
Fix this by AND'ing !user_defined with !SCHED_FLAG_UTIL_CLAMP which
stands for the 'sched class change' case.
The related condition 'if (uc_se->user_defined)' moved from
__setscheduler_uclamp() into uclamp_reset().

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 include/uapi/linux/sched/types.h |  4 +-
 kernel/sched/core.c              | 70 +++++++++++++++++++++++---------
 2 files changed, 53 insertions(+), 21 deletions(-)

diff --git a/include/uapi/linux/sched/types.h b/include/uapi/linux/sched/types.h
index c852153ddb0d..b9165f17dddc 100644
--- a/include/uapi/linux/sched/types.h
+++ b/include/uapi/linux/sched/types.h
@@ -115,8 +115,8 @@ struct sched_attr {
 	__u64 sched_period;
 
 	/* Utilization hints */
-	__u32 sched_util_min;
-	__u32 sched_util_max;
+	__s32 sched_util_min;
+	__s32 sched_util_max;
 
 };
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3dc415f58bd7..caaa2a8434b9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1413,17 +1413,24 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 static int uclamp_validate(struct task_struct *p,
 			   const struct sched_attr *attr)
 {
-	unsigned int lower_bound = p->uclamp_req[UCLAMP_MIN].value;
-	unsigned int upper_bound = p->uclamp_req[UCLAMP_MAX].value;
+	int util_min = p->uclamp_req[UCLAMP_MIN].value;
+	int util_max = p->uclamp_req[UCLAMP_MAX].value;
 
-	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN)
-		lower_bound = attr->sched_util_min;
-	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX)
-		upper_bound = attr->sched_util_max;
+	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
+		util_min = attr->sched_util_min;
 
-	if (lower_bound > upper_bound)
-		return -EINVAL;
-	if (upper_bound > SCHED_CAPACITY_SCALE)
+		if (util_min < -1 || util_min > SCHED_CAPACITY_SCALE)
+			return -EINVAL;
+	}
+
+	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
+		util_max = attr->sched_util_max;
+
+		if (util_max < -1 || util_max > SCHED_CAPACITY_SCALE)
+			return -EINVAL;
+	}
+
+	if (util_min != -1 && util_max != -1 && util_min > util_max)
 		return -EINVAL;
 
 	/*
@@ -1438,20 +1445,41 @@ static int uclamp_validate(struct task_struct *p,
 	return 0;
 }
 
+static bool uclamp_reset(const struct sched_attr *attr,
+			 enum uclamp_id clamp_id,
+			 struct uclamp_se *uc_se)
+{
+	/* Reset on sched class change for a non user-defined clamp value. */
+	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)) &&
+	    !uc_se->user_defined)
+		return true;
+
+	/* Reset on sched_util_{min,max} == -1 */
+	if (clamp_id == UCLAMP_MIN &&
+	    attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN &&
+	    attr->sched_util_min == -1) {
+		return true;
+	}
+
+	if (clamp_id == UCLAMP_MAX &&
+	    attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX &&
+	    attr->sched_util_max == -1) {
+		return true;
+	}
+
+	return false;
+}
+
 static void __setscheduler_uclamp(struct task_struct *p,
 				  const struct sched_attr *attr)
 {
 	enum uclamp_id clamp_id;
 
-	/*
-	 * On scheduling class change, reset to default clamps for tasks
-	 * without a task-specific value.
-	 */
 	for_each_clamp_id(clamp_id) {
 		struct uclamp_se *uc_se = &p->uclamp_req[clamp_id];
+		unsigned int value;
 
-		/* Keep using defined clamps across class changes */
-		if (uc_se->user_defined)
+		if (!uclamp_reset(attr, clamp_id, uc_se))
 			continue;
 
 		/*
@@ -1459,21 +1487,25 @@ static void __setscheduler_uclamp(struct task_struct *p,
 		 * at runtime.
 		 */
 		if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
-			__uclamp_update_util_min_rt_default(p);
+			value = sysctl_sched_uclamp_util_min_rt_default;
 		else
-			uclamp_se_set(uc_se, uclamp_none(clamp_id), false);
+			value = uclamp_none(clamp_id);
+
+		uclamp_se_set(uc_se, value, false);
 
 	}
 
 	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
 		return;
 
-	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
+	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN &&
+	    attr->sched_util_min != -1) {
 		uclamp_se_set(&p->uclamp_req[UCLAMP_MIN],
 			      attr->sched_util_min, true);
 	}
 
-	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
+	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX &&
+	    attr->sched_util_max != -1) {
 		uclamp_se_set(&p->uclamp_req[UCLAMP_MAX],
 			      attr->sched_util_max, true);
 	}
-- 
2.17.1
