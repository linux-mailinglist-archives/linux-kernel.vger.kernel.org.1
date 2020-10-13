Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82EB528CC69
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 13:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgJMLWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 07:22:23 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:55035 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgJMLWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 07:22:22 -0400
Received: by mail-io1-f72.google.com with SMTP id f6so12365399ion.21
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 04:22:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=J3RNnZFCpcuOEalsh/7IWqFK2n8bnYqL+R6ovChSIjg=;
        b=Z344ke4YXYlgzu2BYlFrp9fTX6oEZDeAzd++bsn7KWzSXUqbDV0VE0jKFXHjpJe0RP
         BGi9iHP7yd8wcTFzN2sM1BDfFu1KT71O2PeDp2nzZNvP2NjvkZO40pksK5J6pGhYMs7j
         3FYdrn7ue2QZbGk1KGs9IDZVskDGzqZN3B4Za6zGFHfNsg6blCFosmyvS1qFf0KnUn45
         GRmBpKltYL0jYBp8Ai7XgJomqGlEQ4YoM6WBfc6z06m0Tm3rXeVZkUfflxNCwlPpkLA0
         OPDP6xoG94fPebrPmjMb60H3xb4F3TiSvkDvW/Lnd7qIB7QPCTYXOoAd9HHzN2V4FdpN
         f7LQ==
X-Gm-Message-State: AOAM533moAqwfhyRdJ7QoV5XFT0TclrNdZD915robGZusmhL/YGWE5OP
        AHoH4CRQ0iFlMA4cNlcn8PDBE4wo0Q3qnP4eT0adGqO9MqYp
X-Google-Smtp-Source: ABdhPJy8mlHN++VnscA87qg6vlRcxaBBXh1wxy0KuUjn8Rn9cwPwrBHff79oFlTqPg/ALxIdoPJFEZe8Aptb8CfuW3+aiN4aUDKS
MIME-Version: 1.0
X-Received: by 2002:a02:cc8d:: with SMTP id s13mr22843073jap.4.1602588141755;
 Tue, 13 Oct 2020 04:22:21 -0700 (PDT)
Date:   Tue, 13 Oct 2020 04:22:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e921b305b18ba0a7@google.com>
Subject: BUG: using __this_cpu_read() in preemptible code in trace_hardirqs_on
From:   syzbot <syzbot+53f8ce8bbc07924b6417@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    865c50e1 x86/uaccess: utilize CONFIG_CC_HAS_ASM_GOTO_OUTPUT
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15112ef0500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c829313274207568
dashboard link: https://syzkaller.appspot.com/bug?extid=53f8ce8bbc07924b6417
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+53f8ce8bbc07924b6417@syzkaller.appspotmail.com

BUG: using __this_cpu_read() in preemptible [00000000] code: syz-executor.0/8265
caller is lockdep_hardirqs_on_prepare+0x56/0x620 kernel/locking/lockdep.c:4060
CPU: 0 PID: 8265 Comm: syz-executor.0 Not tainted 5.9.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1d6/0x29e lib/dump_stack.c:118
 check_preemption_disabled+0x13c/0x140 lib/smp_processor_id.c:48
 lockdep_hardirqs_on_prepare+0x56/0x620 kernel/locking/lockdep.c:4060
 trace_hardirqs_on+0x6f/0x80 kernel/trace/trace_preemptirq.c:49
 __bad_area_nosemaphore+0x89/0x510 arch/x86/mm/fault.c:797
 handle_page_fault arch/x86/mm/fault.c:1429 [inline]
 exc_page_fault+0x129/0x240 arch/x86/mm/fault.c:1482
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:538
RIP: 0033:0x402d28
Code: 00 00 48 89 7c 24 f8 48 89 74 24 f0 48 89 54 24 e8 48 89 4c 24 e0 48 8b 74 24 f8 4c 8b 4c 24 f0 48 8b 4c 24 e8 48 8b 54 24 e0 <8b> 86 0c 01 00 00 44 8b 86 08 01 00 00 c1 e0 04 8d b8 7f 01 00 00
RSP: 002b:00007fce5827ec68 EFLAGS: 00010216
RAX: 0000000000402d00 RBX: 000000000118bfc8 RCX: 0000000020000200
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 000000000118c010 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000118bfd4
R13: 00007ffea2de495f R14: 00007fce5827f9c0 R15: 000000000118bfd4
BUG: using __this_cpu_read() in preemptible [00000000] code: syz-executor.0/8265
caller is lockdep_hardirqs_on+0x36/0x110 kernel/locking/lockdep.c:4129
CPU: 0 PID: 8265 Comm: syz-executor.0 Not tainted 5.9.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1d6/0x29e lib/dump_stack.c:118
 check_preemption_disabled+0x13c/0x140 lib/smp_processor_id.c:48
 lockdep_hardirqs_on+0x36/0x110 kernel/locking/lockdep.c:4129
 __bad_area_nosemaphore+0x89/0x510 arch/x86/mm/fault.c:797
 handle_page_fault arch/x86/mm/fault.c:1429 [inline]
 exc_page_fault+0x129/0x240 arch/x86/mm/fault.c:1482
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:538
RIP: 0033:0x402d28
Code: 00 00 48 89 7c 24 f8 48 89 74 24 f0 48 89 54 24 e8 48 89 4c 24 e0 48 8b 74 24 f8 4c 8b 4c 24 f0 48 8b 4c 24 e8 48 8b 54 24 e0 <8b> 86 0c 01 00 00 44 8b 86 08 01 00 00 c1 e0 04 8d b8 7f 01 00 00
RSP: 002b:00007fce5827ec68 EFLAGS: 00010216
RAX: 0000000000402d00 RBX: 000000000118bfc8 RCX: 0000000020000200
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 000000000118c010 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000118bfd4
R13: 00007ffea2de495f R14: 00007fce5827f9c0 R15: 000000000118bfd4


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
