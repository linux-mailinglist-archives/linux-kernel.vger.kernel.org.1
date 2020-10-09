Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF94F2899DB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 22:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388443AbgJIUlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 16:41:18 -0400
Received: from foss.arm.com ([217.140.110.172]:60414 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729587AbgJIUlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 16:41:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06EAA1063;
        Fri,  9 Oct 2020 13:41:17 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C5E023F792;
        Fri,  9 Oct 2020 13:41:12 -0700 (PDT)
Subject: Re: [PATCH -v2 07/17] sched: Fix hotplug vs CPU bandwidth control
To:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        qais.yousef@arm.com, swood@redhat.com, valentin.schneider@arm.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org
References: <20201005145717.346020688@infradead.org>
 <20201005150921.661842442@infradead.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <336a3916-1dd8-98cf-44e8-88dbf27018d5@arm.com>
Date:   Fri, 9 Oct 2020 22:41:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201005150921.661842442@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/2020 16:57, Peter Zijlstra wrote:
> Since we now migrate tasks away before DYING, we should also move
> bandwidth unthrottle, otherwise we can gain tasks from unthrottle
> after we expect all tasks to be gone already.
> 
> Also; it looks like the RT balancers don't respect cpu_active() and
> instead rely on rq->online in part, complete this. This too requires
> we do set_rq_offline() earlier to match the cpu_active() semantics.
> (The bigger patch is to convert RT to cpu_active() entirely)
> 
> Since set_rq_online() is called from sched_cpu_activate(), place
> set_rq_offline() in sched_cpu_deactivate().

[   76.215229] WARNING: CPU: 1 PID: 1913 at kernel/irq_work.c:95
irq_work_queue_on+0x108/0x110
[   76.223589] Modules linked in:
[   76.226646] CPU: 1 PID: 1913 Comm: task0-1 Not tainted
5.9.0-rc1-00159-g231df48234cb-dirty #40
[   76.235268] Hardware name: ARM Juno development board (r0) (DT)
[   76.241194] pstate: 60000085 (nZCv daIf -PAN -UAO BTYPE=--)
[   76.246772] pc : irq_work_queue_on+0x108/0x110
[   76.251220] lr : pull_rt_task+0x58/0x68
[   76.255577] sp : ffff800013a83be0
[   76.258890] x29: ffff800013a83be0 x28: ffff000972f34600
[   76.264208] x27: ffff000972f34b90 x26: ffff8000114156c0
[   76.269524] x25: 0080000000000000 x24: ffff800011cd7000
[   76.274840] x23: ffff000972f34600 x22: ffff800010d627c8
[   76.280157] x21: 0000000000000000 x20: 0000000000000000
[   76.285473] x19: ffff00097ef701c0 x18: 0000000000000010
[   76.290788] x17: 0000000000000000 x16: 0000000000000000
[   76.296104] x15: ffff000972f34a80 x14: ffffffffffffffff
[   76.301420] x13: ffff800093a83987 x12: ffff800013a8398f
[   76.306736] x11: ffff800011ac2000 x10: ffff800011ce8690
[   76.312051] x9 : 0000000000000000 x8 : ffff800011ce9000
[   76.317367] x7 : ffff8000106e9bb8 x6 : 0000000000000144
[   76.322682] x5 : 0000000000000000 x4 : ffff800011aaa1c0
[   76.327998] x3 : 0000000000000000 x2 : 0000000000000000
[   76.333314] x1 : ffff800011ce72a0 x0 : 0000000000000002
[   76.338630] Call trace:
[   76.341076]  irq_work_queue_on+0x108/0x110
[   76.349185]  pull_rt_task+0x58/0x68
[   76.352673]  balance_rt+0x84/0x88
[   76.355990]  __schedule+0x4a4/0x670
[   76.359478]  schedule+0x70/0x108
[   76.362706]  do_nanosleep+0x8c/0x178
[   76.366283]  hrtimer_nanosleep+0xa0/0x118
[   76.370294]  common_nsleep_timens+0x68/0x98
[   76.374479]  __arm64_sys_clock_nanosleep+0xc0/0x138
[   76.379361]  el0_svc_common.constprop.0+0x6c/0x168
[   76.384155]  do_el0_svc+0x24/0x90
[   76.387471]  el0_sync_handler+0x90/0x198
[   76.391394]  el0_sync+0x158/0x180


balance_rt() checks via need_pull_rt_task() that rq is online but it
looks like that with RT_PUSH_IPI pull_rt_task() -> tell_cpu_to_push()
calls irq_work_queue_on() with cpu = rto_next_cpu(rq->rd) and this one
can be offline here as well now.
