Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087CD2784C2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 12:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgIYKKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 06:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbgIYKKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 06:10:46 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942FAC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 03:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JEzIhAQZ21VR1+sPN/DteO9JU9EP8zZM8KBBLet+0vE=; b=ZSx8LeXoR83faG3ndMPl6Eg5uR
        jH+VLah5hfsLcrfoMzzfsT++zvquPOIsN/w7wanYpTR6jsEi+BiqBkOHdUMOXNk+tUfhngTEFL+RY
        lEOHC4vvZI5egUuK1XnYtm96eQP0siXV5hrcUHhcfaKKGw9iFjcMRy7PZZ3iX0odLVUr08i+miua8
        NCuAfxTQNzM8v9MEdns/fI8ZDXR4mpL3y0tdkTQi/K2wn5vpEsci/KIGfV421YpgIVtQSfrA5nahV
        t51LYopaow7ULNroQSedKQZ/Jl3mal9U+ZnZ0KPcDovGVxZavAjth7b7wZhmiTdkBuCPb9y6vmTGC
        x9g/I7Sg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLkgS-0003yR-LR; Fri, 25 Sep 2020 10:10:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DD59E301A27;
        Fri, 25 Sep 2020 12:10:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CA5E720839A45; Fri, 25 Sep 2020 12:10:30 +0200 (CEST)
Date:   Fri, 25 Sep 2020 12:10:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vincent.donnefort@arm.com
Subject: Re: [PATCH 0/9] sched: Migrate disable support
Message-ID: <20200925101030.GA2594@hirez.programming.kicks-ass.net>
References: <20200921163557.234036895@infradead.org>
 <6f55a303-0e5c-8e84-65d3-798b589a5d75@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f55a303-0e5c-8e84-65d3-798b589a5d75@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 11:12:09AM +0200, Dietmar Eggemann wrote:

> I get this when running 6 (periodic) RT50 tasks with CPU hp stress on my
> 6 CPU JUNO board (!CONFIG_PREEMPT_RT).
> 
> [   55.490263] ------------[ cut here ]------------
> [   55.505261] Modules linked in:
> [   55.508322] CPU: 3 PID: 24 Comm: migration/3 Not tainted
> 5.9.0-rc1-00132-gc096e6406c50-dirty #90
> [   55.517119] Hardware name: ARM Juno development board (r0) (DT)
> [   55.523058] Stopper: multi_cpu_stop+0x0/0x170 <- 0x0
> [   55.528029] pstate: 20000085 (nzCv daIf -PAN -UAO BTYPE=--)
> [   55.533612] pc : sched_cpu_dying+0x124/0x130
> [   55.537887] lr : sched_cpu_dying+0xd8/0x130
> [   55.542071] sp : ffff800011f0bca0
> [   55.545385] x29: ffff800011f0bca0 x28: 0000000000000002
> [   55.550703] x27: 0000000000000000 x26: 0000000000000060
> [   55.556022] x25: 0000000000000000 x24: 0000000000000001
> [   55.561340] x23: 0000000000000000 x22: 0000000000000003
> [   55.566659] x21: 0000000000000080 x20: 0000000000000003
> [   55.571977] x19: ffff00097ef9e1c0 x18: 0000000000000010
> [   55.577295] x17: 0000000000000000 x16: 0000000000000000
> [   55.582613] x15: 0000000000000000 x14: 000000000000015c
> [   55.587932] x13: 0000000000000000 x12: 00000000000006f1
> [   55.593250] x11: 0000000000000080 x10: 0000000000000000
> [   55.598567] x9 : 0000000000000003 x8 : ffff0009743f5900
> [   55.603886] x7 : 0000000000000003 x6 : 0000000000000000
> [   55.609204] x5 : 0000000000000001 x4 : 0000000000000002
> [   55.614521] x3 : 0000000000000000 x2 : 0000000000000013
> [   55.619839] x1 : 0000000000000008 x0 : 0000000000000003
> [   55.625158] Call trace:
> [   55.627607]  sched_cpu_dying+0x124/0x130
> [   55.631535]  cpuhp_invoke_callback+0x88/0x210
> [   55.635897]  take_cpu_down+0x7c/0xd8
> [   55.639475]  multi_cpu_stop+0xac/0x170
> [   55.643227]  cpu_stopper_thread+0x98/0x130
> [   55.647327]  smpboot_thread_fn+0x1c4/0x280
> [   55.651427]  kthread+0x140/0x160
> [   55.654658]  ret_from_fork+0x10/0x34
> [   55.658239] Code: f000e1c1 913fc021 1400034a 17ffffde (d4210000)
> [   55.664342] ---[ end trace c5b8988b7b701e56 ]---
> [   55.668963] note: migration/3[24] exited with preempt_count 3
> 
> 7309 int sched_cpu_dying(unsigned int cpu)
>     ...
>     BUG_ON(rq->nr_running != 1 || rq_has_pinned_tasks(rq));
>     ...
> 
> rq->nr_running is always 2 here in this cases.
> 
> balance_hotplug_wait and sched_cpu_wait_empty run in cpuhp/X (CFS)
> whereas sched_cpu_dying in migration/X ?

takedown_cpu() has:

  kthread_park(per_cpu_ptr(&cpuhp_state, cpu)->thread);

before calling:

  err = stop_machine_cpuslocked(take_cpu_down, NULL, cpumask_of(cpu));

So when we get to sched_cpu_dying(), the only task that _should_ still
be there is migration/X.

Do you have any idea what thread, other than migration/X, is still
active on that CPU? per sched_cpu_wait_empty() we should've pushed out
all userspace tasks, and the cpu hotplug machinery should've put all the
per-cpu kthreads to sleep at this point.

