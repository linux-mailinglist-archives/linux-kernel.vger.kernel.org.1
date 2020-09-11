Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB722664C9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 18:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgIKQpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 12:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgIKPIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:08:13 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA72C0612ED
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 07:47:21 -0700 (PDT)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1kGkKU-0006Pw-NV; Fri, 11 Sep 2020 16:47:10 +0200
Received: from mfe by dude02.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1kGkKP-0006nh-4Z; Fri, 11 Sep 2020 16:47:05 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     tudor.ambarus@microchip.com, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com,
        sergei.shtylyov@cogentembedded.com, boris.brezillon@collabora.com,
        michael@walle.cc, j.neuschaefer@gmx.net
Cc:     linux-mtd@lists.infradead.org, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] mtd: spi-nor: sst: move sst_write_second to local driver
Date:   Fri, 11 Sep 2020 16:47:03 +0200
Message-Id: <20200911144703.25409-4-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200911144703.25409-1-m.felsch@pengutronix.de>
References: <20200911144703.25409-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't mess the spi-nor core with details only relating to this specific
device. Handle the addr_width locally and drop the sst related stuff
from the spi-nor core to clean it up.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/mtd/spi-nor/core.c  |  3 ---
 drivers/mtd/spi-nor/sst.c   | 10 ++++++----
 include/linux/mtd/spi-nor.h |  2 --
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 31869ac245a8..fabd8ca4e801 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -173,9 +173,6 @@ static ssize_t spi_nor_spimem_write_data(struct spi_nor *nor, loff_t to,
 	op.addr.buswidth = spi_nor_get_protocol_addr_nbits(nor->write_proto);
 	op.data.buswidth = spi_nor_get_protocol_data_nbits(nor->write_proto);
 
-	if (nor->program_opcode == SPINOR_OP_AAI_WP && nor->sst_write_second)
-		op.addr.nbytes = 0;
-
 	if (spi_nor_spimem_bounce(nor, &op))
 		memcpy(nor->bouncebuf, buf, op.data.nbytes);
 
diff --git a/drivers/mtd/spi-nor/sst.c b/drivers/mtd/spi-nor/sst.c
index 644252e27a2a..7ca7e1a13511 100644
--- a/drivers/mtd/spi-nor/sst.c
+++ b/drivers/mtd/spi-nor/sst.c
@@ -58,10 +58,9 @@ static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
 	if (ret)
 		goto out;
 
-	nor->sst_write_second = false;
-
 	/* Start write from odd address. */
 	if (to % 2) {
+		nor->addr_width = 3;
 		nor->program_opcode = SPINOR_OP_BP;
 
 		/* write one byte. */
@@ -86,6 +85,8 @@ static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
 				goto out;
 		}
 
+		/* Send address only once for each AAI_WP cycle */
+		nor->addr_width = (actual > 1) ? 0 : 3;
 		nor->program_opcode = SPINOR_OP_AAI_WP;
 
 		/* write two bytes. */
@@ -97,9 +98,7 @@ static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
 		if (ret)
 			goto out;
 		to += 2;
-		nor->sst_write_second = true;
 	}
-	nor->sst_write_second = false;
 
 	ret = spi_nor_write_disable(nor);
 	if (ret)
@@ -115,6 +114,7 @@ static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
 		if (ret)
 			goto out;
 
+		nor->addr_width = 3;
 		nor->program_opcode = SPINOR_OP_BP;
 		ret = spi_nor_write_data(nor, to, 1, buf + actual);
 		if (ret < 0)
@@ -129,6 +129,8 @@ static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
 		ret = spi_nor_write_disable(nor);
 	}
 out:
+	/* Set to default in case no trailing bytes are written */
+	nor->addr_width = 3;
 	*retlen += actual;
 	spi_nor_unlock_and_unprep(nor);
 	return ret;
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 60bac2c0ec45..4368c0c41fda 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -343,7 +343,6 @@ struct spi_nor_flash_parameter;
  * @read_opcode:	the read opcode
  * @read_dummy:		the dummy needed by the read operation
  * @program_opcode:	the program opcode
- * @sst_write_second:	used by the SST write operation
  * @flags:		flag options for the current SPI NOR (SNOR_F_*)
  * @read_proto:		the SPI protocol for read operations
  * @write_proto:	the SPI protocol for write operations
@@ -374,7 +373,6 @@ struct spi_nor {
 	enum spi_nor_protocol	read_proto;
 	enum spi_nor_protocol	write_proto;
 	enum spi_nor_protocol	reg_proto;
-	bool			sst_write_second;
 	u32			flags;
 
 	const struct spi_nor_controller_ops *controller_ops;
-- 
2.20.1

