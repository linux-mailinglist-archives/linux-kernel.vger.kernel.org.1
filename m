Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2AC627F209
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 20:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730897AbgI3S6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 14:58:20 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44726 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729945AbgI3S6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 14:58:12 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08UIw46R118469;
        Wed, 30 Sep 2020 13:58:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601492284;
        bh=zkA4AffJRrJkr8FXLUnM7zUmkd1AUGYpPzzy5qdopek=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=WlWuHAgfezrviR1Qf/BXHMRggElk/aCaCn44CQ9dDtcAb9ZkvFsBAqzRuynF7Ntad
         LH0IiCNypBrOj/sHEJiT8rT9uppFKdicuUHGWi/oBJxui0U++6ZPj316uXX2qjILyV
         TcPKO7vHVuovJdAGIg9w3YgnE1KqKSnncxA60tfQ=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08UIw4AZ065363;
        Wed, 30 Sep 2020 13:58:04 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 13:58:04 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 30 Sep 2020 13:58:04 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08UIvX3I007008;
        Wed, 30 Sep 2020 13:58:01 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH v14 09/15] mtd: spi-nor: Introduce SNOR_F_IO_MODE_EN_VOLATILE
Date:   Thu, 1 Oct 2020 00:27:26 +0530
Message-ID: <20200930185732.6201-10-p.yadav@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930185732.6201-1-p.yadav@ti.com>
References: <20200930185732.6201-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

We don't want to enter a stateful mode, where a X-X-X I/O mode
is entered by setting a non-volatile bit, because in case of a
reset or a crash, once in the non-volatile mode, we may not be able
to recover in bootloaders and we may break the SPI NOR boot.

Forbid by default the I/O modes that are set via a non-volatile bit.

SPI_NOR_IO_MODE_EN_VOLATILE should be set just for the flashes that
don't define the optional SFDP SCCR Map, so that we don't pollute the
flash info flags.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/mtd/spi-nor/core.c | 6 ++++++
 drivers/mtd/spi-nor/core.h | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 6b54a923002a..b42d59ab2724 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3085,6 +3085,9 @@ static int spi_nor_octal_dtr_enable(struct spi_nor *nor, bool enable)
 	      nor->write_proto == SNOR_PROTO_8_8_8_DTR))
 		return 0;
 
+	if (!(nor->flags & SNOR_F_IO_MODE_EN_VOLATILE))
+		return 0;
+
 	ret = nor->params->octal_dtr_enable(nor, enable);
 	if (ret)
 		return ret;
@@ -3422,6 +3425,9 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 	if (info->flags & SPI_NOR_4B_OPCODES)
 		nor->flags |= SNOR_F_4B_OPCODES;
 
+	if (info->flags & SPI_NOR_IO_MODE_EN_VOLATILE)
+		nor->flags |= SNOR_F_IO_MODE_EN_VOLATILE;
+
 	ret = spi_nor_set_addr_width(nor);
 	if (ret)
 		return ret;
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 5cfe2db9ee13..105a4ddeb309 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -26,6 +26,7 @@ enum spi_nor_option_flags {
 	SNOR_F_HAS_SR_TB_BIT6	= BIT(11),
 	SNOR_F_HAS_4BIT_BP      = BIT(12),
 	SNOR_F_HAS_SR_BP3_BIT6  = BIT(13),
+	SNOR_F_IO_MODE_EN_VOLATILE = BIT(14),
 };
 
 struct spi_nor_read_command {
@@ -322,6 +323,11 @@ struct flash_info {
 					 */
 #define SPI_NOR_OCTAL_DTR_READ	BIT(19) /* Flash supports octal DTR Read. */
 #define SPI_NOR_OCTAL_DTR_PP	BIT(20) /* Flash supports Octal DTR Page Program */
+#define SPI_NOR_IO_MODE_EN_VOLATILE	BIT(21) /*
+						 * Flash enables the best
+						 * available I/O mode via a
+						 * volatile bit.
+						 */
 
 	/* Part specific fixup hooks. */
 	const struct spi_nor_fixups *fixups;
-- 
2.28.0

