Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F372B0CC4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 19:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgKLSgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 13:36:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21583 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726566AbgKLSgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 13:36:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605206162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A7Z0as5ussQLalpF3BjzXZ0g9NObc//Z+waVDnCP12Q=;
        b=D8YJhdcNmNqnHihpFDRr0FmNtfZCanrZ60RAFAPe8eYrSL8YJ6yut0qw/BaGHn4aq+QYPN
        KWQ0lTTGGwY/zMcZh8H+KaSrEbNZc5wSZc6OCUtgdiJHwwnw/J/tcaOV64eMnqZxazgI9A
        7khpenJfg3iwkVnSElgDKXSJUv57o08=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-FkwgNoyoMTqhm32xIBqM-A-1; Thu, 12 Nov 2020 13:35:58 -0500
X-MC-Unique: FkwgNoyoMTqhm32xIBqM-A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB6A71882FCB;
        Thu, 12 Nov 2020 18:35:55 +0000 (UTC)
Received: from ovpn-66-145.rdu2.redhat.com (ovpn-66-145.rdu2.redhat.com [10.10.66.145])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3634619C59;
        Thu, 12 Nov 2020 18:35:47 +0000 (UTC)
Message-ID: <868a70632853a6fd0e44502fe18b822322b72a9c.camel@redhat.com>
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
Date:   Thu, 12 Nov 2020 13:35:47 -0500
In-Reply-To: <jhjd00ixz9z.mognet@arm.com>
References: <20201023101158.088940906@infradead.org>
         <20201023102346.921768277@infradead.org>
         <8b62fd1ad1b18def27f18e2ee2df3ff5b36d0762.camel@redhat.com>
         <jhjd00ixz9z.mognet@arm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-11-12 at 17:26 +0000, Valentin Schneider wrote:
> On 12/11/20 16:38, Qian Cai wrote:
> > Some syscall fuzzing from an unprivileged user starts to trigger this below
> > since this commit first appeared in the linux-next today. Does it ring any
> > bells?

X86 in a KVM guest as well.

guest .config: 
https://cailca.coding.net/public/linux/mm/git/files/master/x86.config

To reproduce:

# /usr/libexec/qemu-kvm -name kata -cpu host -smp 48 -m 48g -hda rhel-8.3-
x86_64-kvm.img.qcow2 -cdrom kata.iso -nic user,hostfwd=tcp::2222-:22 -nographic

== inside the guest ===
# git clone https://e.coding.net/cailca/linux/mm
# cd mm; make
# ./random -x 0-100 -f

