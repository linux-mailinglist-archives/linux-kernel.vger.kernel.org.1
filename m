Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F17829D501
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbgJ1V4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbgJ1V4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:56:05 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DC8C0613D1;
        Wed, 28 Oct 2020 14:56:05 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 141so733212lfn.5;
        Wed, 28 Oct 2020 14:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=abYJkafoDOKX6fW7qL+UGUXhDXddixsn3/i0RMMQq/s=;
        b=Nmrv8ERmGuAEq081pt54Hacig+9CAWxGFJQxue3Lde5JR5DFPU+NTw14ySZFu56JVQ
         ZVBUvIIQyOHqPFc5SwoAMl2fovwtXPZUS9S+p6JAIUYJydbku560HEYmNbCHiDQad/GH
         pnYrW2rt5czNkupHBUqcuLhGuzSHVk6NrHIsK+bITT3hlNHwWmyp0Uoavii3bfFyxZiQ
         CdUDy58wKidCW/HnBLvN0L6U8RNiBSUjw9/QPfoivZX5IqJDvkgJKs1l4mgK99STMIXX
         K4JW1f2alWxu7DLIEYu3n0+kf15nRQ/3wL0yLxaiy+pdyPCTy/gpriGI+gzBSCkPTf1x
         t8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=abYJkafoDOKX6fW7qL+UGUXhDXddixsn3/i0RMMQq/s=;
        b=aURR/h+ZPYn1cmm1Tnx2WjxOaNDFeksR1mm2Q7Z7K7V1ZxPwJ0PUCGHC5sv42Y6bOm
         UYhdsppBIohZEWLeiEOLX2hJ8pJH0SPP8uYg51yahBjoMPqMMYcItGVsQ8Mx+cZKxlmL
         8KOfN9AscWa/z/2jPF6uCMFDTuJWO0g/aSSksseYr9tzFWBlYvOeGOOL3Ul9lzPMmLV0
         2CsRMtUXCjJpEUsqo7sQqGbPjadUhssYEvodkG9p2pbUK14zEL1tnYkn17b9LX+VooDT
         KndAMGDal/1WjaFh0cLr1kfzE6dSPT44a+2GcL8GLbst8kYSv4L6qbK0Tew7UmBbDFZb
         6/6g==
X-Gm-Message-State: AOAM532vcSOMBZ1Op22nQN4TVmXekZplGrXAI3Brlld08yYtFFiyigj0
        QLKJXmg7qSkhTig9qMKGrEEEn/0ruBcPzTteht8GZK3z
X-Google-Smtp-Source: ABdhPJzB35jmmC/PPHiICXY1xgzJJ+p5Ci778yCAKdxXqgxg2rVlbi0QN2vSdSBkMesEFTO1D1l9Uchs4NGDNXzdbTU=
X-Received: by 2002:a17:906:1246:: with SMTP id u6mr933941eja.432.1603918280500;
 Wed, 28 Oct 2020 13:51:20 -0700 (PDT)
MIME-Version: 1.0
From:   Kyungtae Kim <kt0755@gmail.com>
Date:   Wed, 28 Oct 2020 16:51:09 -0400
Message-ID: <CAEAjamsqOfgS6-7mt4SGd9rou-QRxzRDfQ_wD6dB3veueXtqgw@mail.gmail.com>
Subject: KASAN: use-after-free Read in do_set_interface
To:     Felipe Balbi <balbi@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We report a bug (in linux-5.8.13) found by FuzzUSB (a modified version
of syzkaller).

The bug happened when accessing a freed instance of struct fsg_dev
(i.e., fsg->bulk_in) in do_set_interface() (line 2245).

==================================================================
BUG: KASAN: use-after-free in do_set_interface.part.7+0xa6b/0xd90
drivers/usb/gadget/function/f_mass_storage.c:2245
Read of size 8 at addr ffff88806bc940f8 by task file-storage/2063

