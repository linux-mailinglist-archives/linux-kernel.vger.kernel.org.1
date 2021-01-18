Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 816B32FA137
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 14:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404184AbhARNUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 08:20:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48634 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404391AbhARNTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 08:19:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610975869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qskwrs9PcUI54IS2EGGfpMU4PDXQfqH5PObQuPS3H0M=;
        b=QXO1FenEnvBRQmJdcubmHUBxjkiI/Wbpcd8LYYmFJW5Zy92PrYUdPFxAsD+PC5V9kQb+8R
        A6SaCxwRqnKdgHWRP/6bGd7KedppMiTOmCqm/Uf5inwVyT1L6BUWufxrwyTXNBiuC5XMKF
        Ch0ZhDKIuyuYXOv4KI5wgz/KTs+AeJQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-jupv7Ix9OraMMA5kYsJVuw-1; Mon, 18 Jan 2021 08:17:46 -0500
X-MC-Unique: jupv7Ix9OraMMA5kYsJVuw-1
Received: by mail-ed1-f72.google.com with SMTP id m16so7794411edd.21
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 05:17:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qskwrs9PcUI54IS2EGGfpMU4PDXQfqH5PObQuPS3H0M=;
        b=MjNRhKbA0O7/iIwYPigp307ruIfR0i3iiU5DfjOroEVgbADIxW468zYxsZPywEinSI
         o8IloPgos2iqrgOsrZtvKYLWW7gQdCXNiR7Q4KjLGgWArVnkG7HLBLFyeLyoQUcJV0DU
         owTQypQvLvGk3c/7JnG+TgtueGbnMQQpSdQZR3xgdAftn4xvEZk/2HKaX4hMe9qkZJlk
         S8XCUxBOGo0XFlYi+RRyOObFsVYuCozbJN9PWEAlqggkbPQFDL3jQ/tx8rGqEwyoi31E
         RcafCaF82ibqRC+E8OcS1hB5jeVPpr7L88/5hVq7A7VV+X4AZQqai5Oxl7xrIT7lw2OC
         smQQ==
X-Gm-Message-State: AOAM533mYSQjYhJBuz7YmQTiuCgPrrNN9Rl1918Bf50jra0qZG4qxtNa
        VNVBIpZ6JKLxtCGWd6NctwzsvuD0yS5Ejq/O5Dm1Lk/qV/AVpTGVbDALxsRF7XMff6pIgmkAynt
        ZSguBTQhCtD2Ow99b59qSqxR2
X-Received: by 2002:a17:906:76c9:: with SMTP id q9mr17834268ejn.484.1610975865559;
        Mon, 18 Jan 2021 05:17:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwZpjlL/+bxP47HD4sgWdw8ertcZZC+rKZ/gb+Mqr3Gc+KsMBpO7SHp05HmaNAYihqPtE4JEQ==
X-Received: by 2002:a17:906:76c9:: with SMTP id q9mr17834250ejn.484.1610975865377;
        Mon, 18 Jan 2021 05:17:45 -0800 (PST)
Received: from x1.bristot.me (host-79-46-192-171.retail.telecomitalia.it. [79.46.192.171])
        by smtp.gmail.com with ESMTPSA id zn8sm9810299ejb.39.2021.01.18.05.17.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 05:17:44 -0800 (PST)
Subject: Re: [PATCH 6/6] sched/deadline: Fixes cpu/rd/dl_bw references for
 suspended tasks
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Marco Perronet <perronet@mpi-sws.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Li Zefan <lizefan@huawei.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        cgroups@vger.kernel.org
References: <cover.1610463999.git.bristot@redhat.com>
 <8c1cb0c850e2f3ab1d7a533aa4b33a30f9dbeda5.1610463999.git.bristot@redhat.com>
 <97875017-a6bb-98ea-83f9-82e95db58aca@arm.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <40b1f087-2411-8fb3-4aad-20791e63d940@redhat.com>
Date:   Mon, 18 Jan 2021 14:17:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <97875017-a6bb-98ea-83f9-82e95db58aca@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/21 3:36 PM, Dietmar Eggemann wrote:
> On 12/01/2021 16:53, Daniel Bristot de Oliveira wrote:
> 
> [...]
> 
>> ----- %< -----
>>   #!/bin/bash
>>   # Enter on the cgroup directory
>>   cd /sys/fs/cgroup/
>>
>>   # Check it if is cgroup v2 and enable cpuset
>>   if [ -e cgroup.subtree_control ]; then
>>   	# Enable cpuset controller on cgroup v2
>>   	echo +cpuset > cgroup.subtree_control
>>   fi
>>
>>   echo LOG: create an exclusive cpuset and assigned the CPU 0 to it
>>   # Create cpuset groups
>>   rmdir dl-group &> /dev/null
>>   mkdir dl-group
>>
>>   # Restrict the task to the CPU 0
>>   echo 0 > dl-group/cpuset.mems
>>   echo 0 > dl-group/cpuset.cpus
>>   echo root >  dl-group/cpuset.cpus.partition
>>
>>   echo LOG: dispatching a regular task
>>   sleep 100 &
>>   CPUSET_PID="$!"
>>
>>   # let it settle down
>>   sleep 1
>>
>>   # Assign the second task to the cgroup
> 
> There is only one task 'CPUSET_PID' involved here?

