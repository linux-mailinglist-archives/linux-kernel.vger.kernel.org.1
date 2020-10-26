Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F03298560
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 02:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1421200AbgJZBhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 21:37:42 -0400
Received: from mail-ej1-f44.google.com ([209.85.218.44]:39844 "EHLO
        mail-ej1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1419334AbgJZBhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 21:37:42 -0400
Received: by mail-ej1-f44.google.com with SMTP id qh17so11113588ejb.6;
        Sun, 25 Oct 2020 18:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Vt0uSw1mB/ZaasUfNjH+I5OWDz73d0Ci+yC5WIZEzSY=;
        b=uwO2QrjVeIePWTHQlVOkBBS0TR0nrGUdOQPltqtGQdgnsbvBwHyevFG1t7usK8Nb/y
         38vyUlHw9Exas5O2d9bwPAKArv1LeaWwECfaRYw2xaSi3nV59G+OXVJvj7yrlJe3lQeC
         Xbfu58IJyhU5/FQVN2a6nBEY1+w+Y/2ycWt7UNWZE8cVEC9QZSdjNIaXM51ClMAwQf8E
         pQjs61x72GlxHiUZf7byOtBlSN4kP4IXwe/+VVjV/rm7YP9ZlhtR4VYr/WyYxgoUw3Dy
         VsGQTt/uMv0MmlloV8u7x7NorvP1511ZBJJCL5zmL//+yd/SRtAre38SOpQRTnmLpLqk
         Lbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Vt0uSw1mB/ZaasUfNjH+I5OWDz73d0Ci+yC5WIZEzSY=;
        b=tfNRxoXdIufsgN7mskimiuGPqRf4WDwqt96aH/l5+OcHCpP7dyATZ15URwmwfKAV1o
         6vYe/6+wBTAgH6xGqTMIK7tLpMKjjrvky0tgQVfx6cKIH62z0o7Mw+Gm3XDiJ3LhsjzC
         lshQzcMAzCvo9JRFtX0P2rGiqIA8f82j8igAijKmq8FCP4Vi/BpWLyrmyxwqV1DYCl9+
         Sj0cLx2/JIfXPr0YekloNf9Ka20oXpFZhnPYpbAMiC7z76LQ8jRdVBr/0v9pnOdKWl86
         V11XufjnlriZCROdmvuH7kwGAim731gKTB5QtRyeCd8O74OeeY6NGRdPwDmCsXGUWXwS
         b2fw==
X-Gm-Message-State: AOAM531pKdcYGuzQBvpqPKVByDHYJNET1DqzOMHALwaZGdO/lPri4Bnr
        B/UJM01s86tIO7zcA1Q4ZS+vVAxh5ynozUgPuDuSbNosoYc=
X-Google-Smtp-Source: ABdhPJxYcp/nPeY18elmoannpvGd7nyZOL9ycL9Uo9uQJsKBi+p3UQBlNVwWrViGzHzLHw6mUtYzy/BMlK/dBQTyknQ=
X-Received: by 2002:a17:906:715a:: with SMTP id z26mr13499333ejj.300.1603676257771;
 Sun, 25 Oct 2020 18:37:37 -0700 (PDT)
MIME-Version: 1.0
From:   Kyungtae Kim <kt0755@gmail.com>
Date:   Sun, 25 Oct 2020 21:37:26 -0400
Message-ID: <CAEAjamu0od7enBZJk08drO6puq6KmkMpLN1qwAQyFqyhOuXGMA@mail.gmail.com>
Subject: KASAN: use-after-free Write in tty_init_dev
To:     Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc:     USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We report a bug (in linux-5.8.13) found by FuzzUSB (a modified version
of syzkaller).

The bug happens when the freed object tty->port is accessed in
tty_init_dev (line 1358).
It seems tty->port is freed during the locking (i.e., tty_ldisc_lock)
ahead (line 1355).

==================================================================
BUG: KASAN: use-after-free in tty_init_dev+0x41a/0x440 drivers/tty/tty_io.c:1358
Write of size 8 at addr ffff888039317128 by task c4_fuzz/2278

CPU: 2 PID: 2278 Comm: c4_fuzz Not tainted 5.8.13 #4
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xa7/0xea lib/dump_stack.c:118
 print_address_description.constprop.8+0x3f/0x60 mm/kasan/report.c:383
 kasan_report.cold.11+0x20/0x37 mm/kasan/report.c:513
 __asan_report_store8_noabort+0x17/0x20 mm/kasan/generic_report.c:151
 tty_init_dev+0x41a/0x440 drivers/tty/tty_io.c:1358
 tty_open_by_driver drivers/tty/tty_io.c:1983 [inline]
 tty_open+0x554/0x870 drivers/tty/tty_io.c:2031
 chrdev_open+0x1e9/0x5b0 fs/char_dev.c:414
 do_dentry_open+0x434/0xf40 fs/open.c:828
 vfs_open+0x9a/0xc0 fs/open.c:942
 do_open fs/namei.c:3243 [inline]
 path_openat+0x1658/0x2570 fs/namei.c:3360
 do_filp_open+0x15e/0x210 fs/namei.c:3387
 do_sys_openat2+0x2e0/0x570 fs/open.c:1179
 do_sys_open+0x88/0xc0 fs/open.c:1195
 ksys_open ./include/linux/syscalls.h:1388 [inline]
 __do_sys_open fs/open.c:1201 [inline]
 __se_sys_open fs/open.c:1199 [inline]
 __x64_sys_open+0x79/0xb0 fs/open.c:1199
 do_syscall_64+0x54/0xa0 arch/x86/entry/common.c:392
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x4379c0
Code: c2 c0 ff ff ff f7 d8 64 89 02 48 83 c8 ff c3 66 2e 0f 1f 84 00
00 00 00 00 90 83 3d 51 06 29 00 00 75 14 b8 02 00 00 00 0f 05 <48> 3d
01 f0 ff ff 0f 83 64 4b 00 00 c3 48 83 ec 08 e8 3a 30 00 00
RSP: 002b:00007ffce63829f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00000000004002b0 RCX: 00000000004379c0
RDX: 000000000000000a RSI: 0000000000000002 RDI: 00007ffce6382edb
RBP: 00007ffce6382a40 R08: 00000000006c5b60 R09: 00007ffce6382eee
R10: 0000000000000400 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000401f20 R14: 0000000000401fb0 R15: 0000000000000000

Allocated by task 1544:
 save_stack+0x21/0x50 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc mm/kasan/common.c:494 [inline]
 __kasan_kmalloc.constprop.6+0xc7/0xd0 mm/kasan/common.c:467
 kasan_kmalloc+0x9/0x10 mm/kasan/common.c:508
 kmem_cache_alloc_trace+0x139/0x330 mm/slub.c:2851
 kmalloc ./include/linux/slab.h:555 [inline]
 kzalloc ./include/linux/slab.h:669 [inline]
 gs_port_alloc drivers/usb/gadget/function/u_serial.c:1151 [inline]
 gserial_alloc_line_no_console+0xd7/0x840
drivers/usb/gadget/function/u_serial.c:1231
 gserial_alloc_line+0x17/0x70 drivers/usb/gadget/function/u_serial.c:1265
 gser_alloc_inst+0x8d/0xf0 drivers/usb/gadget/function/f_serial.c:327
 try_get_usb_function_instance+0x10e/0x1c0 drivers/usb/gadget/functions.c:28
 usb_get_function_instance+0x17/0x80 drivers/usb/gadget/functions.c:44
 function_make+0xf9/0x390 drivers/usb/gadget/configfs.c:588
 configfs_mkdir+0x3f8/0xb40 fs/configfs/dir.c:1344
 vfs_mkdir+0x38f/0x640 fs/namei.c:3641
 do_mkdirat+0x113/0x1e0 fs/namei.c:3664
 __do_sys_mkdir fs/namei.c:3680 [inline]
 __se_sys_mkdir fs/namei.c:3678 [inline]
 __x64_sys_mkdir+0x57/0x80 fs/namei.c:3678
 do_syscall_64+0x54/0xa0 arch/x86/entry/common.c:392
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 2286:
 save_stack+0x21/0x50 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 kasan_set_free_info mm/kasan/common.c:316 [inline]
 __kasan_slab_free+0x139/0x190 mm/kasan/common.c:455
 kasan_slab_free+0xe/0x10 mm/kasan/common.c:464
 slab_free_hook mm/slub.c:1474 [inline]
 slab_free_freelist_hook mm/slub.c:1507 [inline]
 slab_free mm/slub.c:3072 [inline]
 kfree+0xef/0x3d0 mm/slub.c:4052
 gserial_free_port+0x129/0x250 drivers/usb/gadget/function/u_serial.c:1195
 gserial_free_line+0x11f/0x270 drivers/usb/gadget/function/u_serial.c:1212
 gser_free_inst+0x3b/0x50 drivers/usb/gadget/function/f_serial.c:313
 usb_put_function_instance+0x86/0xb0 drivers/usb/gadget/functions.c:77
 serial_attr_release+0x15/0x20 drivers/usb/gadget/function/f_serial.c:262
 config_item_cleanup fs/configfs/item.c:130 [inline]
 config_item_release fs/configfs/item.c:139 [inline]
 kref_put ./include/linux/kref.h:65 [inline]
 config_item_put.part.1+0x14e/0x1e0 fs/configfs/item.c:151
 config_item_put+0xe/0x20 fs/configfs/item.c:149
 configfs_rmdir+0x59c/0x870 fs/configfs/dir.c:1555
 vfs_rmdir fs/namei.c:3704 [inline]
 vfs_rmdir+0x13f/0x440 fs/namei.c:3683
 do_rmdir+0x2a3/0x330 fs/namei.c:3766
 __do_sys_rmdir fs/namei.c:3784 [inline]
 __se_sys_rmdir fs/namei.c:3782 [inline]
 __x64_sys_rmdir+0x31/0x40 fs/namei.c:3782
 do_syscall_64+0x54/0xa0 arch/x86/entry/common.c:392
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff888039317000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 296 bytes inside of
 2048-byte region [ffff888039317000, ffff888039317800)
The buggy address belongs to the page:
page:ffffea0000e4c400 refcount:1 mapcount:0 mapping:0000000000000000
index:0x0 head:ffffea0000e4c400 order:3 compound_mapcount:0
compound_pincount:0
flags: 0x100000000010200(slab|head)
raw: 0100000000010200 dead000000000100 dead000000000122 ffff88806c40e080
raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888039317000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888039317080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888039317100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff888039317180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888039317200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

Regards,
Kyungtae Kim
