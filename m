Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C562791C9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 22:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgIYUMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 16:12:43 -0400
Received: from foss.arm.com ([217.140.110.172]:51378 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728431AbgIYUKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 16:10:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03E7311B3;
        Fri, 25 Sep 2020 12:32:29 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22C1A3F73B;
        Fri, 25 Sep 2020 12:32:27 -0700 (PDT)
References: <20200921163557.234036895@infradead.org> <20200925181727.ryuacrsipyaz65z7@linutronix.de>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        qais.yousef@arm.com, swood@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com
Subject: Re: [PATCH 0/9] sched: Migrate disable support
In-reply-to: <20200925181727.ryuacrsipyaz65z7@linutronix.de>
Date:   Fri, 25 Sep 2020 20:32:24 +0100
Message-ID: <jhjzh5dmz3r.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 25/09/20 19:17, Sebastian Andrzej Siewior wrote:
> On 2020-09-21 18:35:57 [+0200], Peter Zijlstra wrote:
>> Hi,
> Hi,
>
>> Here's my take on migrate_disable(). It avoids growing a second means of
>
> I have here:
>
> |005: numa_remove_cpu cpu 5 node 0: mask now 0,3-4,6-7
> |007: smpboot: CPU 5 is now offline
> |006: ------------[ cut here ]------------
> |006: rq->balance_callback
> |006: WARNING: CPU: 6 PID: 8392 at kernel/sched/sched.h:1234 try_to_wake_up+0x696/0x860
> |006: Modules linked in:
> |006:
> |006: CPU: 6 PID: 8392 Comm: hackbench Not tainted 5.9.0-rc6-rt9+ #60
> |006: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-1 04/01/2014
> |006: RIP: 0010:try_to_wake_up+0x696/0x860
> |006: Code: c0 01 00 00 01 e9 d9 fb ff ff 80 3d 90 ef 6d 01 00 0f 85 6c fb ff ff 48 c7 c7 d4 4a 2c 82 c6 05 7c ef 6d 01 01 e8 dd 21 fc ff <0f> 0b e9 52 fb ff ff 0f 0b e9 b2
> |006: RSP: 0018:ffffc90005b978f8 EFLAGS: 00010082
> |006:
> |006: RAX: 0000000000000000 RBX: ffff8882755cca40 RCX: 0000000000000000
> |006: RDX: ffffffff8247aab8 RSI: 00000000ffffffff RDI: 00000000ffffffff
> |006: RBP: 0000000000000000 R08: 0000000000000001 R09: ffffffff8247a9a0
> |006: R10: ffffc90005b97838 R11: 332e39313320205b R12: ffff888276da8600
> |006: R13: 0000000000000093 R14: ffff8882755cd7a0 R15: ffff888276da8618
> |006: FS:  00007f6fa7805740(0000) GS:ffff888276d80000(0000) knlGS:0000000000000000
> |006: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> |006: CR2: 00007f6fa796af90 CR3: 0000000262588000 CR4: 00000000003506e0
> |006: Call Trace:
> |006:  ? cpu_stop_queue_work+0x8e/0x150
> |006:  __wake_up_q+0x96/0xc0
> |006:  cpu_stop_queue_work+0x9a/0x150
> |006:  finish_task_switch.isra.0+0x2f1/0x460
> |006:  __schedule+0x3bd/0xb20
> |006:  schedule+0x4a/0x100
> |006:  schedule_hrtimeout_range_clock+0x14f/0x160
> |006:  ? rt_spin_unlock+0x39/0x90
> |006:  ? rt_mutex_futex_unlock+0xcb/0xe0
> |006:  poll_schedule_timeout.constprop.0+0x4d/0x90
> |006:  do_sys_poll+0x314/0x430
> |006:  ? __lock_acquire+0x39b/0x2010
> |006:  ? poll_schedule_timeout.constprop.0+0x90/0x90
> |006:  ? mark_held_locks+0x49/0x70
> |006:  ? find_held_lock+0x2b/0x80
> |006:  ? rt_spin_unlock+0x39/0x90
> |006:  ? rt_mutex_futex_unlock+0xcb/0xe0
> |006:  ? rt_spin_unlock+0x51/0x90
> |006:  ? handle_mm_fault+0xfbd/0x1510
> |006:  ? find_held_lock+0x2b/0x80
> |006:  ? do_user_addr_fault+0x214/0x420
> |006:  __x64_sys_poll+0x37/0x130
> |006:  do_syscall_64+0x33/0x40
> |006:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> |006: RIP: 0033:0x7f6fa78fb483
>
> Is this somewhere among the fixes Valentin received?
> This SCHED_WARN_ON(rq->balance_callback); in rq_pin_lock().
>

The IRC handout so far is:
https://paste.debian.net/1164646/
https://paste.debian.net/1164656/

As for your splat, I think this is what I was worrying about wrt
suppressing callbacks in the switch but not preventing them from being
queued. Perhaps the below is "better" than what I previously sent.

Technically should be doable with a cpu_active() check instead given this
all gets flipped in sched_cpu_deactivate(), but at least this makes it
obvious that PUSH suppresses any other callback.

---
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 50aac5b6db26..40d78a20fbcb 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1403,7 +1403,7 @@ queue_balance_callback(struct rq *rq,
 {
        lockdep_assert_held(&rq->lock);

-	if (unlikely(head->next))
+	if (unlikely(head->next) || (rq->balance_flags & BALANCE_PUSH))
                return;

        head->func = (void (*)(struct callback_head *))func;
---

> Sebastian
