Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD2626C02D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 11:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgIPJJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 05:09:13 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12304 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726129AbgIPJJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 05:09:10 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 787E2330D12FE261413A;
        Wed, 16 Sep 2020 17:09:00 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Wed, 16 Sep 2020
 17:08:51 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm: mmap: Fix general protection fault in unlink_file_vma()
Date:   Wed, 16 Sep 2020 05:07:33 -0400
Message-ID: <20200916090733.31427-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The syzbot reported the below general protection fault:

general protection fault, probably for non-canonical address
0xe00eeaee0000003b: 0000 [#1] PREEMPT SMP KASAN
KASAN: maybe wild-memory-access in range
[0x00777770000001d8-0x00777770000001df]
CPU: 1 PID: 10488 Comm: syz-executor721 Not tainted 5.9.0-rc3-syzkaller #0
RIP: 0010:unlink_file_vma+0x57/0xb0 mm/mmap.c:164
Code: 4c 8b a5 a0 00 00 00 4d 85 e4 74 4e e8 92 d7 cd ff 49 8d bc 24
d8 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c
02 00 75 3d 4d 8b b4 24 d8 01 00 00 4d 8d 6e 78 4c 89 ef e8
RSP: 0018:ffffc9000ac0f9b0 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff88800010ceb0 RCX: ffffffff81592421
RDX: 000eeeee0000003b RSI: ffffffff81a6736e RDI: 00777770000001d8
RBP: ffff88800010ceb0 R08: 0000000000000001 R09: ffff88801291a50f
R10: ffffed10025234a1 R11: 0000000000000001 R12: 0077777000000000
R13: 00007f1eea0da000 R14: 00007f1eea0d9000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880ae700000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1eea11a9d0 CR3: 000000000007e000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 free_pgtables+0x1b3/0x2f0 mm/memory.c:415
 exit_mmap+0x2c0/0x530 mm/mmap.c:3184
 __mmput+0x122/0x470 kernel/fork.c:1076
 mmput+0x53/0x60 kernel/fork.c:1097
 exit_mm kernel/exit.c:483 [inline]
 do_exit+0xa8b/0x29f0 kernel/exit.c:793
 do_group_exit+0x125/0x310 kernel/exit.c:903
 get_signal+0x428/0x1f00 kernel/signal.c:2757
 arch_do_signal+0x82/0x2520 arch/x86/kernel/signal.c:811
 exit_to_user_mode_loop kernel/entry/common.c:136 [inline]
 exit_to_user_mode_prepare+0x1ae/0x200 kernel/entry/common.c:167
 syscall_exit_to_user_mode+0x7e/0x2e0 kernel/entry/common.c:242
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

It's because the ->mmap() callback can change vma->vm_file and fput the
original file. But the commit d70cec898324 ("mm: mmap: merge vma after
call_mmap() if possible") failed to catch this case and always fput() the
original file, hence add an extra fput().

[ Thanks Hillf for pointing this extra fput() out. ]

Fixes: d70cec898324 ("mm: mmap: merge vma after call_mmap() if possible")
Reported-by: syzbot+c5d5a51dcbb558ca0cb5@syzkaller.appspotmail.com
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/mmap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index e3a1c1b48909..37c985850dc6 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1815,7 +1815,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 			merge = vma_merge(mm, prev, vma->vm_start, vma->vm_end, vma->vm_flags,
 				NULL, vma->vm_file, vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX);
 			if (merge) {
-				fput(file);
+				/* ->mmap() can change vma->vm_file and fput the original file. So
+				 * fput the vma->vm_file here or we would add an extra fput for file
+				 * and cause general protection fault ultimately.
+				 */
+				fput(vma->vm_file);
 				vm_area_free(vma);
 				vma = merge;
 				/* Update vm_flags and possible addr to pick up the change. We don't
-- 
2.19.1

