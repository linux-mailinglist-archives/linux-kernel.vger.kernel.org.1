Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D29B26887E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 11:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgINJed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 05:34:33 -0400
Received: from mail-il1-f206.google.com ([209.85.166.206]:52820 "EHLO
        mail-il1-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgINJeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 05:34:22 -0400
Received: by mail-il1-f206.google.com with SMTP id m1so12206392iln.19
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 02:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=gHiF/tAb6hDyOHdyhfRLLKJ7FRYtrKMjyUsdefDryVk=;
        b=jR9zLD3+Hdb7S+qFXUOLEkbdPoqXbDuzOQ97sFVS8CbMZxenNLMMosxPnLU0h4U2GC
         nQ1NkwB6GNDCGpBPIcIErxefkV3bDKQwJGDQuPGOCCINQF4UZ2EZqUTefbL8MkuDlU5s
         J7Zy9XUGC0o7A1t3qBGEC7ym2dCY2iMy7CW3sbzF5628MOq0Mrb8uyOovtDlRiaRy92B
         cYjifjbSmNV4WTQoDaTzFA56MQdGTm7Av6Rq3Ae4ZODNmqyjFYXg9PBzKste/7NOSWXp
         VFh50iDW4czcoms5CVN8+XINfUiTt966eWb8OumspUC3wbbYrDDqwxOtk3Y+aiwc9lKc
         G3og==
X-Gm-Message-State: AOAM532IMI1FWEfP7ScZUDSXyvGq5q5TikhNlcJBGviFo91PBfUDN3oj
        2fbk2klgPNxCqKLmdmtDq2HWxOYe0pZfX8Q1ar06wM6vyA42
X-Google-Smtp-Source: ABdhPJyOBIgLwXAHI8ybLGF73CaJomR5rzqOej8iL2TNynGD4n+9/55IAMn1qXjkh5uI4dL4FED4AyzNFsdXuxKyZgFv3ru3CpUA
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:df1:: with SMTP id m17mr10118481ilj.276.1600076060403;
 Mon, 14 Sep 2020 02:34:20 -0700 (PDT)
Date:   Mon, 14 Sep 2020 02:34:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000031ae7305af42bdd4@google.com>
Subject: KASAN: slab-out-of-bounds Read in do_update_region
From:   syzbot <syzbot+f91d979f99fe699f08e0@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e4c26faa Merge tag 'usb-5.9-rc5' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=132e6253900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c61610091f4ca8c4
dashboard link: https://syzkaller.appspot.com/bug?extid=f91d979f99fe699f08e0
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f91d979f99fe699f08e0@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in do_update_region+0x5aa/0x630 drivers/tty/vt/vt.c:663
Read of size 2 at addr ffff888218bbd2c0 by task syz-executor.3/21923

CPU: 1 PID: 21923 Comm: syz-executor.3 Not tainted 5.9.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xae/0x497 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 do_update_region+0x5aa/0x630 drivers/tty/vt/vt.c:663
 update_region+0xb5/0x140 drivers/tty/vt/vt.c:693
 vcs_write+0x403/0xc30 drivers/tty/vt/vc_screen.c:623
 do_loop_readv_writev fs/read_write.c:737 [inline]
 do_loop_readv_writev fs/read_write.c:721 [inline]
 do_iter_write+0x489/0x670 fs/read_write.c:1020
 vfs_writev+0x1aa/0x2e0 fs/read_write.c:1091
 do_writev+0x139/0x300 fs/read_write.c:1134
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45d5f9
Code: 5d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 2b b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f831f788c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 0000000000039c40 RCX: 000000000045d5f9
RDX: 0000000000000002 RSI: 0000000020000380 RDI: 0000000000000003
RBP: 000000000118cf80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000118cf4c
R13: 00007ffc44f8988f R14: 00007f831f7899c0 R15: 000000000118cf4c

Allocated by task 1:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:461
 __do_kmalloc mm/slab.c:3655 [inline]
 __kmalloc+0x1b0/0x310 mm/slab.c:3664
 kmalloc include/linux/slab.h:559 [inline]
 kzalloc include/linux/slab.h:666 [inline]
 vc_do_resize+0x2f6/0x1150 drivers/tty/vt/vt.c:1228
 fbcon_init+0x1319/0x1b00 drivers/video/fbdev/core/fbcon.c:1218
 visual_init+0x30e/0x5d0 drivers/tty/vt/vt.c:1074
 do_bind_con_driver.isra.0+0x549/0x8e0 drivers/tty/vt/vt.c:3658
 do_take_over_console+0x423/0x570 drivers/tty/vt/vt.c:4238
 do_fbcon_takeover+0x10b/0x210 drivers/video/fbdev/core/fbcon.c:588
 fbcon_fb_registered+0x26b/0x340 drivers/video/fbdev/core/fbcon.c:3283
 do_register_framebuffer drivers/video/fbdev/core/fbmem.c:1660 [inline]
 register_framebuffer+0x587/0x980 drivers/video/fbdev/core/fbmem.c:1828
 vga16fb_probe+0x6b4/0x7b5 drivers/video/fbdev/vga16fb.c:1373
 platform_drv_probe+0x87/0x140 drivers/base/platform.c:747
 really_probe+0x282/0x9f0 drivers/base/dd.c:553
 driver_probe_device+0xfe/0x1d0 drivers/base/dd.c:738
 __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:844
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:431
 __device_attach+0x228/0x470 drivers/base/dd.c:912
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:491
 device_add+0xb17/0x1c40 drivers/base/core.c:2926
 platform_device_add+0x34f/0x6d0 drivers/base/platform.c:597
 vga16fb_init+0x152/0x1c8 drivers/video/fbdev/vga16fb.c:1431
 do_one_initcall+0x10a/0x7a4 init/main.c:1204
 do_initcall_level init/main.c:1277 [inline]
 do_initcalls init/main.c:1293 [inline]
 do_basic_setup init/main.c:1313 [inline]
 kernel_init_freeable+0x5e9/0x66d init/main.c:1512
 kernel_init+0xd/0x1c0 init/main.c:1402
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

The buggy address belongs to the object at ffff888218bbc000
 which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 4800 bytes inside of
 8192-byte region [ffff888218bbc000, ffff888218bbe000)
The buggy address belongs to the page:
page:00000000b53090a6 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x218bbc
head:00000000b53090a6 order:2 compound_mapcount:0 compound_pincount:0
flags: 0x57ffe0000010200(slab|head)
raw: 057ffe0000010200 ffffea0008654508 ffffea0008603708 ffff8880aa040a00
raw: 0000000000000000 ffff888218bbc000 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888218bbd180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888218bbd200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888218bbd280: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
                                           ^
 ffff888218bbd300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888218bbd380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
