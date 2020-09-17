Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4618226D4A6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 09:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgIQH0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 03:26:07 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:39244 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726210AbgIQH0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 03:26:04 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2132557|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00687124-0.000952784-0.992176;FP=0|0|0|0|0|-1|-1|-1;HT=e01a16378;MF=liush@allwinnertech.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.IYFcKJ1_1600327552;
Received: from localhost.localdomain(mailfrom:liush@allwinnertech.com fp:SMTPD_---.IYFcKJ1_1600327552)
          by smtp.aliyun-inc.com(10.147.41.199);
          Thu, 17 Sep 2020 15:25:59 +0800
From:   liush <liush@allwinnertech.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, akpm@linux-foundation.org,
        peterx@redhat.com, walken@google.com, daniel.m.jordan@oracle.com,
        vbabka@suse.cz, rppt@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        liush <liush@allwinnertech.com>
Subject: [PATCH] riscv: fix pfn_to_virt err in do_page_fault().
Date:   Thu, 17 Sep 2020 15:25:49 +0800
Message-Id: <1600327549-3995-1-git-send-email-liush@allwinnertech.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The argument to pfn_to_virt() should be pfn not the value of CSR_SATP.

Signed-off-by: liush <liush@allwinnertech.com>
---
 arch/riscv/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 716d64e..9b4e088 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -212,7 +212,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 		 * of a task switch.
 		 */
 		index = pgd_index(addr);
-		pgd = (pgd_t *)pfn_to_virt(csr_read(CSR_SATP)) + index;
+		pgd = (pgd_t *)pfn_to_virt(csr_read(CSR_SATP) & SATP_PPN) + index;
 		pgd_k = init_mm.pgd + index;
 
 		if (!pgd_present(*pgd_k))
-- 
2.7.4

