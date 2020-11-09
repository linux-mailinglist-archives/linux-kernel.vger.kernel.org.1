Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441FB2AC966
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 00:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbgKIXeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 18:34:50 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:53188 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgKIXet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 18:34:49 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9NUIbl150038;
        Mon, 9 Nov 2020 23:32:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=FDH6vKmwAO2NQK037hjZRuPUy9YCEb1VTOoZECDQrmc=;
 b=IgZm7EQMUyh+OeNBObS9P0PfLmf8JHwTxGFAjApC24xsJzoU1jw6XRrG7Xl+Jylyt+2v
 RFz1P1yxHxMmq4AlZGuvoz0IEebpztZIbcw6Dus7KMgaGwtMzdtafnLw8I0XdquR++9h
 hwMrD6OD6wTVY4MvxgeWi9WIL7SPGhIt3Q5LzKro4LJxsTVFYNMl9Br3nIU0RZOQ6oY1
 KGUv/rk8uJMjynLQ2qFVkhVNfALQVbHkm0BJ2F3I4biQsOASqtbRaxe/NtiBzjJqDMaZ
 amDK4fs5AbzE65/xQvNvz5L84+1ZURPgJ/292mZ2afO4j05TzYfXsxfhxZYBQjk3Casu GA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 34nh3as1y6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 23:32:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9NOnOn085072;
        Mon, 9 Nov 2020 23:30:32 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 34p5fyda9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 23:30:32 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A9NUHbw020143;
        Mon, 9 Nov 2020 23:30:19 GMT
Received: from [192.168.0.193] (/69.207.174.138)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 15:30:17 -0800
Subject: Re: [PATCH v8 -tip 17/26] sched: Split the cookie and setup per-task
 cookie on fork
From:   chris hyser <chris.hyser@oracle.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        pjt@google.com, rostedt@goodmis.org, derkling@google.com,
        benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
 <20201020014336.2076526-18-joel@joelfernandes.org>
 <e296ed5a-d473-de1e-d2ab-af37e5db856a@oracle.com>
Message-ID: <e8565fa2-aca6-7052-d004-8cbae38387a3@oracle.com>
Date:   Mon, 9 Nov 2020 18:30:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <e296ed5a-d473-de1e-d2ab-af37e5db856a@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9800 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090148
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9800 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090149
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/20 5:30 PM, chris hyser wrote:
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
>>   include/linux/sched.h |   2 +
>>   kernel/sched/core.c   | 241 ++++++++++++++++++++++++++++++++++++++++--
>>   kernel/sched/debug.c  |   4 +
>>   3 files changed, 236 insertions(+), 11 deletions(-)
>>
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index fe6f225bfbf9..c6034c00846a 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -688,6 +688,8 @@ struct task_struct {
>>   #ifdef CONFIG_SCHED_CORE
>>       struct rb_node            core_node;
>>       unsigned long            core_cookie;
>> +    unsigned long            core_task_cookie;
>> +    unsigned long            core_group_cookie;
>>       unsigned int            core_occupation;
>>   #endif
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index bab4ea2f5cd8..30a9e4cb5ce1 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -346,11 +346,14 @@ void sched_core_put(void)
>>       mutex_unlock(&sched_core_mutex);
>>   }
>> +static int sched_core_share_tasks(struct task_struct *t1, struct task_struct *t2);
>> +
>>   #else /* !CONFIG_SCHED_CORE */
>>   static inline void sched_core_enqueue(struct rq *rq, struct task_struct *p) { }
>>   static inline void sched_core_dequeue(struct rq *rq, struct task_struct *p) { }
>>   static bool sched_core_enqueued(struct task_struct *task) { return false; }
>> +static int sched_core_share_tasks(struct task_struct *t1, struct task_struct *t2) { }
>>   #endif /* CONFIG_SCHED_CORE */
>> @@ -3583,6 +3586,20 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
>>   #endif
>>   #ifdef CONFIG_SCHED_CORE
>>       RB_CLEAR_NODE(&p->core_node);
>> +
>> +    /*
>> +     * Tag child via per-task cookie only if parent is tagged via per-task
>> +     * cookie. This is independent of, but can be additive to the CGroup tagging.
>> +     */
>> +    if (current->core_task_cookie) {
>> +
>> +        /* If it is not CLONE_THREAD fork, assign a unique per-task tag. */
>> +        if (!(clone_flags & CLONE_THREAD)) {
>> +            return sched_core_share_tasks(p, p);
>> +               }
>> +        /* Otherwise share the parent's per-task tag. */
>> +        return sched_core_share_tasks(p, current);
>> +    }
>>   #endif
>>       return 0;
>>   }

sched_core_share_tasks() looks at the value of the new tasks core_task_cookie which is non-zero on a
process or thread clone and causes underflow for both the enable flag itself and for cookie ref counts.

So just zero it in __sched_fork().

-chrish

------

sched: zero out the core scheduling cookie on clone

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
+    p->core_task_cookie = 0;
+#endif
  #ifdef CONFIG_SMP
      p->wake_entry.u_flags = CSD_TYPE_TTWU;
  #endif
