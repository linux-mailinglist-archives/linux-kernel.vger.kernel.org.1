Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB25E283463
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 12:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgJEK7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 06:59:25 -0400
Received: from mail-il1-f207.google.com ([209.85.166.207]:41353 "EHLO
        mail-il1-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgJEK7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 06:59:24 -0400
Received: by mail-il1-f207.google.com with SMTP id f10so6904921ilj.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 03:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=2/Mj8FDFri+XG8cVI9LneAyoK8CTL+BJOVDPJiMNGio=;
        b=Y910vMWUE/FtUUI5wRQVCzU1JVxIZlpQqNmM/uAs6QiFNv2Ey6CYhJBQLzvSIFkODX
         uGOGqfVKRFZX+8DVPzO/flI+XHz4Fl2ow7ONH5Vazfo/NZUKeEMlygUE8s5fmpMrbwvv
         rk8xrIn92Z194WrcHOrBrLcj4PA7s0L8GQONZtzKWKbFsazOOmiIbAP2PJGGFjJpDPrg
         FRMrvhqJlWtdk0Rx9SKUxYtzSzhIaPl6BHg9Xs8TQhmAsW/rLiHV4LzfyCJZMGfRW27/
         Qpli6bMnEq3nAwCKTbSLXGRXkwOgISXSAFZJvjEj25bzbD1y2MdTlFRtooExiNsClgf5
         JB0w==
X-Gm-Message-State: AOAM533R2XVkQx+2um1XbOGHJQwwmyOYgPZKA1KiHNfGJR9h7P4LaJ+P
        SmX3N4+esusWtwns9VJe8dIx2S/IjYRY+rLDImX9W7Gl1xM+
X-Google-Smtp-Source: ABdhPJynhHtOJjCs6CIzE2sskBMvBeqsYDZRgldzDPd3GKv2jwlA44VsXCbcLG7TqikZMFV9pUSmMVG44ROO2vEgFD/tMOvBCY4P
MIME-Version: 1.0
X-Received: by 2002:a92:998d:: with SMTP id t13mr4085498ilk.256.1601895563138;
 Mon, 05 Oct 2020 03:59:23 -0700 (PDT)
Date:   Mon, 05 Oct 2020 03:59:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000021e6b05b0ea60bd@google.com>
Subject: WARNING in hif_usb_send/usb_submit_urb
From:   syzbot <syzbot+f5378bcf0f0cab45c1c6@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, eli.billauer@gmail.com,
        gregkh@linuxfoundation.org, gustavoars@kernel.org,
        ingrassia@epigenesys.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com, tiwai@suse.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    168ae5a7 Merge 5.9-rc8 into usb-next
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=1073b7ff900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5429f3643ebc37a
dashboard link: https://syzkaller.appspot.com/bug?extid=f5378bcf0f0cab45c1c6
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f5378bcf0f0cab45c1c6@syzkaller.appspotmail.com

------------[ cut here ]------------
usb 4-1: BOGUS urb xfer, pipe 1 != type 3
WARNING: CPU: 0 PID: 10570 at drivers/usb/core/urb.c:493 usb_submit_urb+0xce2/0x14e0 drivers/usb/core/urb.c:493
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 10570 Comm: kworker/0:9 Not tainted 5.9.0-rc8-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events request_firmware_work_func
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x107/0x16e lib/dump_stack.c:118
 panic+0x2cb/0x702 kernel/panic.c:231
 __warn.cold+0x20/0x44 kernel/panic.c:600
 report_bug+0x1bd/0x210 lib/bug.c:198
 handle_bug+0x41/0x80 arch/x86/kernel/traps.c:234
 exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:254
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
RIP: 0010:usb_submit_urb+0xce2/0x14e0 drivers/usb/core/urb.c:493
Code: 84 04 03 00 00 e8 3e 98 c6 fd 4c 89 ef e8 66 b6 12 ff 41 89 d8 44 89 e1 4c 89 f2 48 89 c6 48 c7 c7 20 b3 5d 86 e8 d0 ba 9a fd <0f> 0b e9 c6 f8 ff ff e8 12 98 c6 fd 48 81 c5 40 06 00 00 e9 f2 f7
RSP: 0018:ffff8881ab1bf808 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: ffff8881ca76cbc0 RSI: ffffffff8129efa3 RDI: ffffed1035637ef3
RBP: ffff8881a27dfc00 R08: 0000000000000001 R09: ffff8881db22f50f
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000001
R13: ffff8881d8fab0a0 R14: ffff8881c7299168 R15: ffff8881cc24a700
 hif_usb_send_regout drivers/net/wireless/ath/ath9k/hif_usb.c:127 [inline]
 hif_usb_send+0x4c1/0xcf0 drivers/net/wireless/ath/ath9k/hif_usb.c:470
 htc_issue_send drivers/net/wireless/ath/ath9k/htc_hst.c:34 [inline]
 htc_connect_service+0x705/0xa00 drivers/net/wireless/ath/ath9k/htc_hst.c:275
 ath9k_wmi_connect+0xc9/0x190 drivers/net/wireless/ath/ath9k/wmi.c:268
 ath9k_init_htc_services.constprop.0+0xb3/0x640 drivers/net/wireless/ath/ath9k/htc_drv_init.c:146
 ath9k_htc_probe_device+0x25f/0x1e10 drivers/net/wireless/ath/ath9k/htc_drv_init.c:962
 ath9k_htc_hw_init+0x31/0x60 drivers/net/wireless/ath/ath9k/htc_hst.c:501
 ath9k_hif_usb_firmware_cb+0x274/0x530 drivers/net/wireless/ath/ath9k/hif_usb.c:1220
 request_firmware_work_func+0x126/0x250 drivers/base/firmware_loader/main.c:1006
 process_one_work+0x94c/0x15f0 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x392/0x470 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
