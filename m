Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB69E294CC9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 14:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442458AbgJUMf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 08:35:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:50812 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440413AbgJUMfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 08:35:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8C8C6AE55;
        Wed, 21 Oct 2020 12:35:29 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     robh+dt@kernel.org, catalin.marinas@arm.com, hch@lst.de,
        ardb@kernel.org, linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Cc:     robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        will@kernel.org, lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v4 3/7] of/address: Introduce of_dma_get_max_cpu_address()
Date:   Wed, 21 Oct 2020 14:34:33 +0200
Message-Id: <20201021123437.21538-4-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021123437.21538-1-nsaenzjulienne@suse.de>
References: <20201021123437.21538-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce of_dma_get_max_cpu_address(), which provides the highest CPU
physical address addressable by all DMA masters in the system. It's
specially useful for setting memory zones sizes at early boot time.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

---

Changes since v3:
 - use u64 with cpu_end

Changes since v2:
 - Use PHYS_ADDR_MAX
 - return phys_dma_t
 - Rename function
 - Correct subject
 - Add support to start parsing from an arbitrary device node in order
   for the function to work with unit tests

 drivers/of/address.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/of.h   |  7 +++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index eb9ab4f1e80b..47dfe5881e18 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -1024,6 +1024,48 @@ int of_dma_get_range(struct device_node *np, const struct bus_dma_region **map)
 }
 #endif /* CONFIG_HAS_DMA */
 
+/**
+ * of_dma_get_max_cpu_address - Gets highest CPU address suitable for DMA
+ * @np: The node to start searching from or NULL to start from the root
+ *
+ * Gets the highest CPU physical address that is addressable by all DMA masters
+ * in the sub-tree pointed by np, or the whole tree if NULL is passed. If no
+ * DMA constrained device is found, it returns PHYS_ADDR_MAX.
+ */
+phys_addr_t __init of_dma_get_max_cpu_address(struct device_node *np)
+{
+	phys_addr_t max_cpu_addr = PHYS_ADDR_MAX;
+	struct of_range_parser parser;
+	phys_addr_t subtree_max_addr;
+	struct device_node *child;
+	struct of_range range;
+	const __be32 *ranges;
+	u64 cpu_end = 0;
+	int len;
+
+	if (!np)
+		np = of_root;
+
+	ranges = of_get_property(np, "dma-ranges", &len);
+	if (ranges && len) {
+		of_dma_range_parser_init(&parser, np);
+		for_each_of_range(&parser, &range)
+			if (range.cpu_addr + range.size > cpu_end)
+				cpu_end = range.cpu_addr + range.size;
+
+		if (max_cpu_addr > cpu_end)
+			max_cpu_addr = cpu_end;
+	}
+
+	for_each_available_child_of_node(np, child) {
+		subtree_max_addr = of_dma_get_max_cpu_address(child);
+		if (max_cpu_addr > subtree_max_addr)
+			max_cpu_addr = subtree_max_addr;
+	}
+
+	return max_cpu_addr;
+}
+
 /**
  * of_dma_is_coherent - Check if device is coherent
  * @np:	device node
diff --git a/include/linux/of.h b/include/linux/of.h
index 481ec0467285..db8db8f2c967 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -558,6 +558,8 @@ int of_map_id(struct device_node *np, u32 id,
 	       const char *map_name, const char *map_mask_name,
 	       struct device_node **target, u32 *id_out);
 
+phys_addr_t of_dma_get_max_cpu_address(struct device_node *np);
+
 #else /* CONFIG_OF */
 
 static inline void of_core_init(void)
@@ -995,6 +997,11 @@ static inline int of_map_id(struct device_node *np, u32 id,
 	return -EINVAL;
 }
 
+static inline phys_addr_t of_dma_get_max_cpu_address(struct device_node *np)
+{
+	return PHYS_ADDR_MAX;
+}
+
 #define of_match_ptr(_ptr)	NULL
 #define of_match_node(_matches, _node)	NULL
 #endif /* CONFIG_OF */
-- 
2.28.0

