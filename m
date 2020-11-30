Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 578252C8907
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 17:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbgK3QLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 11:11:08 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:37843 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgK3QLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 11:11:07 -0500
Received: by mail-il1-f199.google.com with SMTP id u17so10696217ilb.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 08:10:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=zywW7/r5QUTHyeCGYpJYZmEDwBXaxQ27efKgsKiSKuo=;
        b=McW+uz3FTIQQ+ORXsCrCn6/u9fabC3WoZZ5XMtpW3Xvzfo6qtZJ7O0T6rulWxqySxt
         VaswwuyR3ACJYZUlOiggQRT7DNkAwQkZE6sPja8iXxMWmvgGXlX0IiLmaBUI7o9thmxW
         VCt92lhNt37a3QcLmLMBjhxUq3dlJk88gYkWIz0ZPzgaKnKiVKBkI3iXm7uG5RkIbOtc
         JIhsmfhASl5MfIAoeuO34lm0x2yI0zwR6v7MqAfwrYYnkF4FPsBb9lY7CjjVtwDYm97Z
         YUymvlZTFThLyzsnPEqFBH5OiDKmHpBB4Do09eT8b3C5aW8l1piTb4PgAKKKpnG+MZ+L
         m+ZA==
X-Gm-Message-State: AOAM530ITsXOwfiz/dOyP3tdLQOGy8wnAgIIet7ETBPsxzYZSmcJIQX3
        g4g6JnaLHBZuaL8urEr+2w/NcyWxmKTN/2FOIilWDux8WJCo
X-Google-Smtp-Source: ABdhPJzCoJCtrqyCdXA/UXtJ/ochmoETBTSn9wEzaxKNXEsV5qmvB2tkXsgsSjZXbiGKSXa9sKfBjIEEAArBQBeyiAFmtyAvdS2j
MIME-Version: 1.0
X-Received: by 2002:a92:d90c:: with SMTP id s12mr20218836iln.100.1606752626208;
 Mon, 30 Nov 2020 08:10:26 -0800 (PST)
Date:   Mon, 30 Nov 2020 08:10:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000086f79105b5553f1e@google.com>
Subject: general protection fault in drm_client_buffer_vunmap
From:   syzbot <syzbot+10328e8428a896b65119@syzkaller.appspotmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, syzkaller-bugs@googlegroups.com,
        tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    6147c83f Add linux-next specific files for 20201126
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=109130a5500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9b91566da897c24f
dashboard link: https://syzkaller.appspot.com/bug?extid=10328e8428a896b65119
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12541369500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1365c663500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+10328e8428a896b65119@syzkaller.appspotmail.com

[drm] Initialized udl on minor 2
[drm:udl_get_edid_block] *ERROR* Read EDID byte 0 failed err ffffffb9
udl 1-1:0.0: [drm] Cannot find any crtc or sizes
usb 1-1: USB disconnect, device number 2
general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 0 PID: 7 Comm: kworker/0:1 Not tainted 5.10.0-rc5-next-20201126-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
RIP: 0010:drm_client_buffer_vunmap+0x26/0x50 drivers/gpu/drm/drm_client.c:347
Code: 00 00 00 00 53 48 89 fb 48 83 ec 08 e8 83 8b 3f fd 48 8d 7b 10 48 b8 00 00 00 00 00 fc ff df 48 8d 73 18 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 0e 48 8b 7b 10 48 83 c4 08 5b e9 56 61 f7 ff 48 89
RSP: 0018:ffffc90000cc7710 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff815524de
RDX: 0000000000000002 RSI: 0000000000000018 RDI: 0000000000000010
RBP: ffff88801db748c8 R08: 0000000000000000 R09: ffff88801db74a17
R10: ffffed1003b6e942 R11: 0000000000000000 R12: 0000000000000000
R13: ffff88801db748d8 R14: ffff88801db74810 R15: dead000000000100
FS:  0000000000000000(0000) GS:ffff8880b9e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055f43f9d79e0 CR3: 000000000b08e000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 drm_fbdev_cleanup+0x380/0x440 drivers/gpu/drm/drm_fb_helper.c:2042
 drm_fbdev_release drivers/gpu/drm/drm_fb_helper.c:2049 [inline]
 drm_fbdev_client_unregister+0x61/0x80 drivers/gpu/drm/drm_fb_helper.c:2376
 drm_client_dev_unregister+0x239/0x3b0 drivers/gpu/drm/drm_client.c:175
 drm_dev_unregister+0xe9/0x2b0 drivers/gpu/drm/drm_drv.c:942
 usb_unbind_interface+0x1d8/0x8d0 drivers/usb/core/driver.c:458
 __device_release_driver+0x3bd/0x6f0 drivers/base/dd.c:1154
 device_release_driver_internal drivers/base/dd.c:1185 [inline]
 device_release_driver+0x26/0x40 drivers/base/dd.c:1208
 bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:533
 device_del+0x502/0xec0 drivers/base/core.c:3113
 usb_disable_device+0x35b/0x7b0 drivers/usb/core/message.c:1417
 usb_disconnect.cold+0x27d/0x780 drivers/usb/core/hub.c:2218
 hub_port_connect drivers/usb/core/hub.c:5074 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5363 [inline]
 port_event drivers/usb/core/hub.c:5509 [inline]
 hub_event+0x1c8a/0x42d0 drivers/usb/core/hub.c:5591
 process_one_work+0x98d/0x15f0 kernel/workqueue.c:2272
 process_scheduled_works kernel/workqueue.c:2334 [inline]
 worker_thread+0x82b/0x1120 kernel/workqueue.c:2420
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
Modules linked in:
---[ end trace 5e45793b7de819bc ]---
RIP: 0010:drm_client_buffer_vunmap+0x26/0x50 drivers/gpu/drm/drm_client.c:347
Code: 00 00 00 00 53 48 89 fb 48 83 ec 08 e8 83 8b 3f fd 48 8d 7b 10 48 b8 00 00 00 00 00 fc ff df 48 8d 73 18 48 


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
