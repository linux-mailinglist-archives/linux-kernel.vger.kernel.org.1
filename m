Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45ED2797FE
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 10:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbgIZIhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 04:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgIZIhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 04:37:02 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DCAC0613D3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 01:37:02 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id k25so4382416ljk.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 01:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/64NizlY3R+1W750Sl6lz5cA5HBaWEobJaIJmjYldGo=;
        b=yfzae14yYhwMQfd3WD3qe1349qRgTw1ShsvjWGX3l322K/dPRT2MSrR2B2uIe1W2/n
         p3bC8+verF00Y6aLLnW7InT1C50Ru+lpmoy3H4ZzteNWY/Vp7uk+HPleOBdIWxF05a3b
         JnpG/wRxsrE/eDSHI5nU+gX7baC1ldTBGuz3Ef/N2HwoByZ2yEUmqGpmaYbKiEHVlGQN
         0tDE7eqEXpArDAmNOg9aTTWiTyH4qGuVCwboESXyOR/Fpkt0wdl7vsn2il3q5ZmlO1oi
         ydvQcpKugPMGy+Ez7sRMklpAU5K8IYm9+H9VQ3dCk+dyIu5oKwUePUHqngvyjHjX8H3Y
         69qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/64NizlY3R+1W750Sl6lz5cA5HBaWEobJaIJmjYldGo=;
        b=mwcexrd/Ey3CnTk6oXcRVAjHqo5ls8Dp6VQ85iJKSQw878i85BsohyOZsIBijhXVnz
         s1tGaSPjMsL0xNc1XWRtuTe+0REq4GVzx923lUuFqa6NhI6GEVBmCYajRxr0Esg1mmAe
         BCxsYmVfIQVCYO4f+cUAd0IiFkrLivM6t4lgQGi1gvwGZ+/gIrhV1QNCDEQJ6l/hMALF
         qwfOB3XvBKyoB9MEnUr4ZSIZC1P2bK7XSpIeK32FR2+oBXzTyXWLyAYlAxZGB8+VBtf6
         jdzzuyLPxzF6mjTM4h/xa3GcIdf/mjtW1XOx4tK6xBZeDlzqm4hOeSmnkl5Nz31VMfec
         OlEQ==
X-Gm-Message-State: AOAM530QX/sNFlU5srCe3dp0G5bYiuvHB5ybSGXyPI/D65gFGZD2Hpw0
        bcVDXDgim9K0ceDggnx8mQfr8g==
X-Google-Smtp-Source: ABdhPJw3Mqybd4yx2R38riFZT66dxjqqoQpyeX778yhpNnlGbXi9CF22JXJhUTf4FD/rIQPSj92yaA==
X-Received: by 2002:a2e:9103:: with SMTP id m3mr2303689ljg.94.1601109420662;
        Sat, 26 Sep 2020 01:37:00 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id y9sm1183004lfg.293.2020.09.26.01.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 01:36:59 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id E2855101F6D; Sat, 26 Sep 2020 11:36:59 +0300 (+03)
Date:   Sat, 26 Sep 2020 11:36:59 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Minchan Kim <minchan@kernel.org>
Cc:     syzbot <syzbot+ecf80462cb7d5d552bc7@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, andreyknvl@google.com,
        hannes@cmpxchg.org, khalid.aziz@oracle.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        rppt@linux.ibm.com, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org
Subject: Re: general protection fault in madvise_cold_or_pageout_pte_range
Message-ID: <20200926083659.z2ma5puug3atufs3@box>
References: <00000000000002a86f05af42ab27@google.com>
 <20200915163349.GA2868856@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915163349.GA2868856@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 09:33:49AM -0700, Minchan Kim wrote:
