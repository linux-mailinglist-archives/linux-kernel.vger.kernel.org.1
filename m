Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1704E2D0305
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 11:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbgLFKwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 05:52:51 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:41385 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgLFKwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 05:52:50 -0500
Received: by mail-io1-f69.google.com with SMTP id v21so7390397iol.8
        for <linux-kernel@vger.kernel.org>; Sun, 06 Dec 2020 02:52:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=RtKCf1BHb9m9+5vtHLsgsBlaX/jO4yFmes7RmdsLhfg=;
        b=EeZbyiGdUfWDfGalY4rsbhWA+9AoTt7AiDVylSVmY6Mxld0OaBY95hokFPc5qYbRcH
         QgPETmsiXCUTgIqotdfR2myDh1yxGBg4nDFZPLFNyvIVi1D6NUghoSTSI5mk1IDh+m9J
         8/ywiHExJRSrleICNuO/++UTC4cT2+9rha/RcB1mWdVznCHhk3IaZYq+Yswe1FJjQqdK
         K6RWO6LwkSEOe5zjxxXlTxw/H6Xj92m4SVtC6h9/e3WS4G1E9RfkKVqw08bh08SQeoVM
         Oju6m4HuENXBJcxCol4mDxkvPVk7N9qvwLjzBZhuE3IQ1iGXzioANkvihWM3EIbCdoES
         Ar0Q==
X-Gm-Message-State: AOAM532dZzodAIPinWUYeLaPazD+IQLgT/kSU9F+a00nzxp1V+ZZYNI2
        k/MiK7VuBM/7n7+GZEcfN3E7XV4kVQTDlBdelLgO7x9/mDnq
X-Google-Smtp-Source: ABdhPJw15iksimG2cP2A5NCC75wbxRwbsnn26ZmqNYIkqdFIKwi/MvzGW11U5QmfTArX18YATB4jOPO44beb16EY11R6e3ttgddw
MIME-Version: 1.0
X-Received: by 2002:a92:c682:: with SMTP id o2mr779659ilg.97.1607251929424;
 Sun, 06 Dec 2020 02:52:09 -0800 (PST)
Date:   Sun, 06 Dec 2020 02:52:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005168bf05b5c980b8@google.com>
Subject: kernel BUG at mm/internal.h:LINE! (3)
From:   syzbot <syzbot+9e1bcf66d5e11d021793@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    509a1542 Merge tag '5.10-rc6-smb3-fixes' of git://git.samb..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=123d9a55500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e49433cfed49b7d9
dashboard link: https://syzkaller.appspot.com/bug?extid=9e1bcf66d5e11d021793
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9e1bcf66d5e11d021793@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at mm/internal.h:400!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 28126 Comm: kworker/u4:0 Not tainted 5.10.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: writeback wb_workfn (flush-8:0)
RIP: 0010:vma_address mm/internal.h:400 [inline]
RIP: 0010:vma_address mm/internal.h:392 [inline]
RIP: 0010:rmap_walk_file+0x6b4/0xbf0 mm/rmap.c:1923
Code: f8 06 48 01 44 24 18 e9 1b fb ff ff e8 25 1c ca ff 4c 8d bb 00 f0 1f 00 e9 92 fd ff ff e8 14 1c ca ff 4c 89 e7 e8 95 bb 07 07 <0f> 0b e8 05 1c ca ff 48 8b 44 24 10 4c 8d 68 78 4c 89 ef e8 f4 a5
RSP: 0018:ffffc9001656efb8 EFLAGS: 00010283
RAX: 0000000000000154 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff8880702f8000 RSI: ffffffff8158c855 RDI: fffff52002caddd2
RBP: ffffea00014ef380 R08: 0000000000000154 R09: ffff8880b9e30627
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888000129318
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000052df4c CR3: 000000016e143000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 rmap_walk+0x105/0x190 mm/rmap.c:1948
 page_mkclean+0x21c/0x2b0 mm/rmap.c:998
 clear_page_dirty_for_io+0x318/0xbe0 mm/page-writeback.c:2698
 mpage_submit_page+0x80/0x2c0 fs/ext4/inode.c:2072
 mpage_process_page_bufs+0x656/0x780 fs/ext4/inode.c:2206
 mpage_prepare_extent_to_map+0x904/0xe00 fs/ext4/inode.c:2618
 ext4_writepages+0x95f/0x38a0 fs/ext4/inode.c:2746
 do_writepages+0xec/0x290 mm/page-writeback.c:2352
 __writeback_single_inode+0x122/0x1180 fs/fs-writeback.c:1461
 writeback_sb_inodes+0x53d/0xef0 fs/fs-writeback.c:1721
 __writeback_inodes_wb+0xc6/0x280 fs/fs-writeback.c:1790
 wb_writeback+0x814/0xc40 fs/fs-writeback.c:1896
 wb_check_old_data_flush fs/fs-writeback.c:1998 [inline]
 wb_do_writeback fs/fs-writeback.c:2051 [inline]
 wb_workfn+0x891/0x12d0 fs/fs-writeback.c:2080
 process_one_work+0x933/0x15a0 kernel/workqueue.c:2272
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2418
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
Modules linked in:
---[ end trace 5d185e0c163f88c9 ]---
RIP: 0010:vma_address mm/internal.h:400 [inline]
RIP: 0010:vma_address mm/internal.h:392 [inline]
RIP: 0010:rmap_walk_file+0x6b4/0xbf0 mm/rmap.c:1923
Code: f8 06 48 01 44 24 18 e9 1b fb ff ff e8 25 1c ca ff 4c 8d bb 00 f0 1f 00 e9 92 fd ff ff e8 14 1c ca ff 4c 89 e7 e8 95 bb 07 07 <0f> 0b e8 05 1c ca ff 48 8b 44 24 10 4c 8d 68 78 4c 89 ef e8 f4 a5
RSP: 0018:ffffc9001656efb8 EFLAGS: 00010283
RAX: 0000000000000154 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff8880702f8000 RSI: ffffffff8158c855 RDI: fffff52002caddd2
RBP: ffffea00014ef380 R08: 0000000000000154 R09: ffff8880b9e30627
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888000129318
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000749138 CR3: 0000000013a93000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
