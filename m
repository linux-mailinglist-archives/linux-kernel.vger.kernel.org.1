Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 900E22803B7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 18:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732785AbgJAQSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 12:18:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:57840 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732391AbgJAQR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 12:17:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 355AFAF55;
        Thu,  1 Oct 2020 16:17:55 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     robh+dt@kernel.org, catalin.marinas@arm.com, hch@lst.de,
        robin.murphy@arm.com, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-mm@kvack.org,
        Frank Rowand <frowand.list@gmail.com>
Cc:     will@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH 1/4] of/fdt: Update zone_dma_bits when running in bcm2711
Date:   Thu,  1 Oct 2020 18:17:37 +0200
Message-Id: <20201001161740.29064-2-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201001161740.29064-1-nsaenzjulienne@suse.de>
References: <20201001161740.29064-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm64 wants to be able to set ZONE_DMA's size depending on the specific
platform its being run on. Ideally this could be achieved in a smart way
by parsing all dma-ranges and calculating the smaller DMA constraint in
the system. Easier said than done. We compromised on a simpler solution
as the only platform interested in using this is the Raspberry Pi 4.

So update zone_dma_bits if the machine's compatible string matches
Raspberry Pi 4's, otherwise let arm64's mm code deal with it.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/of/fdt.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 4602e467ca8b..cd0d115ef329 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -25,6 +25,7 @@
 #include <linux/serial_core.h>
 #include <linux/sysfs.h>
 #include <linux/random.h>
+#include <linux/dma-direct.h>	/* for zone_dma_bits */
 
 #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
 #include <asm/page.h>
@@ -1198,6 +1199,14 @@ void __init early_init_dt_scan_nodes(void)
 	of_scan_flat_dt(early_init_dt_scan_memory, NULL);
 }
 
+void __init early_init_dt_update_zone_dma_bits(void)
+{
+	unsigned long dt_root = of_get_flat_dt_root();
+
+	if (of_flat_dt_is_compatible(dt_root, "brcm,bcm2711"))
+		zone_dma_bits = 30;
+}
+
 bool __init early_init_dt_scan(void *params)
 {
 	bool status;
@@ -1207,6 +1216,7 @@ bool __init early_init_dt_scan(void *params)
 		return false;
 
 	early_init_dt_scan_nodes();
+	early_init_dt_update_zone_dma_bits();
 	return true;
 }
 
-- 
2.28.0

