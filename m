Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3ED28CF07
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 15:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbgJMNRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 09:17:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:36908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728373AbgJMNRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 09:17:45 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCEDC22D2C;
        Tue, 13 Oct 2020 13:17:44 +0000 (UTC)
Date:   Tue, 13 Oct 2020 09:17:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     syzbot <syzbot+53f8ce8bbc07924b6417@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: BUG: using __this_cpu_read() in preemptible code in
 trace_hardirqs_on
Message-ID: <20201013091743.12c371a8@gandalf.local.home>
In-Reply-To: <000000000000e921b305b18ba0a7@google.com>
References: <000000000000e921b305b18ba0a7@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Oct 2020 04:22:21 -0700
syzbot <syzbot+53f8ce8bbc07924b6417@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    865c50e1 x86/uaccess: utilize CONFIG_CC_HAS_ASM_GOTO_OUTPUT
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15112ef0500000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c829313274207568
> dashboard link: https://syzkaller.appspot.com/bug?extid=53f8ce8bbc07924b6417
> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+53f8ce8bbc07924b6417@syzkaller.appspotmail.com
> 
> BUG: using __this_cpu_read() in preemptible [00000000] code: syz-executor.0/8265
> caller is lockdep_hardirqs_on_prepare+0x56/0x620 kernel/locking/lockdep.c:4060
> CPU: 0 PID: 8265 Comm: syz-executor.0 Not tainted 5.9.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1d6/0x29e lib/dump_stack.c:118
>  check_preemption_disabled+0x13c/0x140 lib/smp_processor_id.c:48
>  lockdep_hardirqs_on_prepare+0x56/0x620 kernel/locking/lockdep.c:4060
>  trace_hardirqs_on+0x6f/0x80 kernel/trace/trace_preemptirq.c:49
>  __bad_area_nosemaphore+0x89/0x510 arch/x86/mm/fault.c:797
>  handle_page_fault arch/x86/mm/fault.c:1429 [inline]
>  exc_page_fault+0x129/0x240 arch/x86/mm/fault.c:1482
>  asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:538
> RIP: 0033:0x402d28
> Code: 00 00 48 89 7c 24 f8 48 89 74 24 f0 48 89 54 24 e8 48 89 4c 24 e0 48 8b 74 24 f8 4c 8b 4c 24 f0 48 8b 4c 24 e8 48 8b 54 24 e0 <8b> 86 0c 01 00 00 44 8b 86 08 01 00 00 c1 e0 04 8d b8 7f 01 00 00
> RSP: 002b:00007fce5827ec68 EFLAGS: 00010216
> RAX: 0000000000402d00 RBX: 000000000118bfc8 RCX: 0000000020000200
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 000000000118c010 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000118bfd4
> R13: 00007ffea2de495f R14: 00007fce5827f9c0 R15: 000000000118bfd4
> BUG: using __this_cpu_read() in preemptible [00000000] code: syz-executor.0/8265
> caller is lockdep_hardirqs_on+0x36/0x110 kernel/locking/lockdep.c:4129
> CPU: 0 PID: 8265 Comm: syz-executor.0 Not tainted 5.9.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1d6/0x29e lib/dump_stack.c:118
>  check_preemption_disabled+0x13c/0x140 lib/smp_processor_id.c:48
>  lockdep_hardirqs_on+0x36/0x110 kernel/locking/lockdep.c:4129
>  __bad_area_nosemaphore+0x89/0x510 arch/x86/mm/fault.c:797

Peter,

I'm guessing the above is:

static void
__bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
		       unsigned long address, u32 pkey, int si_code)
{
	struct task_struct *tsk = current;

	/* User mode accesses just cause a SIGSEGV */
	if (user_mode(regs) && (error_code & X86_PF_USER)) {
		/*
		 * It's possible to have interrupts off here:
		 */
		local_irq_enable();


And I'm also guessing that we can call this with interrupts enabled (based
on the comment).

And we have this:

   local_irq_enable()
      trace_hardirqs_on()
         lockdep_hardirqs_on()
             __this_cpu_read()

-- Steve


>  handle_page_fault arch/x86/mm/fault.c:1429 [inline]
>  exc_page_fault+0x129/0x240 arch/x86/mm/fault.c:1482
>  asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:538
> RIP: 0033:0x402d28
> Code: 00 00 48 89 7c 24 f8 48 89 74 24 f0 48 89 54 24 e8 48 89 4c 24 e0 48 8b 74 24 f8 4c 8b 4c 24 f0 48 8b 4c 24 e8 48 8b 54 24 e0 <8b> 86 0c 01 00 00 44 8b 86 08 01 00 00 c1 e0 04 8d b8 7f 01 00 00
> RSP: 002b:00007fce5827ec68 EFLAGS: 00010216
> RAX: 0000000000402d00 RBX: 000000000118bfc8 RCX: 0000000020000200
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 000000000118c010 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000118bfd4
> R13: 00007ffea2de495f R14: 00007fce5827f9c0 R15: 000000000118bfd4
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

