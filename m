Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6299C2CCA37
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 00:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387981AbgLBXBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 18:01:52 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:36205 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387723AbgLBXBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 18:01:42 -0500
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id C7C0123E60;
        Thu,  3 Dec 2020 00:00:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1606950060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aZgDOrNUNuq9+9lzuH9h5WE+9c6dNa3fugcbUZwN+8s=;
        b=IksG+22QaOScWbjFuGd0omJ7HIitWP89C6sfxNp6ditCfyZ4vC/hH0kacq/+x6kufEq3ob
        qXnihg5XnKbN0tTBA/3kBadXZ9xyqTBKHyZmiEQl3Y9uk9ROI6A8gXpQjrxm3Ay/rpthvM
        aQX+8qd4NmfE+tpOfCvGJT+wrg1Hn4g=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v7 5/7] mtd: spi-nor: intel: remove global protection flag
Date:   Thu,  3 Dec 2020 00:00:38 +0100
Message-Id: <20201202230040.14009-6-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201202230040.14009-1-michael@walle.cc>
References: <20201202230040.14009-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the Atmel and SST parts this flag was already moved to individual
flash parts because it is considered bad esp. because newer flash chips
will automatically inherit the "has locking" support. While this won't
likely be the case for the Intel parts, we do it for consistency
reasons.

Signed-off-by: Michael Walle <michael@walle.cc>
Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
changes since v6
 - none

changes since v5
 - new patch

 drivers/mtd/spi-nor/intel.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/mtd/spi-nor/intel.c b/drivers/mtd/spi-nor/intel.c
index d8196f101368..6c31bef3fc60 100644
--- a/drivers/mtd/spi-nor/intel.c
+++ b/drivers/mtd/spi-nor/intel.c
@@ -10,23 +10,13 @@
 
 static const struct flash_info intel_parts[] = {
 	/* Intel/Numonyx -- xxxs33b */
-	{ "160s33b",  INFO(0x898911, 0, 64 * 1024,  32, 0) },
-	{ "320s33b",  INFO(0x898912, 0, 64 * 1024,  64, 0) },
-	{ "640s33b",  INFO(0x898913, 0, 64 * 1024, 128, 0) },
-};
-
-static void intel_default_init(struct spi_nor *nor)
-{
-	nor->flags |= SNOR_F_HAS_LOCK;
-}
-
-static const struct spi_nor_fixups intel_fixups = {
-	.default_init = intel_default_init,
+	{ "160s33b",  INFO(0x898911, 0, 64 * 1024,  32, SPI_NOR_HAS_LOCK) },
+	{ "320s33b",  INFO(0x898912, 0, 64 * 1024,  64, SPI_NOR_HAS_LOCK) },
+	{ "640s33b",  INFO(0x898913, 0, 64 * 1024, 128, SPI_NOR_HAS_LOCK) },
 };
 
 const struct spi_nor_manufacturer spi_nor_intel = {
 	.name = "intel",
 	.parts = intel_parts,
 	.nparts = ARRAY_SIZE(intel_parts),
-	.fixups = &intel_fixups,
 };
-- 
2.20.1

