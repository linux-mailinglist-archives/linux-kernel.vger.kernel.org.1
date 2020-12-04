Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E282CE7A1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 06:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgLDFo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 00:44:57 -0500
Received: from atcsqr.andestech.com ([60.248.187.195]:49653 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbgLDFo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 00:44:57 -0500
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id 0B45hwMc094282;
        Fri, 4 Dec 2020 13:43:59 +0800 (GMT-8)
        (envelope-from tesheng@andestech.com)
Received: from atcfdc88.andestech.com (10.0.15.120) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.487.0; Fri, 4 Dec 2020
 13:43:50 +0800
From:   Eric Lin <tesheng@andestech.com>
To:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <walken@google.com>, <vbabka@suse.cz>, <peterx@redhat.com>,
        <akpm@linux-foundation.org>, <penberg@kernel.org>,
        <aou@eecs.berkeley.edu>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>
CC:     Eric Lin <tesheng@andestech.com>, Alan Kao <alankao@andestech.com>
Subject: [PATCH v3 1/2] riscv/mm: Introduce a die_kernel_fault() helper function
Date:   Fri, 4 Dec 2020 13:42:58 +0800
Message-ID: <20201204054259.32684-2-tesheng@andestech.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20201204054259.32684-1-tesheng@andestech.com>
References: <20201204054259.32684-1-tesheng@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.120]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com 0B45hwMc094282
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like arm64, this patch adds a die_kernel_fault() helper
to ensure the same semantics for the different kernel faults.

Signed-off-by: Eric Lin <tesheng@andestech.com>
Cc: Alan Kao <alankao@andestech.com>
Reviewed-by: Pekka Enberg <penberg@kernel.org>
---
 arch/riscv/mm/fault.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 3c8b9e433c67..0d5f06d6e3c7 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -19,8 +19,23 @@
 
 #include "../kernel/head.h"
 
+static void die_kernel_fault(const char *msg, unsigned long addr,
+		struct pt_regs *regs)
+{
+	bust_spinlocks(1);
+
+	pr_alert("Unable to handle kernel %s at virtual address " REG_FMT "\n", msg,
+		addr);
+
+	bust_spinlocks(0);
+	die(regs, "Oops");
+	do_exit(SIGKILL);
+}
+
 static inline void no_context(struct pt_regs *regs, unsigned long addr)
 {
+	const char *msg;
+
 	/* Are we prepared to handle this kernel fault? */
 	if (fixup_exception(regs))
 		return;
@@ -29,12 +44,8 @@ static inline void no_context(struct pt_regs *regs, unsigned long addr)
 	 * Oops. The kernel tried to access some bad page. We'll have to
 	 * terminate things with extreme prejudice.
 	 */
-	bust_spinlocks(1);
-	pr_alert("Unable to handle kernel %s at virtual address " REG_FMT "\n",
-		(addr < PAGE_SIZE) ? "NULL pointer dereference" :
-		"paging request", addr);
-	die(regs, "Oops");
-	do_exit(SIGKILL);
+	msg = (addr < PAGE_SIZE) ? "NULL pointer dereference" : "paging request";
+	die_kernel_fault(msg, addr, regs);
 }
 
 static inline void mm_fault_error(struct pt_regs *regs, unsigned long addr, vm_fault_t fault)
-- 
2.17.0

