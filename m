Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1002B0A3E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 17:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbgKLQjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 11:39:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60967 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729087AbgKLQjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 11:39:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605199162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/p+OeEc4R2+aIGxfhYPv4/tQLYRVEX2f4et/noBRJjk=;
        b=b5Q6JJVdVwCIChtmAy4qhECdV79YUPtGqR2AxiLDN2LRFHaSMf+hQg0TyfruQT3hvISWVr
        CYkPcKYke1vrgC7qcjG0sgR5zMOVDWexydYBMU3DWN261fSj16+OJTvPeWjTDHW7Madz90
        9a6Ptskc31Mlepvk5meQyj5ScxFerqU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-Dzq6Y2DQNH-hE267fwGjOA-1; Thu, 12 Nov 2020 11:39:20 -0500
X-MC-Unique: Dzq6Y2DQNH-hE267fwGjOA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43690D3EA1;
        Thu, 12 Nov 2020 16:39:15 +0000 (UTC)
Received: from ovpn-66-145.rdu2.redhat.com (ovpn-66-145.rdu2.redhat.com [10.10.66.145])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E1075D734;
        Thu, 12 Nov 2020 16:38:52 +0000 (UTC)
Message-ID: <8b62fd1ad1b18def27f18e2ee2df3ff5b36d0762.camel@redhat.com>
Subject: Re: [PATCH v4 10/19] sched: Fix migrate_disable() vs
 set_cpus_allowed_ptr()
From:   Qian Cai <cai@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        qais.yousef@arm.com, swood@redhat.com, valentin.schneider@arm.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com,
        tj@kernel.org, ouwen210@hotmail.com
Date:   Thu, 12 Nov 2020 11:38:51 -0500
In-Reply-To: <20201023102346.921768277@infradead.org>
References: <20201023101158.088940906@infradead.org>
         <20201023102346.921768277@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-10-23 at 12:12 +0200, Peter Zijlstra wrote:
> Concurrent migrate_disable() and set_cpus_allowed_ptr() has
> interesting features. We rely on set_cpus_allowed_ptr() to not return
> until the task runs inside the provided mask. This expectation is
> exported to userspace.
> 
> This means that any set_cpus_allowed_ptr() caller must wait until
> migrate_enable() allows migrations.
> 
> At the same time, we don't want migrate_enable() to schedule, due to
> patterns like:
> 
> 	preempt_disable();
> 	migrate_disable();
> 	...
> 	migrate_enable();
> 	preempt_enable();
> 
> And:
> 
> 	raw_spin_lock(&B);
> 	spin_unlock(&A);
> 
> this means that when migrate_enable() must restore the affinity
> mask, it cannot wait for completion thereof. Luck will have it that
> that is exactly the case where there is a pending
> set_cpus_allowed_ptr(), so let that provide storage for the async stop
> machine.
> 
> Much thanks to Valentin who used TLA+ most effective and found lots of
> 'interesting' cases.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/sched.h |    1 
>  kernel/sched/core.c   |  234 +++++++++++++++++++++++++++++++++++++++++++-----
> --
>  2 files changed, 205 insertions(+), 30 deletions(-)

Some syscall fuzzing from an unprivileged user starts to trigger this below
since this commit first appeared in the linux-next today. Does it ring any
bells?

