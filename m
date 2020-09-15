Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6996826AA76
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 19:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbgIORXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 13:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbgIOQdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 12:33:53 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A05C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 09:33:53 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id fa1so78829pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 09:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yQJJ5fmnUBk4QSqJ30BNJdZU/GsrsfsOL40Q6mFk9oY=;
        b=eyGMQUPsLE6QyjA/capur6QRDfCMT6VUycp01vtPwanFo9SmwhVNY/jBBQQVu3ffnA
         goXlTn+CmavCdTJfpCN5cGNQCMPw2MPClbYI5lY0vI2/LEX9DZnDc2perOTT3KpgI0eH
         SvlPrN1V4Mr6fBDPEHEpHwiIbiBxmp50z6bHvkfeAc+YEz3ceSv3yuc1D/NXGq8eUbYR
         XsJifyLnz0A83LqBrm8mqEtHtT0KhyowpCLIWad9KZ4cthOHzxGepjbA8QhkidSNF2Jf
         oHjfflb2aI0Khws0ZUj8jR9HwOXn7ITEKrdCIOeNfFaVM5UgheBOV242z6k6Ry8e7zlt
         5Ypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=yQJJ5fmnUBk4QSqJ30BNJdZU/GsrsfsOL40Q6mFk9oY=;
        b=QanV7HCcR56aUkejd6IFEWud8B4+C9vm/mv2bSu+/wIGOR4sL85jpXWr7fIP6zgAgY
         YmqbR53Enb0ecRrvwe7/AqQPVDFqH8iNT3GhhfwdtlKjSL0qLWiJLtH8LUH2pd989PCL
         SUHFWe5P8AtXOqDiopsGfW4CRw8GBFJ/i/sBfuSF4w6amnb92W5pLXyP3pWP5LkjFL4c
         Q+yn9nBMPBapXWbmmOUaSQFowoMsqzfCLelPc0Lm7pPZhao6OSn1RttTivqtvEwOEhhb
         RWqlf1qgVHkk4Ndaoz0/REGlihOkgKTkvzZsEF6f8b2t0ASh6RyW7yAGGTXIp5pOL+IR
         7Spw==
X-Gm-Message-State: AOAM532ItJKgcZVLTlNbbiKYhmtaXtbb4OSj60+XX+nqKR5os54GtFCA
        wmmJ2dcqtQnr3TMpG0GuujE=
X-Google-Smtp-Source: ABdhPJzxkgbzNgEI1pL2mjfZze8hPz9vaJ1pKh4S7QTvN92qSkUofQdvlKXn5SZSvQtRAF6eU7krjA==
X-Received: by 2002:a17:902:d897:b029:d1:e5f8:d263 with SMTP id b23-20020a170902d897b02900d1e5f8d263mr2298695plz.64.1600187632426;
        Tue, 15 Sep 2020 09:33:52 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id a18sm11778769pgw.50.2020.09.15.09.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 09:33:51 -0700 (PDT)
Date:   Tue, 15 Sep 2020 09:33:49 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     syzbot <syzbot+ecf80462cb7d5d552bc7@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, andreyknvl@google.com,
        hannes@cmpxchg.org, khalid.aziz@oracle.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        rppt@linux.ibm.com, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: general protection fault in madvise_cold_or_pageout_pte_range
Message-ID: <20200915163349.GA2868856@google.com>
References: <00000000000002a86f05af42ab27@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000002a86f05af42ab27@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 02:29:15AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    729e3d09 Merge tag 'ceph-for-5.9-rc5' of git://github.com/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1482b99e900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8f5c353182ed6199
> dashboard link: https://syzkaller.appspot.com/bug?extid=ecf80462cb7d5d552bc7
> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e2a255900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=164afdb3900000
> 
> The issue was bisected to:
> 
> commit 1a4e58cce84ee88129d5d49c064bd2852b481357
> Author: Minchan Kim <minchan@kernel.org>
> Date:   Wed Sep 25 23:49:15 2019 +0000
> 
>     mm: introduce MADV_PAGEOUT
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=127f973e900000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=117f973e900000
> console output: https://syzkaller.appspot.com/x/log.txt?x=167f973e900000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+ecf80462cb7d5d552bc7@syzkaller.appspotmail.com
> Fixes: 1a4e58cce84e ("mm: introduce MADV_PAGEOUT")
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
> RIP: 0033:0x4440e9
> Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db d7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffed62d6668 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
> RAX: ffffffffffffffda RBX: 00000000004002e0 RCX: 00000000004440e9
> RDX: 0000000000000015 RSI: 0000000000600003 RDI: 0000000020000000
> RBP: 00000000006ce018 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000004 R11: 0000000000000246 R12: 0000000000401d50
> R13: 0000000000401de0 R14: 0000000000000000 R15: 0000000000000000
> Modules linked in:
> ---[ end trace 0453ba4a30f03f10 ]---
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
> 