[17213.432777][ T348] INFO: task trinity-c7:216885 can't die for more than 122 seconds.
[17213.434895][ T348] task:trinity-c7      state:D stack:27088 pid:216885 ppid:103237 flags:0x00004004
[17213.437297][ T348] Call Trace:
[17213.438142][ T348] __schedule (kernel/sched/core.c:4272 kernel/sched/core.c:5019) 
[17213.439256][ T348] ? __sched_text_start (kernel/sched/core.c:4901) 
[17213.440477][ T348] schedule (./arch/x86/include/asm/current.h:15 (discriminator 1) ./include/linux/sched.h:1892 (discriminator 1) kernel/sched/core.c:5100 (discriminator 1)) 
[17213.441501][ T348] schedule_timeout (kernel/time/timer.c:1848) 
[17213.442834][ T348] ? usleep_range (kernel/time/timer.c:1833) 
[17213.444070][ T348] ? wait_for_completion (kernel/sched/completion.c:85 kernel/sched/completion.c:106 kernel/sched/completion.c:117 kernel/sched/completion.c:138) 
[17213.445457][ T348] ? lock_downgrade (kernel/locking/lockdep.c:5443) 
[17213.446695][ T348] ? rcu_read_unlock (./include/linux/rcupdate.h:692 (discriminator 5)) 
[17213.447911][ T348] ? do_raw_spin_lock (./arch/x86/include/asm/atomic.h:202 ./include/asm-generic/atomic-instrumented.h:707 ./include/asm-generic/qspinlock.h:82 kernel/locking/spinlock_debug.c:113) 
[17213.449190][ T348] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4036 kernel/locking/lockdep.c:4096 kernel/locking/lockdep.c:4048) 
[17213.450714][ T348] ? _raw_spin_unlock_irq (./arch/x86/include/asm/irqflags.h:54 ./arch/x86/include/asm/irqflags.h:94 ./include/linux/spinlock_api_smp.h:168 kernel/locking/spinlock.c:199) 
[17213.452042][ T348] wait_for_completion (kernel/sched/completion.c:86 kernel/sched/completion.c:106 kernel/sched/completion.c:117 kernel/sched/completion.c:138) 
[17213.453468][ T348] ? wait_for_completion_interruptible (kernel/sched/completion.c:137) 
[17213.455152][ T348] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4036 kernel/locking/lockdep.c:4096 kernel/locking/lockdep.c:4048) 
[17213.456651][ T348] ? _raw_spin_unlock_irqrestore (./include/linux/spinlock_api_smp.h:160 kernel/locking/spinlock.c:191) 
[17213.458115][ T348] affine_move_task (./include/linux/instrumented.h:101 ./include/asm-generic/atomic-instrumented.h:220 ./include/linux/refcount.h:272 ./include/linux/refcount.h:315 ./include/linux/refcount.h:333 kernel/sched/core.c:2263) 
[17213.459313][ T348] ? move_queued_task (kernel/sched/core.c:2151) 
[17213.460553][ T348] ? update_curr (kernel/sched/sched.h:1176 kernel/sched/fair.c:845) 
[17213.461684][ T348] ? enqueue_entity (kernel/sched/fair.c:4247) 
[17213.463001][ T348] ? set_next_task_fair (./arch/x86/include/asm/jump_label.h:25 (discriminator 2) ./include/linux/jump_label.h:200 (discriminator 2) kernel/sched/fair.c:4567 (discriminator 2) kernel/sched/fair.c:4683 (discriminator 2) kernel/sched/fair.c:10953 (discriminator 2)) 
[17213.464294][ T348] __set_cpus_allowed_ptr (kernel/sched/core.c:2353) 
[17213.465668][ T348] ? affine_move_task (kernel/sched/core.c:2287) 
[17213.466952][ T348] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4036 kernel/locking/lockdep.c:4096 kernel/locking/lockdep.c:4048) 
[17213.468452][ T348] ? _raw_spin_unlock_irqrestore (./include/linux/spinlock_api_smp.h:160 kernel/locking/spinlock.c:191) 
[17213.469908][ T348] sched_setaffinity (kernel/sched/core.c:6460) 
[17213.471127][ T348] ? __ia32_sys_sched_getattr (kernel/sched/core.c:6393) 
[17213.472644][ T348] ? _copy_from_user (./arch/x86/include/asm/uaccess_64.h:46 ./arch/x86/include/asm/uaccess_64.h:52 lib/usercopy.c:16) 
[17213.473850][ T348] __x64_sys_sched_setaffinity (kernel/sched/core.c:6511 kernel/sched/core.c:6500 kernel/sched/core.c:6500) 
[17213.475307][ T348] ? sched_setaffinity (kernel/sched/core.c:6500) 
[17213.476542][ T348] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4036 kernel/locking/lockdep.c:4096 kernel/locking/lockdep.c:4048) 
[17213.477991][ T348] ? syscall_enter_from_user_mode (./arch/x86/include/asm/irqflags.h:54 ./arch/x86/include/asm/irqflags.h:94 kernel/entry/common.c:98) 
[17213.479428][ T348] ? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:50 (discriminator 22)) 
[17213.480642][ T348] do_syscall_64 (arch/x86/entry/common.c:46) 
[17213.481706][ T348] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:127) 
[17213.483236][ T348] RIP: 0033:0x7f2f00ebe78d

