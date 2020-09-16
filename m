Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA9126DA4B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgIQLdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:33:22 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:53792 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbgIQL1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:27:53 -0400
X-Greylist: delayed 24715 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 07:27:22 EDT
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08GCikrT073721;
        Wed, 16 Sep 2020 07:44:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600260286;
        bh=CKHgmJWPb3bVn2eZwKmoyTawTcp8T99/wZEZ4Kh7wHk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Tc1yZhCBT5SEBRa2HgeXq4d6bqxyZSkIvKm8dyG4Ofq7BMURmdQV2cVJbc6Np5JjB
         EiiBO70VjtbKilTR5k6Po5n3d/BAX0BIx0aGJqy4mhRUs9cgvSx7UKvWNnF9EztaWR
         m1PTVij+O4tTJ8wK/IJqBhNTmXmvOvsEsZP6jMwA=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08GCikv5070046
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Sep 2020 07:44:46 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 16
 Sep 2020 07:44:46 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 16 Sep 2020 07:44:46 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08GCiIpc125391;
        Wed, 16 Sep 2020 07:44:43 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH v13 08/15] mtd: spi-nor: core: do 2 byte reads for SR and FSR in DTR mode
Date:   Wed, 16 Sep 2020 18:14:11 +0530
Message-ID: <20200916124418.833-9-p.yadav@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200916124418.833-1-p.yadav@ti.com>
References: <20200916124418.833-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some controllers, like the cadence qspi controller, have trouble reading
only 1 byte in DTR mode. So, do 2 byte reads for SR and FSR commands in
DTR mode, and then discard the second byte.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/mtd/spi-nor/core.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 88c9e18067f4..87c568debf14 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -368,7 +368,7 @@ int spi_nor_write_disable(struct spi_nor *nor)
  * spi_nor_read_sr() - Read the Status Register.
  * @nor:	pointer to 'struct spi_nor'.
  * @sr:		pointer to a DMA-able buffer where the value of the
- *              Status Register will be written.
+ *              Status Register will be written. Should be at least 2 bytes.
  *
  * Return: 0 on success, -errno otherwise.
  */
@@ -386,6 +386,11 @@ static int spi_nor_read_sr(struct spi_nor *nor, u8 *sr)
 		if (spi_nor_protocol_is_dtr(nor->reg_proto)) {
 			op.addr.nbytes = nor->params->rdsr_addr_nbytes;
 			op.dummy.nbytes = nor->params->rdsr_dummy;
+			/*
+			 * We don't want to read only one byte in DTR mode. So,
+			 * read 2 and then discard the second byte.
+			 */
+			op.data.nbytes = 2;
 		}
 
 		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
@@ -405,7 +410,8 @@ static int spi_nor_read_sr(struct spi_nor *nor, u8 *sr)
  * spi_nor_read_fsr() - Read the Flag Status Register.
  * @nor:	pointer to 'struct spi_nor'
  * @fsr:	pointer to a DMA-able buffer where the value of the
- *              Flag Status Register will be written.
+ *              Flag Status Register will be written. Should be at least 2
+ *              bytes.
  *
  * Return: 0 on success, -errno otherwise.
  */
@@ -423,6 +429,11 @@ static int spi_nor_read_fsr(struct spi_nor *nor, u8 *fsr)
 		if (spi_nor_protocol_is_dtr(nor->reg_proto)) {
 			op.addr.nbytes = nor->params->rdsr_addr_nbytes;
 			op.dummy.nbytes = nor->params->rdsr_dummy;
+			/*
+			 * We don't want to read only one byte in DTR mode. So,
+			 * read 2 and then discard the second byte.
+			 */
+			op.data.nbytes = 2;
 		}
 
 		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
-- 
2.28.0

