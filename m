Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2115B27FF00
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 14:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732267AbgJAM2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 08:28:44 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:38949 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732243AbgJAM2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 08:28:40 -0400
Received: from mwalle01.sab.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id B694523E3E;
        Thu,  1 Oct 2020 14:28:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1601555317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YPmdGtgririZWeFGZIixYdXaBLbq2MRNAKDVlX/4kUw=;
        b=Vmvl50NgCEDLAz7p7XnOx8mdTY8ozKD66f57f4M0PBQog4T6N7jGjiB2a8yyRdIAKKcg32
        2Ox8lO47xe4Fqo799W+uers876u2fFo6Tgajr88MJ97GFDh0FEjTA9wMxwrTP9F/iBJevr
        EIYqBetka2N21AU3h9VIIwG19DuldzI=
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michael Walle <michael@walle.cc>
Subject: [RFC PATCH 2/2] mtd: spi-nor: sst: remove global SNOR_F_HAS_LOCK
Date:   Thu,  1 Oct 2020 14:28:28 +0200
Message-Id: <20201001122828.23186-2-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201001122828.23186-1-michael@walle.cc>
References: <20201001122828.23186-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is considered bad for the following reasons:
 (1) We only support the block protection with BPn bits for write
     protection. Not all SST parts support this.
 (2) Newly added flash chip will automatically inherit the "has
     locking" support and thus needs to explicitly tested. Better
     be opt-in instead of opt-out.
 (3) There are already supported flashes which don't support the locking
	 scheme. So I assume this wasn't properly tested before adding that
	 chip; which enforces my previous argument that locking support should
	 be an opt-in.

Remove the global flag and add individual flags to all flashes
which supports BP locking. In particular the following flashes
don't support the BP scheme:
 - SST26VF016B
 - SST26WF016B
 - SST26VF064B

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/sst.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/mtd/spi-nor/sst.c b/drivers/mtd/spi-nor/sst.c
index e0af6d25d573..8b169fa4102a 100644
--- a/drivers/mtd/spi-nor/sst.c
+++ b/drivers/mtd/spi-nor/sst.c
@@ -11,26 +11,26 @@
 static const struct flash_info sst_parts[] = {
 	/* SST -- large erase sizes are "overlays", "sectors" are 4K */
 	{ "sst25vf040b", INFO(0xbf258d, 0, 64 * 1024,  8,
-			      SECT_4K | SST_WRITE) },
+			      SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK) },
 	{ "sst25vf080b", INFO(0xbf258e, 0, 64 * 1024, 16,
-			      SECT_4K | SST_WRITE) },
+			      SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK) },
 	{ "sst25vf016b", INFO(0xbf2541, 0, 64 * 1024, 32,
-			      SECT_4K | SST_WRITE) },
+			      SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK) },
 	{ "sst25vf032b", INFO(0xbf254a, 0, 64 * 1024, 64,
-			      SECT_4K | SST_WRITE) },
-	{ "sst25vf064c", INFO(0xbf254b, 0, 64 * 1024, 128, SECT_4K) },
+			      SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK) },
+	{ "sst25vf064c", INFO(0xbf254b, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_HAS_LOCK) },
 	{ "sst25wf512",  INFO(0xbf2501, 0, 64 * 1024,  1,
-			      SECT_4K | SST_WRITE) },
+			      SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK) },
 	{ "sst25wf010",  INFO(0xbf2502, 0, 64 * 1024,  2,
-			      SECT_4K | SST_WRITE) },
+			      SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK) },
 	{ "sst25wf020",  INFO(0xbf2503, 0, 64 * 1024,  4,
-			      SECT_4K | SST_WRITE) },
-	{ "sst25wf020a", INFO(0x621612, 0, 64 * 1024,  4, SECT_4K) },
-	{ "sst25wf040b", INFO(0x621613, 0, 64 * 1024,  8, SECT_4K) },
+			      SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK) },
+	{ "sst25wf020a", INFO(0x621612, 0, 64 * 1024,  4, SECT_4K | SPI_NOR_HAS_LOCK) },
+	{ "sst25wf040b", INFO(0x621613, 0, 64 * 1024,  8, SECT_4K | SPI_NOR_HAS_LOCK) },
 	{ "sst25wf040",  INFO(0xbf2504, 0, 64 * 1024,  8,
-			      SECT_4K | SST_WRITE) },
+			      SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK) },
 	{ "sst25wf080",  INFO(0xbf2505, 0, 64 * 1024, 16,
-			      SECT_4K | SST_WRITE) },
+			      SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK) },
 	{ "sst26wf016b", INFO(0xbf2651, 0, 64 * 1024, 32,
 			      SECT_4K | SPI_NOR_DUAL_READ |
 			      SPI_NOR_QUAD_READ) },
@@ -127,11 +127,6 @@ static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
 	return ret;
 }
 
-static void sst_default_init(struct spi_nor *nor)
-{
-	nor->flags |= SNOR_F_HAS_LOCK;
-}
-
 static void sst_post_sfdp_fixups(struct spi_nor *nor)
 {
 	if (nor->info->flags & SST_WRITE)
@@ -139,7 +134,6 @@ static void sst_post_sfdp_fixups(struct spi_nor *nor)
 }
 
 static const struct spi_nor_fixups sst_fixups = {
-	.default_init = sst_default_init,
 	.post_sfdp = sst_post_sfdp_fixups,
 };
 
-- 
2.20.1

