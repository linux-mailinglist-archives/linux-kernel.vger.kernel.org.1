Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2BF9271E30
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 10:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgIUIlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 04:41:22 -0400
Received: from mail-io1-f80.google.com ([209.85.166.80]:41415 "EHLO
        mail-io1-f80.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgIUIlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 04:41:22 -0400
Received: by mail-io1-f80.google.com with SMTP id j4so9340745iob.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 01:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=c4HhHXZZGrSKTcTM17ro4CKqKcqkq/waKOGnozhbv5g=;
        b=c3wZKx9Vfs0Zfr+Zk9CoWRAA8C6bcm/iO2YXUB43t4WgtO4mDfIKMqwKwcH0Zzsqu0
         0RiepFOX/EpjrfpzphtdyJiQCh+RnRKU6vbZfKTs+n/O7QCGCvQ0+qF1V2vvldOjczRS
         1coe2nlhkfR1ctSh76vw7323hqwBc44iAco9uNi3Wsx2ICU72wFgXhfa0J2Gh0analv6
         i+zfBYK1haVtWcgnS2eeEbg54v72FhQv9j8vaX4IK8lr0rW+bav72FgASNPjBM83sX7f
         dKu950l9q03aNewmQIXjvivKYSNeTKOWnu9NJuQBxqN3pdLdfGomvhWKECWUtyiZrcTt
         8YTA==
X-Gm-Message-State: AOAM533cmShRJZi0MFdfVBuL54PS/UEH6deuN8tppehQ6yRBUVIrAMZE
        29z1PVN8srkuyTyDlO62L18U7e/pORyNt/6GUAT3zb6iubEU
X-Google-Smtp-Source: ABdhPJyYSHQZ1eVJjA+AUJXiv3Rk4hW+a+c63bZbA63TdG5HylRlDHEkyyG6MltcPYi31A6EjOXkym3Hbznulk0QlaL0Y2NnCSqU
MIME-Version: 1.0
X-Received: by 2002:a92:9ad6:: with SMTP id c83mr11379566ill.155.1600677680759;
 Mon, 21 Sep 2020 01:41:20 -0700 (PDT)
Date:   Mon, 21 Sep 2020 01:41:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008fcdcc05afced03d@google.com>
Subject: general protection fault in f2fs_usable_blks_in_seg
From:   syzbot <syzbot+978a34b783141d673eda@syzkaller.appspotmail.com>
To:     aravind.ramesh@wdc.com, chao@kernel.org, damien.lemoal@wdc.com,
        jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, niklas.cassel@wdc.com,
        syzkaller-bugs@googlegroups.com, yuchao0@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b652d2a5 Add linux-next specific files for 20200918
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=103ab84b900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3cf0782933432b43
dashboard link: https://syzkaller.appspot.com/bug?extid=978a34b783141d673eda
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10ffaec5900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16aa5d1d900000

The issue was bisected to:

commit de881df97768d07b342cbd1f8359b832afccace9
Author: Aravind Ramesh <aravind.ramesh@wdc.com>
Date:   Thu Jul 16 12:56:56 2020 +0000

    f2fs: support zone capacity less than zone size

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10f2f707900000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12f2f707900000
console output: https://syzkaller.appspot.com/x/log.txt?x=14f2f707900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+978a34b783141d673eda@syzkaller.appspotmail.com
Fixes: de881df97768 ("f2fs: support zone capacity less than zone size")

F2FS-fs (loop0): Magic Mismatch, valid(0xf2f52010) - read(0x0)
F2FS-fs (loop0): Can't find valid F2FS filesystem in 2th superblock
F2FS-fs (loop0): invalid crc_offset: 0
general protection fault, probably for non-canonical address 0xdffffc0000000009: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000048-0x000000000000004f]
CPU: 1 PID: 6861 Comm: syz-executor912 Not tainted 5.9.0-rc5-next-20200918-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:get_zone_idx fs/f2fs/segment.c:4892 [inline]
RIP: 0010:f2fs_usable_zone_blks_in_seg fs/f2fs/segment.c:4943 [inline]
RIP: 0010:f2fs_usable_blks_in_seg+0x39b/0xa00 fs/f2fs/segment.c:4999
Code: 05 00 00 49 63 d6 4c 8b 83 40 14 00 00 48 6b d2 68 49 8d 04 10 48 ba 00 00 00 00 00 fc ff df 48 8d 78 4c 48 89 fe 48 c1 ee 03 <0f> b6 34 16 48 89 fa 83 e2 07 83 c2 03 40 38 f2 7c 09 40 84 f6 0f
RSP: 0018:ffffc90000ef78b0 EFLAGS: 00010207
RAX: 0000000000000000 RBX: ffff88809632c000 RCX: 0000000000000e00
RDX: dffffc0000000000 RSI: 0000000000000009 RDI: 000000000000004c
RBP: 0000000000001000 R08: 0000000000000000 R09: ffffc90000ef7a81
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000200
R13: ffff88809632c010 R14: 0000000000000000 R15: ffff88809632d440
FS:  0000000002206880(0000) GS:ffff8880ae500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffea055b000 CR3: 000000009486b000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 check_block_count+0x69/0x4e0 fs/f2fs/segment.h:704
 build_sit_entries fs/f2fs/segment.c:4403 [inline]
 f2fs_build_segment_manager+0x51da/0xa370 fs/f2fs/segment.c:5100
 f2fs_fill_super+0x3880/0x6ff0 fs/f2fs/super.c:3684
 mount_bdev+0x32e/0x3f0 fs/super.c:1417
 legacy_get_tree+0x105/0x220 fs/fs_context.c:592
 vfs_get_tree+0x89/0x2f0 fs/super.c:1547
 do_new_mount fs/namespace.c:2896 [inline]
 path_mount+0x12ae/0x1e70 fs/namespace.c:3216
 do_mount fs/namespace.c:3229 [inline]
 __do_sys_mount fs/namespace.c:3437 [inline]
 __se_sys_mount fs/namespace.c:3414 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3414
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x44793a
Code: b8 08 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 fd ad fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 da ad fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007ffea055a198 EFLAGS: 00000297 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffea055a1f0 RCX: 000000000044793a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffea055a1b0
RBP: 00007ffea055a1b0 R08: 00007ffea055a1f0 R09: 00007ffe00000015
R10: 0000000000000000 R11: 0000000000000297 R12: 000000000000004a
R13: 0000000000000004 R14: 0000000000000003 R15: 0000000000000003
Modules linked in:
---[ end trace 49ea7ada353f1c96 ]---
RIP: 0010:get_zone_idx fs/f2fs/segment.c:4892 [inline]
RIP: 0010:f2fs_usable_zone_blks_in_seg fs/f2fs/segment.c:4943 [inline]
RIP: 0010:f2fs_usable_blks_in_seg+0x39b/0xa00 fs/f2fs/segment.c:4999
Code: 05 00 00 49 63 d6 4c 8b 83 40 14 00 00 48 6b d2 68 49 8d 04 10 48 ba 00 00 00 00 00 fc ff df 48 8d 78 4c 48 89 fe 48 c1 ee 03 <0f> b6 34 16 48 89 fa 83 e2 07 83 c2 03 40 38 f2 7c 09 40 84 f6 0f
RSP: 0018:ffffc90000ef78b0 EFLAGS: 00010207
RAX: 0000000000000000 RBX: ffff88809632c000 RCX: 0000000000000e00
RDX: dffffc0000000000 RSI: 0000000000000009 RDI: 000000000000004c
RBP: 0000000000001000 R08: 0000000000000000 R09: ffffc90000ef7a81
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000200
R13: ffff88809632c010 R14: 0000000000000000 R15: ffff88809632d440
FS:  0000000002206880(0000) GS:ffff8880ae500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffea055b000 CR3: 000000009486b000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
