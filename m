Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5B526810C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 21:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbgIMTyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 15:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgIMTyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 15:54:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B3BC06174A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 12:54:48 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600026874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H0e4v9rcDsS5gp8nq2tqKOE7GUOY/YGmN6KNUTSD2h4=;
        b=P3yxDCxzoAA/yNJKB0Nh9okWR++rA9luG/4uwjYoPi696WLhbEqQz3czDf/++G23IVAmnG
        2gRm33fokMOi5sUAgrruVf+ZX5mqSu9bzbaOvjb9WygcnXcuSNVp090hGh0p1XlvCK4dv5
        HZu03FVVLybNsDJiB3+8KzvUrKC9tdHwo8SnH0gHxN38o2yHD6YJCXSIlnXG059tTJYpOk
        5m4OzigU3ZktTx1vEXXFjJmFeOwdOCavuWKRGhmkVl+ov9kwvPIxqv9iNsPdiSsDk3VLlO
        SGQlNjSfQKSZ+8YeJYim2p9RBIH3rEeCXjDHXDdzK+kAhWENM4SwcfD7bj7V+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600026874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H0e4v9rcDsS5gp8nq2tqKOE7GUOY/YGmN6KNUTSD2h4=;
        b=oOEkfTTg2hX0wGyOAbs9fEbpGgWS1AMrhiCR+/KFAjlvZ+aaYz9QMUO40shwde9Q+zAE9a
        K29zXjkIRPf/gOAQ==
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        syzbot <syzbot+7ffc7214b893651d52b8@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: WARNING in syscall_exit_to_user_mode
In-Reply-To: <202009121050.0D9CAB95@keescook>
References: <00000000000018a47605af074c7d@google.com> <202009121050.0D9CAB95@keescook>
Date:   Sun, 13 Sep 2020 21:54:34 +0200
Message-ID: <87sgblpi4l.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 12 2020 at 10:52, Kees Cook wrote:
>> ------------[ cut here ]------------
>> syscall 56 left IRQs disabled
>
> This WARN appears reachable. :)

The above is hardly a problem of the new entry code. It's just detecting
the wreckage...

> I also see on the dashboard these other problems with the new entry
> code:

This one is also just the messenger. That's the

     lockdep_assert_irqs_disabled();

in irqentry_exit() if I'm reading the reports correctly. That's a #PF
returning with interrupts enabled for whatever weird reason. Let me
stare at that...

> https://syzkaller.appspot.com/bug?extid=d4336c84ed0099fdbe47

This one is not a new entry code problem either:

> https://syzkaller.appspot.com/bug?extid=c4af95386364bc59b13e

INFO: task syz-executor.0:5956 can't die for more than 143 seconds.
task:syz-executor.0  state:R  running task     stack:25424 pid: 5956 ppid: 14284 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3778 [inline]
 __schedule+0x8e5/0x21e0 kernel/sched/core.c:4527
 preempt_schedule_irq+0xb0/0x150 kernel/sched/core.c:4785
 irqentry_exit_cond_resched kernel/entry/common.c:333 [inline]
 irqentry_exit_cond_resched kernel/entry/common.c:325 [inline]
 irqentry_exit+0x65/0x90 kernel/entry/common.c:363
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:581
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:653 [inline]
RIP: 0010:lock_acquire+0x27b/0xad0 kernel/locking/lockdep.c:5008
Code: 00 00 00 00 fc ff df 48 c1 e8 03 80 3c 10 00 0f 85 f8 06 00 00 48 83 3d 6a d1 5b 08 00 0f 84 a6 05 00 00 48 8b 7c 24 08 57 9d <0f> 1f 44 00 00 48 b8 00 00 00 00 00 fc ff df 48 03 44 24 10 48 c7
RSP: 0018:ffffc900088477c0 EFLAGS: 00000286
RAX: 1ffffffff136c7d9 RBX: ffff88808766c200 RCX: 000000005603e267
RDX: dffffc0000000000 RSI: 0000000000000001 RDI: 0000000000000286
RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffff8c6a59e7
R10: fffffbfff18d4b3c R11: 0000000000000001 R12: 0000000000000002
R13: ffffffff89c67640 R14: 0000000000000000 R15: ffff88808766c200
 rcu_lock_acquire include/linux/rcupdate.h:248 [inline]
 rcu_read_lock include/linux/rcupdate.h:641 [inline]
 inet_twsk_purge+0x112/0x7c0 net/ipv4/inet_timewait_sock.c:268
 ops_exit_list+0x10d/0x160 net/core/net_namespace.c:189
 setup_net+0x508/0x850 net/core/net_namespace.c:364
 copy_net_ns+0x31e/0x760 net/core/net_namespace.c:482
 create_new_namespaces+0x3f6/0xb20 kernel/nsproxy.c:110

The new entry code is just in the stack trace because that task was
preempted after a timer interrupt.

Thanks,

        tglx
