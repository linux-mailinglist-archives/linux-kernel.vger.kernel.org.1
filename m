Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 675BD28E700
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 21:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390408AbgJNTMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 15:12:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:52206 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390310AbgJNTMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 15:12:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DC93CB298;
        Wed, 14 Oct 2020 19:12:20 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     robh+dt@kernel.org, catalin.marinas@arm.com, hch@lst.de,
        ardb@kernel.org, linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Cc:     robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v3 4/8] of: unittest: Add test for of_dma_get_max_cpu_address()
Date:   Wed, 14 Oct 2020 21:12:06 +0200
Message-Id: <20201014191211.27029-5-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201014191211.27029-1-nsaenzjulienne@suse.de>
References: <20201014191211.27029-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a test for of_dma_get_max_cup_address(), it uses the same DT
data as the rest of dma-ranges unit tests.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/of/unittest.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 06cc988faf78..2cbf2a585c9f 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -869,6 +869,25 @@ static void __init of_unittest_changeset(void)
 #endif
 }
 
+static void __init of_unittest_dma_get_max_cpu_address(void)
+{
+#ifdef CONFIG_HAS_DMA
+	struct device_node *np;
+	phys_addr_t cpu_addr;
+
+	np = of_find_node_by_path("/testcase-data/address-tests");
+	if (!np) {
+		pr_err("missing testcase data\n");
+		return;
+	}
+
+	cpu_addr = of_dma_get_max_cpu_address(np);
+	unittest(cpu_addr == 0x50000000ULL,
+		 "of_dma_get_max_cpu_address: wrong CPU addr %pad (expecting %llx)\n",
+		 &cpu_addr, 0x50000000ULL);
+#endif
+}
+
 static void __init of_unittest_dma_ranges_one(const char *path,
 		u64 expect_dma_addr, u64 expect_paddr)
 {
@@ -3266,6 +3285,7 @@ static int __init of_unittest(void)
 	of_unittest_changeset();
 	of_unittest_parse_interrupts();
 	of_unittest_parse_interrupts_extended();
+	of_unittest_dma_get_max_cpu_address();
 	of_unittest_parse_dma_ranges();
 	of_unittest_pci_dma_ranges();
 	of_unittest_match_node();
-- 
2.28.0

