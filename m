Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9420290A69
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 19:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390372AbgJPRQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 13:16:22 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:48335 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390329AbgJPRQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 13:16:19 -0400
Received: by mail-il1-f200.google.com with SMTP id g1so2084158iln.15
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 10:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=q0jNKtibOWMJBRSMoi9tRAAYTD3Bsh7XibLHQWKKvMs=;
        b=McvN/1Q+TuDeQYPTP9Jk0qGStQp9K5A+Wuqr5StBV7mAtu7YQ7R5sMhzbBHS5zehfw
         25AgMUrGg44Dm8tIeNWt0JOqBv+yXqESgYi220EXRN8RDI2pnhcAkdeyQsRTgCdsPVKt
         FCCZMxfOuHhWoXcMS5hjwRUg4spvr6Uv0tGNxYPkyB5Hj/iDpelXsCpNzD94iW63rsdR
         MTTPOK17mQp5+iXBrbYdqtWLkPnwWG4PcY1hjfC2QrCaXeIp//IpC/9lAKyleo00MQtL
         bACtjy/RzGpg7LPfvT7Wlh6yniDMmNTXoec0mIhGe3lkrur3xUuG22kNkmjtPbzxTu2/
         zwZQ==
X-Gm-Message-State: AOAM531NV0RSh5gUzY6q/aKjRcX3r1Uf3+kod5GtKiBIzbEuu9B+gftm
        ZTfRLeCGuybqe0m0AYshRGwTSaAZ1IsP0HEXqxxsb0Y573Pi
X-Google-Smtp-Source: ABdhPJwqAUmyYK33bi7fsTlYAEosMlLlYVI/JmFTbMGOfskbj7unza2qeiRqPfBErINwiMLlxq0rBxgEvPh/RyCvU9DhOFa4hD3Z
MIME-Version: 1.0
X-Received: by 2002:a92:da0e:: with SMTP id z14mr3473482ilm.151.1602868577972;
 Fri, 16 Oct 2020 10:16:17 -0700 (PDT)
Date:   Fri, 16 Oct 2020 10:16:17 -0700
In-Reply-To: <000000000000e921b305b18ba0a7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000036383505b1ccec93@google.com>
Subject: Re: BUG: using __this_cpu_read() in preemptible code in trace_hardirqs_on
From:   syzbot <syzbot+53f8ce8bbc07924b6417@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        netdev@vger.kernel.org, peterz@infradead.org, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    9ff9b0d3 Merge tag 'net-next-5.10' of git://git.kernel.org..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16638607900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d13c3fa80bc4bcc1
dashboard link: https://syzkaller.appspot.com/bug?extid=53f8ce8bbc07924b6417
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b63310500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1565657f900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+53f8ce8bbc07924b6417@syzkaller.appspotmail.com

BUG: using __this_cpu_read() in preemptible [00000000] code: syz-executor089/6901
caller is lockdep_hardirqs_on_prepare+0x5e/0x450 kernel/locking/lockdep.c:4060
CPU: 0 PID: 6901 Comm: syz-executor089 Not tainted 5.9.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fb lib/dump_stack.c:118
 check_preemption_disabled+0x128/0x130 lib/smp_processor_id.c:48
 lockdep_hardirqs_on_prepare+0x5e/0x450 kernel/locking/lockdep.c:4060
 trace_hardirqs_on+0x5b/0x1c0 kernel/trace/trace_preemptirq.c:49
 __bad_area_nosemaphore+0xc6/0x4f0 arch/x86/mm/fault.c:797
 do_user_addr_fault+0x852/0xbf0 arch/x86/mm/fault.c:1335
 handle_page_fault arch/x86/mm/fault.c:1429 [inline]
 exc_page_fault+0xa8/0x190 arch/x86/mm/fault.c:1482
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:583
RIP: 0033:0x4241f0
Code: 66 0f ef c0 66 0f ef c9 66 0f ef d2 66 0f ef db 48 89 f8 48 89 f9 48 81 e1 ff 0f 00 00 48 81 f9 cf 0f 00 00 77 74 48 83 e0 f0 <66> 0f 74 00 66 0f 74 48 10 66 0f 74 50 20 66 0f 74 58 30 66 0f d7
RSP: 002b:00007ffcacd310b8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 00007ffcacd310e0 RCX: 0000000000000000
RDX: 0000000000000010 RSI: 000000000000000f RDI: 0000000000000000
RBP: 0000000000000003 R08: 00000000ffffffff R09: 0000000000000000
R10: 0000000000000000 R11: 000000000000000f R12: 0000000000401d70
R13: 0000000000401e00 R14: 0000000000000000 R15: 0000000000000000
BUG: using __this_cpu_read() in preemptible [00000000] code: syz-executor089/6901
caller is lockdep_hardirqs_on+0x34/0x110 kernel/locking/lockdep.c:4129
CPU: 0 PID: 6901 Comm: syz-executor089 Not tainted 5.9.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fb lib/dump_stack.c:118
 check_preemption_disabled+0x128/0x130 lib/smp_processor_id.c:48
 lockdep_hardirqs_on+0x34/0x110 kernel/locking/lockdep.c:4129
 __bad_area_nosemaphore+0xc6/0x4f0 arch/x86/mm/fault.c:797
 do_user_addr_fault+0x852/0xbf0 arch/x86/mm/fault.c:1335
 handle_page_fault arch/x86/mm/fault.c:1429 [inline]
 exc_page_fault+0xa8/0x190 arch/x86/mm/fault.c:1482
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:583
RIP: 0033:0x4241f0
Code: 66 0f ef c0 66 0f ef c9 66 0f ef d2 66 0f ef db 48 89 f8 48 89 f9 48 81 e1 ff 0f 00 00 48 81 f9 cf 0f 00 00 77 74 48 83 e0 f0 <66> 0f 74 00 66 0f 74 48 10 66 0f 74 50 20 66 0f 74 58 30 66 0f d7
RSP: 002b:00007ffcacd310b8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 00007ffcacd310e0 RCX: 0000000000000000
RDX: 0000000000000010 RSI: 000000000000000f RDI: 0000000000000000
RBP: 0000000000000003 R08: 00000000ffffffff R09: 0000000000000000
R10: 0000000000000000 R11: 00000000000

