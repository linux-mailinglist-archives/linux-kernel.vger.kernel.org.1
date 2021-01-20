Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1092FCF99
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 13:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732984AbhATLj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 06:39:58 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:55790 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388390AbhATKzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 05:55:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611140138; x=1642676138;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j9SnMxFMohMOhtRc0zyIy62dahNt9twPv6q6Qyrq+JU=;
  b=Psnu83VjCjtrkKDjuFTWh0pEY4zHU5bbsXHMGgnTD2Ixdw3VU6ktjKGi
   CLLJoZh68NX5UOgR5fSYrU4LMMhFVRDTC0AcJ/icRV6GUKmmrKxZwRoYI
   bzT4xhefVuSb7dddYN5pFSpMIaAGFKm4uDMBuMCBGGGfLUHDgqspyqNhP
   OGlNbIOfIAzXiR3/wXNgP+msDJOHGLymK9t/avH5LUQmpgFhreW3PGxCT
   6P1XHJb6lqzHorGPUSxoowiNUxM4VgWbRitQfwdq7bli27RUTvoLJCz2B
   oBZkfG0HN8O9MNurTlvFHbrRO6c1pNKwv/aDlUPsDT0prlqDzTy4F4MoQ
   Q==;
IronPort-SDR: FwvCSXSfRcvvq/mR7riRqT5eHSIaKncCcYxII/fQ2vWU9xZp4tR0h/C3ljKVyx/nfQysWWOkx+
 DVIqClboniCRcUelX/JI/deIL9xrk6zru/ky7zEuOrYEfJwB7nxcQ6tXvwfshRHy7JUgd9rIp4
 2TyL8X//J6M1VOBc0dn72JpDHGEc16uf5VLrSD3LRM8aUJHxyLBm9tU1+zPzZZ6SZRiFYWawfm
 A10BPUhARqq2Kh8qSnVUyGMlueubsj/fyG53NdQ1gPSKwTuVdXdzUgyE1++NWBIikbUMsBgY/7
 so0=
X-IronPort-AV: E=Sophos;i="5.79,361,1602572400"; 
   d="scan'208";a="111756525"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jan 2021 03:54:20 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 20 Jan 2021 03:54:19 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 20 Jan 2021 03:54:17 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <michael@walle.cc>, <vigneshr@ti.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Kavyasree.Kotagiri@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH 2/2] mtd: spi-nor: sst: Add support for Global Unlock on sst26vf
Date:   Wed, 20 Jan 2021 12:54:11 +0200
Message-ID: <20210120105411.254890-2-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210120105411.254890-1-tudor.ambarus@microchip.com>
References: <20210120105411.254890-1-tudor.ambarus@microchip.com>
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
 drivers/mtd/spi-nor/sst.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/sst.c b/drivers/mtd/spi-nor/sst.c
index 00e48da0744a..1cd2a360c41e 100644
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
+	if (!ofs && len == nor->params->size)
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

