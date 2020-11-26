Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98BB42C5D09
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 21:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390233AbgKZU0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 15:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389964AbgKZU0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 15:26:40 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD413C061A04
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 12:26:39 -0800 (PST)
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id AC31B23E55;
        Thu, 26 Nov 2020 21:26:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1606422395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3CC0GGIKYEhXEIc2gHBdOUxUvIBC0XKOsm4V4nbxURA=;
        b=LAR/rvvZBU8E9efg2OqY4KYbDZVM8aG70wfOpodqGjKuCyxldIePiSLURRxwnEvZZflnOg
        9+BZ0J5igTbnUibSLpMHoRMb388aawVqWoX83DipT2pcb/Ciq9AaD3e/C5Wdza9IpJJHwR
        HhqyOfVomLhQ0TvUXUENsQDTbokAUlQ=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v6 1/5] mtd: spi-nor: atmel: remove global protection flag
Date:   Thu, 26 Nov 2020 21:26:10 +0100
Message-Id: <20201126202614.5710-2-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201126202614.5710-1-michael@walle.cc>
References: <20201126202614.5710-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is considered bad for the following reasons:
 (1) We only support the block protection with BPn bits for write
     protection. Not all Atmel parts support this.
 (2) Newly added flash chip will automatically inherit the "has
     locking" support and thus needs to explicitly tested. Better
     be opt-in instead of opt-out.
 (3) There are already supported flashes which doesn't support
     the locking scheme. So I assume this wasn't properly tested
     before adding that chip; which enforces my previous argument
     that locking support should be an opt-in.

Remove the global flag and add individual flags to all flashes which
supports BP locking. In particular the following flashes don't support
the BP scheme:
 - AT26F004
 - AT25SL321
 - AT45DB081D

Please note, that some flashes which are marked as SPI_NOR_HAS_LOCK just
support Global Protection, i.e. not our supported block protection
locking scheme. This is to keep backwards compatibility with the
current "unlock all at boot" mechanism. In particular the following
flashes doesn't have BP bits:
 - AT25DF041A
 - AT25DF321
 - AT25DF321A
 - AT25DF641
 - AT26DF081A
 - AT26DF161A
 - AT26DF321

Signed-off-by: Michael Walle <michael@walle.cc>
Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
changes since v5:
 - none

changes since v4:
 - none

changes since v3/v2/v1:
 - there was no such version because this patch was bundled with another
   patch

changes since RFC:
 - mention the flashes which just support the "Global Unprotect" in the
   commit message

 drivers/mtd/spi-nor/atmel.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/mtd/spi-nor/atmel.c b/drivers/mtd/spi-nor/atmel.c
index 3f5f21a473a6..49d392c6c8bc 100644
--- a/drivers/mtd/spi-nor/atmel.c
+++ b/drivers/mtd/spi-nor/atmel.c
@@ -10,37 +10,27 @@
 
 static const struct flash_info atmel_parts[] = {
 	/* Atmel -- some are (confusingly) marketed as "DataFlash" */
-	{ "at25fs010",  INFO(0x1f6601, 0, 32 * 1024,   4, SECT_4K) },
-	{ "at25fs040",  INFO(0x1f6604, 0, 64 * 1024,   8, SECT_4K) },
+	{ "at25fs010",  INFO(0x1f6601, 0, 32 * 1024,   4, SECT_4K | SPI_NOR_HAS_LOCK) },
+	{ "at25fs040",  INFO(0x1f6604, 0, 64 * 1024,   8, SECT_4K | SPI_NOR_HAS_LOCK) },
 
-	{ "at25df041a", INFO(0x1f4401, 0, 64 * 1024,   8, SECT_4K) },
-	{ "at25df321",  INFO(0x1f4700, 0, 64 * 1024,  64, SECT_4K) },
-	{ "at25df321a", INFO(0x1f4701, 0, 64 * 1024,  64, SECT_4K) },
-	{ "at25df641",  INFO(0x1f4800, 0, 64 * 1024, 128, SECT_4K) },
+	{ "at25df041a", INFO(0x1f4401, 0, 64 * 1024,   8, SECT_4K | SPI_NOR_HAS_LOCK) },
+	{ "at25df321",  INFO(0x1f4700, 0, 64 * 1024,  64, SECT_4K | SPI_NOR_HAS_LOCK) },
+	{ "at25df321a", INFO(0x1f4701, 0, 64 * 1024,  64, SECT_4K | SPI_NOR_HAS_LOCK) },
+	{ "at25df641",  INFO(0x1f4800, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_HAS_LOCK) },
 
 	{ "at25sl321",	INFO(0x1f4216, 0, 64 * 1024, 64,
 			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 
 	{ "at26f004",   INFO(0x1f0400, 0, 64 * 1024,  8, SECT_4K) },
-	{ "at26df081a", INFO(0x1f4501, 0, 64 * 1024, 16, SECT_4K) },
-	{ "at26df161a", INFO(0x1f4601, 0, 64 * 1024, 32, SECT_4K) },
-	{ "at26df321",  INFO(0x1f4700, 0, 64 * 1024, 64, SECT_4K) },
+	{ "at26df081a", INFO(0x1f4501, 0, 64 * 1024, 16, SECT_4K | SPI_NOR_HAS_LOCK) },
+	{ "at26df161a", INFO(0x1f4601, 0, 64 * 1024, 32, SECT_4K | SPI_NOR_HAS_LOCK) },
+	{ "at26df321",  INFO(0x1f4700, 0, 64 * 1024, 64, SECT_4K | SPI_NOR_HAS_LOCK) },
 
 	{ "at45db081d", INFO(0x1f2500, 0, 64 * 1024, 16, SECT_4K) },
 };
 
-static void atmel_default_init(struct spi_nor *nor)
-{
-	nor->flags |= SNOR_F_HAS_LOCK;
-}
-
-static const struct spi_nor_fixups atmel_fixups = {
-	.default_init = atmel_default_init,
-};
-
 const struct spi_nor_manufacturer spi_nor_atmel = {
 	.name = "atmel",
 	.parts = atmel_parts,
 	.nparts = ARRAY_SIZE(atmel_parts),
-	.fixups = &atmel_fixups,
 };
-- 
2.20.1