[12065.065837][ T1310] INFO: task trinity-c30:91730 blocked for more than 368 seconds.
[12065.073524][ T1310]       Tainted: G             L    5.10.0-rc3-next-20201112 #2
[12065.081076][ T1310] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[12065.089648][ T1310] task:trinity-c30     state:D stack:26576 pid:91730 ppid: 82688 flags:0x00000000
[12065.098818][ T1310] Call trace:
[12065.101987][ T1310]  __switch_to+0xf0/0x1a8
[12065.106227][ T1310]  __schedule+0x6ec/0x1708
[12065.110505][ T1310]  schedule+0x1bc/0x3b0
[12065.114562][ T1310]  schedule_timeout+0x3c4/0x4c0
[12065.119275][ T1310]  wait_for_completion+0x13c/0x248
[12065.124257][ T1310]  affine_move_task+0x410/0x688
(inlined by) affine_move_task at kernel/sched/core.c:2261
[12065.129013][ T1310]  __set_cpus_allowed_ptr+0x1b4/0x370
[12065.134248][ T1310]  sched_setaffinity+0x4f0/0x7e8
[12065.139088][ T1310]  __arm64_sys_sched_setaffinity+0x1f4/0x2a0
[12065.144972][ T1310]  do_el0_svc+0x124/0x228
[12065.149165][ T1310]  el0_sync_handler+0x208/0x384
[12065.153876][ T1310]  el0_sync+0x140/0x180
[12065.157971][ T1310] 
[12065.157971][ T1310] Showing all locks held in the system:
[12065.166401][ T1310] 1 lock held by khungtaskd/1310:
[12065.171288][ T1310]  #0: ffff800018d0cb40 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire.constprop.56+0x0/0x38
[12065.182210][ T1310] 4 locks held by trinity-main/82688:
[12065.187515][ T1310] 2 locks held by kworker/u513:3/82813:
[12065.192922][ T1310]  #0: ffff000000419d38 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x69c/0x18c8
[12065.203890][ T1310]  #1: ffff0000122bfd40 ((work_completion)(&buf->work)){+.+.}-{0:0}, at: __update_idle_core+0xa8/0x460
[12065.214916][ T1310] 1 lock held by trinity-c35/137168:
[12065.220061][ T1310]  #0: ffff0087ce767898 (&tty->ldisc_sem){++++}-{0:0}, at: ldsem_down_read+0x3c/0x48
[12065.229483][ T1310] 3 locks held by trinity-c61/137611:
[12065.234757][ T1310] 1 lock held by trinity-c7/137630:
[12065.239828][ T1310] 1 lock held by trinity-c57/137714:
[12065.242612][T137611] futex_wake_op: trinity-c61 tries to shift op by 1008; fix this program
[12065.245012][ T1310] 1 lock held by trinity-c52/137771:
[12065.258538][ T1310] 2 locks held by trinity-c42/137835:
[12065.263783][ T1310] 4 locks held by trinity-c22/137868:
[12065.269051][ T1310]  #0: ffff000e78503798 (&rq->lock){-.-.}-{2:2}, at: newidle_balance+0x92c/0xd78
[12065.278155][ T1310]  #1: ffff0087ce767930 (&tty->atomic_write_lock){+.+.}-{3:3}, at: tty_write_lock+0x30/0x58
[12065.288317][ T1310]  #2: ffff800018d0cb40 (rcu_read_lock){....}-{1:2}, at: __mutex_lock+0x24c/0x1310
[12065.297592][ T1310]  #3: ffff800018d0cb40 (rcu_read_lock){....}-{1:2}, at: lock_page_memcg+0x98/0x240
[12065.307026][ T1310] 2 locks held by trinity-c34/137896:
[12065.312266][ T1310]  #0: ffff000e78463798 (&rq->lock){-.-.}-{2:2}, at: __schedule+0x22c/0x1708
[12065.321023][ T1310]  #1: ffff800018d0cb40 (rcu_read_lock){....}-{1:2}, at: __update_idle_core+0xa8/0x460
[12065.330663][ T1310] 2 locks held by trinity-c43/137909:
[12065.335996][ T1310] 1 lock held by trinity-c24/137910:
[12065.341164][ T1310] 1 lock held by trinity-c1/137954:
[12065.346272][ T1310] 1 lock held by trinity-c49/138020:
[12065.351425][ T1310] 1 lock held by trinity-c10/138021:
[12065.356649][ T1310] 1 lock held by trinity-c32/138039:
[12065.361813][ T1310] 4 locks held by trinity-c36/138042:
[12065.367129][ T1310] 2 locks held by trinity-c14/138061:
[12065.372378][ T1310] 2 locks held by trinity-c38/138070:
[12065.377688][ T1310] 1 lock held by trinity-c50/138074:
[12065.382885][ T1310] 1 lock held by trinity-c12/138085:
[12065.388186][ T1310] 1 lock held by trinity-c4/138087:
[12065.393272][ T1310] 3 locks held by trinity-c6/138091:
[12065.398492][ T1310] 2 locks held by trinity-c48/138095:
[12065.403757][ T1310] 2 locks held by trinity-c62/138097:
[12065.409045][ T1310] 2 locks held by trinity-main/138107:
[12065.414441][ T1310] 1 lock held by modprobe/138108:
[12065.419351][ T1310] 
[12065.421560][ T1310] =============================================
[12065.421560][ T1310] 

