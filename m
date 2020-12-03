Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C54D12CCFD2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 07:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbgLCGuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 01:50:19 -0500
Received: from atcsqr.andestech.com ([60.248.187.195]:56806 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729114AbgLCGuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 01:50:17 -0500
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id 0B36njXT099106;
        Thu, 3 Dec 2020 14:49:45 +0800 (GMT-8)
        (envelope-from tesheng@andestech.com)
Received: from atcfdc88.andestech.com (10.0.15.120) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.487.0; Thu, 3 Dec 2020
 14:49:29 +0800
From:   Eric Lin <tesheng@andestech.com>
To:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <walken@google.com>, <vbabka@suse.cz>, <peterx@redhat.com>,
        <akpm@linux-foundation.org>, <penberg@kernel.org>,
        <aou@eecs.berkeley.edu>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <hch@infradead.org>
CC:     Eric Lin <tesheng@andestech.com>, Alan Kao <alankao@andestech.com>
Subject: [PATCH v2 1/2] riscv/mm: Introduce a die_kernel_fault() helper function
Date:   Thu, 3 Dec 2020 14:48:25 +0800
Message-ID: <20201203064826.30832-2-tesheng@andestech.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20201203064826.30832-1-tesheng@andestech.com>
References: <20201203064826.30832-1-tesheng@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.120]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com 0B36njXT099106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like arm64, this patch adds a die_kernel_fault() helper
to ensure the same semantics for the different kernel faults.

Signed-off-by: Eric Lin <tesheng@andestech.com>
Cc: Alan Kao <alankao@andestech.com>
---
 arch/riscv/mm/fault.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 3c8b9e433c67..0bcfd0e1b39e 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -19,6 +19,19 @@
 
 #include "../kernel/head.h"
 
+static void die_kernel_fault(const char *msg, unsigned long addr,
+		struct pt_regs *regs)
+{
+	bust_spinlocks(1);
+
+	pr_alert("Unable to handle kernel %s at virtual address " REG_FMT "\n", msg,
+			addr);
+
+	bust_spinlocks(0);
+	die(regs, "Oops");
+	do_exit(SIGKILL);
+}
+
 static inline void no_context(struct pt_regs *regs, unsigned long addr)
 {
 	/* Are we prepared to handle this kernel fault? */
-- 
2.17.0

