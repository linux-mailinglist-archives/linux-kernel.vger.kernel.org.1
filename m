Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF9D2CCFD3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 07:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbgLCGuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 01:50:23 -0500
Received: from atcsqr.andestech.com ([60.248.187.195]:36379 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729114AbgLCGuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 01:50:22 -0500
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id 0B36noOo099128;
        Thu, 3 Dec 2020 14:49:50 +0800 (GMT-8)
        (envelope-from tesheng@andestech.com)
Received: from atcfdc88.andestech.com (10.0.15.120) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.487.0; Thu, 3 Dec 2020
 14:49:38 +0800
From:   Eric Lin <tesheng@andestech.com>
To:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <walken@google.com>, <vbabka@suse.cz>, <peterx@redhat.com>,
        <akpm@linux-foundation.org>, <penberg@kernel.org>,
        <aou@eecs.berkeley.edu>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <hch@infradead.org>
CC:     Eric Lin <tesheng@andestech.com>, Alan Kao <alankao@andestech.com>
Subject: [PATCH v2 2/2] riscv/mm: Prevent kernel module to access user memory without uaccess routines
Date:   Thu, 3 Dec 2020 14:48:26 +0800
Message-ID: <20201203064826.30832-3-tesheng@andestech.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20201203064826.30832-1-tesheng@andestech.com>
References: <20201203064826.30832-1-tesheng@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.120]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com 0B36noOo099128
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We found this issue in an legacy out-of-tree kernel module
which didn't properly access user space pointer by get/put_user().
Such an illegal access loops in the page fault handler.
To resolve this, let it die here.

Signed-off-by: Eric Lin <tesheng@andestech.com>
Cc: Alan Kao <alankao@andestech.com>
---
 arch/riscv/mm/fault.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 0bcfd0e1b39e..00884c1bac28 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -245,6 +245,11 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
 
+	if (!user_mode(regs) && addr < TASK_SIZE &&
+			unlikely(!(regs->status & SR_SUM)))
+		die_kernel_fault("access to user memory without uaccess routines",
+				addr, regs);
+
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
 
 	if (cause == EXC_STORE_PAGE_FAULT)
-- 
2.17.0

