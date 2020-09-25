Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C490277FDB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 07:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbgIYFSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 01:18:22 -0400
Received: from mail-io1-f78.google.com ([209.85.166.78]:49856 "EHLO
        mail-io1-f78.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgIYFSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 01:18:22 -0400
Received: by mail-io1-f78.google.com with SMTP id k133so1075326iof.16
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 22:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=xnaQi0Ogw6Ir+bQkz0MTlcxfGbyjAbFPvVDgd22X8g4=;
        b=ALVzSaj+FaOIkLUFXeW917xNM6k2dVLqLLrAkaFccRBi1QECSLCwfQyjifKmCX6Fzl
         Frku5K5riK9wMg9PAaI0GsxKDZjC8lbhgQEt8OvduYE1tLvrDcRkyYL6MF2Ho3kr+ZgY
         zmwmPhctTJvRUFA0M50mEsdK7Ym+P30qwtt9iPUAdCQSpSghNJo1BxNwubcTCND34JPs
         LMnYR8k7A43IlxcUhJ0PbZq9RWdltg4deUcZiw6o3T7shjglKUBF2YOAxAh7FWBE/kBE
         r4vwwqDXztRbNqP0IRMEB6OceXpXHlRy2N1UebC9cnYxYzUZV0euYIZBe89siklY/fCP
         5+KQ==
X-Gm-Message-State: AOAM532zy2RBCNLrUS00W+qYlAH57RflB8RprFGtqO6hTN8X/kyHiCsi
        eQ5694e5bpD1gWDpJXPuCdVaudHz4tFInIj9KGXhQ4ihIxA1
X-Google-Smtp-Source: ABdhPJwFHnIAiyZebX2UEaNXh4EpklxkDUzVeGdciChcFKVao+vl1qvk1nfhQAvDSpVwdjyDosA8TNS/pClz6ns/4jJiDzlfljAN
MIME-Version: 1.0
X-Received: by 2002:a02:8802:: with SMTP id r2mr1962416jai.75.1601011101332;
 Thu, 24 Sep 2020 22:18:21 -0700 (PDT)
Date:   Thu, 24 Sep 2020 22:18:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f9f80905b01c7185@google.com>
Subject: KMSAN: uninit-value in f2fs_lookup
From:   syzbot <syzbot+0eac6f0bbd558fd866d7@syzkaller.appspotmail.com>
To:     chao@kernel.org, glider@google.com, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c5a13b33 kmsan: clang-format core
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=14f5b19b900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=20f149ad694ba4be
dashboard link: https://syzkaller.appspot.com/bug?extid=0eac6f0bbd558fd866d7
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0eac6f0bbd558fd866d7@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in f2fs_lookup+0xe05/0x1a80 fs/f2fs/namei.c:503
CPU: 0 PID: 20216 Comm: syz-executor.5 Not tainted 5.9.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x21c/0x280 lib/dump_stack.c:118
 kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:122
 __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:219
 f2fs_lookup+0xe05/0x1a80 fs/f2fs/namei.c:503
 lookup_open fs/namei.c:3082 [inline]
 open_last_lookups fs/namei.c:3177 [inline]
 path_openat+0x2729/0x6a90 fs/namei.c:3365
 do_filp_open+0x2b8/0x710 fs/namei.c:3395
 do_sys_openat2+0xa88/0x1140 fs/open.c:1168
 do_sys_open fs/open.c:1184 [inline]
 __do_compat_sys_openat fs/open.c:1242 [inline]
 __se_compat_sys_openat+0x2a4/0x310 fs/open.c:1240
 __ia32_compat_sys_openat+0x56/0x70 fs/open.c:1240
 do_syscall_32_irqs_on arch/x86/entry/common.c:80 [inline]
 __do_fast_syscall_32+0x129/0x180 arch/x86/entry/common.c:139
 do_fast_syscall_32+0x6a/0xc0 arch/x86/entry/common.c:162
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:205
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7f73549
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f554c0cc EFLAGS: 00000296 ORIG_RAX: 0000000000000127
RAX: ffffffffffffffda RBX: 00000000ffffff9c RCX: 0000000020000980
RDX: 000000000002f042 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Local variable ----page@f2fs_lookup created at:
 f2fs_lookup+0x8f/0x1a80 fs/f2fs/namei.c:477
 f2fs_lookup+0x8f/0x1a80 fs/f2fs/namei.c:477
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
