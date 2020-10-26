Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 578AF298CDB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 13:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775105AbgJZM1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 08:27:12 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:35736 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1775098AbgJZM1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 08:27:08 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08011946|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0174674-0.00699969-0.975533;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047207;MF=liush@allwinnertech.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.Iode2WR_1603715216;
Received: from localhost.localdomain(mailfrom:liush@allwinnertech.com fp:SMTPD_---.Iode2WR_1603715216)
          by smtp.aliyun-inc.com(10.147.40.7);
          Mon, 26 Oct 2020 20:27:01 +0800
From:   liush <liush@allwinnertech.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, penberg@kernel.org,
        akpm@linux-foundation.org, peterx@redhat.com, vbabka@suse.cz,
        walken@google.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Liu Shaohua <liush@allwinnertech.com>
Subject: [PATCH v3] riscv: fix pfn_to_virt err in do_page_fault().
Date:   Mon, 26 Oct 2020 20:26:54 +0800
Message-Id: <1603715214-29082-1-git-send-email-liush@allwinnertech.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Shaohua <liush@allwinnertech.com>

The argument to pfn_to_virt() should be pfn not the value of CSR_SATP.

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: liush <liush@allwinnertech.com>
---
 arch/riscv/mm/fault.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 1359e21..3c8b9e4 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -86,6 +86,7 @@ static inline void vmalloc_fault(struct pt_regs *regs, int code, unsigned long a
 	pmd_t *pmd, *pmd_k;
 	pte_t *pte_k;
 	int index;
+	unsigned long pfn;
 
 	/* User mode accesses just cause a SIGSEGV */
 	if (user_mode(regs))
@@ -100,7 +101,8 @@ static inline void vmalloc_fault(struct pt_regs *regs, int code, unsigned long a
 	 * of a task switch.
 	 */
 	index = pgd_index(addr);
-	pgd = (pgd_t *)pfn_to_virt(csr_read(CSR_SATP)) + index;
+	pfn = csr_read(CSR_SATP) & SATP_PPN;
+	pgd = (pgd_t *)pfn_to_virt(pfn) + index;
 	pgd_k = init_mm.pgd + index;
 
 	if (!pgd_present(*pgd_k)) {
-- 
2.7.4

