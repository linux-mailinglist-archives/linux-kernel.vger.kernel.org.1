Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30FA0278EF6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 18:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbgIYQpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 12:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbgIYQpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 12:45:18 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1F7C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 09:45:18 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id c18so4294568wrm.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 09:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YUu3faED3mWy40+D3cSdzZ9KMiB1kACXr9/cQo5iPy4=;
        b=PU4O4HtYxklsjXLVPL2geJkof5iuVWW/Z9RSsAk4jVIORB3mfYYFRiOhdR/XSITpsK
         i3IotiUj5CCLD1ToefahtaKN9JTYUlA9OkLQWIkpNgboUiho+77KVKaKg2lM0jYotGnG
         acI7+fAGlVt41abJw2GyXpmg2BaJIwKAX0YtKz+RDEfXKyyqjt/LLs7kCVTZuaGPKkcc
         jH22gnTzbFJbQKgPeD5YeacP4+CbYLHXYZo/qzoaV7NpZef3AMJoEM+2o5L+qwee4FVg
         R/vMcrLFvEFZdChp3enKnet8COQfyhrnztTRJCkMPsiuEWXNwlqtm/Cq3MmqsCAdfUrJ
         cYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YUu3faED3mWy40+D3cSdzZ9KMiB1kACXr9/cQo5iPy4=;
        b=JxzuwemVEsiKRINWVOzSoE59Z16aXH2GCSjbkyPgGGkcry9O3ftCPjWInbg0jTuBx4
         yxAEMdm9X0dJQjcW/8ZsqqcQJqJx9rLUeLDyFrcW+pcGAvzgZMOa74QyGYdqotfNhReC
         90HVcoqrUjQ7+7CcWlrEp2qj7Yd117BV3HXeLCV+IQy5RODB4yAK+xa39nEX705tL2Jr
         aeNU45tghezBNuEvg+8iT4/Ivm+xaY6W1jLDcCQxoMquChclfZpNPbaUy8VWaqThc9Wr
         hpMnvqkDwLv7eXcTtbPmh3wcN8qv84djurq4SBxEHWYiCedKTp0Hqpfo54xyWvY4FUVP
         Atng==
X-Gm-Message-State: AOAM530AvJhX3QE/ek5txG7KOQYgK9ZFFEVQQ7cnjnXmgpZZe30I8xP1
        VkMoc15fGK7gmVawibS7Sn4xww==
X-Google-Smtp-Source: ABdhPJxIEtJsqh6szBXb9XyBBG05VZzATGK3+RgFbN+d7CmcWqqHvIZ3qdg6uGrh2gtMhWXGV8Yk3g==
X-Received: by 2002:adf:f984:: with SMTP id f4mr5485083wrr.102.1601052316722;
        Fri, 25 Sep 2020 09:45:16 -0700 (PDT)
Received: from vingu-book ([2a01:e0a:f:6020:bd73:9ee4:5e68:9b9c])
        by smtp.gmail.com with ESMTPSA id z8sm3410432wrl.11.2020.09.25.09.45.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Sep 2020 09:45:15 -0700 (PDT)
Date:   Fri, 25 Sep 2020 18:45:14 +0200
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Jiang Biao <benbjiang@gmail.com>
Subject: Re: [RFC PATCH v2] sched/fair: select idle cpu from idle cpumask in
 sched domain
