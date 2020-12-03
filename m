Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 567582CDB43
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 17:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731304AbgLCQa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 11:30:56 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:41835 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbgLCQay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 11:30:54 -0500
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 4604023E5D;
        Thu,  3 Dec 2020 17:30:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1607013011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MMIF3+rWO2apGLu9yhbnHHAuw+NkIpMjqv/0IVPCslo=;
        b=HX7Hzhv6PkPYg96PiiVamvcdxUDhdy85oDWuGjSnvTwj/GEsiTQYpPE4h0BLdfUDLx410+
        JCD0zHQ9QMSn7/SFLA1pF0NKPAE7AykLcKTG4R09ORvmVE5fPwfLWNWcA8W62n9ukMv5sE
        CUP4SAVamD10N1iwNdpxsbQCDFoJv8s=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v8 4/7] mtd: spi-nor: sst: remove global protection flag
Date:   Thu,  3 Dec 2020 17:29:56 +0100
Message-Id: <20201203162959.29589-5-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201203162959.29589-1-michael@walle.cc>
References: <20201203162959.29589-1-michael@walle.cc>
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
 (3) There are already supported flashes which doesn't support
     the locking scheme. So I assume this wasn't properly tested
     before adding that chip; which enforces my previous argument
     that locking support should be an opt-in.

Remove the global flag and add individual flags to all flashes
which supports BP locking. In particular the following flashes
don't support the BP scheme:
 - SST26VF016B
 - SST26WF016B
 - SST26VF064B

Signed-off-by: Michael Walle <michael@walle.cc>
Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
changes since v7:
 - none

changes since v6:
 - none

changes since v5:
 - none

changes since v4:
 - none

changes since v3/v2/v1:
 - there was no such version because this patch was bundled with another
   patch

changes since RFC:
 - none

 drivers/mtd/spi-nor/sst.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/mtd/spi-nor/sst.c b/drivers/mtd/spi-nor/sst.c
index 0ab07624fb73..0d9d319f61e6 100644
--- a/drivers/mtd/spi-nor/sst.c
+++ b/drivers/mtd/spi-nor/sst.c
@@ -11,27 +11,27 @@
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
+			      SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK) },
 	{ "sst25vf064c", INFO(0xbf254b, 0, 64 * 1024, 128,
-			      SECT_4K | SPI_NOR_4BIT_BP) },
+			      SECT_4K | SPI_NOR_4BIT_BP | SPI_NOR_HAS_LOCK) },
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
@@ -128,11 +128,6 @@ static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
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
@@ -140,7 +135,6 @@ static void sst_post_sfdp_fixups(struct spi_nor *nor)
 }
 
 static const struct spi_nor_fixups sst_fixups = {
-	.default_init = sst_default_init,
 	.post_sfdp = sst_post_sfdp_fixups,
 };
 
-- 
2.20.1

