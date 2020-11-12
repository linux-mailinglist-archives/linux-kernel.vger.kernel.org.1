Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66FF2B0F18
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 21:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgKLUh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 15:37:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37986 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726566AbgKLUhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 15:37:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605213443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=65nYhisyA6QTWyYgeX0UH+AGmbCDy5BIzfEFXNH8QSg=;
        b=X+38+lMPP1dZd0VPlb/znPsj7gLErwv0jo2YimZimJUTY/rN45cekD82CJVt56F8BQgvq9
        2xsL7g3TGbE8phgQM0RbWfEsfX+O0i4asIF+bc+vmLoAHRAWsOU+BxDE3e4ebGyNHXmcMi
        DmeyNRS+ybOlt+FEvwP7dDJvOquV348=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-582-hYx1GYw_PU23zHhV-yaZFg-1; Thu, 12 Nov 2020 15:37:20 -0500
X-MC-Unique: hYx1GYw_PU23zHhV-yaZFg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56400804751;
        Thu, 12 Nov 2020 20:37:17 +0000 (UTC)
Received: from ovpn-66-145.rdu2.redhat.com (ovpn-66-145.rdu2.redhat.com [10.10.66.145])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7ECAB5DE19;
        Thu, 12 Nov 2020 20:37:09 +0000 (UTC)
Message-ID: <371cfc80a1ecaa526a774efbe36369cc66b4ae69.camel@redhat.com>
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
Date:   Thu, 12 Nov 2020 15:37:08 -0500
In-Reply-To: <jhja6vmxthb.mognet@arm.com>
References: <20201023101158.088940906@infradead.org>
         <20201023102346.921768277@infradead.org>
         <8b62fd1ad1b18def27f18e2ee2df3ff5b36d0762.camel@redhat.com>
         <jhjd00ixz9z.mognet@arm.com>
         <13786aa5a5fc958708ef1182c885d1a574449d99.camel@redhat.com>
         <jhja6vmxthb.mognet@arm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-11-12 at 19:31 +0000, Valentin Schneider wrote:
> a) Do you also get this on CONFIG_PREEMPT=y?

This also happens with:

CONFIG_PREEMPT=y
CONFIG_PREEMPTION=y
CONFIG_PREEMPT_RCU=y
CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_DEBUG_PREEMPT=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y

[ 1235.044945][  T330] INFO: task trinity-c4:60050 blocked for more than 245 seconds.
[ 1235.052540][  T330]       Not tainted 5.10.0-rc3-next-20201112+ #2
[ 1235.058774][  T330] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1235.067392][  T330] task:trinity-c4      state:D stack:26880 pid:60050 ppid:  1722 flags:0x00004000
[ 1235.076505][  T330] Call Trace:
[ 1235.079680][ T330] __schedule (kernel/sched/core.c:4272 kernel/sched/core.c:5019) 
[ 1235.083971][ T330] ? __sched_text_start (kernel/sched/core.c:4901) 
[ 1235.088721][ T330] schedule (kernel/sched/core.c:5099 (discriminator 1)) 
[ 1235.092661][ T330] schedule_timeout (kernel/time/timer.c:1848) 
[ 1235.097399][ T330] ? usleep_range (kernel/time/timer.c:1833) 
[ 1235.101945][ T330] ? wait_for_completion (kernel/sched/completion.c:85 kernel/sched/completion.c:106 kernel/sched/completion.c:117 kernel/sched/completion.c:138) 
[ 1235.107156][ T330] ? lock_downgrade (kernel/locking/lockdep.c:5443) 
[ 1235.111883][ T330] ? rcu_read_unlock (./include/linux/rcupdate.h:692 (discriminator 5)) 
[ 1235.116561][ T330] ? do_raw_spin_lock (./arch/x86/include/asm/atomic.h:202 ./include/asm-generic/atomic-instrumented.h:707 ./include/asm-generic/qspinlock.h:82 kernel/locking/spinlock_debug.c:113) 
[ 1235.121459][ T330] ? _raw_spin_unlock_irq (./arch/x86/include/asm/irqflags.h:54 ./arch/x86/include/asm/irqflags.h:94 ./include/linux/spinlock_api_smp.h:168 kernel/locking/spinlock.c:199) 
[ 1235.126601][ T330] wait_for_completion (kernel/sched/completion.c:86 kernel/sched/completion.c:106 kernel/sched/completion.c:117 kernel/sched/completion.c:138) 
[ 1235.131591][ T330] ? wait_for_completion_interruptible (kernel/sched/completion.c:137) 
[ 1235.138013][ T330] ? _raw_spin_unlock_irqrestore (./include/linux/spinlock_api_smp.h:160 kernel/locking/spinlock.c:191) 
[ 1235.143698][ T330] affine_move_task (./include/linux/instrumented.h:101 ./include/asm-generic/atomic-instrumented.h:220 ./include/linux/refcount.h:272 ./include/linux/refcount.h:315 ./include/linux/refcount.h:333 kernel/sched/core.c:2263) 
[ 1235.148451][ T330] ? move_queued_task (kernel/sched/core.c:2151) 
[ 1235.153351][ T330] ? update_curr (kernel/sched/sched.h:1176 kernel/sched/fair.c:845) 
[ 1235.157848][ T330] ? enqueue_entity (kernel/sched/fair.c:4247) 
[ 1235.162658][ T330] ? set_next_task_fair (./arch/x86/include/asm/jump_label.h:25 (discriminator 2) ./include/linux/jump_label.h:200 (discriminator 2) kernel/sched/fair.c:4567 (discriminator 2) kernel/sched/fair.c:4683 (discriminator 2) kernel/sched/fair.c:10953 (discriminator 2)) 
[ 1235.167667][ T330] __set_cpus_allowed_ptr (kernel/sched/core.c:2353) 
[ 1235.172905][ T330] ? affine_move_task (kernel/sched/core.c:2287) 
[ 1235.177826][ T330] ? _raw_spin_unlock_irqrestore (./include/linux/spinlock_api_smp.h:160 kernel/locking/spinlock.c:191) 
[ 1235.183501][ T330] sched_setaffinity (kernel/sched/core.c:6460) 
[ 1235.188345][ T330] ? __ia32_sys_sched_getattr (kernel/sched/core.c:6393) 
[ 1235.193937][ T330] ? _copy_from_user (./arch/x86/include/asm/uaccess_64.h:46 ./arch/x86/include/asm/uaccess_64.h:52 lib/usercopy.c:16) 
[ 1235.198605][ T330] __x64_sys_sched_setaffinity (kernel/sched/core.c:6511 kernel/sched/core.c:6500 kernel/sched/core.c:6500) 
[ 1235.204291][ T330] ? sched_setaffinity (kernel/sched/core.c:6500) 
[ 1235.209324][ T330] ? syscall_enter_from_user_mode (./arch/x86/include/asm/irqflags.h:54 ./arch/x86/include/asm/irqflags.h:94 kernel/entry/common.c:98) 
[ 1235.215133][ T330] do_syscall_64 (arch/x86/entry/common.c:46) 
[ 1235.219431][ T330] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:127) 
[ 1235.225251][  T330] RIP: 0033:0x7fb102b1178d

> b) Could you try the below?

It is running good so far on multiple systems. I'll keep it running and report
back if it happens again.

