Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF8D2AC93F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 00:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730778AbgKIXXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 18:23:18 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:58132 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgKIXXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 18:23:18 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9NDj9B189702;
        Mon, 9 Nov 2020 23:23:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : references
 : from : to : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=3ZO8bg9r6TKZ6SnICTJvFF+t0nzlnGOvrSmmh/6z+l4=;
 b=MIY7qmLYADZWKpwvQBlTLpQivDeYJgrZXak5YMLElSdYuaIhEWGFHRDmjNUbOwtguPGL
 BwURdV5V0YSfo+xVpWrOxU9myQ8rv+1MDXTCE0gjstfIeiZTFT7rvmFpCL+DaiZBkZnP
 HndlJfq2eLjxGE1oI7CvhF584Xpt1PEhhJWHkAoLH1FKX5QYpE5m52vOHhww0b5uhsJm
 ERFnD0ATTkR7h6o6ObFJtgN3tc1s/GV8NFoSZS3NjuRYtmI9vpCvUWoVHeRlkh52cGxv
 7oGhVFWSeGLU1oHJfmvfw0DtttWruYs4SkV58w/Z4EX5YnlKcmJAqM6YMwP7rsUrMm51 Og== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 34nkhkrt50-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 23:23:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9NF2Z9061499;
        Mon, 9 Nov 2020 23:23:15 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 34p5br7x4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 23:23:15 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A9NNFar028771;
        Mon, 9 Nov 2020 23:23:15 GMT
Received: from [192.168.0.193] (/69.207.174.138)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 15:23:14 -0800
Subject: Re: [PATCH v8 -tip 17/26] sched: Split the cookie and setup per-task
 cookie on fork
References: <4ff7f030-b797-6711-fb6a-fe39bb02075a@oracle.com>
From:   chris hyser <chris.hyser@oracle.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
X-Forwarded-Message-Id: <4ff7f030-b797-6711-fb6a-fe39bb02075a@oracle.com>
Message-ID: <6e864ca1-d02b-dc56-7ec2-6224eeb0b32d@oracle.com>
Date:   Mon, 9 Nov 2020 18:23:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <4ff7f030-b797-6711-fb6a-fe39bb02075a@oracle.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9800 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011090147
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9800 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090147
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 10/19/20 9:43 PM, Joel Fernandes (Google) wrote:
>> In order to prevent interference and clearly support both per-task and CGroup
>> APIs, split the cookie into 2 and allow it to be set from either per-task, or
>> CGroup API. The final cookie is the combined value of both and is computed when
>> the stop-machine executes during a change of cookie.
>>
>> Also, for the per-task cookie, it will get weird if we use pointers of any
>> emphemeral objects. For this reason, introduce a refcounted object who's sole
>> purpose is to assign unique cookie value by way of the object's pointer.
>>
>> While at it, refactor the CGroup code a bit. Future patches will introduce more
>> APIs and support.
>>
>> Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>> ---
>>   include/linux/sched.h |   2 +
>>   kernel/sched/core.c   | 241 ++++++++++++++++++++++++++++++++++++++++--
>>   kernel/sched/debug.c  |   4 +
>>   3 files changed, 236 insertions(+), 11 deletions(-)
>>
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index fe6f225bfbf9..c6034c00846a 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -688,6 +688,8 @@ struct task_struct {
>>   #ifdef CONFIG_SCHED_CORE
>>       struct rb_node            core_node;
>>       unsigned long            core_cookie;
>> +    unsigned long            core_task_cookie;
>> +    unsigned long            core_group_cookie;
>>       unsigned int            core_occupation;
>>   #endif
>>   diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index bab4ea2f5cd8..30a9e4cb5ce1 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -346,11 +346,14 @@ void sched_core_put(void)
>>       mutex_unlock(&sched_core_mutex);
>>   }
>>   +static int sched_core_share_tasks(struct task_struct *t1, struct task_struct *t2);
>> +
>>   #else /* !CONFIG_SCHED_CORE */
>>     static inline void sched_core_enqueue(struct rq *rq, struct task_struct *p) { }
>>   static inline void sched_core_dequeue(struct rq *rq, struct task_struct *p) { }
>>   static bool sched_core_enqueued(struct task_struct *task) { return false; }
>> +static int sched_core_share_tasks(struct task_struct *t1, struct task_struct *t2) { }
>>     #endif /* CONFIG_SCHED_CORE */
>>   @@ -3583,6 +3586,20 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
>>   #endif
>>   #ifdef CONFIG_SCHED_CORE
>>       RB_CLEAR_NODE(&p->core_node);
>> +
>> +    /*
>> +     * Tag child via per-task cookie only if parent is tagged via per-task
>> +     * cookie. This is independent of, but can be additive to the CGroup tagging.
>> +     */
>> +    if (current->core_task_cookie) {
>> +
>> +        /* If it is not CLONE_THREAD fork, assign a unique per-task tag. */
>> +        if (!(clone_flags & CLONE_THREAD)) {
>> +            return sched_core_share_tasks(p, p);
>> +               }
>> +        /* Otherwise share the parent's per-task tag. */
>> +        return sched_core_share_tasks(p, current);
>> +    }
>>   #endif
>>       return 0;
>>   } 

sched_core_share_tasks() looks at the value of the new tasks core_task_cookie which is non-zero on a
process or thread clone and causes underflow for both the enable flag itself and for cookie ref counts.

So just zero it in __sched_fork().

-chris


PATCH] sched: zero out the core scheduling cookie on clone

From: chris hyser <chris.hyser@oracle.com>

As the cookie is reference counted, even if inherited, zero this and allow
explicit sharing.

Signed-off-by: Chris Hyser <chris.hyser@oracle.com>
---
  kernel/sched/core.c | 3 +++
  1 file changed, 3 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fd3cc03..2af0ea6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3378,6 +3378,9 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
  	p->capture_control = NULL;
  #endif
  	init_numa_balancing(clone_flags, p);
+#ifdef CONFIG_SCHED_CORE
+	p->core_task_cookie = 0;
+#endif
  #ifdef CONFIG_SMP
  	p->wake_entry.u_flags = CSD_TYPE_TTWU;
  #endif
-- 
1.8.3.1

