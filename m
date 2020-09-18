Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F30C26F8C0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 10:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgIRI4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 04:56:12 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:46043 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725874AbgIRI4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 04:56:12 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1160887|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00896768-0.00102384-0.990008;FP=0|0|0|0|0|-1|-1|-1;HT=e01a16368;MF=liush@allwinnertech.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.IYnLyfc_1600419360;
Received: from localhost.localdomain(mailfrom:liush@allwinnertech.com fp:SMTPD_---.IYnLyfc_1600419360)
          by smtp.aliyun-inc.com(10.147.42.16);
          Fri, 18 Sep 2020 16:56:07 +0800
From:   liush <liush@allwinnertech.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, akpm@linux-foundation.org,
        peterx@redhat.com, daniel.m.jordan@oracle.com, walken@google.com,
        vbabka@suse.cz, rppt@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        liush <liush@allwinnertech.com>
Subject: [V2] riscv: fix pfn_to_virt err in do_page_fault().
Date:   Fri, 18 Sep 2020 16:55:58 +0800
Message-Id: <1600419358-21446-1-git-send-email-liush@allwinnertech.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The argument to pfn_to_virt() should be pfn not the value of CSR_SATP.

Signed-off-by: liush <liush@allwinnertech.com>
---
 arch/riscv/mm/fault.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 716d64e..3e560ec13 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -198,6 +198,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 		pmd_t *pmd, *pmd_k;
 		pte_t *pte_k;
 		int index;
+		unsigned long pfn;
 
 		/* User mode accesses just cause a SIGSEGV */
 		if (user_mode(regs))
@@ -212,7 +213,8 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 		 * of a task switch.
 		 */
 		index = pgd_index(addr);
-		pgd = (pgd_t *)pfn_to_virt(csr_read(CSR_SATP)) + index;
+		pfn = csr_read(CSR_SATP) & SATP_PPN;
+		pgd = (pgd_t *)pfn_to_virt(pfn) + index;
 		pgd_k = init_mm.pgd + index;
 
 		if (!pgd_present(*pgd_k))
-- 
2.7.4

