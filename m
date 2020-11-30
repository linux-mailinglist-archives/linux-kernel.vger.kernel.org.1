Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF7A2C7DFD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 07:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbgK3GBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 01:01:46 -0500
Received: from atcsqr.andestech.com ([60.248.187.195]:23423 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgK3GBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 01:01:45 -0500
X-Greylist: delayed 1765 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Nov 2020 01:01:45 EST
Received: from ATCSQR.andestech.com (localhost [127.0.0.2] (may be forged))
        by ATCSQR.andestech.com with ESMTP id 0AU5WjgV040092
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 13:32:45 +0800 (GMT-8)
        (envelope-from tesheng@andestech.com)
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id 0AU5VqLj039951;
        Mon, 30 Nov 2020 13:31:52 +0800 (GMT-8)
        (envelope-from tesheng@andestech.com)
Received: from atcfdc88.andestech.com (10.0.15.120) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.487.0; Mon, 30 Nov 2020
 13:31:25 +0800
From:   Eric Lin <tesheng@andestech.com>
To:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <walken@google.com>, <daniel.m.jordan@oracle.com>,
        <peterx@redhat.com>, <akpm@linux-foundation.org>,
        <penberg@kernel.org>, <aou@eecs.berkeley.edu>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>
CC:     <dslin1010@gmail.com>, Eric Lin <tesheng@andestech.com>,
        Alan Kao <alankao@andestech.com>
Subject: [PATCH] riscv/mm: Prevent kernel module access user-space memory without uaccess routines
Date:   Mon, 30 Nov 2020 13:30:37 +0800
Message-ID: <20201130053037.27006-1-tesheng@andestech.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.120]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com 0AU5VqLj039951
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the page fault handler, an access to user-space memory
without get/put_user() or copy_from/to_user() routines is
not resolved properly. Like arm and other architectures,
we need to let it die earlier in page fault handler.

Signed-off-by: Eric Lin <tesheng@andestech.com>
Cc: Alan Kao <alankao@andestech.com>
---
 arch/riscv/mm/fault.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 3c8b9e433c67..a452cfa266a2 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -232,6 +232,9 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
 
+	if (!user_mode(regs) && addr < TASK_SIZE && unlikely(!(regs->status & SR_SUM)))
+		die(regs, "Accessing user space memory without uaccess routines\n");
+
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
 
 	if (cause == EXC_STORE_PAGE_FAULT)
-- 
2.17.0

