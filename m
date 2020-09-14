Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE9452696D0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 22:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgINUic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 16:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgINUi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 16:38:28 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CD9C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 13:38:28 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id kk9so506459pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 13:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=buEiFiqSMKWZbMoNpmJsFjFaGJivnld+lGWUepGeL9g=;
        b=UGyqbWzqEO0uyKdAw8DSpSCLJxQ8TMoNTekIvldk1LP1JLlV6RkCohDqyWrk6stvDg
         bFM8XTta5WUrWim6jXuJ6N5+zpYauY+eRzbUL0p90bSdzWMWFftowwsFjO2GM93q5Rkr
         8eQVJoMJZbIgv8TZTmgyWrPRE2Juo95y2AXwbeRnEDMctRdsmcyniZI6xVTI6VfcILLj
         AtmRTMMkuISkqArmSD5jLT/Rf2Ln5Nu3OfXsdXg8cfN5OLjTUAtVYFCc1fEPQhviGorc
         +o0YXbbH4NdxkxLS4pD+/0TkMPUdoW+a62Ol2JUewz/3H2z/USuItXbrvgfz8fMu5z6Q
         CAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=buEiFiqSMKWZbMoNpmJsFjFaGJivnld+lGWUepGeL9g=;
        b=ebXQ0dSm5jlxoRVbxc5WLoUZ58pBg5nXjDBnvLsqBk8XXZ9kEdWWT1Zl12jKMIyUOu
         pDs/YUBlMGKmsmzJ9TT2ReDBgL2lfYI9kLWdoks4OBfH6KDUUGHJQ3JRXYDNkWDuotyI
         Z+KWviJLhdYepfdi3s0xEUcveIfbT5hRFi5b5Y7OFn2J3/ESj0FOSKXshaLJK+llbzUW
         nj+Ra2VcPbEYFcV7NmyJ/J7b0IinrW0x29wtKmp34DArfZjUh3Q8QVyYpVHsnS1nQ8Rd
         ux7Ew0yaB8DhdPgM0SKBoyAO1nvT3uri0Ef1BMZB5jS5nncmeuAMaFh0Dnwv/Z5Pvk/d
         Simg==
X-Gm-Message-State: AOAM533ytbIMnD+QhbVXXDg3YbiAufvUTuehJKb4Q4lzFx4zcJYvF2XT
        4qHqCQlYDyXjQ+3bFzXOTU4=
X-Google-Smtp-Source: ABdhPJz/S4gXFMIIlebGj6+a9mBCbtR5TNFdNCGIK6pdVitshuy3jFlp5HHM+IxT1g5DEBhfxUSWeg==
X-Received: by 2002:a17:902:8491:b029:d1:9bd3:6653 with SMTP id c17-20020a1709028491b02900d19bd36653mr16315779plo.1.1600115907703;
        Mon, 14 Sep 2020 13:38:27 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id i25sm9542117pgi.9.2020.09.14.13.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 13:38:26 -0700 (PDT)
Date:   Mon, 14 Sep 2020 13:38:24 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     syzbot <syzbot+ecf80462cb7d5d552bc7@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, andreyknvl@google.com,
        hannes@cmpxchg.org, khalid.aziz@oracle.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        rppt@linux.ibm.com, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org
Subject: Re: general protection fault in madvise_cold_or_pageout_pte_range
Message-ID: <20200914203824.GA2525005@google.com>
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

It's the bug to access pmd again after split_huge_page of the pmd so pmd
would be NULL. Let me look at it.

Thanks.
