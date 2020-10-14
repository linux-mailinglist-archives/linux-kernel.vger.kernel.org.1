Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7AE228E050
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 14:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgJNMLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 08:11:19 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:53122 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgJNMLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 08:11:18 -0400
Received: by mail-io1-f72.google.com with SMTP id e10so2224252ioq.19
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 05:11:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=BbVySK820kv4hRTVQvHs4ijb0VJ8p3tZyO+wMtqUIM0=;
        b=cqed3czpb0Ot6CV0ANov200tyyYtSoZ1favi3eZcC7yc12FKQhXbkYSZUjEEvzxEei
         oHDlneTbOnie2bIw973B4dnYunILAT/1vT7unpjUlmt5UlFP6Vqod3a1myDlerSP9YKK
         FW2i95eiHFZ1LadTC9cvf9ZHhN5uaXFep8iMB4J1ZIFxfimRjF+UcFpavYAepsndcD4J
         eBVd4AcQA6Biy6IeNxP/TsClAGRZYfyQhgduD+UWacF3om7ALQnIca9XETlohVBy+JxK
         eJy/CF1/nh8OLoDpuG2Mv4RMIe7qPRbTIQyc7tiNnSbsdlmDCIvXYe8lpfKxBWIYp6Za
         8KJg==
X-Gm-Message-State: AOAM533Ko0v3IrZibR8ZC5tQy5pWiLGZLxP4vaLS7k46MONe5YkqmaXf
        +ItE8swEVBOK7E6uIYFoV9XHIa1mPnKuJMabPWRUJjgasypD
X-Google-Smtp-Source: ABdhPJw15WDNyW3HVyWhCIAlcuyf+s8F8ggLdT2ONdHT0Qv/gFxtVmfgS8iRJfDry5Kot2PN9i5gZF5hp2fLJr1VXGYhvtAc5nFG
MIME-Version: 1.0
X-Received: by 2002:a92:8e51:: with SMTP id k17mr3471376ilh.270.1602677476505;
 Wed, 14 Oct 2020 05:11:16 -0700 (PDT)
Date:   Wed, 14 Oct 2020 05:11:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ad3f7f05b1a06d8a@google.com>
Subject: KASAN: use-after-free Read in ntfs_are_names_equal
From:   syzbot <syzbot+ecbcf37464c627253e44@syzkaller.appspotmail.com>
To:     anton@tuxera.com, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    bbf5c979 Linux 5.9
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1359031b900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f3005fbc9c851d04
dashboard link: https://syzkaller.appspot.com/bug?extid=ecbcf37464c627253e44
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16698ffb900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=141b8558500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ecbcf37464c627253e44@syzkaller.appspotmail.com

ntfs: (device loop0): ntfs_read_locked_inode(): Failed with error code -5.  Marking corrupt inode 0xa as bad.  Run chkdsk.
ntfs: (device loop0): load_and_init_upcase(): Failed to load $UpCase from the volume. Using default.
ntfs: volume version 3.1.
ntfs: (device loop0): map_mft_record_page(): Mft record 0x2 is corrupt.  Run chkdsk.
==================================================================
BUG: KASAN: use-after-free in ntfs_ucsncmp fs/ntfs/unistr.c:142 [inline]
BUG: KASAN: use-after-free in ntfs_are_names_equal+0x2f8/0x340 fs/ntfs/unistr.c:61
Read of size 2 at addr ffff888086758ee8 by task syz-executor601/6839

CPU: 0 PID: 6839 Comm: syz-executor601 Not tainted 5.9.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1d6/0x29e lib/dump_stack.c:118
 print_address_description+0x66/0x620 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report+0x132/0x1d0 mm/kasan/report.c:530
 ntfs_ucsncmp fs/ntfs/unistr.c:142 [inline]
 ntfs_are_names_equal+0x2f8/0x340 fs/ntfs/unistr.c:61
 ntfs_attr_find+0x36d/0xac0 fs/ntfs/attrib.c:614
 ntfs_attr_lookup+0x1ec/0x23b0 fs/ntfs/attrib.c:1189
 ntfs_read_locked_attr_inode fs/ntfs/inode.c:1233 [inline]
 ntfs_attr_iget+0x48c/0x21a0 fs/ntfs/inode.c:238
 ntfs_read_locked_inode+0x36fd/0x4e30 fs/ntfs/inode.c:954
 ntfs_iget+0xc2/0x130 fs/ntfs/inode.c:177
 load_system_files fs/ntfs/super.c:1974 [inline]
 ntfs_fill_super+0x5c38/0x8bd0 fs/ntfs/super.c:2894
 mount_bdev+0x24f/0x360 fs/super.c:1417
 legacy_get_tree+0xea/0x180 fs/fs_context.c:592
 vfs_get_tree+0x88/0x270 fs/super.c:1547
 do_new_mount fs/namespace.c:2875 [inline]
 path_mount+0x179d/0x29e0 fs/namespace.c:3192
 do_mount fs/namespace.c:3205 [inline]
 __do_sys_mount fs/namespace.c:3413 [inline]
 __se_sys_mount+0x126/0x180 fs/namespace.c:3390
 do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45726a
Code: b8 08 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 8d a3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 6a a3 fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007ffcaca0cb18 EFLAGS: 00000287 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffcaca0cb70 RCX: 000000000045726a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffcaca0cb30
RBP: 0000000000000004 R08: 00007ffcaca0cb70 R09: 0000000000316777
R10: 0000000000000000 R11: 0000000000000287 R12: 0000000000000003
R13: 00007ffcaca0cb30 R14: 0000000000000000 R15: 0000000020001218

The buggy address belongs to the page:
page:000000007012e419 refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x86758
flags: 0xfffe0000000000()
raw: 00fffe0000000000 ffffea000219d688 ffffea000219d3c8 0000000000000000
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888086758d80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888086758e00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff888086758e80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                                          ^
 ffff888086758f00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888086758f80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