> On Mon, Sep 14, 2020 at 02:29:15AM -0700, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    729e3d09 Merge tag 'ceph-for-5.9-rc5' of git://github.com/..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1482b99e900000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=8f5c353182ed6199
> > dashboard link: https://syzkaller.appspot.com/bug?extid=ecf80462cb7d5d552bc7
> > compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e2a255900000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=164afdb3900000
> > 
> > The issue was bisected to:
> > 
> > commit 1a4e58cce84ee88129d5d49c064bd2852b481357
> > Author: Minchan Kim <minchan@kernel.org>
> > Date:   Wed Sep 25 23:49:15 2019 +0000
> > 
> >     mm: introduce MADV_PAGEOUT
> > 
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=127f973e900000
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=117f973e900000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=167f973e900000
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+ecf80462cb7d5d552bc7@syzkaller.appspotmail.com
> > Fixes: 1a4e58cce84e ("mm: introduce MADV_PAGEOUT")
> > 
> > general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN
> > KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
> > CPU: 1 PID: 6826 Comm: syz-executor142 Not tainted 5.9.0-rc4-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > RIP: 0010:__lock_acquire+0x84/0x2ae0 kernel/locking/lockdep.c:4296
> > Code: ff df 8a 04 30 84 c0 0f 85 e3 16 00 00 83 3d 56 58 35 08 00 0f 84 0e 17 00 00 83 3d 25 c7 f5 07 00 74 2c 4c 89 e8 48 c1 e8 03 <80> 3c 30 00 74 12 4c 89 ef e8 3e d1 5a 00 48 be 00 00 00 00 00 fc
> > RSP: 0018:ffffc90004b9f850 EFLAGS: 00010006
> > RAX: 0000000000000003 RBX: 0000000000000001 RCX: 0000000000000000
> > RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 0000000000000018
> > RBP: ffffc90004b9f9a8 R08: 0000000000000001 R09: 0000000000000000
> > R10: fffffbfff131e2e6 R11: 0000000000000000 R12: ffff8880937161c0
> > R13: 0000000000000018 R14: 0000000000000000 R15: 0000000000000000
> > FS:  0000000002638880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 000000002100003f CR3: 00000000a49a2000 CR4: 00000000001506e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  lock_acquire+0x140/0x6f0 kernel/locking/lockdep.c:5006
> >  __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
> >  _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
> >  spin_lock include/linux/spinlock.h:354 [inline]
> >  madvise_cold_or_pageout_pte_range+0x52f/0x25c0 mm/madvise.c:389
> >  walk_pmd_range mm/pagewalk.c:89 [inline]
> >  walk_pud_range mm/pagewalk.c:160 [inline]
> >  walk_p4d_range mm/pagewalk.c:193 [inline]
> >  walk_pgd_range mm/pagewalk.c:229 [inline]
> >  __walk_page_range+0xe7b/0x1da0 mm/pagewalk.c:331
> >  walk_page_range+0x2c3/0x5c0 mm/pagewalk.c:427
> >  madvise_pageout_page_range mm/madvise.c:521 [inline]
> >  madvise_pageout mm/madvise.c:557 [inline]
> >  madvise_vma mm/madvise.c:946 [inline]
> >  do_madvise+0x12d0/0x2090 mm/madvise.c:1145
> >  __do_sys_madvise mm/madvise.c:1171 [inline]
> >  __se_sys_madvise mm/madvise.c:1169 [inline]
> >  __x64_sys_madvise+0x76/0x80 mm/madvise.c:1169
> >  do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
> >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > RIP: 0033:0x4440e9
> > Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db d7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> > RSP: 002b:00007ffed62d6668 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
> > RAX: ffffffffffffffda RBX: 00000000004002e0 RCX: 00000000004440e9
> > RDX: 0000000000000015 RSI: 0000000000600003 RDI: 0000000020000000
> > RBP: 00000000006ce018 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000004 R11: 0000000000000246 R12: 0000000000401d50
> > R13: 0000000000401de0 R14: 0000000000000000 R15: 0000000000000000
> > Modules linked in:
> > ---[ end trace 0453ba4a30f03f10 ]---
> > RIP: 0010:__lock_acquire+0x84/0x2ae0 kernel/locking/lockdep.c:4296
> > Code: ff df 8a 04 30 84 c0 0f 85 e3 16 00 00 83 3d 56 58 35 08 00 0f 84 0e 17 00 00 83 3d 25 c7 f5 07 00 74 2c 4c 89 e8 48 c1 e8 03 <80> 3c 30 00 74 12 4c 89 ef e8 3e d1 5a 00 48 be 00 00 00 00 00 fc
> > RSP: 0018:ffffc90004b9f850 EFLAGS: 00010006
> > RAX: 0000000000000003 RBX: 0000000000000001 RCX: 0000000000000000
> > RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 0000000000000018
> > RBP: ffffc90004b9f9a8 R08: 0000000000000001 R09: 0000000000000000
> > R10: fffffbfff131e2e6 R11: 0000000000000000 R12: ffff8880937161c0
> > R13: 0000000000000018 R14: 0000000000000000 R15: 0000000000000000
> > FS:  0000000002638880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 000000002100003f CR3: 00000000a49a2000 CR4: 00000000001506e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > 
> 
> 
> The backing vma was shmem. When I see the implemenation of __split_huge_pmd,
> it looks like pmd zapping if vma is not vma_is_anonymous unlike anon vma
> whereremapping pmd page to ptes.
> 
> commit d21b9e57c74c (HEAD)
> Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Date:   Tue Jul 26 15:25:37 2016 -0700
> 
>     thp: handle file pages in split_huge_pmd()
> 
>     Splitting THP PMD is simple: just unmap it as in DAX case.  This way we
>     can avoid memory overhead on page table allocation to deposit.
> 
>     It's probably a good idea to try to allocation page table with
>     GFP_ATOMIC in __split_huge_pmd_locked() to avoid refaulting the area,
>     but clearing pmd should be good enough for now.
> 
>     Unlike DAX, we also remove the page from rmap and drop reference.
>     pmd_young() is transfered to PageReferenced().
> 
> If so, we need to check the pmd validation after splitting.
> Ccing to Kirill for double check.
> 
> From 26e804a0723f92862aa1ee9cc2c9e5d4691cb11d Mon Sep 17 00:00:00 2001
> From: Minchan Kim <minchan@kernel.org>
> Date: Mon, 14 Sep 2020 23:32:15 -0700
> Subject: [PATCH] mm: validate pmd after splitting
> 
> syzbot reported following.
> 
> general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
> CPU: 1 PID: 6826 Comm: syz-executor142 Not tainted 5.9.0-rc4-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:__lock_acquire+0x84/0x2ae0 kernel/locking/lockdep.c:4296
> Code: ff df 8a 04 30 84 c0 0f 85 e3 16 00 00 83 3d 56 58 35 08 00 0f 84 0e 17 00 00 83 3d 25 c7 f5 07 00 74 2c 4c 89 e8 48 c1 e8 03 <80> 3c 30 00 74 12 4c 89 ef e8 3e d1 5a 00 48 be 00 00 00 00 00 fc
> RSP: 0018:ffffc90004b9f850 EFLAGS: 00010006
> RAX: 0000000000000003 RBX: 0000000000000001 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 0000000000000018
> RBP: ffffc90004b9f9a8 R08: 0000000000000001 R09: 0000000000000000
> R10: fffffbfff131e2e6 R11: 0000000000000000 R12: ffff8880937161c0
> R13: 0000000000000018 R14: 0000000000000000 R15: 0000000000000000
> FS:  0000000002638880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000002100003f CR3: 00000000a49a2000 CR4: 00000000001506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  lock_acquire+0x140/0x6f0 kernel/locking/lockdep.c:5006
>  __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
>  _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
>  spin_lock include/linux/spinlock.h:354 [inline]
>  madvise_cold_or_pageout_pte_range+0x52f/0x25c0 mm/madvise.c:389
>  walk_pmd_range mm/pagewalk.c:89 [inline]
>  walk_pud_range mm/pagewalk.c:160 [inline]
>  walk_p4d_range mm/pagewalk.c:193 [inline]
>  walk_pgd_range mm/pagewalk.c:229 [inline]
>  __walk_page_range+0xe7b/0x1da0 mm/pagewalk.c:331
>  walk_page_range+0x2c3/0x5c0 mm/pagewalk.c:427
>  madvise_pageout_page_range mm/madvise.c:521 [inline]
>  madvise_pageout mm/madvise.c:557 [inline]
>  madvise_vma mm/madvise.c:946 [inline]
>  do_madvise+0x12d0/0x2090 mm/madvise.c:1145
>  __do_sys_madvise mm/madvise.c:1171 [inline]
>  __se_sys_madvise mm/madvise.c:1169 [inline]
>  __x64_sys_madvise+0x76/0x80 mm/madvise.c:1169
>  do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> In case of split page of file-backed THP, it zaps the pmd instead of
> remapping of sub-pages so need to check pmd validity after split.
> 
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reported-by: syzbot+ecf80462cb7d5d552bc7@syzkaller.appspotmail.com
> Fixes: 1a4e58cce84e ("mm: introduce MADV_PAGEOUT")
> Signed-off-by: Minchan Kim <minchan@kernel.org>

That's correct fix. I've come up with the same one.

But it would be nice to trim the commit message. There's a lot of
unrelated info in the dump.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

> ---
>  mm/madvise.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index d4aa5f776543..0e0d61003fc6 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -381,9 +381,9 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  		return 0;
>  	}
>  
> +regular_page:
>  	if (pmd_trans_unstable(pmd))
>  		return 0;
> -regular_page:
>  #endif
>  	tlb_change_page_size(tlb, PAGE_SIZE);
>  	orig_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
> -- 
> 2.28.0.618.gf4bc123cb7-goog
> 

-- 
 Kirill A. Shutemov
