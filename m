Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B025F2B6EA0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 20:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgKQT27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 14:28:59 -0500
Received: from foss.arm.com ([217.140.110.172]:35442 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbgKQT27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 14:28:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86945101E;
        Tue, 17 Nov 2020 11:28:58 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 468293F718;
        Tue, 17 Nov 2020 11:28:56 -0800 (PST)
References: <20201023101158.088940906@infradead.org> <20201023102347.067278757@infradead.org> <ff62e3ee994efb3620177bf7b19fab16f4866845.camel@redhat.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Qian Cai <cai@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com,
        tj@kernel.org, ouwen210@hotmail.com
Subject: Re: [PATCH v4 11/19] sched/core: Make migrate disable and CPU hotplug cooperative
In-reply-to: <ff62e3ee994efb3620177bf7b19fab16f4866845.camel@redhat.com>
Date:   Tue, 17 Nov 2020 19:28:50 +0000
Message-ID: <jhjpn4bwznx.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/11/20 15:06, Qian Cai wrote:
> On Fri, 2020-10-23 at 12:12 +0200, Peter Zijlstra wrote:
[...]
>> @@ -7310,7 +7334,7 @@ int sched_cpu_dying(unsigned int cpu)
>>  	sched_tick_stop(cpu);
>>  
>>  	rq_lock_irqsave(rq, &rf);
>> -	BUG_ON(rq->nr_running != 1);
>> +	BUG_ON(rq->nr_running != 1 || rq_has_pinned_tasks(rq));
>
> CPU hotplug is now triggering this. This is with Valentin's affine_move_task()
> fix on top:
>
> https://lore.kernel.org/lkml/20201113112414.2569-1-valentin.schneider@arm.com/
>
> [  809.412232][  T428] kernel BUG at kernel/sched/core.c:7547!
> [  809.417841][  T428] invalid opcode: 0000 [#1] SMP KASAN PTI
> [  809.423445][  T428] CPU: 72 PID: 428 Comm: migration/72 Tainted: G          I       5.10.0-rc3-next-20201113+ #1
> [  809.433678][  T428] Hardware name: HPE ProLiant DL560 Gen10/ProLiant DL560 Gen10, BIOS U34 11/13/2019
> [  809.442951][  T428] Stopper: multi_cpu_stop+0x0/0x350 <- 0x0
> [  809.448643][  T428] RIP: 0010:sched_cpu_dying+0x10f/0x130
> [  809.454071][  T428] Code: 10 00 31 c0 48 83 c4 08 5b 41 5c 41 5d 5d c3 be 08 00 00 00 48 c7 c7 60 3f b5 96 e8 ab 81 4d 00 f0 4c 01 25 73 c4 5a 09 eb a3 <0f> 0b 48 89 34 24 e8 86 7d 4d 00 48 8b 34 24 e9 5d ff ff ff e8 88
> [  809.473650][  T428] RSP: 0018:ffffc9000889fca0 EFLAGS: 00010002
> [  809.479606][  T428] RAX: 0000000000000000 RBX: ffff8887dfcb23c0 RCX: ffffffff8e057e0d
> [  809.487482][  T428] RDX: 1ffff110fbf96480 RSI: 0000000000007c11 RDI: ffff8887dfcb2400
> [  809.495355][  T428] RBP: ffffc9000889fcc0 R08: fffffbfff2cb8e96 R09: fffffbfff2cb8e96
> [  809.503229][  T428] R10: ffffffff965c74af R11: fffffbfff2cb8e95 R12: ffff8887dfcb23d8
> [  809.511103][  T428] R13: 0000000000000086 R14: ffffffff8d5038e0 R15: 0000000000000003
> [  809.518979][  T428] FS:  0000000000000000(0000) GS:ffff8887dfc80000(0000) knlGS:0000000000000000
> [  809.527815][  T428] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  809.534291][  T428] CR2: 00007fea4cdf899c CR3: 00000018c7414002 CR4: 00000000007706e0
> [  809.542165][  T428] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  809.550040][  T428] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  809.557913][  T428] PKRU: 55555554
> [  809.561332][  T428] Call Trace:
> [  809.564489][  T428]  ? x86_pmu_starting_cpu+0x20/0x20
> [  809.569570][  T428]  ? sched_cpu_wait_empty+0x220/0x220
> [  809.574826][  T428]  cpuhp_invoke_callback+0x1d8/0x1520
> [  809.580082][  T428]  ? x2apic_send_IPI_mask+0x10/0x10
> [  809.585161][  T428]  ? clear_local_APIC+0x788/0xc10
> [  809.590068][  T428]  ? cpuhp_invoke_callback+0x1520/0x1520
> [  809.595584][  T428]  take_cpu_down+0x10f/0x1a0
> [  809.600053][  T428]  multi_cpu_stop+0x149/0x350
> [  809.604607][  T428]  ? stop_machine_yield+0x10/0x10
> [  809.609511][  T428]  cpu_stopper_thread+0x200/0x400
> [  809.614416][  T428]  ? cpu_stop_create+0x70/0x70
> [  809.619059][  T428]  smpboot_thread_fn+0x30a/0x770
> [  809.623878][  T428]  ? smpboot_register_percpu_thread+0x370/0x370
> [  809.630005][  T428]  ? trace_hardirqs_on+0x1c/0x150
> [  809.634910][  T428]  ? __kthread_parkme+0xcc/0x1a0
> [  809.639729][  T428]  ? smpboot_register_percpu_thread+0x370/0x370
> [  809.645855][  T428]  kthread+0x352/0x420
> [  809.649798][  T428]  ? kthread_create_on_node+0xc0/0xc0
> [  809.655052][  T428]  ret_from_fork+0x22/0x30
> [  809.659345][  T428] Modules linked in: nls_ascii nls_cp437 vfat fat kvm_intel kvm ses enclosure irqbypass efivarfs ip_tables x_tables sd_mod nvme tg3 firmware_class smartpqi nvme_core scsi_transport_sas libphy dm_mirror dm_region_hash dm_log dm_mod


We did have some breakage in that area, but all the holes I was aware of
have been plugged. What would help here is to see which tasks are still
queued on that outgoing CPU, and their recent activity.

Something like
- ftrace_dump_on_oops on your kernel cmdline
- trace-cmd start -e 'sched:*'
 <start the test here>

ought to do it. Then you can paste the (tail of the) ftrace dump.

I also had this laying around, which may or may not be of some help:
---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a6aaf9fb3400..c4a4cb8b47a2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7534,7 +7534,25 @@ int sched_cpu_dying(unsigned int cpu)
 	sched_tick_stop(cpu);
 
 	rq_lock_irqsave(rq, &rf);
-	BUG_ON(rq->nr_running != 1 || rq_has_pinned_tasks(rq));
+
+	if (rq->nr_running != 1 || rq_has_pinned_tasks(rq)) {
+		struct task_struct *g, *p;
+
+		pr_crit("CPU%d nr_running=%d\n", cpu, rq->nr_running);
+		rcu_read_lock();
+		for_each_process_thread(g, p) {
+			if (task_cpu(p) != cpu)
+				continue;
+
+			if (!task_on_rq_queued(p))
+				continue;
+
+			pr_crit("\tp=%s\n", p->comm);
+		}
+		rcu_read_unlock();
+		BUG();
+	}
+
 	rq_unlock_irqrestore(rq, &rf);
 
 	calc_load_migrate(rq);
