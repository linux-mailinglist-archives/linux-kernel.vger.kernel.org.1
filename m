Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7B429965C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 20:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1791391AbgJZTAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 15:00:52 -0400
Received: from foss.arm.com ([217.140.110.172]:49576 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1791383AbgJZTAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 15:00:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA40B139F;
        Mon, 26 Oct 2020 12:00:50 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB3073F66E;
        Mon, 26 Oct 2020 12:00:49 -0700 (PDT)
Subject: Re: [PATCH v3 1/1] sched/uclamp: add SCHED_FLAG_UTIL_CLAMP_RESET flag
 to reset uclamp
To:     Yun Hsiang <hsiang023167@gmail.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        qais.yousef@arm.com, patrick.bellasi@matbug.net
References: <20201025073632.720393-1-hsiang023167@gmail.com>
 <08b7cdda-291c-bdf1-b72d-0a3ef411fcf3@arm.com>
 <20201026154538.GA807103@ubuntu>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <605c21f7-3c4d-5c24-6d23-9f2604e6757b@arm.com>
Date:   Mon, 26 Oct 2020 20:00:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201026154538.GA807103@ubuntu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/2020 16:45, Yun Hsiang wrote:
> Hi Dietmar,
> 
> On Mon, Oct 26, 2020 at 10:47:11AM +0100, Dietmar Eggemann wrote:
>> On 25/10/2020 08:36, Yun Hsiang wrote:
>>> If the user wants to stop controlling uclamp and let the task inherit
>>> the value from the group, we need a method to reset.
>>>
>>> Add SCHED_FLAG_UTIL_CLAMP_RESET flag to allow the user to reset uclamp via
>>> sched_setattr syscall.
>>>
>>> The policy is
>>> _CLAMP_RESET                           => reset both min and max
>>> _CLAMP_RESET | _CLAMP_MIN              => reset min value
>>> _CLAMP_RESET | _CLAMP_MAX              => reset max value
>>> _CLAMP_RESET | _CLAMP_MIN | _CLAMP_MAX => reset both min and max
>>>
>>> Signed-off-by: Yun Hsiang <hsiang023167@gmail.com>
>>
>> [...]
>>
>>> @@ -1451,7 +1464,8 @@ static void __setscheduler_uclamp(struct task_struct *p,
>>>  		struct uclamp_se *uc_se = &p->uclamp_req[clamp_id];
>>>  
>>>  		/* Keep using defined clamps across class changes */
>>> -		if (uc_se->user_defined)
>>> +		if (flags != SCHED_FLAG_UTIL_CLAMP_RESET &&
>>> +				uc_se->user_defined)
>>>  			continue;
>>
>> With:
>>
>> (1) _CLAMP_RESET                           => reset both min and max
>> (2) _CLAMP_RESET | _CLAMP_MIN              => reset min value
>> (3) _CLAMP_RESET | _CLAMP_MAX              => reset max value
>> (4) _CLAMP_RESET | _CLAMP_MIN | _CLAMP_MAX => reset both min and max
>>
>> If you reset an RT task with (1) you don't reset its uclamp.min value.
>>
>> __uclamp_update_util_min_rt_default(p) doesn't know about
>> SCHED_FLAG_UTIL_CLAMP_RESET. It only knows user_defined and will bail early.
>>
> 
> Sorry I didn't notice __uclamp_update_util_min_rt_default will return
> directly if user_defined is set, I'll fix it.
> 
>> [...]
>>
>>> -	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
>>> +	if (likely(!flags || flags == SCHED_FLAG_UTIL_CLAMP_RESET))
>>>  		return;
>>>  
>>> -	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
>>> +	if (flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
>>> +		if (reset) {
>>> +			clamp_value = __default_uclamp_value(p, UCLAMP_MIN);
>>> +			user_defined = false;
>>> +		} else {
>>> +			clamp_value = attr->sched_util_min;
>>> +			user_defined = true;
>>> +		}
>>
>> Why do you reset for (1) in the for_each_clamp_id(clamp_id) loop and for
>> (2)-(4) in the if (flags & SCHED_FLAG_UTIL_CLAMP_MXX) condition?
>>
>> You could reset (1)-(4) in the for_each_clamp_id(clamp_id) loop? In this
>> case you wouldn't need __default_uclamp_value().
> 
> Do you mean adding these code in for_each_clamp_id(clamp_id) loop?
> 
> if (clamp_id == UCLAMP_MIN) {
> 	if (flags == SCHED_FLAG_UTIL_CLAMP_RESET || 
> 		(reset && (flags || SCHED_FLAG_UTIL_CLAMP_MIN)) ||
> 		!se->user_defined) {
> 		if (task_rt(p)) {
> 			clamp_value = sysctl_sched_uclamp_util_min_rt_default
> 		} else {
> 			clamp_value = uclamp_none(clamp_id);
> 		}
> 	} else 
> 		continue;
> }
> /* similar code for UCLAMP_MAX */
> ...
> uclamp_se_set(uc_se, clamp_value, false);
> 
> It seems more clear.
> If you think this one is better, I'll use this method and send patch V4.

I thought about something like this. Only lightly tested. 

---8<---

From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Date: Mon, 26 Oct 2020 13:52:23 +0100
Subject: [PATCH] SCHED_FLAG_UTIL_CLAMP_RESET

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 include/uapi/linux/sched.h |  4 +++-
 kernel/sched/core.c        | 31 +++++++++++++++++++++++++++----
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 3bac0a8ceab2..0dd890822751 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -132,12 +132,14 @@ struct clone_args {
 #define SCHED_FLAG_KEEP_PARAMS		0x10
 #define SCHED_FLAG_UTIL_CLAMP_MIN	0x20
 #define SCHED_FLAG_UTIL_CLAMP_MAX	0x40
+#define SCHED_FLAG_UTIL_CLAMP_RESET	0x80
 
 #define SCHED_FLAG_KEEP_ALL	(SCHED_FLAG_KEEP_POLICY | \
 				 SCHED_FLAG_KEEP_PARAMS)
 
 #define SCHED_FLAG_UTIL_CLAMP	(SCHED_FLAG_UTIL_CLAMP_MIN | \
-				 SCHED_FLAG_UTIL_CLAMP_MAX)
+				 SCHED_FLAG_UTIL_CLAMP_MAX | \
+				 SCHED_FLAG_UTIL_CLAMP_RESET)
 
 #define SCHED_FLAG_ALL	(SCHED_FLAG_RESET_ON_FORK	| \
 			 SCHED_FLAG_RECLAIM		| \
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3dc415f58bd7..717b1cf5cf1f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1438,6 +1438,23 @@ static int uclamp_validate(struct task_struct *p,
 	return 0;
 }
 
+static bool uclamp_reset(enum uclamp_id clamp_id, unsigned long flags)
+{
+	if (!(flags & SCHED_FLAG_UTIL_CLAMP_RESET))
+		return false;
+
+	if (!(flags & (SCHED_FLAG_UTIL_CLAMP_MIN | SCHED_FLAG_UTIL_CLAMP_MAX)))
+		return true;
+
+	if ((flags & SCHED_FLAG_UTIL_CLAMP_MIN) && clamp_id == UCLAMP_MIN)
+		return true;
+
+	if ((flags & SCHED_FLAG_UTIL_CLAMP_MAX) && clamp_id == UCLAMP_MAX)
+		return true;
+
+	return false;
+}
+
 static void __setscheduler_uclamp(struct task_struct *p,
 				  const struct sched_attr *attr)
 {
@@ -1449,24 +1466,30 @@ static void __setscheduler_uclamp(struct task_struct *p,
 	 */
 	for_each_clamp_id(clamp_id) {
 		struct uclamp_se *uc_se = &p->uclamp_req[clamp_id];
+		unsigned int value;
 
 		/* Keep using defined clamps across class changes */
-		if (uc_se->user_defined)
+		if (!uclamp_reset(clamp_id, attr->sched_flags) &&
+		    uc_se->user_defined) {
 			continue;
+		}
 
 		/*
 		 * RT by default have a 100% boost value that could be modified
 		 * at runtime.
 		 */
 		if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
-			__uclamp_update_util_min_rt_default(p);
+			value = sysctl_sched_uclamp_util_min_rt_default;
 		else
-			uclamp_se_set(uc_se, uclamp_none(clamp_id), false);
+			value = uclamp_none(clamp_id);
 
+		uclamp_se_set(uc_se, value, false);
 	}
 
-	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
+	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)) ||
+	    attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_RESET) {
 		return;
+	}
 
 	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
 		uclamp_se_set(&p->uclamp_req[UCLAMP_MIN],
-- 
2.17.1



