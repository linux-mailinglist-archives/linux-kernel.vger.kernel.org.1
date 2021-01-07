Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799722ED418
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 17:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbhAGQOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 11:14:12 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:51242 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbhAGQOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 11:14:11 -0500
Received: by mail-io1-f69.google.com with SMTP id h206so5132611iof.18
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 08:13:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=bTMytF+N4TDmJ9rHn8WRoyCXgqj8j9/O59RQj+Q1ud0=;
        b=bucsYKy6rj9YuEPAPSLslJBL+TL7eQqiissyqFmByDGJLuWNmrEfJDY5ZZBqYlCsAK
         /K1UeyAYe7fiM2QuoXgWGZVnuwzhBpLUENCCkZy9YsFdBop4srTXvmidokb2p7ufzQD1
         CjGopwgd6HFsm2PCiAFaOFht+QhGC6Vd8fdKktzXMt5f3yQO6vE1riqfcKeH4mshk1Ku
         /aRGHw7HLKqH5MEt042vnpAO7LrZGdCl36Rl4BjpdSsAiWNdumFZUBvOkrYXmzJnDGCs
         0zykxQYyLEuDiTZD7P5Sq8A2ClaloByLoQaYT7KXLTwbRgAWcBUsCsa51G3Xe6JDFMO1
         iMEw==
X-Gm-Message-State: AOAM532ZQQqRheRg8O2aChIGvtoDwZZSfzQrp8Mhub1YChLtntd0IxqA
        N1ctqOOAa9bKyVa36Lm+pKWDxAzjyeaaRf1QNeZZtnHxXkWl
X-Google-Smtp-Source: ABdhPJw+qti4Ox3Xawufw2SDiFU1QenfWARf9q+8K76Ppo/Ixx7OsPObSBWhforkGN3mwVFPzbLl9ghGYutsNFBhJW4XoHCsljny
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188d:: with SMTP id o13mr8460240ilu.233.1610036010763;
 Thu, 07 Jan 2021 08:13:30 -0800 (PST)
Date:   Thu, 07 Jan 2021 08:13:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007f4ec105b851b870@google.com>
Subject: WARNING in __usbhid_submit_report
From:   syzbot <syzbot+c44943d43677810db388@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, andreyknvl@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ed054e4e USB: gadget: f_printer: set a default q_len
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=172880e7500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8ac36d562a4f043
dashboard link: https://syzkaller.appspot.com/bug?extid=c44943d43677810db388
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1516acc7500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15658b57500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c44943d43677810db388@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 4394 at mm/page_alloc.c:4974 __alloc_pages_nodemask+0x569/0x690 mm/page_alloc.c:5009
Modules linked in:
CPU: 0 PID: 4394 Comm: syz-executor446 Not tainted 5.11.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__alloc_pages_nodemask+0x569/0x690 mm/page_alloc.c:4974
Code: 00 00 0c 00 0f 85 94 00 00 00 4c 89 c2 44 89 e6 44 89 f7 c6 44 24 70 00 4c 89 6c 24 58 e8 0f da ff ff 49 89 c7 e9 2f fd ff ff <0f> 0b e9 f7 fd ff ff 4c 89 44 24 18 4c 89 44 24 10 89 74 24 0c 4c
RSP: 0018:ffffc90000207b98 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 1ffff92000040f77 RCX: 0000000000000000
RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 0000000000040a20
RBP: 0000000000000000 R08: 00000000ffffffff R09: 0000000000000000
R10: ffffffff8169a911 R11: 0000000000000000 R12: 0000000000000012
R13: 0000000000000012 R14: 0000000000000000 R15: ffff8881020e2958
FS:  0000000000fa6880(0000) GS:ffff8881f6a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000557339925678 CR3: 000000010239d000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 alloc_pages_current+0x18c/0x2a0 mm/mempolicy.c:2267
 alloc_pages include/linux/gfp.h:547 [inline]
 kmalloc_order+0x2e/0xb0 mm/slab_common.c:837
 kmalloc_order_trace+0x14/0x110 mm/slab_common.c:853
 __usbhid_submit_report+0x56a/0xd50 drivers/hid/usbhid/hid-core.c:590
 usbhid_submit_report drivers/hid/usbhid/hid-core.c:640 [inline]
 usbhid_request+0x7b/0xf0 drivers/hid/usbhid/hid-core.c:1274
 hid_hw_request include/linux/hid.h:1072 [inline]
 hiddev_ioctl+0x513/0x1630 drivers/hid/usbhid/hiddev.c:726
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
 do_syscall_64+0x2d/0x40 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x445cb9
Code: e8 5c ad 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 1b cd fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fff01168048 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000445cb9
RDX: 0000000020000040 RSI: 00000000400c4808 RDI: 0000000000000004
RBP: 00000000006d0018 R08: 000000000000000b R09: 00000000004002e0
R10: 000000000000000f R11: 0000000000000246 R12: 0000000000402e60
R13: 0000000000402ef0 R14: 0000000000000000 R15: 0000000000000000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
