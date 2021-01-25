Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E16EA3020D5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 04:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbhAYD07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 22:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbhAYD05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 22:26:57 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D68C061573
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 19:26:16 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id p13so13593555ljg.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 19:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=3HY6TVcvjdmITu7NxPbrOIZGq7qwtX0T1kRv9TPCzZY=;
        b=ojAsSNPKwYr/RPQrYBs0AnWbgDbUcsgOdVtKbDpn0zdokAfJRa9K0aWPPrGcRTfYSN
         fPCL1x3WDE1+AuCP6/GKmC6UauIE2Li/oHT0WNNxtkFceGkW5Os0kcXHB4DYBrQ6ZKBe
         hDHWJOxLvRzclBj6Mg0ha9oEnZrwAs3H0ddHtT96EKC8SZParvMqIsXk2QR8xJOvJa3j
         iaeYeXOkvhCO+zvx2ocxBIk5AsLESs28GLzbX8sYOlBkyOUbgLfgcV2W7CWUfuuA+dql
         H6ZhAp7f99JWIttDkAuvPwR8h0AtmdJ3+NFkcIdKGNJnyIv+gIeQGn0uR3peCBHd+B4G
         Y5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3HY6TVcvjdmITu7NxPbrOIZGq7qwtX0T1kRv9TPCzZY=;
        b=nL3H+o96hosFAOljEFVd1XORfG5Hay8i8qiK5KlUhqN53UigZFNDaj0ntL2P/SmkgT
         NSqbiiKMGW5f8NUSuovqzn0nOhm4asP5mTPZ8BMUtQyxC+2zPif+NFIjawQAW4IhuBEb
         IIxycGHlN1w6UCj4Ae86VL2H2eIL+XhCCSxJnKeH3CWdlDP0SPL6sydLyqrfF6fVrvLp
         jT7KaFfZ1bR0rYVItsPPhQTUn1ebovtoH2Kgyk+XWUoLw33NC2CnR/1rQBIljjWUZRtb
         WUANcYfcTwdL/f5VGkzCENjosZndpQBqkhOB8cdYDUM2BO286feyNmyyYfzugO+Rr1Fp
         p9TA==
X-Gm-Message-State: AOAM5304DWmFLbG5Yv/RHF7pApoD0KD13JUoImrGihKop6pUKMQJmaDp
        z94xXfOt19IUFnU7ncO+GrI=
X-Google-Smtp-Source: ABdhPJz2iFcJQ5OwjK8R/Sk0z9QtqTK4oNXtnYsWh3aSk+XLcKphSz45sM79VhbOE7b/DMmNuRSRBw==
X-Received: by 2002:a2e:8995:: with SMTP id c21mr319656lji.251.1611545175543;
        Sun, 24 Jan 2021 19:26:15 -0800 (PST)
Received: from localhost.localdomain ([2a03:5342:f:6::2])
        by smtp.gmail.com with ESMTPSA id x144sm940533lff.89.2021.01.24.19.26.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jan 2021 19:26:14 -0800 (PST)
Subject: Re: kernel BUG in split_huge_page_to_list
To:     syzbot <syzbot+9b83ff893245a25c320e@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com
References: <000000000000c21dd605b9a42d3f@google.com>
From:   Li Xinhai <lixinhai.lxh@gmail.com>
Message-ID: <1c9aa71b-51bf-eb17-4521-4cbe602f296c@gmail.com>
Date:   Mon, 25 Jan 2021 11:26:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <000000000000c21dd605b9a42d3f@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/24/21 8:01 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    647060f3 Add linux-next specific files for 20210120
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=16f0353f500000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8f8a72b7e5067002
> dashboard link: https://syzkaller.appspot.com/bug?extid=9b83ff893245a25c320e
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=143d7e3b500000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17652feb500000
> 

It looks like a new page been mapped by the old vma, which happen
- after the existing page table entry moved from old vma to new vma;
- before unlinking anon_vma from old vma;

So this new page's ->mapping still points to the anon_vma which been
unlinked by the old vma. later, rmap path would not be able to find
mapped entries of this page.

Any hints about above scenario? I suppose it only possible for THP
pages and not happen through page fault path. Thanks.