Ooops, yep, I will remove the "second" part.

>>   echo LOG: moving the second DL task to the cpuset
>>   echo "$CPUSET_PID" > dl-group/cgroup.procs 2> /dev/null
>>
>>   CPUSET_ALLOWED=`cat /proc/$CPUSET_PID/status | grep Cpus_allowed_list | awk '{print $2}'`
>>
>>   chrt -p -d --sched-period 1000000000 --sched-runtime 100000000 0 $CPUSET_PID
>>   ACCEPTED=$?
>>
>>   if [ $ACCEPTED == 0 ]; then
>>   	echo PASS: the task became DL
>>   else
>>   	echo FAIL: the task was rejected as DL
>>   fi
> 
> [...]
> 
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 5961a97541c2..3c2775e6869f 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -5905,15 +5905,15 @@ static int __sched_setscheduler(struct task_struct *p,
>>  #ifdef CONFIG_SMP
>>  		if (dl_bandwidth_enabled() && dl_policy(policy) &&
>>  				!(attr->sched_flags & SCHED_FLAG_SUGOV)) {
>> -			cpumask_t *span = rq->rd->span;
>> +			struct root_domain *rd = dl_task_rd(p);
>>  
>>  			/*
>>  			 * Don't allow tasks with an affinity mask smaller than
>>  			 * the entire root_domain to become SCHED_DEADLINE. We
>>  			 * will also fail if there's no bandwidth available.
>>  			 */
>> -			if (!cpumask_subset(span, p->cpus_ptr) ||
>> -			    rq->rd->dl_bw.bw == 0) {
>> +			if (!cpumask_subset(rd->span, p->cpus_ptr) ||
>> +			    rd->dl_bw.bw == 0) {
>>  				retval = -EPERM;
>>  				goto unlock;
>>  			}
>> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
>> index c221e14d5b86..1f6264cb8867 100644
>> --- a/kernel/sched/deadline.c
>> +++ b/kernel/sched/deadline.c
>> @@ -2678,8 +2678,8 @@ int sched_dl_overflow(struct task_struct *p, int policy,
>>  	u64 period = attr->sched_period ?: attr->sched_deadline;
>>  	u64 runtime = attr->sched_runtime;
>>  	u64 new_bw = dl_policy(policy) ? to_ratio(period, runtime) : 0;
>> -	int cpus, err = -1, cpu = task_cpu(p);
>> -	struct dl_bw *dl_b = dl_bw_of(cpu);
>> +	int cpus, err = -1, cpu = dl_task_cpu(p);
>> +	struct dl_bw *dl_b = dl_task_root_bw(p);
>>  	unsigned long cap;
>>  
>>  	if (attr->sched_flags & SCHED_FLAG_SUGOV)
>>
> 
> Wouldn't it be sufficient to just introduce dl_task_cpu() and use the
> correct cpu to get rd->span or struct dl_bw in __sched_setscheduler()
> -> sched_dl_overflow()?

While I think that having the dl_task_rd() makes the code more intuitive, I have
no problem on not adding it...

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 5961a97541c2..0573f676696a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5905,7 +5905,8 @@ static int __sched_setscheduler(struct task_struct *p,
>  #ifdef CONFIG_SMP
>                 if (dl_bandwidth_enabled() && dl_policy(policy) &&
>                                 !(attr->sched_flags & SCHED_FLAG_SUGOV)) {
> -                       cpumask_t *span = rq->rd->span;
> +                       int cpu = dl_task_cpu(p);
> +                       cpumask_t *span = cpu_rq(cpu)->rd->span;
>  
>                         /*
>                          * Don't allow tasks with an affinity mask smaller than
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index c221e14d5b86..308ecaaf3d28 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2678,7 +2678,7 @@ int sched_dl_overflow(struct task_struct *p, int policy,
>         u64 period = attr->sched_period ?: attr->sched_deadline;
>         u64 runtime = attr->sched_runtime;
>         u64 new_bw = dl_policy(policy) ? to_ratio(period, runtime) : 0;
> -       int cpus, err = -1, cpu = task_cpu(p);
> +       int cpus, err = -1, cpu = dl_task_cpu(p);
>         struct dl_bw *dl_b = dl_bw_of(cpu);
>         unsigned long cap;
> 

This way works for me too.

Thanks!

-- Daniel

