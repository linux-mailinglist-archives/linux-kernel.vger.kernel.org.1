Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A8B2AD09A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 08:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgKJHpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 02:45:21 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:42588 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728636AbgKJHpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 02:45:20 -0500
Received: by mail-io1-f69.google.com with SMTP id p67so7656552iod.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 23:45:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=01nyrfr+gYRmZlH1jpzWRTGtxsWtm9M28tH9DfqpTiE=;
        b=JrcwitazPZyeNKnk1Z5hLODeNh8PNXG03ROJC+2oOkz128x5inRVICZFigQNCmIjAY
         RRP1ppVtM/uXFysHWiioW2JMQSWla2AoVEciO5OuWJ1wFG+g9Exr0u7GcnI68zS0ZW6T
         yzopN4d2SFIn2hGgO1pq3ePVBZb5IkYSCoLrA3VsZ7MjfqrTtVWL9toGnPopZFs1pOIg
         SAOFDIfmODHpQqLn3bq6/gDbYGIkjyDYF6baPc5lk262/tqIrNC8+hgepgpKPnqQLeUB
         SIh1+G00VxrEk1lxCksjIq9pwf2Ho1fs7tWTK0g4NwDYPlMddgmB/aJU9BrkT04yQTFY
         U7WA==
X-Gm-Message-State: AOAM5335mlcYMRYGXD9DbDQsrFB2GNEC1poSU7/WTbcZPscYkYTZOBKD
        unPDsan+MaoXFsMAOepQ/P49/dFFKuTATuog0zBPHBlqLzRG
X-Google-Smtp-Source: ABdhPJz1G8AGhIojkS8oFUQMfpYkVRRnj14Gmr8TTV0jDZrkCP58ghRiqM945hGMSm039UAr2OE5qIBwDQIdkNQJmzCE0WhDhVrp
MIME-Version: 1.0
X-Received: by 2002:a5e:a613:: with SMTP id q19mr12847062ioi.110.1604994319534;
 Mon, 09 Nov 2020 23:45:19 -0800 (PST)
Date:   Mon, 09 Nov 2020 23:45:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000484e4b05b3bbdcf4@google.com>
Subject: WARNING in put_i2c_dev
From:   syzbot <syzbot+0a05df8ed151f2ed3a05@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    521b619a Merge tag 'linux-kselftest-kunit-fixes-5.10-rc3' ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10760a34500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61033507391c77ff
dashboard link: https://syzkaller.appspot.com/bug?extid=0a05df8ed151f2ed3a05
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1672e7a8500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15f6b4b2500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0a05df8ed151f2ed3a05@syzkaller.appspotmail.com

pvrusb2: Attached sub-driver cx25840
pvrusb2: ***WARNING*** pvrusb2 device hardware appears to be jammed and I can't clear it.
pvrusb2: You might need to power cycle the pvrusb2 device in order to recover.
------------[ cut here ]------------
sysfs group 'power' not found for kobject 'i2c-1'
WARNING: CPU: 1 PID: 4041 at fs/sysfs/group.c:279 sysfs_remove_group+0x126/0x170 fs/sysfs/group.c:279
Modules linked in:
CPU: 1 PID: 4041 Comm: pvrusb2-context Not tainted 5.10.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:sysfs_remove_group+0x126/0x170 fs/sysfs/group.c:279
Code: 48 89 d9 49 8b 14 24 48 b8 00 00 00 00 00 fc ff df 48 c1 e9 03 80 3c 01 00 75 37 48 8b 33 48 c7 c7 60 72 5b 89 e8 81 52 c4 06 <0f> 0b eb 98 e8 11 7e ca ff e9 01 ff ff ff 48 89 df e8 04 7e ca ff
RSP: 0018:ffffc9000367fa38 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffffffff89b53740 RCX: 0000000000000000
RDX: ffff88801d0d8000 RSI: ffffffff8158d055 RDI: fffff520006cff39
RBP: 0000000000000000 R08: 0000000000000001 R09: ffff8880b9f309e7
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888143e19018
R13: ffffffff89b53ce0 R14: ffff888143e1e000 R15: ffffffff8c2c7d20
FS:  0000000000000000(0000) GS:ffff8880b9f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc516e9a020 CR3: 0000000020556000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 dpm_sysfs_remove+0x97/0xb0 drivers/base/power/sysfs.c:837
 device_del+0x20c/0xec0 drivers/base/core.c:3092
 cdev_device_del+0x19/0x100 fs/char_dev.c:573
 put_i2c_dev+0x160/0x1b0 drivers/i2c/i2c-dev.c:93
 i2cdev_detach_adapter.part.0+0x10f/0x1a0 drivers/i2c/i2c-dev.c:689
 i2cdev_detach_adapter drivers/i2c/i2c-dev.c:647 [inline]
 i2cdev_notifier_call+0xad/0xc0 drivers/i2c/i2c-dev.c:704
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 blocking_notifier_call_chain kernel/notifier.c:337 [inline]
 blocking_notifier_call_chain+0x67/0x90 kernel/notifier.c:325
 device_del+0x1ff/0xec0 drivers/base/core.c:3089
 device_unregister+0x22/0xc0 drivers/base/core.c:3148
 i2c_del_adapter+0x4d6/0x680 drivers/i2c/i2c-core-base.c:1690
 pvr2_i2c_core_done+0x69/0xc0 drivers/media/usb/pvrusb2/pvrusb2-i2c-core.c:652
 pvr2_hdw_destroy+0x179/0x3b0 drivers/media/usb/pvrusb2/pvrusb2-hdw.c:2679
 pvr2_context_destroy+0x84/0x230 drivers/media/usb/pvrusb2/pvrusb2-context.c:70
 pvr2_context_check drivers/media/usb/pvrusb2/pvrusb2-context.c:137 [inline]
 pvr2_context_thread_func+0x641/0x850 drivers/media/usb/pvrusb2/pvrusb2-context.c:158
 kthread+0x3af/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
