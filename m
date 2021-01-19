Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23EF2FBCF2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 17:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390871AbhASQv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 11:51:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390373AbhASQuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 11:50:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9760C0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 08:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=iYPt0MUAE8jWLM+UeDEgO07BOX1gF6JoewgAhyEGFTo=; b=Pe0rlY9pFTOaP47vb8GV9ZQzWf
        dA2E0wPPoIzygh0jA6XTaS2S7vazvalTcObC+m+VwpgHuJYGHrSIi7dY7lHOULXid0Jdld+Up7zJb
        rMoHSUOFFKNKJ7AKQ/H0k9hz7c6kLuYogaNt+7tjWDeAC6w3dJEAmoMqHXbuW9mURVRaO79akDv5r
        dO83pU0DTVCh+v7qdA2bYpuqJvTedZvS35LG+5937doNNdAlLiy/pJUP9/039HJPH/yRGQ5IAMVut
        tgYjHYUqPsoWwcyueE8GaCPkZvnQX4F0v2cQXS5GeuP3OP47x9GKXv4pBA3EaViNMKNA6D8LoCtvx
        errjnU+g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l1uCR-00EZkF-Lj; Tue, 19 Jan 2021 16:49:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9CC063007CD;
        Tue, 19 Jan 2021 17:49:46 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8124C20248705; Tue, 19 Jan 2021 17:49:46 +0100 (CET)
Date:   Tue, 19 Jan 2021 17:49:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: BUG: sleeping function called from invalid context at
 kernel/stop_machine.c:135
Message-ID: <YAcNqqn3JRnZ1PmZ@hirez.programming.kicks-ass.net>
References: <ffe8b460-4bc5-4a6b-bd66-4bb56e0f33d3@redhat.com>
 <328c6389-9944-ba7d-6ec6-44009bac4f0b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <328c6389-9944-ba7d-6ec6-44009bac4f0b@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 11:45:02AM -0500, Waiman Long wrote:
> On 1/19/21 6:13 AM, Daniel Bristot de Oliveira wrote:
> > Hi Waiman,
> > 
> > Are you aware of this issue:
> > ----- %< -----
> > [   88.307857] BUG: sleeping function called from invalid context at kernel/stop_machine.c:135
> > [   88.308796] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 801, name: sh
> > [   88.309785] 6 locks held by sh/801:
> > [   88.310265]  #0: ffff9f008c575460 (sb_writers#7){.+.+}-{0:0}, at: ksys_write+0x58/0xd0
> > [   88.310906]  #1: ffff9f008e9dd088 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write+0xa5/0x1c0
> > [   88.311672]  #2: ffff9f0092164a88 (kn->active#195){.+.+}-{0:0}, at: kernfs_fop_write+0xad/0x1c0
> > [   88.312456]  #3: ffffffffbac68310 (cpu_hotplug_lock){++++}-{0:0}, at: sched_partition_write+0x72/0x2f0
> > [   88.313280]  #4: ffffffffbae37090 (&cpuset_rwsem){++++}-{0:0}, at: sched_partition_write+0x7e/0x2f0
> > [   88.314095]  #5: ffffffffbad89140 (rcu_read_lock){....}-{1:3}, at: update_sibling_cpumasks+0x5/0x140
> > [   88.314806] Preemption disabled at:
> > [   88.314810] [<ffffffffb900454d>] preempt_schedule_thunk+0x16/0x18
> > [   88.315815] CPU: 1 PID: 801 Comm: sh Not tainted 5.10.0-rc5+ #10
> > [   88.316203] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
> > [   88.316714] Call Trace:
> > [   88.316875]  dump_stack+0x8b/0xb0
> > [   88.317087]  ___might_sleep.cold+0x102/0x116
> > [   88.317354]  stop_one_cpu+0x82/0xa0
> > [   88.317578]  ? set_cpus_allowed_ptr+0x10/0x10
> > [   88.317858]  __set_cpus_allowed_ptr+0x1e6/0x1f0
> > [   88.318144]  update_tasks_cpumask+0x25/0x50
> > [   88.318415]  update_cpumasks_hier+0x257/0x840
> > [   88.318687]  update_sibling_cpumasks+0x96/0x140
> > [   88.318968]  update_prstate+0x1a0/0x1f0
> > [   88.319210]  sched_partition_write+0x9f/0x2f0
> > [   88.319482]  kernfs_fop_write+0xdc/0x1c0
> > [   88.319730]  vfs_write+0xea/0x3b0
> > [   88.319943]  ksys_write+0x58/0xd0
> > [   88.320156]  do_syscall_64+0x33/0x40
> > [   88.320382]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > [   88.320692] RIP: 0033:0x7fbbd79be537
> > [   88.320915] Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04
> > 		     25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3
> > 		     48 83 ec 28 48 89 54 24 18 48 89 74 24
> > [   88.322028] RSP: 002b:00007ffd44cc8398 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> > [   88.322479] RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007fbbd79be537
> > [   88.322910] RDX: 0000000000000005 RSI: 0000558ae69200a0 RDI: 0000000000000001
> > [   88.323342] RBP: 0000558ae69200a0 R08: 000000000000000a R09: 0000000000000004
> > [   88.323775] R10: 0000558ae6921ba0 R11: 0000000000000246 R12: 0000000000000005
> > [   88.325046] R13: 00007fbbd7a90500 R14: 0000000000000005 R15: 00007fbbd7a90700
> > ----- >% -----
> 
> I am not aware of that.
> 
> void ___might_sleep(const char *file, int line, int preempt_offset)
>   :
>         if ((preempt_count_equals(preempt_offset) && !irqs_disabled() &&
>              !is_idle_task(current) && !current->non_block_count) ||
>             system_state == SYSTEM_BOOTING || system_state > SYSTEM_RUNNING
> ||
>             oops_in_progress)
>                 return;
> 
> I think the failing test was preempt_count_equals(preempt_offset).
> 
> static inline int preempt_count_equals(int preempt_offset)
> {
>         int nested = preempt_count() + rcu_preempt_depth();
> 
>         return (nested == preempt_offset);
> }
> 
> preempt_count() is 0 (in_atomic() == 0) and preempt_offset is 0, but
> rcu_preempt_depth() should be at least 1 as a rcu_read_lock was held. I
> don't think we should prevent sleeping if a rcu_read_lock is held. We need
> to look at the reason why rcu_preempt_depth() is included in this test.

You're not allowed to sleep with rcu_read_lock() held. With config
PREEMPT=y you're allowed to get preempted with rcu_read_lock() held, but
never to explicitly block.
