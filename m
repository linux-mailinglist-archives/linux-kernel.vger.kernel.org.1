Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD7BD26E6D9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 22:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgIQUkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 16:40:03 -0400
Received: from linux.microsoft.com ([13.77.154.182]:34864 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgIQUj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 16:39:58 -0400
Received: from [192.168.86.179] (c-73-38-52-84.hsd1.vt.comcast.net [73.38.52.84])
        by linux.microsoft.com (Postfix) with ESMTPSA id C409120B7178;
        Thu, 17 Sep 2020 13:39:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C409120B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1600375198;
        bh=0uKuarWd2xUvr1x37IumPqUrk4kLzvFwkDr+AogX5/Y=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=KRRE7LKzY3YE0Pk3ihtzBxX8cUZwGZZ+XoKv7+GqlSdMN/kmLm0TBiUG7hf8aLLwX
         0hRMPGdmqkKqllg1JIwmBGgxaYumDS5nzzZJZGhfToQFeWucMyherv2hirhPKKTZO9
         JNxcUWRZSMbmddG/Zvt7Nj92y88k1RX4gA5WvEqY=
Subject: Re: [RFC PATCH v7 11/23] sched/fair: core wide cfs task priority
 comparison
From:   Vineeth Pillai <viremana@linux.microsoft.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Julien Desfossez <jdesfossez@digitalocean.com>
Cc:     Joel Fernandes <joelaf@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, joel@joelfernandes.org,
        vineeth@bitbyteword.org, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, derkling@google.com, benbjiang@tencent.com,
        Aaron Lu <ziqian.lzq@antfin.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
 <d02923d38df20f1d8c51cf4df6dce66ac0a385ce.1598643276.git.jdesfossez@digitalocean.com>
 <20200828212927.GE29142@worktop.programming.kicks-ass.net>
 <8b9f28f2-7f21-b7da-1056-732b6227ea25@linux.microsoft.com>
Message-ID: <bdc919e5-0bfb-9ec6-b8e7-5a98a30f821c@linux.microsoft.com>
Date:   Thu, 17 Sep 2020 16:39:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8b9f28f2-7f21-b7da-1056-732b6227ea25@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +
> +bool cfs_prio_less(struct task_struct *a, struct task_struct *b)
> +{
> +       struct sched_entity *se_a = &a->se, *se_b = &b->se;
> +       struct cfs_rq *cfs_rq_a, *cfs_rq_b;
> +       u64 vruntime_a, vruntime_b;
> +
> +#ifdef CONFIG_FAIR_GROUP_SCHED
> +       while (!is_same_tg(se_a, se_b)) {
> +               int se_a_depth = se_a->depth;
> +               int se_b_depth = se_b->depth;
> +
> +               if (se_a_depth <= se_b_depth)
> +                       se_b = parent_entity(se_b);
> +               if (se_a_depth >= se_b_depth)
> +                       se_a = parent_entity(se_a);
> +       }
> +#endif
> +
> +       cfs_rq_a = cfs_rq_of(se_a);
> +       cfs_rq_b = cfs_rq_of(se_b);
> +
> +       vruntime_a = se_a->vruntime - cfs_rq_a->min_vruntime;
> +       vruntime_b = se_b->vruntime - cfs_rq_b->min_vruntime;
> +
> +       trace_printk("(%s/%d;%Ld,%Lu) ?< (%s/%d;%Ld,%Lu)\n",
> +                    a->comm, a->pid, vruntime_a, cfs_rq_a->core_lag,
> +                    b->comm, b->pid, vruntime_b, cfs_rq_b->core_lag);
> +       if (cfs_rq_a != cfs_rq_b) {
> +               vruntime_a -= calc_delta_fair(cfs_rq_a->core_lag, 
> &a->se);
> +               vruntime_b -= calc_delta_fair(cfs_rq_b->core_lag, 
> &b->se);

This should be:
+               vruntime_a -= calc_delta_fair(cfs_rq_a->core_lag, se_a);
+               vruntime_b -= calc_delta_fair(cfs_rq_b->core_lag, se_b);


Thanks,
Vineeth


