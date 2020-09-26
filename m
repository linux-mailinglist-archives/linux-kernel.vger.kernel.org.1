Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC3C9279664
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 05:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729959AbgIZDVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 23:21:18 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:32814 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728935AbgIZDVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 23:21:17 -0400
Received: by mail-il1-f198.google.com with SMTP id e73so3935330ill.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 20:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=4VbAGN7iQiSvF2eC6i+kemaMInFiN1WW0i62tJqGJwQ=;
        b=IqIRV/YlEX/xwEAiFnVC6l81/Hpb0CkfLx7/MCR/wjFraHCfslO4W+Jj8SrAAta9FD
         NT3QmfoKgWORg67oHRr1B+1foWVjlPO+yc/hIb49FuzQUdd+kUR5ojny53u9rZpbmYMU
         mUnsSs39z3VVhHjLoFXAvN3PJcAyYxY5/ERTqjTdmRzdMDST5cxWRnDDYXDki5O25s84
         YgAsPbAajZ0hV1cwYa4gxgBRK7rR+sIu0IJagkM08YKHxfEJCa9aydw77U0vkl2JA/Mj
         jzaloGkwZu2q12xumUgbzFpxOHyw4VomXzp/hh5waG5qmMWwq355Srl91n7BO4z6MVds
         YFFQ==
X-Gm-Message-State: AOAM531T+bAFNXWQpZfzpxIJSZ0HShoQxt23WbiGbZ72VCE3MANAkESv
        RxugAQ7FW7ywZzExBrW2Ah6+pkJmyKAReFQswgh+fV6Cb9vD
X-Google-Smtp-Source: ABdhPJy1vPhWdzPcDPZZS4TuN/BzMYt9kc9narTQDbAVymusZ6MumpoKEizvR46BGsiB6cx5uJ4B/aEjtAmxfNvnDn1nU7NI8iZX
MIME-Version: 1.0
X-Received: by 2002:a5d:8e14:: with SMTP id e20mr1111795iod.119.1601090476604;
 Fri, 25 Sep 2020 20:21:16 -0700 (PDT)
Date:   Fri, 25 Sep 2020 20:21:16 -0700
In-Reply-To: <0000000000005103e405a3a66ecd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001cab5d05b02eed75@google.com>
Subject: Re: kernel BUG at include/linux/mm.h:LINE! (6)
From:   syzbot <syzbot+a923008018a2d298247b@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hannes@cmpxchg.org, hdanton@sina.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        luto@kernel.org, mhocko@kernel.org, minchan@kernel.org,
        mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    171d4ff7 Merge tag 'mmc-v5.9-rc4-2' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1197c517900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=240e2ebab67245c7
dashboard link: https://syzkaller.appspot.com/bug?extid=a923008018a2d298247b
compiler:       gcc (GCC) 10.1.0-syz 20200507
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10c679ad900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1125efab900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a923008018a2d298247b@syzkaller.appspotmail.com

raw: 0000000000000000 ffff888096b02ae0 00000001ffffffff 0000000000000000
page dumped because: VM_BUG_ON_PAGE(page->pmd_huge_pte)
------------[ cut here ]------------
kernel BUG at include/linux/mm.h:2260!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 6951 Comm: syz-executor101 Not tainted 5.9.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:pgtable_pmd_page_dtor include/linux/mm.h:2260 [inline]
RIP: 0010:pgtable_pmd_page_dtor include/linux/mm.h:2257 [inline]
RIP: 0010:___pmd_free_tlb+0x108/0x140 arch/x86/mm/pgtable.c:72
Code: ee e8 5c 8e fe ff 66 90 5b 5d 41 5c 41 5d c3 e8 de 95 40 00 0f 0b e8 d7 95 40 00 48 c7 c6 40 20 89 88 48 89 ef e8 a8 90 6f 00 <0f> 0b e8 c1 95 40 00 0f 0b 48 c7 c7 68 6c fc 89 e8 23 69 81 00 e9
RSP: 0018:ffffc900061678c0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 000000000008fef6 RCX: ffffffff81a54935
RDX: ffff88808e70a1c0 RSI: ffffffff81a54984 RDI: ffffea00023fbdb8
RBP: ffffea00023fbd80 R08: 0000000000000037 R09: ffff8880ae5318e7
R10: ffffffffffffffff R11: 0000000000000000 R12: ffffc90006167a20
R13: ffff88808fef6000 R14: 0000000021000fff R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880ae500000(0000) knlGS:0000000000000000
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000080fd718 CR3: 000000008e534000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __pmd_free_tlb arch/x86/include/asm/pgalloc.h:95 [inline]
 free_pmd_range mm/memory.c:255 [inline]
 free_pud_range mm/memory.c:273 [inline]
 free_p4d_range mm/memory.c:307 [inline]
 free_pgd_range+0xa3f/0xf90 mm/memory.c:387
 free_pgtables+0x230/0x2f0 mm/memory.c:419
 exit_mmap+0x2c0/0x530 mm/mmap.c:3184
 __mmput+0x122/0x470 kernel/fork.c:1076
 mmput+0x53/0x60 kernel/fork.c:1097
 exit_mm kernel/exit.c:483 [inline]
 do_exit+0xa8b/0x29f0 kernel/exit.c:793
 do_group_exit+0x125/0x310 kernel/exit.c:903
 get_signal+0x428/0x1f00 kernel/signal.c:2757
 arch_do_signal+0x82/0x2520 arch/x86/kernel/signal.c:811
 exit_to_user_mode_loop kernel/entry/common.c:161 [inline]
 exit_to_user_mode_prepare+0x1ae/0x200 kernel/entry/common.c:192
 syscall_exit_to_user_mode+0x7e/0x2e0 kernel/entry/common.c:267
 __do_fast_syscall_32+0x6c/0x90 arch/x86/entry/common.c:138
 do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:160
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7f80549
Code: Bad RIP value.
RSP: 002b:00000000f7f7b1ec EFLAGS: 00000296 ORIG_RAX: 00000000000000f0
RAX: fffffffffffffe00 RBX: 00000000080fafe8 RCX: 0000000000000080
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace f578be228b447c1d ]---
RIP: 0010:pgtable_pmd_page_dtor include/linux/mm.h:2260 [inline]
RIP: 0010:pgtable_pmd_page_dtor include/linux/mm.h:2257 [inline]
RIP: 0010:___pmd_free_tlb+0x108/0x140 arch/x86/mm/pgtable.c:72
Code: ee e8 5c 8e fe ff 66 90 5b 5d 41 5c 41 5d c3 e8 de 95 40 00 0f 0b e8 d7 95 40 00 48 c7 c6 40 20 89 88 48 89 ef e8 a8 90 6f 00 <0f> 0b e8 c1 95 40 00 0f 0b 48 c7 c7 68 6c fc 89 e8 23 69 81 00 e9
RSP: 0018:ffffc900061678c0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 000000000008fef6 RCX: ffffffff81a54935
RDX: ffff88808e70a1c0 RSI: ffffffff81a54984 RDI: ffffea00023fbdb8
RBP: ffffea00023fbd80 R08: 0000000000000037 R09: ffff8880ae5318e7
R10: ffffffffffffffff R11: 0000000000000000 R12: ffffc90006167a20
R13: ffff88808fef6000 R14: 0000000021000fff R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880ae500000(0000) knlGS:0000000000000000
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000f7f5a22c CR3: 0000000088483000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

