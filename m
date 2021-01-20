Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 657612FD1D0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 14:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389900AbhATN3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 08:29:42 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:60843 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733284AbhATNUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:20:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611148848; x=1642684848;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nu0DWecPAvplEFUztuBszcCe7KUNT4UBQzzQs4ZKFo0=;
  b=ADMBr+AhkTaPQGeleF8d6JBYH/bedGz7HflGrAF6PuBV2DDPrvblfTxO
   SMNZCwD5WQR/QFPh1c/eTzytjeOibNMwvF4NMhY5jAd9+pAk/1waBvxRx
   7LkVoO9P1G/Yd9cpj0jzJUmfs0s+Kt65a7J24Vr8raLTSEqXytCxpigsD
   RSHthf7Qw0Frp6YOJBvu2wXmdClQMwKgJVrslq65CFlVNgThn8BL/8+JS
   B0NUjzEZ0oWxRsNp8VEHWZdX9TZk6SALZR1QfSQdNSUC8yIaXd71Qlp4s
   Yf1NomNzlGuwbUhphJVlCkdqn9DAsOIV1j+323CRn20+7dppkulpyT02p
   g==;
IronPort-SDR: RMswkpPqUOQAYorY/yLoY5ZCKWZHqUaXFqjyw0qI2mjtYZrhZ0mhPPfKtzCeAmVZScD+8Kn0J9
 HOFXxCvz1i57rGbCHpMH7OjHa7EcHdHX5ozMBXtCfobV5eTM7mkw+r4vXIIG7vhpa1cWj3JWW6
 XBHZz/FPdSSCcajgcy9EdGee0Med7SelV15D25cVVrU7dqKjmguuvLTDTAdFRVgFX0JuXxbCRG
 qPS8ot51TmUmyzEb7r+ThB3I6mhhtR5wSu9F5UfCieU4/2tOhZEceSNzxUC1CncvkJwnX8bXqT
 Khw=
X-IronPort-AV: E=Sophos;i="5.79,361,1602572400"; 
   d="scan'208";a="106102990"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jan 2021 06:19:32 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 20 Jan 2021 06:19:21 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 20 Jan 2021 06:19:19 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <michael@walle.cc>, <vigneshr@ti.com>, <p.yadav@ti.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Kavyasree.Kotagiri@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v2 2/2] mtd: spi-nor: sst: Add support for Global Unlock on sst26vf
Date:   Wed, 20 Jan 2021 15:19:14 +0200
Message-ID: <20210120131914.277363-2-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210120131914.277363-1-tudor.ambarus@microchip.com>
References: <20210120131914.277363-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even if sst26vf shares the SPINOR_OP_GBULK opcode with
Macronix (ex. MX25U12835F) and Winbound (ex. W25Q128FV),
it has its own Individual Block Protection scheme, which
is also capable to read-lock individual parameter blocks.
Thus the sst26vf's Individual Block Protection scheme will
reside in the sst.c manufacturer driver.

Add support to unlock the entire flash memory. The device
is write-protected by default after a power-on reset cycle
(volatile software protection), in order to avoid inadvertent
writes during power-up. Could do an erase, write, read back,
and compare when MTD_SPI_NOR_SWP_DISABLE_ON_VOLATILE=y.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
v2: s/!ofs/ofs == 0/

 drivers/mtd/spi-nor/sst.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/sst.c b/drivers/mtd/spi-nor/sst.c
index 00e48da0744a..d6e1396abb96 100644
--- a/drivers/mtd/spi-nor/sst.c
+++ b/drivers/mtd/spi-nor/sst.c
@@ -8,6 +8,39 @@
 
 #include "core.h"
 
+static int sst26vf_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
+{
+	return -EOPNOTSUPP;
+}
+
+static int sst26vf_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
+{
+	if (ofs == 0 && len == nor->params->size)
+		return spi_nor_global_block_unlock(nor);
+
+	return -EOPNOTSUPP;
+}
+
+static int sst26vf_is_locked(struct spi_nor *nor, loff_t ofs, uint64_t len)
+{
+	return -EOPNOTSUPP;
+}
+
+static const struct spi_nor_locking_ops sst26vf_locking_ops = {
+	.lock = sst26vf_lock,
+	.unlock = sst26vf_unlock,
+	.is_locked = sst26vf_is_locked,
+};
+
+static void sst26vf_default_init(struct spi_nor *nor)
+{
+	nor->params->locking_ops = &sst26vf_locking_ops;
+}
+
+static const struct spi_nor_fixups sst26vf_fixups = {
+	.default_init = sst26vf_default_init,
+};
+
 static const struct flash_info sst_parts[] = {
 	/* SST -- large erase sizes are "overlays", "sectors" are 4K */
 	{ "sst25vf040b", INFO(0xbf258d, 0, 64 * 1024,  8,
@@ -39,8 +72,9 @@ static const struct flash_info sst_parts[] = {
 	{ "sst26vf016b", INFO(0xbf2641, 0, 64 * 1024, 32,
 			      SECT_4K | SPI_NOR_DUAL_READ) },
 	{ "sst26vf064b", INFO(0xbf2643, 0, 64 * 1024, 128,
-			      SECT_4K | SPI_NOR_DUAL_READ |
-			      SPI_NOR_QUAD_READ) },
+			      SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			      SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
+		.fixups = &sst26vf_fixups },
 };
 
 static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
-- 
2.25.1

