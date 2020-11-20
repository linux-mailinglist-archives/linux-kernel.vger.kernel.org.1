Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F92E2BAE56
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 16:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbgKTPP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 10:15:27 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:52284 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729306AbgKTPPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:15:21 -0500
Received: by mail-il1-f198.google.com with SMTP id o18so7743083ilg.19
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 07:15:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=tkGBu9ed9HkqCobXkIkI9MEn9IDKeb0kRoM4P7yTfoc=;
        b=P5ofje4XUOHF6dr7PFNqnox7lFetRGYIdI3bVp2NeJ6JuZIKx+Vvs147TefwfQFvDA
         Id6RYrOSIppIzh+c1G5GSAzXVOgtHvt3i3aEH51y0lzDg7m3QDKCHRQyhiq/9ReHoR3U
         D8G6v+k4wLlatGEVRRVK5SXx4/qSY+f9tji0JTFAKF+UbXrlx7Mc7DiMtMywHLdv3dhS
         ziShwcWaS1FNCqDgE8xJHugjPmqHD/axqGJ7t4Vkf8awzj5c/mrc0f1gE75KsuCjE4Ef
         /MkKIqjVDqaM1SdhnfHgudPULPwd7YXyZ8zywYeCTCTVG4SbBxGA9Ql+NMIVycs5WaxM
         PGKQ==
X-Gm-Message-State: AOAM531NgKzlpE8Ki1h+GxRcoziaToFTQYQVTnxmxYC2i+SfVuPu/0Sw
        A3Ao8KUqhpIiUItVrrl25y7lDsI73vjuI5vmXtpwI/ZS3gaS
X-Google-Smtp-Source: ABdhPJyTkdywlV2rv06IKPHZU2WygAhj5xWz3w9jMY+BBtiEvsyTXlh5nJfabDh9i7hRVaVHbxxuS4SBnPQKBWSApOz+j4VgrCEG
MIME-Version: 1.0
X-Received: by 2002:a5e:df03:: with SMTP id f3mr15662613ioq.182.1605885321379;
 Fri, 20 Nov 2020 07:15:21 -0800 (PST)
Date:   Fri, 20 Nov 2020 07:15:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000021890a05b48b5068@google.com>
Subject: kernel BUG at fs/jfs/jfs_logmgr.c:LINE!
From:   syzbot <syzbot+889fbbf5a2eb77be373f@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    111e91a6 Merge tag 's390-5.10-4' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=104697be500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1f5252d7c8fd7762
dashboard link: https://syzkaller.appspot.com/bug?extid=889fbbf5a2eb77be373f
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+889fbbf5a2eb77be373f@syzkaller.appspotmail.com

BUG at fs/jfs/jfs_logmgr.c:2312 assert(bp->l_flag & lbmRELEASE)
------------[ cut here ]------------
kernel BUG at fs/jfs/jfs_logmgr.c:2312!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 17 Comm: ksoftirqd/1 Not tainted 5.10.0-rc4-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:lbmIODone.cold+0x24/0x5b fs/jfs/jfs_logmgr.c:2312
Code: f8 e8 cb ff ff ff e8 ac 52 bd f8 48 c7 c1 40 ca 82 89 ba 08 09 00 00 48 c7 c6 c0 c9 82 89 48 c7 c7 00 ca 82 89 e8 7e ea fa ff <0f> 0b e8 86 52 bd f8 48 c7 c1 80 ca 82 89 ba 09 09 00 00 48 c7 c6
RSP: 0018:ffffc900004bfbb8 EFLAGS: 00010082
RAX: 000000000000003f RBX: ffff888012bf1b00 RCX: 0000000000000000
RDX: ffff888010b2c580 RSI: ffffffff8158f3e5 RDI: fffff52000097f69
RBP: 0000000000000020 R08: 000000000000003f R09: ffff88802cb30627
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000246
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88802cb00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000002d9aad8 CR3: 00000000691cf000 CR4: 0000000000350ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 bio_endio+0x3d3/0x7a0 block/bio.c:1450
 req_bio_endio block/blk-core.c:263 [inline]
 blk_update_request+0x68e/0x1490 block/blk-core.c:1467
 blk_mq_end_request+0x4c/0x510 block/blk-mq.c:562
 lo_complete_rq+0x20d/0x2d0 drivers/block/loop.c:501
 blk_done_softirq+0x294/0x3e0 block/blk-mq.c:586
 __do_softirq+0x2a0/0x9f6 kernel/softirq.c:298
 run_ksoftirqd kernel/softirq.c:653 [inline]
 run_ksoftirqd+0x2d/0x50 kernel/softirq.c:645
 smpboot_thread_fn+0x655/0x9e0 kernel/smpboot.c:165
 kthread+0x3af/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
Modules linked in:
---[ end trace 6a25c5a071b6977e ]---
RIP: 0010:lbmIODone.cold+0x24/0x5b fs/jfs/jfs_logmgr.c:2312
Code: f8 e8 cb ff ff ff e8 ac 52 bd f8 48 c7 c1 40 ca 82 89 ba 08 09 00 00 48 c7 c6 c0 c9 82 89 48 c7 c7 00 ca 82 89 e8 7e ea fa ff <0f> 0b e8 86 52 bd f8 48 c7 c1 80 ca 82 89 ba 09 09 00 00 48 c7 c6
RSP: 0018:ffffc900004bfbb8 EFLAGS: 00010082
RAX: 000000000000003f RBX: ffff888012bf1b00 RCX: 0000000000000000
RDX: ffff888010b2c580 RSI: ffffffff8158f3e5 RDI: fffff52000097f69
RBP: 0000000000000020 R08: 000000000000003f R09: ffff88802cb30627
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000246
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88802cb00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000002d9aad8 CR3: 00000000691cf000 CR4: 0000000000350ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
