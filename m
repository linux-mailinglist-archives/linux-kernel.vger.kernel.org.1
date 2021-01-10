Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09BBC2F04FE
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 04:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbhAJDs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 22:48:58 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:42476 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbhAJDs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 22:48:57 -0500
Received: by mail-il1-f200.google.com with SMTP id l14so362043ilq.9
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 19:48:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=tSiUcg27ESIxzz8qnuK5MB1m0bMVAMb1rUy6oxtuLWI=;
        b=gkFyou7xRkI8OsIhlybEk8gc8dFXPngnRQDN6yTIQ9H8jnOPNEMg5Ngd1LN0PIqW8o
         KlgwWuG9C6Jc93A5iG5CW/ow12K6CVmwuS5JEpJ2STyQG0mDcdG3yKz7DVvdiv4C86GY
         /q57/eIVsSetodr31rdSlkVHw1FV9JsgRnjzIyeGgsvk5ifSWe3WbRq+hyyZwfJPVdpD
         Fh7LXUR1yFtaDBCNFco+jEt4vSzvL0lO1d0AUnCuc4nby5m8tjAMMULDVBiqI+aWxoG0
         F0wFBSJA/P4iZ6NsimU13UAus14CIJW8aLxvd3ERyyIDABxaZ97wec+PJ1YYK28nc47e
         wWyg==
X-Gm-Message-State: AOAM531W/6KWZsn07jhDjirhcs9h2Tx+Oq9aoZf3X4F7pPjm3yFPbyFI
        FhPmVC4nazA9YnvOFx5Bvps9gTa2lrxBbX+m0XYEHjNukQ57
X-Google-Smtp-Source: ABdhPJzi1MutTwTTnv1UrXSKnFLNZktTYSFlDKHulQmpu/A/DvuE/79ktDkUpnqpu+mQ4uYZnONIoFTGpATR3hDi6F2kcSQbLz2+
MIME-Version: 1.0
X-Received: by 2002:a92:8e46:: with SMTP id k6mr10622328ilh.235.1610250496763;
 Sat, 09 Jan 2021 19:48:16 -0800 (PST)
Date:   Sat, 09 Jan 2021 19:48:16 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dbefbb05b883a826@google.com>
Subject: WARNING in qrtr_tun_write_iter
From:   syzbot <syzbot+c2a7e5c5211605a90865@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    6207214a Merge tag 'afs-fixes-04012021' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12b600cf500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8aa30b9da402d224
dashboard link: https://syzkaller.appspot.com/bug?extid=c2a7e5c5211605a90865
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=169c0d0b500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=152fe7a8d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c2a7e5c5211605a90865@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 8469 at mm/page_alloc.c:4976 __alloc_pages_nodemask+0x5f8/0x730 mm/page_alloc.c:5011
Modules linked in:
CPU: 0 PID: 8469 Comm: syz-executor105 Not tainted 5.11.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__alloc_pages_nodemask+0x5f8/0x730 mm/page_alloc.c:4976
Code: 00 00 0c 00 0f 85 a7 00 00 00 8b 3c 24 4c 89 f2 44 89 e6 c6 44 24 70 00 48 89 6c 24 58 e8 d0 d7 ff ff 49 89 c5 e9 ea fc ff ff <0f> 0b e9 b5 fd ff ff 89 74 24 14 4c 89 4c 24 08 4c 89 74 24 18 e8
RSP: 0018:ffffc900013efb70 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 1ffff9200027df72 RCX: 0000000000000000
RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 0000000000040dc0
RBP: 0000000000040dc0 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff81b1f7f1 R11: 0000000000000000 R12: 0000000000000012
R13: 0000000000000012 R14: 0000000000000000 R15: 0000000020000020
FS:  0000000002127880(0000) GS:ffff8880b9f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000000 CR3: 0000000027766000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 alloc_pages_current+0x18c/0x2a0 mm/mempolicy.c:2267
 alloc_pages include/linux/gfp.h:547 [inline]
 kmalloc_order+0x2e/0xb0 mm/slab_common.c:837
 kmalloc_order_trace+0x14/0x120 mm/slab_common.c:853
 kmalloc include/linux/slab.h:557 [inline]
 kzalloc include/linux/slab.h:682 [inline]
 qrtr_tun_write_iter+0x8a/0x180 net/qrtr/tun.c:83
 call_write_iter include/linux/fs.h:1901 [inline]
 new_sync_write+0x426/0x650 fs/read_write.c:518
 vfs_write+0x791/0xa30 fs/read_write.c:605
 ksys_write+0x12d/0x250 fs/read_write.c:658
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x440279
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc5f1b8358 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440279
RDX: 0000000020000020 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401a80
R13: 0000000000401b10 R14: 0000000000000000 R15: 0000000000000000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
