Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B594C2F832C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730880AbhAOR7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:59:23 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:46687 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbhAOR7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:59:23 -0500
X-Originating-IP: 93.29.109.196
Received: from localhost.localdomain (196.109.29.93.rev.sfr.net [93.29.109.196])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 435151C0003;
        Fri, 15 Jan 2021 17:58:40 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH 1/2] of: device: Allow DMA range map to be set before of_dma_configure_id
Date:   Fri, 15 Jan 2021 18:58:30 +0100
Message-Id: <20210115175831.1184260-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A mechanism was recently introduced for the sunxi architecture where
the DMA offset for specific devices (under the MBUS) is set by a common
driver (sunxi_mbus). This driver calls dma_direct_set_offset to set
the device's dma_range_map manually.

However this information was overwritten by of_dma_configure_id, which
obtains the map from of_dma_get_range (or keeps it NULL when it fails
and the force_dma argument is true, which is the case for platform
devices).

As a result, the dma_range_map was always overwritten and the mechanism
could not correctly take effect.

This adds a check to ensure that no previous DMA range map is
overwritten and prints a warning when the map was already set while
also being available from dt. In this case, the map that was already
set is kept.

Fixes: b4bdc4fbf8d0 ("soc: sunxi: Deal with the MBUS DMA offsets in a central place")
Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/of/device.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index aedfaaafd3e7..db1b8634c2c7 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -181,7 +181,14 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 
 	arch_setup_dma_ops(dev, dma_start, size, iommu, coherent);
 
-	dev->dma_range_map = map;
+	if (!dev->dma_range_map) {
+		dev->dma_range_map = map;
+	} else if (map) {
+		dev_warn(dev,
+			 "DMA range map was already set, ignoring range map from dt\n");
+		kfree(map);
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_dma_configure_id);
-- 
2.30.0

