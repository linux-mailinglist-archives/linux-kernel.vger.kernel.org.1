Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B237285B96
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 11:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgJGJJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 05:09:18 -0400
Received: from mail-il1-f208.google.com ([209.85.166.208]:40425 "EHLO
        mail-il1-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbgJGJJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 05:09:18 -0400
Received: by mail-il1-f208.google.com with SMTP id p17so1049103ilg.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 02:09:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=RPbi0L3LEGQCHC9LzRoxc05o9gWfsGlWtHMxECXs/j0=;
        b=VPA3vW2sZEVU5GGYmXGCCoE3SeHNUtAl7ewgSAsEhgIYRfFgMWbb9YWlKNUBS7pid5
         LLoud2Sxv8WA9xwMLIEy1Rb+Rje09JcsjHkXjX/6fRVannRhyG/HesjI/ApZoXfM9GDQ
         zsAKauJKH2ONphZtOF+XPhiHIMqjtX+P6b4Xbot0ZS32eBScci5WagbFPIf1ygu4YGoI
         2Pwqvsf9hjKKc+vF6NnDtQCC/RzNk0UsihwdPU5VndCThe2GImFRmYb+vQYlRwmf0mLh
         9ukNeBvOrLRqayt8oRSsBEUQKEJpUX8Jqb838e/rz5vadvvvaNTAX4d8Nr+ysPRB8tp5
         aYew==
X-Gm-Message-State: AOAM532fkLGN7Ob634tviQ3ZGrsP5xWzrYk4F1TgfKHd5CdtorhwbsSL
        CyyvDWjuTEVuXKGU6Wxw7IbLEf/5IO/DBadendyiQ9ojZFES
X-Google-Smtp-Source: ABdhPJxi8ofKiwLGzpqK2O4TH2TRf5qP5OEMTv34ulrZiHIKeN6M+iadC52W0fKznvmsqU9abdbUqybbtYmF8D/AXttebEca1lWC
MIME-Version: 1.0
X-Received: by 2002:a92:ca92:: with SMTP id t18mr1987198ilo.287.1602061757300;
 Wed, 07 Oct 2020 02:09:17 -0700 (PDT)
Date:   Wed, 07 Oct 2020 02:09:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f3c7f005b11111c9@google.com>
Subject: WARNING in pin_user_pages_locked
From:   syzbot <syzbot+542e00ce34515318e08e@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, daniel.vetter@ffwll.ch,
        daniel.vetter@intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a804ab08 Add linux-next specific files for 20201006
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1688db0b900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=26c1b4cc4a62ccb
dashboard link: https://syzkaller.appspot.com/bug?extid=542e00ce34515318e08e
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15ab0c77900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17d2c33f900000

The issue was bisected to:

commit d53807afc288c71eb9374f102d49cc01f6b6c760
Author: Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Sat Oct 3 08:01:38 2020 +0000

    mm/frame-vec: use FOLL_LONGTERM

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=164d7c68500000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=154d7c68500000
console output: https://syzkaller.appspot.com/x/log.txt?x=114d7c68500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+542e00ce34515318e08e@syzkaller.appspotmail.com
Fixes: d53807afc288 ("mm/frame-vec: use FOLL_LONGTERM")

------------[ cut here ]------------
WARNING: CPU: 0 PID: 6893 at mm/gup.c:2992 pin_user_pages_locked+0x60d/0x780 mm/gup.c:2992
Modules linked in:
CPU: 0 PID: 6893 Comm: syz-executor513 Not tainted 5.9.0-rc8-next-20201006-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:pin_user_pages_locked+0x60d/0x780 mm/gup.c:2992
Code: cf ff 49 83 c7 08 e8 22 2e cf ff 48 8b 44 24 10 c6 44 24 10 01 48 05 00 10 00 00 48 89 44 24 08 e9 65 fb ff ff e8 03 2e cf ff <0f> 0b 49 c7 c4 ea ff ff ff e9 8a fe ff ff e8 f0 2d cf ff 0f 0b 49
RSP: 0018:ffffc900011c7648 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000010000 RCX: ffffffff81a61358
RDX: ffff8880a6822000 RSI: ffffffff81a6192d RDI: 0000000000000005
RBP: ffffc900011c7728 R08: ffffc900011c7728 R09: ffff88808e116307
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000110 R14: 0000000000000110 R15: ffff888092918010
FS:  00000000024e4880(0000) GS:ffff8880ae400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f91c63cc028 CR3: 00000000a7259000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 get_vaddr_frames+0x788/0x960 mm/frame_vector.c:75
 vb2_create_framevec+0x55/0xc0 drivers/media/common/videobuf2/videobuf2-memops.c:50
 vb2_vmalloc_get_userptr+0xce/0x4c0 drivers/media/common/videobuf2/videobuf2-vmalloc.c:90
 __prepare_userptr+0x342/0x15f0 drivers/media/common/videobuf2/videobuf2-core.c:1117
 __buf_prepare+0x635/0x7d0 drivers/media/common/videobuf2/videobuf2-core.c:1356
 vb2_core_qbuf+0xa9d/0x11c0 drivers/media/common/videobuf2/videobuf2-core.c:1647
 vb2_qbuf+0x135/0x1a0 drivers/media/common/videobuf2/videobuf2-v4l2.c:826
 vb2_ioctl_qbuf+0xfb/0x140 drivers/media/common/videobuf2/videobuf2-v4l2.c:1056
 v4l_qbuf drivers/media/v4l2-core/v4l2-ioctl.c:2066 [inline]
 v4l_qbuf+0x92/0xc0 drivers/media/v4l2-core/v4l2-ioctl.c:2060
 __video_do_ioctl+0xb94/0xe20 drivers/media/v4l2-core/v4l2-ioctl.c:2990
 video_usercopy+0x207/0xe50 drivers/media/v4l2-core/v4l2-ioctl.c:3306
 v4l2_ioctl+0x1b3/0x250 drivers/media/v4l2-core/v4l2-dev.c:360
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x443ff9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 fb d7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffd1306b5e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004002e0 RCX: 0000000000443ff9
RDX: 0000000020000140 RSI: 00000000c058560f RDI: 0000000000000003
RBP: 00000000006ce018 R08: 00000000004002e0 R09: 00000000004002e0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401c80
R13: 0000000000401d10 R14: 0000000000000000 R15: 0000000000000000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