> The issue was bisected to:
> 
> commit fbdbae3da30a149a55a5f1883bbbe17a27660e05
> Author: Li Xinhai <lixinhai.lxh@gmail.com>
> Date:   Tue Jan 19 21:54:00 2021 +0000
> 
>      mm: mremap: unlink anon_vmas when mremap with MREMAP_DONTUNMAP success
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16cad100d00000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=15cad100d00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=11cad100d00000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+9b83ff893245a25c320e@syzkaller.appspotmail.com
> Fixes: fbdbae3da30a ("mm: mremap: unlink anon_vmas when mremap with MREMAP_DONTUNMAP success")
> 
> head:00000000091c6650 order:9 compound_mapcount:0 compound_pincount:0
> memcg:ffff888010d0a000
> anon flags: 0xfff0000009001d(locked|uptodate|dirty|lru|head|swapbacked)
> raw: 00fff0000009001d ffffea0000bc51c8 ffff888010201800 ffff88802575d801
> raw: 0000000000020e00 0000000000000000 000001fc00000000 ffff888010d0a000
> page dumped because: VM_BUG_ON_PAGE(!unmap_success)
> ------------[ cut here ]------------
> kernel BUG at mm/huge_memory.c:2351!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 8483 Comm: syz-executor525 Not tainted 5.11.0-rc4-next-20210120-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:unmap_page mm/huge_memory.c:2351 [inline]
> RIP: 0010:split_huge_page_to_list+0x1f02/0x43b0 mm/huge_memory.c:2720
> Code: ef e8 82 46 ea ff 0f 0b e8 ab 69 b9 ff 4c 8d 73 ff e9 56 ea ff ff e8 9d 69 b9 ff 48 c7 c6 40 69 57 89 48 89 ef e8 5e 46 ea ff <0f> 0b e8 87 69 b9 ff 4c 8d 75 ff e9 28 e9 ff ff e8 79 69 b9 ff 49
> RSP: 0018:ffffc9000168f7a0 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: ffff88801e2d5400 RSI: ffffffff88bcc6c7 RDI: fffff520002d1e8e
> RBP: ffffea0000ca8000 R08: 0000000000000033 R09: 0000000000000000
> R10: ffffffff815b136e R11: 0000000000000000 R12: ffff888010d0ae60
> R13: ffffea0000ca8000 R14: 000000000000018c R15: 0000000000000000
> FS:  000000000154e880(0000) GS:ffff8880b9e00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fcc655666c0 CR3: 0000000012e9a000 CR4: 00000000001506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   split_huge_page include/linux/huge_mm.h:187 [inline]
>   madvise_free_pte_range+0x736/0x1ee0 mm/madvise.c:633
>   walk_pmd_range mm/pagewalk.c:89 [inline]
>   walk_pud_range mm/pagewalk.c:160 [inline]
>   walk_p4d_range mm/pagewalk.c:193 [inline]
>   walk_pgd_range mm/pagewalk.c:229 [inline]
>   __walk_page_range+0xe20/0x1ea0 mm/pagewalk.c:331
>   walk_page_range+0x20d/0x400 mm/pagewalk.c:427
>   madvise_free_single_vma+0x383/0x550 mm/madvise.c:731
>   madvise_dontneed_free mm/madvise.c:819 [inline]
>   madvise_vma mm/madvise.c:936 [inline]
>   do_madvise.part.0+0x4e4/0x1ed0 mm/madvise.c:1132
>   do_madvise mm/madvise.c:1158 [inline]
>   __do_sys_madvise mm/madvise.c:1158 [inline]
>   __se_sys_madvise mm/madvise.c:1156 [inline]
>   __x64_sys_madvise+0x113/0x150 mm/madvise.c:1156
>   do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x440219
> Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffc51b58b98 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
> RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440219
> RDX: 0000000000000008 RSI: 0000000000c00000 RDI: 0000000020400000
> RBP: 00000000006ca018 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000020ffc000 R11: 0000000000000246 R12: 0000000000401a20
> R13: 0000000000401ab0 R14: 0000000000000000 R15: 0000000000000000
> Modules linked in:
> ---[ end trace 7812a13de61fd12e ]---
> RIP: 0010:unmap_page mm/huge_memory.c:2351 [inline]
> RIP: 0010:split_huge_page_to_list+0x1f02/0x43b0 mm/huge_memory.c:2720
> Code: ef e8 82 46 ea ff 0f 0b e8 ab 69 b9 ff 4c 8d 73 ff e9 56 ea ff ff e8 9d 69 b9 ff 48 c7 c6 40 69 57 89 48 89 ef e8 5e 46 ea ff <0f> 0b e8 87 69 b9 ff 4c 8d 75 ff e9 28 e9 ff ff e8 79 69 b9 ff 49
> RSP: 0018:ffffc9000168f7a0 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: ffff88801e2d5400 RSI: ffffffff88bcc6c7 RDI: fffff520002d1e8e
> RBP: ffffea0000ca8000 R08: 0000000000000033 R09: 0000000000000000
> R10: ffffffff815b136e R11: 0000000000000000 R12: ffff888010d0ae60
> R13: ffffea0000ca8000 R14: 000000000000018c R15: 0000000000000000
> FS:  000000000154e880(0000) GS:ffff8880b9e00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fcc655666c0 CR3: 0000000012e9a000 CR4: 00000000001506f0
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
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
> 
