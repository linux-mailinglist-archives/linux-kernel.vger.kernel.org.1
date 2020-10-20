Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412B228FFCE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 10:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405100AbgJPIMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 04:12:47 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:41036 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405073AbgJPIM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 04:12:26 -0400
Received: by mail-io1-f70.google.com with SMTP id j21so1018565iog.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 01:12:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=xcWA32PLfjx6w6sKv3bsQQXLERevMZycCbs2tAWwNCw=;
        b=KdZ0m1N7LMm4c36fIzifFdLFVrwi4RjY6JItDkPbRgGYbtUF0NjzAZdb3BfCL3tEE/
         JJTZiBPNd/y6bgaPIqGy57xmiWp62eCMI1/Yoygy3O+0NhxxwMxcn9mbA6daE7rRj+gB
         sDNG79PfCFNttgTdTZSHK6u5UWGdaZF/T4unHoz/EQmUH7V9L8g8pUTTLbGyN16ZRZuE
         kabnrjxhGhfwx8ITkIiUn9I/9qLyC3wmtONmywRmJ12azwyiIpDQ99/F2Q1sm1i3HWHa
         UACoWfrrERSjQsBN+qe3fVaDGXMLTtSDmjSpFp2mvg6oXths/JUAekpQi27gOi3GSHXn
         9XDA==
X-Gm-Message-State: AOAM531DYPFxeTRYcQkKh4G8jy9LMXjGe4e9CewnocKStDag7CiUpeII
        Vmwz4+kEgC7fXyjt/5WGGScaxAXSqta2aUlC6258TELA+rmF
X-Google-Smtp-Source: ABdhPJzwvMF9v0pcHs6e2Uz/eGY/vdXVtzVUVGAUB+hmv0oGAXPqUsfIMO7RIxIVpqDYMb8sANNZ3w+yOogd+Wy10rAdqzMY3OO6
MIME-Version: 1.0
X-Received: by 2002:a6b:fa07:: with SMTP id p7mr1543319ioh.124.1602835944057;
 Fri, 16 Oct 2020 01:12:24 -0700 (PDT)
Date:   Fri, 16 Oct 2020 01:12:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000014370305b1c55370@google.com>
Subject: UBSAN: array-index-out-of-bounds in alg_bind
From:   syzbot <syzbot+92ead4eb8e26a26d465e@syzkaller.appspotmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    726eb70e Merge tag 'char-misc-5.10-rc1' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1011b678500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=89a0a83d1be17a89
dashboard link: https://syzkaller.appspot.com/bug?extid=92ead4eb8e26a26d465e
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+92ead4eb8e26a26d465e@syzkaller.appspotmail.com

================================================================================
UBSAN: array-index-out-of-bounds in crypto/af_alg.c:166:2
index 91 is out of range for type '__u8 [64]'
CPU: 1 PID: 8236 Comm: syz-executor.0 Not tainted 5.9.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1d6/0x29e lib/dump_stack.c:118
 ubsan_epilogue lib/ubsan.c:148 [inline]
 __ubsan_handle_out_of_bounds+0xdb/0x130 lib/ubsan.c:356
 alg_bind+0x738/0x740 crypto/af_alg.c:166
 __sys_bind+0x283/0x360 net/socket.c:1656
 __do_sys_bind net/socket.c:1667 [inline]
 __se_sys_bind net/socket.c:1665 [inline]
 __x64_sys_bind+0x76/0x80 net/socket.c:1665
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45de59
Code: 0d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f547948ec78 EFLAGS: 00000246 ORIG_RAX: 0000000000000031
RAX: ffffffffffffffda RBX: 0000000000000ac0 RCX: 000000000045de59
RDX: 0000000000000074 RSI: 0000000020000940 RDI: 0000000000000003
RBP: 000000000118bf60 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000118bf2c
R13: 00007ffd6121d5bf R14: 00007f547948f9c0 R15: 000000000118bf2c
================================================================================
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 8236 Comm: syz-executor.0 Not tainted 5.9.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1d6/0x29e lib/dump_stack.c:118
 panic+0x316/0x910 kernel/panic.c:231
 ubsan_epilogue lib/ubsan.c:162 [inline]
 __ubsan_handle_out_of_bounds+0x12b/0x130 lib/ubsan.c:356
 alg_bind+0x738/0x740 crypto/af_alg.c:166
 __sys_bind+0x283/0x360 net/socket.c:1656
 __do_sys_bind net/socket.c:1667 [inline]
 __se_sys_bind net/socket.c:1665 [inline]
 __x64_sys_bind+0x76/0x80 net/socket.c:1665
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45de59
Code: 0d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f547948ec78 EFLAGS: 00000246 ORIG_RAX: 0000000000000031
RAX: ffffffffffffffda RBX: 0000000000000ac0 RCX: 000000000045de59
RDX: 0000000000000074 RSI: 0000000020000940 RDI: 0000000000000003
RBP: 000000000118bf60 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000118bf2c
R13: 00007ffd6121d5bf R14: 00007f547948f9c0 R15: 000000000118bf2c
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