The backing vma was shmem. When I see the implemenation of __split_huge_pmd,
it looks like pmd zapping if vma is not vma_is_anonymous unlike anon vma
whereremapping pmd page to ptes.

commit d21b9e57c74c (HEAD)
Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Date:   Tue Jul 26 15:25:37 2016 -0700

    thp: handle file pages in split_huge_pmd()

    Splitting THP PMD is simple: just unmap it as in DAX case.  This way we
    can avoid memory overhead on page table allocation to deposit.

    It's probably a good idea to try to allocation page table with
    GFP_ATOMIC in __split_huge_pmd_locked() to avoid refaulting the area,
    but clearing pmd should be good enough for now.

    Unlike DAX, we also remove the page from rmap and drop reference.
    pmd_young() is transfered to PageReferenced().

If so, we need to check the pmd validation after splitting.
Ccing to Kirill for double check.

From 26e804a0723f92862aa1ee9cc2c9e5d4691cb11d Mon Sep 17 00:00:00 2001
From: Minchan Kim <minchan@kernel.org>
Date: Mon, 14 Sep 2020 23:32:15 -0700
Subject: [PATCH] mm: validate pmd after splitting

syzbot reported following.

general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 1 PID: 6826 Comm: syz-executor142 Not tainted 5.9.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__lock_acquire+0x84/0x2ae0 kernel/locking/lockdep.c:4296
Code: ff df 8a 04 30 84 c0 0f 85 e3 16 00 00 83 3d 56 58 35 08 00 0f 84 0e 17 00 00 83 3d 25 c7 f5 07 00 74 2c 4c 89 e8 48 c1 e8 03 <80> 3c 30 00 74 12 4c 89 ef e8 3e d1 5a 00 48 be 00 00 00 00 00 fc
RSP: 0018:ffffc90004b9f850 EFLAGS: 00010006
RAX: 0000000000000003 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 0000000000000018
RBP: ffffc90004b9f9a8 R08: 0000000000000001 R09: 0000000000000000
R10: fffffbfff131e2e6 R11: 0000000000000000 R12: ffff8880937161c0
R13: 0000000000000018 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000002638880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002100003f CR3: 00000000a49a2000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 lock_acquire+0x140/0x6f0 kernel/locking/lockdep.c:5006
 __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
 spin_lock include/linux/spinlock.h:354 [inline]
 madvise_cold_or_pageout_pte_range+0x52f/0x25c0 mm/madvise.c:389
 walk_pmd_range mm/pagewalk.c:89 [inline]
 walk_pud_range mm/pagewalk.c:160 [inline]
 walk_p4d_range mm/pagewalk.c:193 [inline]
 walk_pgd_range mm/pagewalk.c:229 [inline]
 __walk_page_range+0xe7b/0x1da0 mm/pagewalk.c:331
 walk_page_range+0x2c3/0x5c0 mm/pagewalk.c:427
 madvise_pageout_page_range mm/madvise.c:521 [inline]
 madvise_pageout mm/madvise.c:557 [inline]
 madvise_vma mm/madvise.c:946 [inline]
 do_madvise+0x12d0/0x2090 mm/madvise.c:1145
 __do_sys_madvise mm/madvise.c:1171 [inline]
 __se_sys_madvise mm/madvise.c:1169 [inline]
 __x64_sys_madvise+0x76/0x80 mm/madvise.c:1169
 do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

In case of split page of file-backed THP, it zaps the pmd instead of
remapping of sub-pages so need to check pmd validity after split.

Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reported-by: syzbot+ecf80462cb7d5d552bc7@syzkaller.appspotmail.com
Fixes: 1a4e58cce84e ("mm: introduce MADV_PAGEOUT")
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/madvise.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index d4aa5f776543..0e0d61003fc6 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -381,9 +381,9 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		return 0;
 	}
 
+regular_page:
 	if (pmd_trans_unstable(pmd))
 		return 0;
-regular_page:
 #endif
 	tlb_change_page_size(tlb, PAGE_SIZE);
 	orig_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
-- 
2.28.0.618.gf4bc123cb7-goog