Message-ID: <20200925164514.GA6432@vingu-book>
References: <78d608f2-b974-e940-da32-b37777bc405a@linux.intel.com>
 <CAKfTPtAVkg081VEGp3Hx3i7D+jxRJcyBi2=NJypvHH6HVJ8Nwg@mail.gmail.com>
 <CAKfTPtA2yE_sFfP5MFN=K+ph7rqpYUhapUdDBJ5hFLxnQPktJw@mail.gmail.com>
 <af0237e0-1451-9d11-2ee2-1468a8bb6180@linux.intel.com>
 <CAKfTPtD71z-n2dVTpZk5tLwy5OZjkju9v5vJ-3QNHhw8Grhc_Q@mail.gmail.com>
 <8a86b085-b445-b1c2-9b46-6346d923abf0@linux.intel.com>
 <CAKfTPtB-L3uM34N1w5ELzceuJxiMdkwXV5nQcqWitBAhsLoMhQ@mail.gmail.com>
 <eb1c4c84-e361-d5a7-d071-b0dd7310eab4@linux.intel.com>
 <CAKfTPtBYmAauUi1-bKpN1UmMTWEQL-TZqQJxtkVFnYjo-E1mRg@mail.gmail.com>
 <aff0c293-cf4d-9770-cd54-fc0d06662f09@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aff0c293-cf4d-9770-cd54-fc0d06662f09@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 25 sept. 2020 à 17:21:46 (+0800), Li, Aubrey a écrit :
> Hi Vicent,
> 
> On 2020/9/24 21:09, Vincent Guittot wrote:
> >>>>
> >>>> Would you mind share uperf(netperf load) result on your side? That's the
> >>>> workload I have seen the most benefit this patch contributed under heavy
> >>>> load level.
> >>>
> >>> with uperf, i've got the same kind of result as sched pipe
> >>> tip/sched/core: Throughput 24.83Mb/s (+/- 0.09%)
> >>> with this patch:  Throughput 19.02Mb/s (+/- 0.71%) which is a 23%
> >>> regression as for sched pipe
> >>>
> >> In case this is caused by the logic error in this patch(sorry again), did
> >> you see any improvement in patch V2? Though it does not helps for nohz=off
> >> case, just want to know if it helps or does not help at all on arm platform.
> > 
> > With the v2 which rate limit the update of the cpumask (but doesn't
> > support sched_idle stask),  I don't see any performance impact:
> 
> I agree we should go the way with cpumask update rate limited.
> 
> And I think no performance impact for sched-pipe is expected, as this workload
> has only 2 threads and the platform has 8 cores, so mostly previous cpu is
> returned, and even if select_idle_sibling is called, select_idle_core is hit
> and rarely call select_idle_cpu.

my platform is not smt so select_idle_core is nop. Nevertheless select_idle_cpu
is almost never called because prev is idle and selected before calling it in
our case

> 
> But I'm more curious why there is 23% performance penalty? So for this patch, if
> you revert this change but keep cpumask updated, is 23% penalty still there?
> 
> -       cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> +       cpumask_and(cpus, sds_idle_cpus(sd->shared), p->cpus_ptr);

I was about to say that reverting this line should not change anything because
we never reach this point but it does in fact. And after looking at a trace,
I can see that the 2 threads of perf bench sched pipe are on the same CPU and
that the sds_idle_cpus(sd->shared) is always empty. In fact, the rq->curr is
not yet idle and still point to the cfs task when you call update_idle_cpumask().
This means that once cleared, the bit will never be set
You can remove the test in update_idle_cpumask() which is called either when
entering idle or when there is only sched_idle tasks that are runnable.

@@ -6044,8 +6044,7 @@ void update_idle_cpumask(struct rq *rq)
        sd = rcu_dereference(per_cpu(sd_llc, cpu));
        if (!sd || !sd->shared)
                goto unlock;
-       if (!available_idle_cpu(cpu) || !sched_idle_cpu(cpu))
-               goto unlock;
+
        cpumask_set_cpu(cpu, sds_idle_cpus(sd->shared));
 unlock:
        rcu_read_unlock();

With this fix, the performance decrease is only 2%

> 
> I just wonder if it's caused by the atomic ops as you have two cache domains with
> sd_llc(?). Do you have a x86 machine to make a comparison? It's hard for me to find
> an ARM machine but I'll try.
> 
> Also, for uperf(task thread num = cpu num) workload, how is it on patch v2? no any
> performance impact?

with v2 :  Throughput 24.97Mb/s (+/- 0.07%) so there is no perf regression

>
> 
> Thanks,
> -Aubrey
