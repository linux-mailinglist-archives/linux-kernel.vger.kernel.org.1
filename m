Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C869929FAE9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 02:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgJ3BxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 21:53:20 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:44004 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgJ3BxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 21:53:20 -0400
Received: by mail-io1-f71.google.com with SMTP id f5so3271853iok.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 18:53:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=lYmoRmhXPePOEaWuq72nDKpmvbrrsU0VoVnNfbqP8bI=;
        b=VOqnOfllGtHmoWZ+Iyxq1iFH7AXKEEi9DmPHsfCDYzUPmJzBH9jMy91xl5snsolFL5
         /dDINk8AYHv9TlYFU4j1WLOYFPaUG9w9hOvNqpqvijyeztbvc+Sw8IGWcBJ6U+hifVgt
         HKIsuQmYFWEVTwnzS8ZHVRFRfgcZAWQmKV8udnPDWNd3Am1W17RcOSgHttqBNmc5Lxb6
         tkbMC4GPOLMMMwnuoehCpa80a8iw8E2GXTS3vE0OzK7GrcTzGCKmMqENYUB32xyz6+Mt
         GZ2/TpShs6/sgg0HEK0S56THkldBhOsJ2NpsYc9/8vKesqAMEnxE5gKqyjW0yFEocCmq
         zC8A==
X-Gm-Message-State: AOAM530LA0xaWvvaji/tR8gjF1ONoKzIFDvmP1BsH/eJlSBdzBi+tvRQ
        fqzP+p2pVCgc+ajhWzJolD0FhBLEx7ntOGfbRUIwlsdLwnqb
X-Google-Smtp-Source: ABdhPJzQlzCLVEhFBosJ2S8PNa5ncph6BY4NohjO7xRf0z57Vro/Sqgs6OZH/edzY1JakUK/o3vOddnSXOn+3weF9lpkrabDQm/+
MIME-Version: 1.0
X-Received: by 2002:a5e:9319:: with SMTP id k25mr155886iom.153.1604022797388;
 Thu, 29 Oct 2020 18:53:17 -0700 (PDT)
Date:   Thu, 29 Oct 2020 18:53:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000cd2e305b2d9a9db@google.com>
Subject: BUG: using __this_cpu_read() in preemptible code in __bad_area_nosemaphore
From:   syzbot <syzbot+cebc65195a8639f648b9@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    672f8871 Merge tag 'timers-urgent-2020-10-25' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14bb0aac500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6ab976a648fdc6
dashboard link: https://syzkaller.appspot.com/bug?extid=cebc65195a8639f648b9
compiler:       gcc (GCC) 10.1.0-syz 20200507
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cebc65195a8639f648b9@syzkaller.appspotmail.com

check_preemption_disabled: 1 callbacks suppressed
BUG: usqemu-system-x86_64: warning: guest updated active QH
caller is lockdep_hardirqs_on_prepare+0x5e/0x410 kernel/locking/lockdep.c:4060
CPU: 0 PID: 9482 Comm: syz-executor.0 Not tainted 5.9.0-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:118
 check_preemption_disabled+0x123/0x130 lib/smp_processor_id.c:48
 lockdep_hardirqs_on_prepare+0x5e/0x410 kernel/locking/lockdep.c:4060
 trace_hardirqs_on+0x5b/0x1c0 kernel/trace/trace_preemptirq.c:49
 __bad_area_nosemaphore+0xc6/0x400 arch/x86/mm/fault.c:797
 do_user_addr_fault+0x7d7/0xb40 arch/x86/mm/fault.c:1335
 handle_page_fault arch/x86/mm/fault.c:1429 [inline]
 exc_page_fault+0x9e/0x180 arch/x86/mm/fault.c:1485
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:583
RIP: 0023:0x808bb62
Code: 00 00 0f bc d1 f3 0f 7f 27 f3 0f 7f 6f 10 f3 0f 7f 77 20 f3 0f 7f 7f 30 83 c3 0f 29 d3 8d 7c 17 31 e9 d2 0b 00 00 66 0f ef c0 <66> 0f 6f 0e 66 0f 74 c1 66 0f d7 d0 83 fb 11 0f 86 e2 01 00 00 85
RSP: 002b:00000000f5533c90 EFLAGS: 00010246
RAX: 00000000f5533cb0 RBX: 00000000000003ff RCX: 0000000000000000
RDX: 000000000002c550 RSI: 0000000000000000 RDI: 00000000f5533cb0
RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
BUG: using __this_cpu_read() in preemptible [00000000] code: syz-executor.0/9482
caller is lockdep_hardirqs_on+0x38/0x110 kernel/locking/lockdep.c:4129
CPU: 0 PID: 9482 Comm: syz-executor.0 Not tainted 5.9.0-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:118
 check_preemption_disabled+0x123/0x130 lib/smp_processor_id.c:48
 lockdep_hardirqs_on+0x38/0x110 kernel/locking/lockdep.c:4129
 __bad_area_nosemaphore+0xc6/0x400 arch/x86/mm/fault.c:797
 do_user_addr_fault+0x7d7/0xb40 arch/x86/mm/fault.c:1335
 handle_page_fault arch/x86/mm/fault.c:1429 [inline]
 exc_page_fault+0x9e/0x180 arch/x86/mm/fault.c:1485
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:583
RIP: 0023:0x808bb62
Code: 00 00 0f bc d1 f3 0f 7f 27 f3 0f 7f 6f 10 f3 0f 7f 77 20 f3 0f 7f 7f 30 83 c3 0f 29 d3 8d 7c 17 31 e9 d2 0b 00 00 66 0f ef c0 <66> 0f 6f 0e 66 0f 74 c1 66 0f d7 d0 83 fb 11 0f 86 e2 01 00 00 85
RSP: 002b:00000000f5533c90 EFLAGS: 00010246
RAX: 00000000f5533cb0 RBX: 00000000000003ff RCX: 0000000000000000
RDX: 000000000002c550 RSI: 0000000000000000 RDI: 00000000f5533cb0
RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
