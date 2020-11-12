Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3142B0C18
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 19:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgKLSB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 13:01:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42888 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726496AbgKLSB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 13:01:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605204084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m2484VQcmTKFAUifP9r1LVLL2cNxlxsxNIWUOG+UGhU=;
        b=hdVBlZQrjwgWfMty15gXDFPVkwlMlcBsNDyEY2tF3eBOQn0Ir+gt2ROSdfxB5AxlnkE+kk
        aybY3kqWJh/FMb47jSlOxMatdAozlYw/opB7AZMf1IZPndFCZE1818HuWAf1ha0pz387OH
        y/xycvAAy3uF9yYmYm1gKDxLEGf7LEI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-sPQVwXlyMUiEzNtm-sIU5Q-1; Thu, 12 Nov 2020 13:01:21 -0500
X-MC-Unique: sPQVwXlyMUiEzNtm-sIU5Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFAF4801FDF;
        Thu, 12 Nov 2020 18:01:18 +0000 (UTC)
Received: from ovpn-66-145.rdu2.redhat.com (ovpn-66-145.rdu2.redhat.com [10.10.66.145])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A579560C0F;
        Thu, 12 Nov 2020 18:01:10 +0000 (UTC)
Message-ID: <13786aa5a5fc958708ef1182c885d1a574449d99.camel@redhat.com>
Subject: Re: [PATCH v4 10/19] sched: Fix migrate_disable() vs
 set_cpus_allowed_ptr()
From:   Qian Cai <cai@redhat.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com,
        tj@kernel.org, ouwen210@hotmail.com
Date:   Thu, 12 Nov 2020 13:01:10 -0500
In-Reply-To: <jhjd00ixz9z.mognet@arm.com>
References: <20201023101158.088940906@infradead.org>
         <20201023102346.921768277@infradead.org>
         <8b62fd1ad1b18def27f18e2ee2df3ff5b36d0762.camel@redhat.com>
         <jhjd00ixz9z.mognet@arm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-11-12 at 17:26 +0000, Valentin Schneider wrote:
> On 12/11/20 16:38, Qian Cai wrote:
> > Some syscall fuzzing from an unprivileged user starts to trigger this below
> > since this commit first appeared in the linux-next today. Does it ring any
> > bells?
> > 
> 
> What's the .config? I'm interested in
> CONFIG_PREEMPT
> CONFIG_PREEMPT_RT
> CONFIG_SMP

https://cailca.coding.net/public/linux/mm/git/files/master/arm64.config

# CONFIG_PREEMPT is not set
CONFIG_SMP=y

Also, I have been able to reproduce this on powerpc as well just now.

> 
> From a quick look it seems that tree doesn't have Thomas' "generalization" of
> migrate_disable(), so if this doesn't have PREEMPT_RT we could forget about
> migrate_disable() for now.
> 
> > [12065.065837][ T1310] INFO: task trinity-c30:91730 blocked for more than
> > 368 seconds.
> > [12065.073524][ T1310]       Tainted: G             L    5.10.0-rc3-next-
> > 20201112 #2
> > [12065.081076][ T1310] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > disables this message.
> > [12065.089648][ T1310] task:trinity-c30     state:D stack:26576 pid:91730
> > ppid: 82688 flags:0x00000000
> > [12065.098818][ T1310] Call trace:
> > [12065.101987][ T1310]  __switch_to+0xf0/0x1a8
> > [12065.106227][ T1310]  __schedule+0x6ec/0x1708
> > [12065.110505][ T1310]  schedule+0x1bc/0x3b0
> > [12065.114562][ T1310]  schedule_timeout+0x3c4/0x4c0
> > [12065.119275][ T1310]  wait_for_completion+0x13c/0x248
> > [12065.124257][ T1310]  affine_move_task+0x410/0x688
> > (inlined by) affine_move_task at kernel/sched/core.c:2261
> > [12065.129013][ T1310]  __set_cpus_allowed_ptr+0x1b4/0x370
> > [12065.134248][ T1310]  sched_setaffinity+0x4f0/0x7e8
> > [12065.139088][ T1310]  __arm64_sys_sched_setaffinity+0x1f4/0x2a0
> > [12065.144972][ T1310]  do_el0_svc+0x124/0x228
> > [12065.149165][ T1310]  el0_sync_handler+0x208/0x384
> > [12065.153876][ T1310]  el0_sync+0x140/0x180
> > [12065.157971][ T1310]
> 
> So that's a task changing the affinity of some task (either itself or
> another; I can't say without a decoded stacktrace), and then blocking on a
> wait_for_completion() that apparently never happens.
> 
> I don't see stop_one_cpu() in the trace, so I assume it's the !task_running
> case, for which the completion should be completed before getting to the
> wait (unless we *do* have migrate_disable()).
> 
> Could you please run scripts/decode_stacktrace.sh on the above?

