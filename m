Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663FE268881
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 11:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgINJej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 05:34:39 -0400
Received: from mail-il1-f208.google.com ([209.85.166.208]:50535 "EHLO
        mail-il1-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgINJeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 05:34:21 -0400
Received: by mail-il1-f208.google.com with SMTP id u20so3014692ilk.17
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 02:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=mpLvn3u66tHFv9Em3uKyA7uympIh7+6tlTS3lnYh3rs=;
        b=bdag0g9bkAzTGfnG2dxFIoBBAagmyPVFV+exYnF2wQnlCA3fYRMbNcdLe3x7ZIPGUm
         Nhrx3maIp/6Ux6NKzBBZTCMnG36z87QdifpYJdBZVKgc9h43u80gB0S5tUJcdWKb/QAN
         NxeiStJdL5y8cnK7z+e4Tpl1m3JCjTx0JqYgnpdKBYdqiDcRJxoS9osNMT1E/QLj1qm7
         mask4JK9C9degqrVz0gOOfiZ4B7BFBS2gkl2nF92yN8Bo2NFoQGSjhGIwEa+xZXa5c+h
         bSw7GabgElWrVR/j8ZbjNYcGBkeEAsiMP3LfLWIZzDq+Lninb2zRYBdx9XEwbvTO1Nwv
         bo2A==
X-Gm-Message-State: AOAM532lNB27CBD3jN7ONi72BwmxvZRJq71rfpGljG3rECraQt2qo2/8
        q6bbZUXDEG0WrRrst4HY8YD19orwpmGTtWsYgch19eSujAYQ
X-Google-Smtp-Source: ABdhPJzEMiBYiQ7QRCK6v++Le5dE5IBqLuugWk6dN7RvJEqI+dAVSPXalZTWVLzi15OUqkFHKoe9rSW1ncq7zS32yizJc+TWKxQn
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:d2:: with SMTP id r18mr10890752ilq.303.1600076060199;
 Mon, 14 Sep 2020 02:34:20 -0700 (PDT)
Date:   Mon, 14 Sep 2020 02:34:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002e90d405af42bd38@google.com>
Subject: KASAN: slab-out-of-bounds Read in fbcon_scrolldelta
From:   syzbot <syzbot+9381e25e04a6ea4f2a20@syzkaller.appspotmail.com>
To:     b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch,
        dri-devel@lists.freedesktop.org, george.kennedy@oracle.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        natechancellor@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e4c26faa Merge tag 'usb-5.9-rc5' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14d155f9900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c61610091f4ca8c4
dashboard link: https://syzkaller.appspot.com/bug?extid=9381e25e04a6ea4f2a20
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9381e25e04a6ea4f2a20@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in fbcon_redraw_softback drivers/video/fbdev/core/fbcon.c:1676 [inline]
BUG: KASAN: slab-out-of-bounds in fbcon_scrolldelta+0x10da/0x1230 drivers/video/fbdev/core/fbcon.c:2909
Read of size 2 at addr ffff8881e9ae68c0 by task syz-executor.1/20692

CPU: 0 PID: 20692 Comm: syz-executor.1 Not tainted 5.9.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xae/0x497 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 fbcon_redraw_softback drivers/video/fbdev/core/fbcon.c:1676 [inline]
 fbcon_scrolldelta+0x10da/0x1230 drivers/video/fbdev/core/fbcon.c:2909
 fbcon_set_origin+0x3c/0x50 drivers/video/fbdev/core/fbcon.c:2959
 set_origin+0xe7/0x3e0 drivers/tty/vt/vt.c:930
 vc_do_resize+0xb0f/0x1150 drivers/tty/vt/vt.c:1305
 fbcon_modechanged+0x36c/0x710 drivers/video/fbdev/core/fbcon.c:3011
 fbcon_update_vcs+0x3a/0x50 drivers/video/fbdev/core/fbcon.c:3069
 do_fb_ioctl+0x62e/0x690 drivers/video/fbdev/core/fbmem.c:1106
 fb_ioctl+0xdd/0x130 drivers/video/fbdev/core/fbmem.c:1181
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45d5f9
Code: 5d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 2b b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f51ee9c6c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000000e0c0 RCX: 000000000045d5f9
RDX: 0000000020001180 RSI: 0000000000004601 RDI: 0000000000000003
RBP: 000000000118cf80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000118cf4c
R13: 00007fffb40f07cf R14: 00007f51ee9c79c0 R15: 000000000118cf4c

Allocated by task 3837:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:461
 __do_kmalloc mm/slab.c:3655 [inline]
 __kmalloc+0x1b0/0x310 mm/slab.c:3664
 kmalloc include/linux/slab.h:559 [inline]
 kzalloc include/linux/slab.h:666 [inline]
 vc_do_resize+0x2f6/0x1150 drivers/tty/vt/vt.c:1228
 vt_resizex drivers/tty/vt/vt_ioctl.c:818 [inline]
 vt_ioctl+0xef0/0x2cc0 drivers/tty/vt/vt_ioctl.c:1036
 tty_ioctl+0x1019/0x15f0 drivers/tty/tty_io.c:2656
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff8881e9ae6000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 2240 bytes inside of
 4096-byte region [ffff8881e9ae6000, ffff8881e9ae7000)
The buggy address belongs to the page:
page:00000000761e5aa4 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1e9ae6
head:00000000761e5aa4 order:1 compound_mapcount:0
flags: 0x57ffe0000010200(slab|head)
raw: 057ffe0000010200 ffffea0007bbe508 ffffea0007bc1288 ffff8880aa040900
raw: 0000000000000000 ffff8881e9ae6000 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8881e9ae6780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8881e9ae6800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff8881e9ae6880: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
                                           ^
 ffff8881e9ae6900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8881e9ae6980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
