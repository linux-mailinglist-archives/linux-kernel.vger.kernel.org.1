Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F52C271888
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 01:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgITXCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 19:02:15 -0400
Received: from mail-il1-f207.google.com ([209.85.166.207]:35631 "EHLO
        mail-il1-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgITXCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 19:02:15 -0400
Received: by mail-il1-f207.google.com with SMTP id e16so9705996ilq.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 16:02:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=EcQEdfH8mpDxvi0WYtbUFzEjgbR8tJYUQRmVWspJSCQ=;
        b=hSBQtw7H0TAkam57OxHgnjTbS7jzXMxPJhLfaQ1EYj+++b6rlA+b1A9lI/dQhdKxPZ
         wXgjXN3NdiPwvGBvAKbtZmUWom/Dd2SBWIN4fotWsxucx378e/xiYz4APRKDFuAGjegU
         JsLjQB78Cc6Ja8cqcrrBPqjccJJwzgkHpu9Gj3cuSPpdzGasACv8nAjHo+5tGYltTYDj
         l/PqHrLq9AL5d7SlKdFWXnJJhaDCzlBqlmd7TJHdlJs9QrTGbb7g4YefQWidJp9P0XAl
         FqIxUU5h/lnmE3WlIuBjZYBFZf0JwOXQzRWpkSzXThwQrxTh+Y95H7+jPVAkFo9dlyit
         3dZw==
X-Gm-Message-State: AOAM532RYo9cwC9kEEneHPeDWktsVqtSMSHnt4bOD/jitx1oKGHmAOJK
        5zbcUNaAfcghhOUNf/KqUbAipcHAOKxtJXvE1KPCWPShL5Hq
X-Google-Smtp-Source: ABdhPJzFyWbbcTochGoHMUUy74NpdPoauyjZD4y3dXXixTr2yqFT/Mjlyhw0dkoUU+3KSeqNgZtV8TsmAFZwfynwtMCWEzRSn7zZ
MIME-Version: 1.0
X-Received: by 2002:a5d:8752:: with SMTP id k18mr33909906iol.27.1600642934263;
 Sun, 20 Sep 2020 16:02:14 -0700 (PDT)
Date:   Sun, 20 Sep 2020 16:02:14 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000082559e05afc6b97a@google.com>
Subject: UBSAN: array-index-out-of-bounds in arch_uprobe_analyze_insn
From:   syzbot <syzbot+9b64b619f10f19d19a7c@syzkaller.appspotmail.com>
To:     bp@alien8.de, gustavoars@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        wang.yi59@zte.com.cn, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    325d0eab Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1195f481900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b12e84189082991c
dashboard link: https://syzkaller.appspot.com/bug?extid=9b64b619f10f19d19a7c
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9b64b619f10f19d19a7c@syzkaller.appspotmail.com

================================================================================
UBSAN: array-index-out-of-bounds in arch/x86/kernel/uprobes.c:263:56
index 4 is out of range for type 'insn_byte_t [4]'
CPU: 1 PID: 22315 Comm: syz-executor.4 Not tainted 5.9.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 ubsan_epilogue+0xb/0x5a lib/ubsan.c:148
 __ubsan_handle_out_of_bounds.cold+0x62/0x6c lib/ubsan.c:356
 is_prefix_bad arch/x86/kernel/uprobes.c:263 [inline]
 uprobe_init_insn arch/x86/kernel/uprobes.c:286 [inline]
 arch_uprobe_analyze_insn+0x8f4/0xa40 arch/x86/kernel/uprobes.c:856
 prepare_uprobe kernel/events/uprobes.c:860 [inline]
 install_breakpoint.isra.0+0x6c4/0x7c0 kernel/events/uprobes.c:903
 uprobe_mmap+0x5ec/0x1080 kernel/events/uprobes.c:1394
 mmap_region+0x5cf/0x1780 mm/mmap.c:1839
 do_mmap+0xcf9/0x11d0 mm/mmap.c:1545
 vm_mmap_pgoff+0x195/0x200 mm/util.c:506
 ksys_mmap_pgoff+0x444/0x580 mm/mmap.c:1596
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45d5f9
Code: 5d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 2b b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f8e919bcc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 0000000000020f80 RCX: 000000000045d5f9
RDX: 0000000000000000 RSI: 0000000000003000 RDI: 0000000020007000
RBP: 000000000118cf98 R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000000412 R11: 0000000000000246 R12: 000000000118cf4c
R13: 00007ffe8fbd4c5f R14: 00007f8e919bd9c0 R15: 000000000118cf4c
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
