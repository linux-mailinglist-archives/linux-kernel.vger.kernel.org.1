Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62D52CF610
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 22:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgLDVVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 16:21:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28005 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726021AbgLDVVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 16:21:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607116807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rti/zXs8iWZFVePr61fLRL/S8lU6QGDR6HAjsWQ0LKI=;
        b=eDEOV1/h5K/F0qfWX5i9JdDkyDHC8T9eoADSdH+kBx50GSx0HiEiHVb3YO+OuXsQqt+Y91
        emnb+/1Ousd/MTwP4iWf4GI+gk+6UrnvCKFc+IPYevgKCH6DkxSWTP6d/UhWpIMI1ernnK
        JGfbn5pa0ZlZJ2qwhmrtzJIzKC5DJiI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-TnNHZlQTOrm119R95lDh7g-1; Fri, 04 Dec 2020 16:20:05 -0500
X-MC-Unique: TnNHZlQTOrm119R95lDh7g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5E0EC296;
        Fri,  4 Dec 2020 21:20:02 +0000 (UTC)
Received: from ovpn-66-66.rdu2.redhat.com (unknown [10.10.67.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F19B5D6A1;
        Fri,  4 Dec 2020 21:19:52 +0000 (UTC)
Message-ID: <c2c013282faf278ee6e0fc66deefbab165ff4e88.camel@redhat.com>
Subject: Re: [PATCH v4 11/19] sched/core: Make migrate disable and CPU
 hotplug cooperative
From:   Qian Cai <qcai@redhat.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com,
        tj@kernel.org, ouwen210@hotmail.com
Date:   Fri, 04 Dec 2020 16:19:52 -0500
In-Reply-To: <jhjpn4bwznx.mognet@arm.com>
References: <20201023101158.088940906@infradead.org>
         <20201023102347.067278757@infradead.org>
         <ff62e3ee994efb3620177bf7b19fab16f4866845.camel@redhat.com>
         <jhjpn4bwznx.mognet@arm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-11-17 at 19:28 +0000, Valentin Schneider wrote:
> We did have some breakage in that area, but all the holes I was aware of
> have been plugged. What would help here is to see which tasks are still
> queued on that outgoing CPU, and their recent activity.
> 
> Something like
> - ftrace_dump_on_oops on your kernel cmdline
> - trace-cmd start -e 'sched:*'
>  <start the test here>
> 
> ought to do it. Then you can paste the (tail of the) ftrace dump.
> 
> I also had this laying around, which may or may not be of some help:

Okay, your patch did not help, since it can still be reproduced using this,

https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh

# while :; do cpuhotplug04.sh -l 1; done

The ftrace dump has too much output on this 256-CPU system, so I have not had
the patient to wait for it to finish after 15-min. But here is the log capturing
so far (search for "kernel BUG" there).

http://people.redhat.com/qcai/console.log

> ---
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a6aaf9fb3400..c4a4cb8b47a2 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7534,7 +7534,25 @@ int sched_cpu_dying(unsigned int cpu)
>  	sched_tick_stop(cpu);
>  
>  	rq_lock_irqsave(rq, &rf);
> -	BUG_ON(rq->nr_running != 1 || rq_has_pinned_tasks(rq));
> +
> +	if (rq->nr_running != 1 || rq_has_pinned_tasks(rq)) {
> +		struct task_struct *g, *p;
> +
> +		pr_crit("CPU%d nr_running=%d\n", cpu, rq->nr_running);
> +		rcu_read_lock();
> +		for_each_process_thread(g, p) {
> +			if (task_cpu(p) != cpu)
> +				continue;
> +
> +			if (!task_on_rq_queued(p))
> +				continue;
> +
> +			pr_crit("\tp=%s\n", p->comm);
> +		}
> +		rcu_read_unlock();
> +		BUG();
> +	}
> +
>  	rq_unlock_irqrestore(rq, &rf);
>  
>  	calc_load_migrate(rq);
> 

