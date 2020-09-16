Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C24426BF81
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 10:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgIPIjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 04:39:20 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:37833 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgIPIjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 04:39:12 -0400
Received: by mail-io1-f72.google.com with SMTP id 80so4503031iou.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 01:39:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ZT7dqACYduKjF5xWwI0UlpLjXynZqI3xxYFzGwLDVE8=;
        b=QjcwzVJinGSQQxjFPqxk3VpHnhb7XTQ3rlb9BFbyEfXaVjS7celyKlZzulOef1d9z4
         FdDjL65nuZ6zRirpsD270dWd7kYxtwjRfRI8SsJ31rnuDuXp08xWYIzE1Y4WfSZBnC/V
         /pKjiXklZwSEptL9pifBiI2XrIy8aQQmRHvxYhbN/oczjbDMcgOhUlClUvpdYtRq9NcI
         0HIVpxurSSaBbyNOYWugACiQvIB9OF6um7C78tsKcGAYRRecGl3SArZHqHkGWjwhojAr
         HHhbs6HzjFnXJw+lMDthwRDn84gsy4Fgft2g/lTuns4pRXTXg5Cli8SGO/6Q+x8aAkb9
         midQ==
X-Gm-Message-State: AOAM533TCSHqzn0PKhbB/4zNOVMry9QNoSgl9mquAIMq2Yk93QcO/q6i
        SULoZSZ4zN0g5TujLoY8Iy6XvlE8vWCkjCjVhrdJ1NG04dI1
X-Google-Smtp-Source: ABdhPJzfIyjdU9E7g3mot7mBdEDDZ/rWY/T4vppU205YQveDoemE4N1aP2463u3uCQUTUpzdGVY646Eh87O6qmj5lIfo/VKJum+J
MIME-Version: 1.0
X-Received: by 2002:a6b:7c0d:: with SMTP id m13mr18443869iok.57.1600245549968;
 Wed, 16 Sep 2020 01:39:09 -0700 (PDT)
Date:   Wed, 16 Sep 2020 01:39:09 -0700
In-Reply-To: <d3a7e455690b4c629145c8c4936a55c7@huawei.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008f30e505af6a33f4@google.com>
Subject: Re: general protection fault in unlink_file_vma
From:   syzbot <syzbot+c5d5a51dcbb558ca0cb5@syzkaller.appspotmail.com>
To:     linmiaohe@huawei.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG at arch/x86/mm/physaddr.c:LINE!

------------[ cut here ]------------
kernel BUG at arch/x86/mm/physaddr.c:28!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 6975 Comm: syz-executor.2 Not tainted 5.9.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__phys_addr+0xa7/0x110 arch/x86/mm/physaddr.c:28
Code: 92 7d 09 4c 89 e3 31 ff 48 d3 eb 48 89 de e8 10 8e 3f 00 48 85 db 75 0d e8 66 91 3f 00 4c 89 e0 5b 5d 41 5c c3 e8 59 91 3f 00 <0f> 0b e8 52 91 3f 00 48 c7 c0 10 50 a9 89 48 ba 00 00 00 00 00 fc
RSP: 0018:ffffc900055e7a18 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000007700000000 RCX: ffffffff8134b948
RDX: ffff8880a83c8280 RSI: ffffffff8134b9a7 RDI: 0000000000000006
RBP: 0000007780000000 R08: 0000000000000001 R09: ffffffff8c5f4a57
R10: 0000007780000000 R11: 0000000000000000 R12: 000077f700000000
R13: ffffc900055e7a80 R14: 0000000000000200 R15: dffffc0000000000
FS:  000000000221c940(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000749198 CR3: 00000000a7df1000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 virt_to_head_page include/linux/mm.h:848 [inline]
 qlink_to_cache mm/kasan/quarantine.c:128 [inline]
 qlist_free_all+0xd9/0x170 mm/kasan/quarantine.c:165
 quarantine_reduce+0x17e/0x200 mm/kasan/quarantine.c:261
 __kasan_kmalloc.constprop.0+0x9e/0xd0 mm/kasan/common.c:442
 slab_post_alloc_hook mm/slab.h:518 [inline]
 slab_alloc_node mm/slab.c:3254 [inline]
 kmem_cache_alloc_node_trace+0x144/0x3f0 mm/slab.c:3592
 kmalloc_node include/linux/slab.h:572 [inline]
 kzalloc_node include/linux/slab.h:677 [inline]
 __get_vm_area_node+0x126/0x3b0 mm/vmalloc.c:2075
 __vmalloc_node_range mm/vmalloc.c:2506 [inline]
 __vmalloc_node mm/vmalloc.c:2554 [inline]
 vzalloc+0xf2/0x1a0 mm/vmalloc.c:2607
 do_ipt_get_ctl+0x613/0x9d0 net/ipv4/netfilter/ip_tables.c:800
 nf_getsockopt+0x72/0xd0 net/netfilter/nf_sockopt.c:116
 ip_getsockopt net/ipv4/ip_sockglue.c:1778 [inline]
 ip_getsockopt+0x164/0x1c0 net/ipv4/ip_sockglue.c:1757
 tcp_getsockopt+0x86/0xd0 net/ipv4/tcp.c:3876
 __sys_getsockopt+0x219/0x4c0 net/socket.c:2173
 __do_sys_getsockopt net/socket.c:2188 [inline]
 __se_sys_getsockopt net/socket.c:2185 [inline]
 __x64_sys_getsockopt+0xba/0x150 net/socket.c:2185
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x4600ca
Code: b8 34 01 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 3d 89 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 37 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 1a 89 fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007fff61ca7778 EFLAGS: 00000216 ORIG_RAX: 0000000000000037
RAX: ffffffffffffffda RBX: 00007fff61ca77a0 RCX: 00000000004600ca
RDX: 0000000000000041 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000749e60 R08: 00007fff61ca779c R09: 0000000000004000
R10: 00007fff61ca7800 R11: 0000000000000216 R12: 00007fff61ca7800
R13: 0000000000000003 R14: 00000000007497a0 R15: 0000000000000000
Modules linked in:
---[ end trace 58c08b00b19487d8 ]---
RIP: 0010:__phys_addr+0xa7/0x110 arch/x86/mm/physaddr.c:28
Code: 92 7d 09 4c 89 e3 31 ff 48 d3 eb 48 89 de e8 10 8e 3f 00 48 85 db 75 0d e8 66 91 3f 00 4c 89 e0 5b 5d 41 5c c3 e8 59 91 3f 00 <0f> 0b e8 52 91 3f 00 48 c7 c0 10 50 a9 89 48 ba 00 00 00 00 00 fc
RSP: 0018:ffffc900055e7a18 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000007700000000 RCX: ffffffff8134b948
RDX: ffff8880a83c8280 RSI: ffffffff8134b9a7 RDI: 0000000000000006
RBP: 0000007780000000 R08: 0000000000000001 R09: ffffffff8c5f4a57
R10: 0000007780000000 R11: 0000000000000000 R12: 000077f700000000
R13: ffffc900055e7a80 R14: 0000000000000200 R15: dffffc0000000000
FS:  000000000221c940(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000749198 CR3: 00000000a7df1000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         152d246f mmap: revert mm-mmap-merge-vma-after-call_mmap-if..
git tree:       https://github.com/Linmiaohe/linux vma_merge_fix
console output: https://syzkaller.appspot.com/x/log.txt?x=162e6cc5900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c5f6ce8d5b68299
dashboard link: https://syzkaller.appspot.com/bug?extid=c5d5a51dcbb558ca0cb5
compiler:       gcc (GCC) 10.1.0-syz 20200507

