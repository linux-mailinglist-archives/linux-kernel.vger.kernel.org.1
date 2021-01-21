Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5402D2FE86A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 12:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbhAULJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 06:09:44 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:31770 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730100AbhAULHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 06:07:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611227230; x=1642763230;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZW2Po+iRxqwT+mLgUcs2IUScO0elOp7Zu2+SE07oNTg=;
  b=WEhXanOE2tPDR4lmm4NTMoAGdf5kW0PxNDR4FbXINyVie/dk0PJebiSW
   e73DCwkZNqk/BH8VYmFtFa8NP3vafAZF9TSq2XN5BGjaqOXWiKvhpo0ED
   vAqAdAqWBYoaBdFAd5fRV7Unf4LtegH8cIK/Og0i5/VM8KBBXbhjwbdVZ
   FJtMYpQtcMIhClmX93UsxiIfzkzUVRFXd44f2sv321w81+aVLws2su5al
   SI38w+7gFlBnwY8mS1cx+gwe5D+WWcQcOiiag4f06mZs9koVYCn2/W7Mp
   SG3mV5IWHemKga5JgAgmPQHCx/wyp+Evy67kEjbcqIok85Lk+B8GTZQIE
   A==;
IronPort-SDR: c908ihq3s6qI/Sif7VnrLhVUNLfjLsIr6rxzGXoN55VhrNfnXEnIosSRiPJbIehqzlyO4BgW52
 nvr+MRdP/phDe9P2604xtpds2MkReu8UrXboBT6sf5r61RbjUnhp8VhDdDiFuBuBpHvL8+I+Ko
 6ogWZ0G03zHhRLfX/D/PV839lCqyJBruM0SwqU1PDCdbFKDrQNQ3pWkQnf9cf69L8xnuemVglA
 K/lZGimaQmUBGN2XPOyrT+WRR7NeCEXK+/aJPr5kquZA/pZRESsvOoZMuCG2XsccEks/UD2pD1
 Hhs=
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="106240014"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jan 2021 04:05:54 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 21 Jan 2021 04:05:53 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 21 Jan 2021 04:05:50 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <michael@walle.cc>, <vigneshr@ti.com>, <p.yadav@ti.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Kavyasree.Kotagiri@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v3 2/2] mtd: spi-nor: sst: Add support for Global Unlock on sst26vf
Date:   Thu, 21 Jan 2021 13:05:46 +0200
Message-ID: <20210121110546.382633-2-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121110546.382633-1-tudor.ambarus@microchip.com>
References: <20210121110546.382633-1-tudor.ambarus@microchip.com>
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
v3:
- s/Winbound/Winbond/
- read CR.BPNV and check if we can really unlock the entire flash array
- sst26vf_unlock: return -EINVAL instead of -EOPNOTSUPP when caller
asks to unlock a range/granularity that we can't unlock

v2: v2: s/!ofs/ofs == 0/

 drivers/mtd/spi-nor/core.c |  2 +-
 drivers/mtd/spi-nor/core.h |  1 +
 drivers/mtd/spi-nor/sst.c  | 52 ++++++++++++++++++++++++++++++++++++--
 3 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index e82732dd31e1..c50b30fbb912 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -465,7 +465,7 @@ static int spi_nor_read_fsr(struct spi_nor *nor, u8 *fsr)
  *
  * Return: 0 on success, -errno otherwise.
  */
-static int spi_nor_read_cr(struct spi_nor *nor, u8 *cr)
+int spi_nor_read_cr(struct spi_nor *nor, u8 *cr)
 {
 	int ret;
 
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index eb26796db026..4a3f7f150b5d 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -441,6 +441,7 @@ int spi_nor_sr1_bit6_quad_enable(struct spi_nor *nor);
 int spi_nor_sr2_bit1_quad_enable(struct spi_nor *nor);
 int spi_nor_sr2_bit7_quad_enable(struct spi_nor *nor);
 int spi_nor_read_sr(struct spi_nor *nor, u8 *sr);
+int spi_nor_read_cr(struct spi_nor *nor, u8 *cr);
 int spi_nor_write_sr(struct spi_nor *nor, const u8 *sr, size_t len);
 int spi_nor_write_sr_and_check(struct spi_nor *nor, u8 sr1);
 
diff --git a/drivers/mtd/spi-nor/sst.c b/drivers/mtd/spi-nor/sst.c
index 00e48da0744a..980f4c09c91d 100644
--- a/drivers/mtd/spi-nor/sst.c
+++ b/drivers/mtd/spi-nor/sst.c
@@ -8,6 +8,53 @@
 
 #include "core.h"
 
+#define SST26VF_CR_BPNV		BIT(3)
+
+static int sst26vf_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
+{
+	return -EOPNOTSUPP;
+}
+
+static int sst26vf_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
+{
+	int ret;
+
+	/* We only support unlocking the entire flash array. */
+	if (ofs != 0 || len != nor->params->size)
+		return -EINVAL;
+
+	ret = spi_nor_read_cr(nor, nor->bouncebuf);
+	if (ret)
+		return ret;
+
+	if (!(nor->bouncebuf[0] & SST26VF_CR_BPNV)) {
+		dev_dbg(nor->dev, "Any block has been permanently locked\n");
+		return -EINVAL;
+	}
+
+	return spi_nor_global_block_unlock(nor);
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
@@ -39,8 +86,9 @@ static const struct flash_info sst_parts[] = {
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

