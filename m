Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0BB22F8148
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 17:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbhAOQyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 11:54:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:42450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbhAOQyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 11:54:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CEFE2222B3;
        Fri, 15 Jan 2021 16:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610729653;
        bh=AxQOx0xuMhxgfv0JBN+yrTBriFb0/DYhLUv+nlz8pok=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=lzYzlXU+wqQ5BCutC9JWYwBRKQeaPgAXVzB1W4btu+TInyDrOwYeM2XD8zIJq8bFE
         70PEAxYzjsIe2x3FziyyLaxvljLMlduAT/uLUpYi0SKLAtlG0m/GDzQuifef/YgT5u
         BmMIhtgIVM5G2EhzzWlnzaXHlt11wzHfRQpD7yY10t7a0ql6UNBKYnBECUEu1bf58W
         y/4Gw7gNRbbwM+YGF7UKzawETocM/ENtMCyzzA6goRUbxeEUEZLtVsC51uAvbwuflF
         agtDzFKoM91f1xV/NpkN0T/5O3cdE4oCAU8PgYwTs/pMx91itySSDBFD3p4ap7tGoC
         CGZlhTrLolpSA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 93382352162B; Fri, 15 Jan 2021 08:54:13 -0800 (PST)
Date:   Fri, 15 Jan 2021 08:54:13 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org, tglx@linutronix.de, jiangshanlai@gmail.com,
        cai@redhat.com, vincent.donnefort@arm.com, decui@microsoft.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org, tj@kernel.org
Subject: Re: [PATCH] sched/core: Print out straggler tasks in
 sched_cpu_dying()
Message-ID: <20210115165413.GA705@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210113183141.11974-1-valentin.schneider@arm.com>
 <20210113220244.GC2743@paulmck-ThinkPad-P72>
 <jhjft34z84j.mognet@arm.com>
 <20210114003613.GD2743@paulmck-ThinkPad-P72>
 <jhjczy7ztw0.mognet@arm.com>
 <20210114152207.GI2743@paulmck-ThinkPad-P72>
 <jhj35z3o6qv.mognet@arm.com>
 <20210114171317.GJ2743@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114171317.GJ2743@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 09:13:17AM -0800, Paul E. McKenney wrote:
> On Thu, Jan 14, 2021 at 03:52:56PM +0000, Valentin Schneider wrote:
> > On 14/01/21 07:22, Paul E. McKenney wrote:
> > > If someone can identify Lai's series to me, I would be happy to give it
> > > a try as well.  All I see are workqueue-specific patches and patches
> > > contributing to the discussion of possible fixes to the splats from
> > > Peter's series.  (I figured that I would wait for the discussion to
> > > converge a bit.)
> > 
> > I was referring to
> > 
> > http://lore.kernel.org/r/20210111152638.2417-1-jiangshanlai@gmail.com
> > 
> > which I believe you already tested earlier version of.
> 
> Indeed I did, thank you for the clarification.

And there was only one run that failed yesterday evening, but it managed
to get both warnings.  Please see below, timestamps included this time.
My guess is that the BUG...preemptible warnings are a consequence of
the prior warning, but I am including them anyway.

							Thanx, Paul

------------------------------------------------------------------------

[ 4166.692555] WARNING: CPU: 1 PID: 17 at kernel/kthread.c:508 kthread_set_per_cpu+0x3b/0x50
[ 4166.693913] Modules linked in:
[ 4166.694367] CPU: 1 PID: 17 Comm: cpuhp/1 Not tainted 5.11.0-rc3+ #1222
[ 4166.695351] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.11.0-2.el7 04/01/2014
[ 4166.696746] RIP: 0010:kthread_set_per_cpu+0x3b/0x50
[ 4166.697680] Code: 00 48 85 c0 74 1f 40 84 f6 74 16 81 e2 00 00 00 04 74 1b 83 bf a0 03 00 00 01 75 0e f0 80 08 01 c3 f0 80 20 fe c3 0f 0b eb d0 <0f> 0b eb ee 0f 0b eb e1 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 f6
[ 4166.700957] RSP: 0000:ffff98ea000cfdf8 EFLAGS: 00010202
[ 4166.702152] RAX: ffff966e41869b00 RBX: ffff966e42a9f480 RCX: 0000000000000000
[ 4166.703319] RDX: 0000000004000000 RSI: 0000000000000001 RDI: ffff966e43049780
[ 4166.704475] RBP: ffff966e5f46adc0 R08: 0000000000000001 R09: 0000000000000001
[ 4166.705557] R10: 0000000000000004 R11: 0000000000000000 R12: ffff966e5f46b0e8
[ 4166.706604] R13: 0000000000000001 R14: ffffffffb3868c40 R15: 00000000ffffffff
[ 4166.707749] FS:  0000000000000000(0000) GS:ffff966e5f440000(0000) knlGS:0000000000000000
[ 4166.709119] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4166.710337] CR2: 0000000000000000 CR3: 0000000010a22000 CR4: 00000000000006e0
[ 4166.711586] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 4166.712639] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 4166.713769] Call Trace:
[ 4166.714143]  workqueue_online_cpu+0x19c/0x360
[ 4166.714789]  ? workqueue_prepare_cpu+0x70/0x70
[ 4166.715434]  cpuhp_invoke_callback+0x9e/0x890
[ 4166.716098]  cpuhp_thread_fun+0x199/0x230
[ 4166.716683]  ? sort_range+0x20/0x20
[ 4166.717192]  smpboot_thread_fn+0x193/0x230
[ 4166.717832]  kthread+0x13b/0x160
[ 4166.718296]  ? kthread_insert_work_sanity_check+0x50/0x50
[ 4166.719356]  ret_from_fork+0x22/0x30
[ 4166.720108] irq event stamp: 162011
[ 4166.720614] hardirqs last  enabled at (162021): [<ffffffffb20dafaa>] console_unlock+0x46a/0x550
[ 4166.721900] hardirqs last disabled at (162030): [<ffffffffb20daf16>] console_unlock+0x3d6/0x550
[ 4166.723157] softirqs last  enabled at (161064): [<ffffffffb3000342>] __do_softirq+0x342/0x48e
[ 4166.724450] softirqs last disabled at (161057): [<ffffffffb2e00f92>] asm_call_irq_on_stack+0x12/0x20
[ 4166.725776] ---[ end trace dc72cd4b00d9fafc ]---