[12065.101987][ T1310] __switch_to (arch/arm64/kernel/process.c:580) 
[12065.106227][ T1310] __schedule (kernel/sched/core.c:4272 kernel/sched/core.c:5019) 
[12065.110505][ T1310] schedule (./arch/arm64/include/asm/current.h:19 (discriminator 1) ./arch/arm64/include/asm/preempt.h:53 (discriminator 1) kernel/sched/core.c:5099 (discriminator 1)) 
[12065.114562][ T1310] schedule_timeout (kernel/time/timer.c:1848) 
[12065.119275][ T1310] wait_for_completion (kernel/sched/completion.c:85 kernel/sched/completion.c:106 kernel/sched/completion.c:117 kernel/sched/completion.c:138) 
[12065.124257][ T1310] affine_move_task (./include/linux/instrumented.h:101 ./include/asm-generic/atomic-instrumented.h:220 ./include/linux/refcount.h:272 ./include/linux/refcount.h:315 ./include/linux/refcount.h:333 kernel/sched/core.c:2263) 
[12065.129013][ T1310] __set_cpus_allowed_ptr (kernel/sched/core.c:2353) 
[12065.134248][ T1310] sched_setaffinity (kernel/sched/core.c:6460) 
[12065.139088][ T1310] __arm64_sys_sched_setaffinity (kernel/sched/core.c:6511 kernel/sched/core.c:6500 kernel/sched/core.c:6500) 
[12065.144972][ T1310] do_el0_svc (arch/arm64/kernel/syscall.c:36 arch/arm64/kernel/syscall.c:48 arch/arm64/kernel/syscall.c:159 arch/arm64/kernel/syscall.c:205) 
[12065.149165][ T1310] el0_sync_handler (arch/arm64/kernel/entry-common.c:236 arch/arm64/kernel/entry-common.c:254) 
[12065.153876][ T1310] el0_sync (arch/arm64/kernel/entry.S:741)

== powerpc ==
[18060.020301][ T676] [c000200014227670] [c000000000a6d1e8] __func__.5350+0x1220e0/0x181338 unreliable 
[18060.020333][ T676] [c000200014227850] [c00000000001a278] __switch_to (arch/powerpc/kernel/process.c:1273) 
[18060.020351][ T676] [c0002000142278c0] [c0000000008f3e94] __schedule (kernel/sched/core.c:4269 kernel/sched/core.c:5019) 
[18060.020377][ T676] [c000200014227990] [c0000000008f4638] schedule (./include/asm-generic/preempt.h:59 (discriminator 1) kernel/sched/core.c:5099 (discriminator 1)) 
[18060.020394][ T676] [c0002000142279c0] [c0000000008fbd34] schedule_timeout (kernel/time/timer.c:1847) 
[18060.020420][ T676] [c000200014227ac0] [c0000000008f6398] wait_for_completion (kernel/sched/completion.c:85 kernel/sched/completion.c:106 kernel/sched/completion.c:117 kernel/sched/completion.c:138) 
[18060.020455][ T676] [c000200014227b30] [c000000000100fd4] affine_move_task (kernel/sched/core.c:2261) 
[18060.020481][ T676] [c000200014227c90] [c000000000101444] __set_cpus_allowed_ptr (kernel/sched/core.c:2353) 
[18060.020507][ T676] [c000200014227d00] [c000000000106eac] sched_setaffinity (kernel/sched/core.c:6460) 
[18060.020533][ T676] [c000200014227d70] [c000000000107134] sys_sched_setaffinity (kernel/sched/core.c:6511 kernel/sched/core.c:6500) 
[18060.020559][ T676] [c000200014227dc0] [c00000000002a6d8] system_call_exception (arch/powerpc/kernel/syscall_64.c:111) 
[18060.020585][ T676] [c000200014227e20] [c00000000000d0a8] system_call_common (arch/powerpc/kernel/entry_64.S:302)


