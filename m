Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4510527C1CB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 12:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgI2KAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 06:00:01 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:46855 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgI2J76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 05:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1601373597; x=1632909597;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zj5Q3mRato2NGNAAfnW3tQlSDG2rqHg7C0p4y7YGyBg=;
  b=bfoBG0inA7DTj9bqabLMtGxPNDUsW33jPHGN8AVX7/lRrARTyKF23vOZ
   OEmJDT3V3iWdnW3ymCxSG/XNV1rmsK1YrAwJbRD9PxCOasHF+Ir8RzzFa
   OsInP0dCaQyQv9jLer0DqyLwAbtgfZrfqVKajZTVi/YmKksulYeRRnCAi
   4qmXPaGuV1b5J6aFd9ffFcSPVxqwuXIlw+S5KhuoDjj1xtM0P2igDRE3V
   Ml7Qi7Efe+Od9f89Ur1/ow4IIf4GDwa9wpA6O/O/ckgJlSAXpo/jIU6+O
   t/pkMARQ+WvQRm5rTvFvbAKVEuSGFaUdot1jOFmmQQqzkgEpqe4lcWtsn
   g==;
IronPort-SDR: AHRt/oWDvV0oJ9fGM6xCZt8rUT7PclAsmwXI+CUUQJeA+SeVgzM32U2DMz8H/kaX8K7C3yZleT
 TDoaTiEahnkoqEfxxOl7/spXgFlAJrTYBfhzWzTZZWCRe7Lmzirf0ArrI2Ig5AiLxeKHE8+UFk
 l0tVJCGvydbBMe88wsipF0aucjkEQ9NnDavrv4NMYDBQuwjn7FIShjNwtXL8dEM7PH+h+mAxWz
 zzzVejZr3ZPCHObbVRXVeKsFNJMLaBqecBz8FgqMNSfW6eixfXOkExypAa18m7UJk7+fEm8tzm
 Tok=
X-IronPort-AV: E=Sophos;i="5.77,318,1596524400"; 
   d="scan'208";a="93570882"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Sep 2020 02:59:57 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 29 Sep 2020 02:59:47 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 29 Sep 2020 02:59:45 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <p.yadav@ti.com>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [RFC PATCH 1/3] mtd: spi-nor: Introduce SNOR_F_IO_MODE_EN_VOLATILE
Date:   Tue, 29 Sep 2020 12:59:49 +0300
Message-ID: <20200929095951.1575658-2-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200929095951.1575658-1-tudor.ambarus@microchip.com>
References: <20200916124418.833-1-p.yadav@ti.com>
 <20200929095951.1575658-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't want to enter a stateful mode, where a X-X-X I/O mode
is entered by setting a non-volatile bit, because in case of a
reset or a crash, once in the non-volatile mode, we may not be able
to recover in bootloaders and we may break the SPI NOR boot.

Forbid by default the I/O modes that are set via a non-volatile bit.

SPI_NOR_IO_MODE_EN_VOLATILE should be set just for the flashes that
don't define the optional SFDP SCCR Map, so that we don't pollute the
flash info flags.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/core.c | 6 ++++++
 drivers/mtd/spi-nor/core.h | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 34edfcf33172..c149b318e2e8 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3089,6 +3089,9 @@ static int spi_nor_octal_dtr_enable(struct spi_nor *nor, bool enable)
 	      nor->write_proto == SNOR_PROTO_8_8_8_DTR))
 		return 0;
 
+	if (!(nor->flags & SNOR_F_IO_MODE_EN_VOLATILE))
+		return 0;
+
 	ret = nor->params->octal_dtr_enable(nor, enable);
 	if (ret)
 		return ret;
@@ -3474,6 +3477,9 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 	if (info->flags & SPI_NOR_4B_OPCODES)
 		nor->flags |= SNOR_F_4B_OPCODES;
 
+	if (info->flags & SPI_NOR_IO_MODE_EN_VOLATILE)
+		nor->flags |= SNOR_F_IO_MODE_EN_VOLATILE;
+
 	ret = spi_nor_set_addr_width(nor);
 	if (ret)
 		return ret;
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 10dc03506f93..c2755c82f978 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -27,6 +27,7 @@ enum spi_nor_option_flags {
 	SNOR_F_HAS_4BIT_BP      = BIT(12),
 	SNOR_F_HAS_SR_BP3_BIT6  = BIT(13),
 	SNOR_F_SOFT_RESET	= BIT(14),
+	SNOR_F_IO_MODE_EN_VOLATILE = BIT(15),
 };
 
 struct spi_nor_read_command {
@@ -323,6 +324,11 @@ struct flash_info {
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
2.25.1

