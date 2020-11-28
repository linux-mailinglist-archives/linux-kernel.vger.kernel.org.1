Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D9A2C733B
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 23:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389607AbgK1VuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:50:03 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9067 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728452AbgK1SFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:05:44 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CjhC42BVqzLw1Z;
        Sat, 28 Nov 2020 14:18:40 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Sat, 28 Nov 2020 14:19:04 +0800
From:   Chen Huang <chenhuang5@huawei.com>
To:     <wangkefeng.wang@huawei.com>
CC:     <akpm@linux-foundation.org>, <aou@eecs.berkeley.edu>,
        <chenhuang5@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>
Subject: [PATCH v2] riscv: stacktrace: fix stackframe without ra on the top
Date:   Sat, 28 Nov 2020 06:22:42 +0000
Message-ID: <20201128062242.825448-1-chenhuang5@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <22dbe32a-0757-97ad-8885-0f2ba55bb743@huawei.com>
References: <22dbe32a-0757-97ad-8885-0f2ba55bb743@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a function doesn't have a callee, then it will not push ra
into the stack, such as lkdtm_BUG() function:

addi	sp,sp,-16
sd		s0,8(sp)
addi	s0,sp,16
ebreak

The struct stackframe use {fp,ra} to get information from
stack, if walk_stackframe() with pr_regs, we will obtain
wrong value and bad stacktrace,

[<ffffffe00066c56c>] lkdtm_BUG+0x6/0x8
---[ end trace 18da3fbdf08e25d5 ]---

Correct the next fp and pc, after that, full stacktrace
shown as expects,

[<ffffffe00066c56c>] lkdtm_BUG+0x6/0x8
[<ffffffe0008b24a4>] lkdtm_do_action+0x14/0x1c
[<ffffffe00066c372>] direct_entry+0xc0/0x10a
[<ffffffe000439f86>] full_proxy_write+0x42/0x6a
[<ffffffe000309626>] vfs_write+0x7e/0x214
[<ffffffe00030992a>] ksys_write+0x98/0xc0
[<ffffffe000309960>] sys_write+0xe/0x16
[<ffffffe0002014bc>] ret_from_syscall+0x0/0x2
---[ end trace 61917f3d9a9fadcd ]---

Signed-off-by: Chen Huang <chenhuang5@huawei.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/riscv/kernel/stacktrace.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index 595342910c3f..3842fac26e85 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -57,9 +57,14 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 		/* Unwind stack frame */
 		frame = (struct stackframe *)fp - 1;
 		sp = fp;
-		fp = frame->fp;
-		pc = ftrace_graph_ret_addr(current, NULL, frame->ra,
-					   (unsigned long *)(fp - 8));
+		if (regs && (pc == regs->epc) && (frame->fp & 0x7)) {
+			fp = frame->ra;
+			pc = regs->ra;
+		} else {
+			fp = frame->fp;
+			pc = ftrace_graph_ret_addr(current, NULL, frame->ra,
+						(unsigned long *)(fp - 8));
+		}
 	}
 }
 
-- 
2.17.1