CPU: 3 PID: 2063 Comm: file-storage Not tainted 5.8.13 #4
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xa7/0xea lib/dump_stack.c:118
 print_address_description.constprop.8+0x3f/0x60 mm/kasan/report.c:383
 kasan_report.cold.11+0x20/0x37 mm/kasan/report.c:513
 __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:146
 do_set_interface.part.7+0xa6b/0xd90
drivers/usb/gadget/function/f_mass_storage.c:2245
 do_set_interface drivers/usb/gadget/function/f_mass_storage.c:2202 [inline]
 handle_exception drivers/usb/gadget/function/f_mass_storage.c:2426 [inline]
 fsg_main_thread+0x12c7/0x59f1 drivers/usb/gadget/function/f_mass_storage.c:2466
 kthread+0x374/0x480 kernel/kthread.c:291
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293

Allocated by task 1910:
 save_stack+0x21/0x50 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc mm/kasan/common.c:494 [inline]
 __kasan_kmalloc.constprop.6+0xc7/0xd0 mm/kasan/common.c:467
 kasan_kmalloc+0x9/0x10 mm/kasan/common.c:508
 kmem_cache_alloc_trace+0x139/0x330 mm/slub.c:2851
 kzalloc ./include/linux/slab.h:555 [inline]
 fsg_alloc+0x77/0x290 drivers/usb/gadget/function/f_mass_storage.c:3417
 usb_get_function+0x58/0xc0 drivers/usb/gadget/functions.c:61
 config_usb_cfg_link+0x1ed/0x3a0 drivers/usb/gadget/configfs.c:435
 configfs_symlink+0x4f5/0xf10 fs/configfs/symlink.c:202
 vfs_symlink fs/namei.c:3953 [inline]
 vfs_symlink+0x304/0x540 fs/namei.c:3939
 do_symlinkat+0x104/0x1a0 fs/namei.c:3980
 __do_sys_symlinkat fs/namei.c:3994 [inline]
 __se_sys_symlinkat fs/namei.c:3991 [inline]
 __x64_sys_symlinkat+0x6e/0xb0 fs/namei.c:3991
 do_syscall_64+0x54/0xa0 arch/x86/entry/common.c:392
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 2072:
 save_stack+0x21/0x50 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 kasan_set_free_info mm/kasan/common.c:316 [inline]
 __kasan_slab_free+0x139/0x190 mm/kasan/common.c:455
 kasan_slab_free+0xe/0x10 mm/kasan/common.c:464
 slab_free_hook mm/slub.c:1474 [inline]
 slab_free_freelist_hook mm/slub.c:1507 [inline]
 slab_free mm/slub.c:3072 [inline]
 kfree+0xef/0x3d0 mm/slub.c:4052
 fsg_free+0x84/0xa0 drivers/usb/gadget/function/f_mass_storage.c:3408
 usb_put_function+0x38/0x50 drivers/usb/gadget/functions.c:87
 config_usb_cfg_unlink+0x2e9/0x3a0 drivers/usb/gadget/configfs.c:476
 configfs_unlink+0x379/0x77e fs/configfs/symlink.c:250
 vfs_unlink+0x241/0x550 fs/namei.c:3825
 do_unlinkat+0x3e7/0x610 fs/namei.c:3889
 __do_sys_unlink fs/namei.c:3936 [inline]
 __se_sys_unlink fs/namei.c:3934 [inline]
 __x64_sys_unlink+0x3d/0x50 fs/namei.c:3934
 do_syscall_64+0x54/0xa0 arch/x86/entry/common.c:392
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff88806bc94000
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 248 bytes inside of
 512-byte region [ffff88806bc94000, ffff88806bc94200)
The buggy address belongs to the page:
page:ffffea0001af2500 refcount:1 mapcount:0 mapping:0000000000000000
index:0x0 head:ffffea0001af2500 order:2 compound_mapcount:0
compound_pincount:0
flags: 0x100000000010200(slab|head)
raw: 0100000000010200 dead000000000100 dead000000000122 ffff88806c40e580
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88806bc93f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88806bc94000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88806bc94080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                                ^
 ffff88806bc94100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88806bc94180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

Regards,
Kyungtae Kim
