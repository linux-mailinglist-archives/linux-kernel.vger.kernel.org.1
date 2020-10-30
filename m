Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5094429FBC2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 03:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgJ3CvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 22:51:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:42564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbgJ3CvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 22:51:10 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84B252076E;
        Fri, 30 Oct 2020 02:51:08 +0000 (UTC)
Date:   Thu, 29 Oct 2020 22:51:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     syzbot <syzbot+cebc65195a8639f648b9@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: BUG: using __this_cpu_read() in preemptible code in
 __bad_area_nosemaphore
Message-ID: <20201029225106.0ce492a4@oasis.local.home>
In-Reply-To: <0000000000000cd2e305b2d9a9db@google.com>
References: <0000000000000cd2e305b2d9a9db@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Oct 2020 18:53:17 -0700
syzbot <syzbot+cebc65195a8639f648b9@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:

Didn't Peter already send a fix for this? Is it not upstream yet?

-- Steve

> 
> HEAD commit:    672f8871 Merge tag 'timers-urgent-2020-10-25' of git://git..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14bb0aac500000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6ab976a648fdc6
> dashboard link: https://syzkaller.appspot.com/bug?extid=cebc65195a8639f648b9
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> userspace arch: i386
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+cebc65195a8639f648b9@syzkaller.appspotmail.com
> 
> check_preemption_disabled: 1 callbacks suppressed
> BUG: usqemu-system-x86_64: warning: guest updated active QH
> caller is lockdep_hardirqs_on_prepare+0x5e/0x410 kernel/locking/lockdep.c:4060
> CPU: 0 PID: 9482 Comm: syz-executor.0 Not tainted 5.9.0-syzkaller #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x107/0x163 lib/dump_stack.c:118
>  check_preemption_disabled+0x123/0x130 lib/smp_processor_id.c:48
>  lockdep_hardirqs_on_prepare+0x5e/0x410 kernel/locking/lockdep.c:4060
>  trace_hardirqs_on+0x5b/0x1c0 kernel/trace/trace_preemptirq.c:49
>  __bad_area_nosemaphore+0xc6/0x400 arch/x86/mm/fault.c:797
>  do_user_addr_fault+0x7d7/0xb40 arch/x86/mm/fault.c:1335
>  handle_page_fault arch/x86/mm/fault.c:1429 [inline]
>  exc_page_fault+0x9e/0x180 arch/x86/mm/fault.c:1485
>  asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:583
> RIP: 0023:0x808bb62
> Code: 00 00 0f bc d1 f3 0f 7f 27 f3 0f 7f 6f 10 f3 0f 7f 77 20 f3 0f 7f 7f 30 83 c3 0f 29 d3 8d 7c 17 31 e9 d2 0b 00 00 66 0f ef c0 <66> 0f 6f 0e 66 0f 74 c1 66 0f d7 d0 83 fb 11 0f 86 e2 01 00 00 85
> RSP: 002b:00000000f5533c90 EFLAGS: 00010246
> RAX: 00000000f5533cb0 RBX: 00000000000003ff RCX: 0000000000000000
> RDX: 000000000002c550 RSI: 0000000000000000 RDI: 00000000f5533cb0
> RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> BUG: using __this_cpu_read() in preemptible [00000000] code: syz-executor.0/9482
> caller is lockdep_hardirqs_on+0x38/0x110 kernel/locking/lockdep.c:4129
> CPU: 0 PID: 9482 Comm: syz-executor.0 Not tainted 5.9.0-syzkaller #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x107/0x163 lib/dump_stack.c:118
>  check_preemption_disabled+0x123/0x130 lib/smp_processor_id.c:48
>  lockdep_hardirqs_on+0x38/0x110 kernel/locking/lockdep.c:4129
>  __bad_area_nosemaphore+0xc6/0x400 arch/x86/mm/fault.c:797
>  do_user_addr_fault+0x7d7/0xb40 arch/x86/mm/fault.c:1335
>  handle_page_fault arch/x86/mm/fault.c:1429 [inline]
>  exc_page_fault+0x9e/0x180 arch/x86/mm/fault.c:1485
>  asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:583
> RIP: 0023:0x808bb62
> Code: 00 00 0f bc d1 f3 0f 7f 27 f3 0f 7f 6f 10 f3 0f 7f 77 20 f3 0f 7f 7f 30 83 c3 0f 29 d3 8d 7c 17 31 e9 d2 0b 00 00 66 0f ef c0 <66> 0f 6f 0e 66 0f 74 c1 66 0f d7 d0 83 fb 11 0f 86 e2 01 00 00 85
> RSP: 002b:00000000f5533c90 EFLAGS: 00010246
> RAX: 00000000f5533cb0 RBX: 00000000000003ff RCX: 0000000000000000
> RDX: 000000000002c550 RSI: 0000000000000000 RDI: 00000000f5533cb0
> RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

