Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3306271F89
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 12:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgIUKCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 06:02:23 -0400
Received: from mail-il1-f205.google.com ([209.85.166.205]:51097 "EHLO
        mail-il1-f205.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgIUKCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:02:22 -0400
Received: by mail-il1-f205.google.com with SMTP id u20so10554258ilk.17
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 03:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=UrOT62Oj4GRjmaKFdFgDIhd86YLaoW5rX/6hwUD3AZw=;
        b=XvEFFBAyIKFHfapsu4WHvguVDjbkFPR8zxv+0JcFxvizK4PBF2k52WQ7ZelO0nHA4u
         VmxmAJUoxiwOhafAQsaZ0Tv1O/Xk1CDbvMIIU7j1a+MvcGWpESaLpd8BZemQVPfPO5ch
         37Pllps95dVZazl0EZIIcOYjyNaAGjlszqEHgCdvHt3tNiYk5pssrzBvx7Z12RVcOc/r
         xNvU/qPzVXEjiWlNIKz1hain4NbGSCto6IlQ9m+dmUNY4Yhkz0IPYjBAorrb231fto9N
         wIrRyzd5TstRehC/DPsgi+GzYN7mxoameUaQ7pkrTMGN9evtgE5rch4Ug2glAcE2GpEW
         e3Gw==
X-Gm-Message-State: AOAM530ndfYUM/ih9KP2sUbiSnOyvxs8uOkIOK3p0VdQDcStaT1l4Tjb
        EBRq2Ie8hzltG7JBuW2YzmYXbDFXbeOsF3uvwSmxCn/+Xd/j
X-Google-Smtp-Source: ABdhPJx/RqJSeGhQOwYiUCC/AXEdupsu+C55iPqhfqOtzbCMf8gIs66F/OyhAZUMSKJCLb26WDRvrBJGC3VrmvmzNTeM1Ic2MDv+
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2f07:: with SMTP id q7mr36573930iow.191.1600682541716;
 Mon, 21 Sep 2020 03:02:21 -0700 (PDT)
Date:   Mon, 21 Sep 2020 03:02:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004c1f4d05afcff2f4@google.com>
Subject: memory leak in udf_process_sequence
From:   syzbot <syzbot+128f4dd6e796c98b3760@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    325d0eab Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13ec44d3900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1f3c5052e8097e9
dashboard link: https://syzkaller.appspot.com/bug?extid=128f4dd6e796c98b3760
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101a0e9b900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17ae18d3900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+128f4dd6e796c98b3760@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88811a1d0a00 (size 512):
  comm "syz-executor299", pid 6519, jiffies 4294943224 (age 15.090s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000009ea2686e>] kmalloc include/linux/slab.h:554 [inline]
    [<000000009ea2686e>] kmalloc_array include/linux/slab.h:593 [inline]
    [<000000009ea2686e>] kcalloc include/linux/slab.h:605 [inline]
    [<000000009ea2686e>] udf_process_sequence+0x7e/0x1080 fs/udf/super.c:1676
    [<00000000d9f60715>] udf_load_sequence fs/udf/super.c:1795 [inline]
    [<00000000d9f60715>] udf_check_anchor_block+0xdc/0x1a0 fs/udf/super.c:1835
    [<0000000067395456>] udf_scan_anchors+0x9e/0x240 fs/udf/super.c:1868
    [<00000000966a1b37>] udf_find_anchor fs/udf/super.c:1925 [inline]
    [<00000000966a1b37>] udf_load_vrs+0x1be/0x3b0 fs/udf/super.c:1990
    [<0000000004bba192>] udf_fill_super+0x286/0x7a5 fs/udf/super.c:2183
    [<00000000d48efb9b>] mount_bdev+0x1d3/0x210 fs/super.c:1417
    [<00000000280e173c>] legacy_get_tree+0x26/0x70 fs/fs_context.c:592
    [<0000000059fde270>] vfs_get_tree+0x28/0xe0 fs/super.c:1547
    [<00000000904c79e7>] do_new_mount fs/namespace.c:2875 [inline]
    [<00000000904c79e7>] path_mount+0x90e/0xda0 fs/namespace.c:3192
    [<000000008e0f8bcd>] do_mount fs/namespace.c:3205 [inline]
    [<000000008e0f8bcd>] __do_sys_mount fs/namespace.c:3413 [inline]
    [<000000008e0f8bcd>] __se_sys_mount fs/namespace.c:3390 [inline]
    [<000000008e0f8bcd>] __x64_sys_mount+0x140/0x190 fs/namespace.c:3390
    [<00000000e981acac>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<000000006322386a>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
