Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519EB2C1C28
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 04:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgKXDmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 22:42:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:43208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbgKXDmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 22:42:32 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7445020857;
        Tue, 24 Nov 2020 03:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1606189351;
        bh=NOfCsv/YXXhVyGt2Kvus7SwHhbMMgHytZAwpTGpbP1A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dSncuCME1df9nPGIAKe1Il9qlXmqUITCmBKzTnQLqfTyT/o97OW4p4jsVfzZSxRSt
         Itzg6RGRFfb6MDkUofsiWFRomKRHd7h8B/d8DAEj3N6umKgyFXza4sgZeHpVUjp0F9
         LWccMbCvLeVwt+KeUXTYTlpdCwPEmsV/fVeQRQQk=
Date:   Mon, 23 Nov 2020 19:42:30 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     syzbot <syzbot+dcb847a3e1e0ecd191ab@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: kernel BUG at include/linux/highmem.h:LINE!
Message-Id: <20201123194230.f59c93eba3cf356c632eb1c0@linux-foundation.org>
In-Reply-To: <000000000000f6914405b49d9c9d@google.com>
References: <000000000000f6914405b49d9c9d@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Nov 2020 05:05:19 -0800 syzbot <syzbot+dcb847a3e1e0ecd191ab@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    7c8ca812 Add linux-next specific files for 20201117
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=16ea946a500000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ff4bc71371dc5b13
> dashboard link: https://syzkaller.appspot.com/bug?extid=dcb847a3e1e0ecd191ab
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14530c7a500000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=137c581c500000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+dcb847a3e1e0ecd191ab@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> kernel BUG at include/linux/highmem.h:202!

Thomas has changed the highmem code (well, kmap) quite a bit.  But I
don't think that's the culprit here.

> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 8526 Comm: syz-executor603 Not tainted 5.10.0-rc4-next-20201117-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:zero_user_segments include/linux/highmem.h:202 [inline]
> RIP: 0010:zero_user include/linux/highmem.h:223 [inline]
> RIP: 0010:truncate_inode_partial_page+0x5aa/0x720 mm/truncate.c:264
> Code: bc 01 00 00 00 e8 e6 f8 ff ff e9 e7 fe ff ff e8 2c 12 d8 ff 48 c7 c6 00 44 54 89 48 89 ef e8 dd b5 08 00 0f 0b e8 16 12 d8 ff <0f> 0b e8 0f 12 d8 ff 48 c7 c6 80 44 54 89 48 89 ef e8 c0 b5 08 00
> RSP: 0018:ffffc90000f8fa00 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000200000 RCX: ffffffff81987fe1
> RDX: ffff88801e614f80 RSI: ffffffff819882ca RDI: 0000000000000005
> RBP: ffffea0000c70000 R08: 0000000000000000 R09: ffffea0000c70007
> R10: 0000000000001000 R11: 0000000000000000 R12: 00000000001ffffa
> R13: 00000000001ffffa R14: 0000000000000006 R15: ffffea0000c70008
> FS:  0000000000e30880(0000) GS:ffff8880b9e00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000000043e920 CR3: 00000000228a7000 CR4: 00000000001506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  shmem_undo_range+0x6fd/0x18f0 mm/shmem.c:921
>  shmem_truncate_range mm/shmem.c:999 [inline]
>  shmem_setattr+0x67a/0xc70 mm/shmem.c:1058
>  notify_change+0xb60/0x10a0 fs/attr.c:336
>  do_truncate+0x134/0x1f0 fs/open.c:64
>  vfs_truncate+0x49e/0x600 fs/open.c:110
>  do_sys_truncate.part.0+0x11e/0x140 fs/open.c:133
>  do_sys_truncate fs/open.c:127 [inline]
>  __do_sys_truncate fs/open.c:145 [inline]
>  __se_sys_truncate fs/open.c:143 [inline]
>  __x64_sys_truncate+0x69/0x90 fs/open.c:143
>  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Matthew's series "Overhaul multi-page lookups for THP" chnages the
shmem code quite a bit, and in the area of truncate.  Matthew, could
you please fire up that reproducer?

> RIP: 0033:0x444109
> Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db d7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffec4a90088 EFLAGS: 00000246 ORIG_RAX: 000000000000004c
> RAX: ffffffffffffffda RBX: 00000000004002e0 RCX: 0000000000444109
> RDX: 0000000000444109 RSI: 0000000000000006 RDI: 0000000020000040
> RBP: 00000000006ce018 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000005 R11: 0000000000000246 R12: 0000000000401d70
> R13: 0000000000401e00 R14: 0000000000000000 R15: 0000000000000000
> Modules linked in:
> ---[ end trace 910e59f95b39ab18 ]---
> RIP: 0010:zero_user_segments include/linux/highmem.h:202 [inline]
> RIP: 0010:zero_user include/linux/highmem.h:223 [inline]
> RIP: 0010:truncate_inode_partial_page+0x5aa/0x720 mm/truncate.c:264
> Code: bc 01 00 00 00 e8 e6 f8 ff ff e9 e7 fe ff ff e8 2c 12 d8 ff 48 c7 c6 00 44 54 89 48 89 ef e8 dd b5 08 00 0f 0b e8 16 12 d8 ff <0f> 0b e8 0f 12 d8 ff 48 c7 c6 80 44 54 89 48 89 ef e8 c0 b5 08 00
> RSP: 0018:ffffc90000f8fa00 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000200000 RCX: ffffffff81987fe1
> RDX: ffff88801e614f80 RSI: ffffffff819882ca RDI: 0000000000000005
> RBP: ffffea0000c70000 R08: 0000000000000000 R09: ffffea0000c70007
> R10: 0000000000001000 R11: 0000000000000000 R12: 00000000001ffffa
> R13: 00000000001ffffa R14: 0000000000000006 R15: ffffea0000c70008
> FS:  0000000000e30880(0000) GS:ffff8880b9e00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000000043e920 CR3: 00000000228a7000 CR4: 00000000001506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