...

[14094.371624] ------------[ cut here ]------------
[14094.373762] WARNING: CPU: 0 PID: 22 at kernel/workqueue.c:2194 process_one_work+0x8c/0x5f0
[14094.375067] Modules linked in:
[14094.375572] CPU: 0 PID: 22 Comm: kworker/1:1 Tainted: G        W         5.11.0-rc3+ #1222
[14094.376855] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.11.0-2.el7 04/01/2014
[14094.378240] Workqueue:  0x0 (events)
[14094.378807] RIP: 0010:process_one_work+0x8c/0x5f0
[14094.379553] Code: 48 8b 46 38 41 83 e6 20 48 89 45 c0 48 8b 46 40 48 89 45 c8 41 f6 44 24 4c 04 75 10 65 8b 05 db 5d f8 4d 41 39 44 24 40 74 02 <0f> 0b 48 ba eb 83 b5 80 46 86 c8 61 48 0f af d3 48 c1 ea 3a 49 8b
[14094.382431] RSP: 0018:ffff98ea000fbe70 EFLAGS: 00010002
[14094.383234] RAX: 0000000000000000 RBX: ffff966e5f4727e0 RCX: 2b970af959bb2a7d
[14094.384445] RDX: ffff966e5f4727e8 RSI: ffff966e5f4727e0 RDI: ffff966e41202000
[14094.385743] RBP: ffff98ea000fbed0 R08: 0000000000000001 R09: ffff966e411e4680
[14094.387526] R10: 0000000000000000 R11: 0000000000000000 R12: ffff966e5f46adc0
[14094.388927] R13: ffff966e5f46f700 R14: 0000000000000000 R15: ffff966e41202000
[14094.390043] FS:  0000000000000000(0000) GS:ffff966e5f400000(0000) knlGS:0000000000000000
[14094.391276] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[14094.392151] CR2: 0000000000000000 CR3: 000000000253c000 CR4: 00000000000006f0
[14094.393250] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[14094.394354] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[14094.395447] Call Trace:
[14094.395837]  ? process_one_work+0x5f0/0x5f0
[14094.396521]  worker_thread+0x28/0x3c0
[14094.397106]  ? process_one_work+0x5f0/0x5f0
[14094.397782]  kthread+0x13b/0x160
[14094.398302]  ? kthread_insert_work_sanity_check+0x50/0x50
[14094.399268]  ret_from_fork+0x22/0x30
[14094.399824] irq event stamp: 10439696
[14094.400409] hardirqs last  enabled at (10439695): [<ffffffffb2ca91df>] _raw_spin_unlock_irq+0x1f/0x40
[14094.402463] hardirqs last disabled at (10439696): [<ffffffffb2ca8fc1>] _raw_spin_lock_irq+0x41/0x50
[14094.403837] softirqs last  enabled at (10438912): [<ffffffffb20ece97>] srcu_invoke_callbacks+0xe7/0x1a0
[14094.405255] softirqs last disabled at (10438910): [<ffffffffb20ece97>] srcu_invoke_callbacks+0xe7/0x1a0
[14094.406683] ---[ end trace dc72cd4b00d9fafd ]---
[14094.407896] kvm-guest: stealtime: cpu 1, msr 1f457b00
[14094.587644] BUG: using __this_cpu_read() in preemptible [00000000] code: kworker/1:1/22
[14094.589432] caller is refresh_cpu_vm_stats+0x1a6/0x320
[14094.591054] CPU: 0 PID: 22 Comm: kworker/1:1 Tainted: G        W         5.11.0-rc3+ #1222
[14094.592319] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.11.0-2.el7 04/01/2014
[14094.593597] Workqueue: mm_percpu_wq vmstat_update
[14094.594318] Call Trace:
[14094.594709]  dump_stack+0x77/0x97
[14094.595234]  check_preemption_disabled+0xb6/0xd0
[14094.595946]  refresh_cpu_vm_stats+0x1a6/0x320
[14094.596645]  vmstat_update+0xe/0x60
[14094.597198]  process_one_work+0x2a0/0x5f0
[14094.597818]  ? process_one_work+0x5f0/0x5f0
[14094.598466]  worker_thread+0x28/0x3c0
[14094.599032]  ? process_one_work+0x5f0/0x5f0
[14094.599697]  kthread+0x13b/0x160
[14094.600281]  ? kthread_insert_work_sanity_check+0x50/0x50
[14094.601244]  ret_from_fork+0x22/0x30
[14094.601839] BUG: using __this_cpu_read() in preemptible [00000000] code: kworker/1:1/22
[14094.603102] caller is refresh_cpu_vm_stats+0x1a6/0x320
[14094.603917] CPU: 0 PID: 22 Comm: kworker/1:1 Tainted: G        W         5.11.0-rc3+ #1222
[14094.605190] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.11.0-2.el7 04/01/2014
[14094.606499] Workqueue: mm_percpu_wq vmstat_update
[14094.607226] Call Trace:
[14094.607744]  dump_stack+0x77/0x97
[14094.608433]  check_preemption_disabled+0xb6/0xd0
[14094.609390]  refresh_cpu_vm_stats+0x1a6/0x320
[14094.610090]  vmstat_update+0xe/0x60
[14094.610637]  process_one_work+0x2a0/0x5f0
[14094.611270]  ? process_one_work+0x5f0/0x5f0
[14094.611933]  worker_thread+0x28/0x3c0
[14094.612509]  ? process_one_work+0x5f0/0x5f0
[14094.613169]  kthread+0x13b/0x160
[14094.613653]  ? kthread_insert_work_sanity_check+0x50/0x50
[14094.614486]  ret_from_fork+0x22/0x30
[14095.424619] smpboot: Booting Node 0 Processor 7 APIC 0x7
[14095.445528] kvm-clock: cpu 7, msr 112b31c1, secondary cpu clock
[14095.485902] kvm-guest: stealtime: cpu 7, msr 1f5d7b00
[14095.610598] BUG: using __this_cpu_read() in preemptible [00000000] code: kworker/1:1/22
[14095.612427] caller is refresh_cpu_vm_stats+0x1a6/0x320
[14095.613568] CPU: 6 PID: 22 Comm: kworker/1:1 Tainted: G        W         5.11.0-rc3+ #1222
[14095.615315] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.11.0-2.el7 04/01/2014
[14095.617108] Workqueue: mm_percpu_wq vmstat_update
[14095.618094] Call Trace:
[14095.618615]  dump_stack+0x77/0x97
[14095.619587]  check_preemption_disabled+0xb6/0xd0
[14095.620667]  refresh_cpu_vm_stats+0x1a6/0x320
[14095.621690]  vmstat_update+0xe/0x60
[14095.622452]  process_one_work+0x2a0/0x5f0
[14095.623340]  ? process_one_work+0x5f0/0x5f0
[14095.624485]  worker_thread+0x28/0x3c0
[14095.625354]  ? process_one_work+0x5f0/0x5f0
[14095.626305]  kthread+0x13b/0x160
[14095.627059]  ? kthread_insert_work_sanity_check+0x50/0x50
[14095.628228]  ret_from_fork+0x22/0x30
[14095.629066] BUG: using __this_cpu_read() in preemptible [00000000] code: kworker/1:1/22
[14095.630865] caller is refresh_cpu_vm_stats+0x1a6/0x320
[14095.631799] CPU: 6 PID: 22 Comm: kworker/1:1 Tainted: G        W         5.11.0-rc3+ #1222
[14095.633549] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.11.0-2.el7 04/01/2014
[14095.635359] Workqueue: mm_percpu_wq vmstat_update
[14095.636370] Call Trace:
[14095.636885]  dump_stack+0x77/0x97
[14095.637613]  check_preemption_disabled+0xb6/0xd0
[14095.638595]  refresh_cpu_vm_stats+0x1a6/0x320
[14095.639565]  vmstat_update+0xe/0x60
[14095.640310]  process_one_work+0x2a0/0x5f0
[14095.641178]  ? process_one_work+0x5f0/0x5f0
[14095.642091]  worker_thread+0x28/0x3c0
[14095.643025]  ? process_one_work+0x5f0/0x5f0
[14095.643929]  kthread+0x13b/0x160
[14095.644627]  ? kthread_insert_work_sanity_check+0x50/0x50
[14095.645790]  ret_from_fork+0x22/0x30
