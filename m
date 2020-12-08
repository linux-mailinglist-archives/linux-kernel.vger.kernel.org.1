Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE912D2548
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 09:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgLHIA3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 8 Dec 2020 03:00:29 -0500
Received: from smtp.h3c.com ([60.191.123.56]:56160 "EHLO h3cspam01-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727420AbgLHIA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 03:00:28 -0500
Received: from DAG2EX01-BASE.srv.huawei-3com.com ([10.8.0.64])
        by h3cspam01-ex.h3c.com with ESMTP id 0B87wqWN085203;
        Tue, 8 Dec 2020 15:58:52 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX01-BASE.srv.huawei-3com.com (10.8.0.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 8 Dec 2020 15:58:54 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%7]) with
 mapi id 15.01.2106.002; Tue, 8 Dec 2020 15:58:54 +0800
From:   Tianxianting <tian.xianting@h3c.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] sched/rt: Print curr when RT throttling activated
Thread-Topic: [PATCH] sched/rt: Print curr when RT throttling activated
Thread-Index: AQHWyUqT3q2oDjHX10eYLLyUvd1ib6nk66QAgAfwkIA=
Date:   Tue, 8 Dec 2020 07:58:54 +0000
Message-ID: <f3265adc26d4416dacf157f61fa60ad6@h3c.com>
References: <20201203075129.17902-1-tian.xianting@h3c.com>
 <20201203093956.6dd8a753@gandalf.local.home>
In-Reply-To: <20201203093956.6dd8a753@gandalf.local.home>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.99.141.128]
x-sender-location: DAG2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: h3cspam01-ex.h3c.com 0B87wqWN085203
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,
We met an issue that a normal thread can't get cpu, 
And at this moment, we found 'sched: RT throttling activated' log.

So I think this patch is useful for such issue.

Could I get more comments?  Thanks in advance
-----Original Message-----
From: Steven Rostedt [mailto:rostedt@goodmis.org] 
Sent: Thursday, December 03, 2020 10:40 PM
To: tianxianting (RD) <tian.xianting@h3c.com>
Cc: mingo@redhat.com; peterz@infradead.org; juri.lelli@redhat.com; vincent.guittot@linaro.org; dietmar.eggemann@arm.com; bsegall@google.com; mgorman@suse.de; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/rt: Print curr when RT throttling activated

On Thu, 3 Dec 2020 15:51:29 +0800
Xianting Tian <tian.xianting@h3c.com> wrote:

> We may meet the issue, that one RT thread occupied the cpu by 
> 950ms/1s, The RT thread maybe is a business thread or other unknown thread.
> 
> Currently, it only outputs the print "sched: RT throttling activated"
> when RT throttling happen. It is hard to know what is the RT thread, 
> For further analysis, we need add more prints.
> 
> This patch is to print current RT task when RT throttling activated, 
> It help us to know what is the RT thread in the first time.

I think this can be useful information to include.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> 
> Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
> ---
>  kernel/sched/rt.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c index 
> f215eea6a..8913f38cb 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -946,7 +946,7 @@ static inline int rt_se_prio(struct sched_rt_entity *rt_se)
>  	return rt_task_of(rt_se)->prio;
>  }
>  
> -static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq)
> +static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq, struct 
> +task_struct *curr)
>  {
>  	u64 runtime = sched_rt_runtime(rt_rq);
>  
> @@ -970,7 +970,8 @@ static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq)
>  		 */
>  		if (likely(rt_b->rt_runtime)) {
>  			rt_rq->rt_throttled = 1;
> -			printk_deferred_once("sched: RT throttling activated\n");
> +			printk_deferred_once("sched: RT throttling activated (curr: pid %d, comm %s)\n",
> +						curr->pid, curr->comm);
>  		} else {
>  			/*
>  			 * In case we did anyway, make it go away, @@ -1026,7 +1027,7 @@ 
> static void update_curr_rt(struct rq *rq)
>  		if (sched_rt_runtime(rt_rq) != RUNTIME_INF) {
>  			raw_spin_lock(&rt_rq->rt_runtime_lock);
>  			rt_rq->rt_time += delta_exec;
> -			if (sched_rt_runtime_exceeded(rt_rq))
> +			if (sched_rt_runtime_exceeded(rt_rq, curr))
>  				resched_curr(rq);
>  			raw_spin_unlock(&rt_rq->rt_runtime_lock);
>  		}

