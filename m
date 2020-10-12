Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7085328B599
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 15:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbgJLNK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 09:10:27 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:41066 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730368AbgJLNKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:10:22 -0400
Received: by mail-il1-f199.google.com with SMTP id z6so4055080ilf.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 06:10:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ty+a1LZxl17gReBYzjTIEx2+QFoT3DIs5fUkSnxzBxs=;
        b=WxdW1AyWa79Z6zOCJ5lfCxPuE86qrFVzBqsOGc8690TzxCKrcyG/iHrPXIU7n1ZrWS
         Wzxsz3KBWBPyDsbl2K0xNNeVBHKUTeFyjHfvJTADb44b56ipTJc8tIPswml0eslYccr2
         qxa12Y5YD5Fh1kILeKS6jDN2VGtO+j7jrcboy8LLGth2nGRdvVQWnRP8x++47hu9N1l3
         FANRbkh0TAQH/f/CW1qBNR5BATGDVsKSLvMJFPJlLoZWEYRmisQ7GKO5g69mr8poJpc8
         himNaHcQfRozwL8Hv+8DbrzAQlx75eQ6GDprWahT+HIq1ysm83NcLgZhUDeFkVMJwiD+
         C9bA==
X-Gm-Message-State: AOAM533/5dr/SxgxP770/UvHN1rmJQbL/Zcq36hlMvuZQYHjotC17YEI
        Yef8b8LyiHt9Ug8BG9J86JD0xan5e7qcvuNHFbtdpDcErxqY
X-Google-Smtp-Source: ABdhPJyNZvFhmmuyQWlSXrAhghAZG2nABU8cIhFSLaGFhf+Ic89VxBQYh9e5I6CsSoB0ajJmtJhvAwvqrbmux4Td+kv8UMIq9eFN
MIME-Version: 1.0
X-Received: by 2002:a02:2ac1:: with SMTP id w184mr19540608jaw.44.1602508221256;
 Mon, 12 Oct 2020 06:10:21 -0700 (PDT)
Date:   Mon, 12 Oct 2020 06:10:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000471ab405b179056d@google.com>
Subject: UBSAN: array-index-out-of-bounds in init_sb
From:   syzbot <syzbot+a5e2482a693e6b1e444b@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, rpeterso@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    6f2f486d Merge tag 'spi-fix-v5.9-rc8' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16887cab900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c06bcf3cc963d91c
dashboard link: https://syzkaller.appspot.com/bug?extid=a5e2482a693e6b1e444b
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1081031b900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=133c359f900000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15f3f320500000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17f3f320500000
console output: https://syzkaller.appspot.com/x/log.txt?x=13f3f320500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a5e2482a693e6b1e444b@syzkaller.appspotmail.com

gfs2: fsid=loop0: Trying to join cluster "lock_nolock", "loop0"
gfs2: fsid=loop0: Now mounting FS...
================================================================================
UBSAN: array-index-out-of-bounds in fs/gfs2/ops_fstype.c:342:21
index 11 is out of range for type 'u64 [11]'
CPU: 0 PID: 6887 Comm: syz-executor693 Not tainted 5.9.0-rc8-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 ubsan_epilogue+0xb/0x5a lib/ubsan.c:148
 __ubsan_handle_out_of_bounds.cold+0x62/0x6c lib/ubsan.c:356
 gfs2_read_sb fs/gfs2/ops_fstype.c:342 [inline]
 init_sb+0xc37/0xd30 fs/gfs2/ops_fstype.c:479
 gfs2_fill_super+0x1796/0x254a fs/gfs2/ops_fstype.c:1096
 get_tree_bdev+0x421/0x740 fs/super.c:1342
 gfs2_get_tree+0x4a/0x270 fs/gfs2/ops_fstype.c:1201
 vfs_get_tree+0x89/0x2f0 fs/super.c:1547
 do_new_mount fs/namespace.c:2875 [inline]
 path_mount+0x1387/0x20a0 fs/namespace.c:3192
 do_mount fs/namespace.c:3205 [inline]
 __do_sys_mount fs/namespace.c:3413 [inline]
 __se_sys_mount fs/namespace.c:3390 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3390
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446dba
Code: b8 08 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 fd ad fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 da ad fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007ffcd944f138 EFLAGS: 00000293 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffcd944f190 RCX: 0000000000446dba
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffcd944f150
RBP: 00007ffcd944f150 R08: 00007ffcd944f190 R09: 00007ffc00000015
R10: 0000000002200000 R11: 0000000000000293 R12: 0000000000000001
R13: 0000000000000004 R14: 0000000000000003 R15: 0000000000000003
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
