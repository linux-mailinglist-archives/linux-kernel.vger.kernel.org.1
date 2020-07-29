Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09EA232715
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 23:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgG2Voi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 17:44:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:43820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727788AbgG2Voi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 17:44:38 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AE67207F5;
        Wed, 29 Jul 2020 21:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596059077;
        bh=msuxD56fsXFg0kmBAnfheBGKsXJCXkIQLb1xpodpa6c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=09LBOV6He9vhIEI0Yf8p+ppx25tUAcZXarv6PqC+kgoQ02xOtuiI4eBDq+t/FJdc0
         fuVkypVtmp1ZapaiVM0+1jOSy9RricnNIqQM+SS32zgqc2NVtQ88CjM89hQ3Bwm6BL
         IdP1+mhvtfsCyAeZb6aJYwKsBjjBvUf6CRhfSHlw=
Date:   Wed, 29 Jul 2020 14:44:36 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     syzbot <syzbot+f62749569eab36774dc5@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: kernel BUG at mm/internal.h:LINE! (2)
Message-Id: <20200729144436.297734bd08344414d20e9645@linux-foundation.org>
In-Reply-To: <000000000000c276c005ab9a0fb1@google.com>
References: <000000000000c276c005ab9a0fb1@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jul 2020 13:04:21 -0700 syzbot <syzbot+f62749569eab36774dc5@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    68845a55 Merge branch 'akpm' into master (patches from And..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17c86c54900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f87a5e4232fdb267
> dashboard link: https://syzkaller.appspot.com/bug?extid=f62749569eab36774dc5
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+f62749569eab36774dc5@syzkaller.appspotmail.com
> 
> vma ffff888000153210 start 0007700000077000 end 0000000000077000
> next 0007700000000000 prev 0000000007070707 mm 0007700000000000
> prot 77700000077000 anon_vma 0000000000000000 vm_ops ffffffff885cecc0
> pgoff 0 file ffff88809e09a7c0 private_data 0000000000000000
> flags: 0x0()

Well that is one messed up VMA.  Something in the kernel scribbled on
some memory.  Possibly scribbled on the vma itself, possibly scribbled
somewhere in the pointer chase which led us to the vma.

Interestingly, vm_ops (0xffffffff885cecc0) appears to be a valid
address.  Would it be possible to look up that symbol in your kernel,
see if it points at something interesting?

But don't try too hard - I doubt if we'll learn much from it :(

> ------------[ cut here ]------------
> kernel BUG at mm/internal.h:401!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 1676 Comm: kswapd0 Not tainted 5.8.0-rc6-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:vma_address mm/internal.h:401 [inline]
> RIP: 0010:vma_address mm/internal.h:393 [inline]
> RIP: 0010:rmap_walk_file+0x6a4/0xbf0 mm/rmap.c:1921
> Code: e8 91 20 cc ff 48 83 eb 01 48 89 e8 48 29 d8 48 c1 f8 06 48 01 44 24 18 e9 1a fb ff ff e8 74 20 cc ff 4c 89 e7 e8 95 e3 f9 ff <0f> 0b e8 65 20 cc ff 48 8b 44 24 10 4c 8d 68 78 4c 89 ef e8 b4 8a
> RSP: 0018:ffffc90006987598 EFLAGS: 00010287
> RAX: 000000000000010f RBX: 000770000019e000 RCX: 0000000000000000
> RDX: ffff8880a425e540 RSI: ffffffff815d4eb7 RDI: fffff52000d30e8e
> RBP: ffffea00021eac40 R08: 000000000000010f R09: ffff8880ae6318e7
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff888000153210
> R13: dffffc0000000000 R14: 0007700000077000 R15: 0000000000077000
> FS:  0000000000000000(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000788070 CR3: 000000020b00c000 CR4: 00000000001426f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  rmap_walk+0x105/0x190 mm/rmap.c:1946
>  page_referenced+0x417/0x4b0 mm/rmap.c:888
>  shrink_active_list+0x3a6/0x1350 mm/vmscan.c:2061
>  shrink_list mm/vmscan.c:2167 [inline]
>  shrink_lruvec+0x842/0x10f0 mm/vmscan.c:2467
>  shrink_node_memcgs mm/vmscan.c:2656 [inline]
>  shrink_node+0x4b0/0x1b60 mm/vmscan.c:2770
>  kswapd_shrink_node mm/vmscan.c:3517 [inline]
>  balance_pgdat+0x72f/0x10d0 mm/vmscan.c:3675
>  kswapd+0x5a5/0xe70 mm/vmscan.c:3932
>  kthread+0x3b5/0x4a0 kernel/kthread.c:291
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293
>
> ...
>
