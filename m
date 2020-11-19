Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6E62B9A27
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 18:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbgKSRyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 12:54:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:40718 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727395AbgKSRyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 12:54:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 07E31AD07;
        Thu, 19 Nov 2020 17:54:10 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     robh+dt@kernel.org, catalin.marinas@arm.com, hch@lst.de,
        ardb@kernel.org, linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Cc:     robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        will@kernel.org, lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v7 4/7] of: unittest: Add test for of_dma_get_max_cpu_address()
Date:   Thu, 19 Nov 2020 18:53:56 +0100
Message-Id: <20201119175400.9995-5-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201119175400.9995-1-nsaenzjulienne@suse.de>
References: <20201119175400.9995-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a test for of_dma_get_max_cup_address(), it uses the same DT
data as the rest of dma-ranges unit tests.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Rob Herring <robh@kernel.org>

---
Changes since v5:
- Update address expected by test

Changes since v3:
 - Remove HAS_DMA guards

 drivers/of/unittest.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 06cc988faf78..98cc0163301b 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -869,6 +869,23 @@ static void __init of_unittest_changeset(void)
 #endif
 }
 
+static void __init of_unittest_dma_get_max_cpu_address(void)
+{
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
+	unittest(cpu_addr == 0x4fffffff,
+		 "of_dma_get_max_cpu_address: wrong CPU addr %pad (expecting %x)\n",
+		 &cpu_addr, 0x4fffffff);
+}
+
 static void __init of_unittest_dma_ranges_one(const char *path,
 		u64 expect_dma_addr, u64 expect_paddr)
 {
@@ -3266,6 +3283,7 @@ static int __init of_unittest(void)
 	of_unittest_changeset();
 	of_unittest_parse_interrupts();
 	of_unittest_parse_interrupts_extended();
+	of_unittest_dma_get_max_cpu_address();
 	of_unittest_parse_dma_ranges();
 	of_unittest_pci_dma_ranges();
 	of_unittest_match_node();
-- 
2.29.2

