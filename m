Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2402BAFCF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbgKTQPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:15:18 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:41420 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbgKTQPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:15:17 -0500
Received: by mail-io1-f71.google.com with SMTP id y2so7755733ioy.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 08:15:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=fCjbTYJhb9UCDrinwlyFQtGfkQaAPgsqQIPO6Ct1q98=;
        b=sLJg4SJRV2zTb42GULqI8zlaDRDFhdonuldnyd9Rg12DjQHFkcmPhCzzHkBx1vclLE
         I8a1lt3tdKYnQg9tg+LYrOO8LHplSUgM8siLIdp9BcpAPkboWV5ZRkIzX+evXLhJzSpB
         NnHbFYscidQzNJmi3jkuznodJTGyf8NqcPTHdiyN9WZPShXD2AZeG2mhjXRRinVlxPXo
         b+DgCjvRPBf6Po2RJ9wdra2nyk/OORkFQUnXN1HFQODaKhgazAEFYi+MpuUudx1eoqoY
         b2KvyxZZ6wo29wJcIrjn50GxxV2WW6pdqRSwtliXQ8HJATDMg64rxurtUWAIn4je6wEl
         S43g==
X-Gm-Message-State: AOAM531D6VEVz0agHnnkWLgW2UIXjYUHEhSSvR6hQjxIwjCZ5Bo0Bh5N
        r44u8nnXL3Xd6E8/0RykxJSDwbRU38vZhJwzyGu+Ina2ruh4
X-Google-Smtp-Source: ABdhPJzgkCfymH4ZRnf3Ka/RpLzSJfM7iDEs6E7SGHEzOnDVHfLYOZZGb3M1zWaFBQd936Xq+xqNZmq5wYAd+0VIZFwJFDOH3flt
MIME-Version: 1.0
X-Received: by 2002:a05:6638:d46:: with SMTP id d6mr18913707jak.124.1605888916800;
 Fri, 20 Nov 2020 08:15:16 -0800 (PST)
Date:   Fri, 20 Nov 2020 08:15:16 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006f4d3c05b48c263d@google.com>
Subject: memory leak in kobject_set_name_vargs (4)
From:   syzbot <syzbot+859119106243eb95085b@syzkaller.appspotmail.com>
To:     konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org,
        linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c2e7554e Merge tag 'gfs2-v5.10-rc4-fixes' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=120277be500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dc8ee843c1fc6693
dashboard link: https://syzkaller.appspot.com/bug?extid=859119106243eb95085b
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172afce2500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12c8a9d6500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+859119106243eb95085b@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff8881110c8f40 (size 32):
  comm "syz-executor894", pid 8479, jiffies 4294942790 (age 8.030s)
  hex dump (first 32 bytes):
    6c 6f 6f 70 30 00 00 00 00 00 00 00 00 00 00 00  loop0...........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000002a879a43>] kstrdup+0x36/0x70 mm/util.c:60
    [<0000000068356e6a>] kstrdup_const+0x53/0x80 mm/util.c:83
    [<00000000beef27f8>] kvasprintf_const+0xc2/0x110 lib/kasprintf.c:48
    [<00000000fa036169>] kobject_set_name_vargs+0x3b/0xe0 lib/kobject.c:289
    [<00000000c1ae635f>] kobject_add_varg lib/kobject.c:384 [inline]
    [<00000000c1ae635f>] kobject_init_and_add+0x6d/0xc0 lib/kobject.c:473
    [<0000000033a7e260>] nilfs_sysfs_create_device_group+0x98/0x3a0 fs/nilfs2/sysfs.c:999
    [<00000000ed96fbb9>] init_nilfs+0x523/0x680 fs/nilfs2/the_nilfs.c:637
    [<0000000047c27b86>] nilfs_fill_super fs/nilfs2/super.c:1046 [inline]
    [<0000000047c27b86>] nilfs_mount+0x51b/0x890 fs/nilfs2/super.c:1316
    [<00000000bc71acf1>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:592
    [<000000004ee940ed>] vfs_get_tree+0x28/0x100 fs/super.c:1549
    [<00000000badf1d9b>] do_new_mount fs/namespace.c:2875 [inline]
    [<00000000badf1d9b>] path_mount+0xc5e/0x1170 fs/namespace.c:3205
    [<00000000214ca321>] do_mount fs/namespace.c:3218 [inline]
    [<00000000214ca321>] __do_sys_mount fs/namespace.c:3426 [inline]
    [<00000000214ca321>] __se_sys_mount fs/namespace.c:3403 [inline]
    [<00000000214ca321>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3403
    [<00000000106f08a7>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000534b6078>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
