Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3044E28A282
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 00:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731822AbgJJW5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:57:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:48202 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732225AbgJJTn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:43:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3053EB132;
        Sat, 10 Oct 2020 15:12:46 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     robh+dt@kernel.org, catalin.marinas@arm.com, hch@lst.de,
        ardb@kernel.org, linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Cc:     robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v2 2/5] of/address: Introduce of_dma_lower_bus_limit()
Date:   Sat, 10 Oct 2020 17:12:32 +0200
Message-Id: <20201010151235.20585-3-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201010151235.20585-1-nsaenzjulienne@suse.de>
References: <20201010151235.20585-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function provides the CPU physical address addressable by the most
constrained bus in the system. It might be useful in order to
dynamically set up memory zones during boot.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/of/address.c | 34 ++++++++++++++++++++++++++++++++++
 include/linux/of.h   |  7 +++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index eb9ab4f1e80b..755e97b65096 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -1024,6 +1024,40 @@ int of_dma_get_range(struct device_node *np, const struct bus_dma_region **map)
 }
 #endif /* CONFIG_HAS_DMA */
 
+/**
+ * of_dma_safe_phys_limit - Get system wide DMA safe address space
+ *
+ * Gets the CPU physical address limit for safe DMA addressing system wide by
+ * searching for the most constraining dma-range. Otherwise it returns ~0ULL.
+ */
+u64 __init of_dma_safe_phys_limit(void)
+{
+	struct device_node *np = NULL;
+	struct of_range_parser parser;
+	const __be32 *ranges = NULL;
+	u64 phys_dma_limit = ~0ULL;
+	struct of_range range;
+	int len;
+
+	for_each_of_allnodes(np) {
+		dma_addr_t cpu_end = 0;
+
+		ranges = of_get_property(np, "dma-ranges", &len);
+		if (!ranges || !len)
+			continue;
+
+		of_dma_range_parser_init(&parser, np);
+		for_each_of_range(&parser, &range)
+			if (range.cpu_addr + range.size > cpu_end)
+				cpu_end = range.cpu_addr + range.size;
+
+		if (phys_dma_limit > cpu_end)
+			phys_dma_limit = cpu_end;
+	}
+
+	return phys_dma_limit;
+}
+
 /**
  * of_dma_is_coherent - Check if device is coherent
  * @np:	device node
diff --git a/include/linux/of.h b/include/linux/of.h
index 481ec0467285..958c64cffa92 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -558,6 +558,8 @@ int of_map_id(struct device_node *np, u32 id,
 	       const char *map_name, const char *map_mask_name,
 	       struct device_node **target, u32 *id_out);
 
+u64 of_dma_safe_phys_limit(void);
+
 #else /* CONFIG_OF */
 
 static inline void of_core_init(void)
@@ -995,6 +997,11 @@ static inline int of_map_id(struct device_node *np, u32 id,
 	return -EINVAL;
 }
 
+static inline u64 of_dma_safe_phys_limit(void)
+{
+	return ~0ULL;
+}
+
 #define of_match_ptr(_ptr)	NULL
 #define of_match_node(_matches, _node)	NULL
 #endif /* CONFIG_OF */
-- 
2.28.0

