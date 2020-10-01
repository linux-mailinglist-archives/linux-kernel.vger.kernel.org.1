Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB3F3280861
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 22:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733158AbgJAUVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 16:21:35 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40570 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732981AbgJAUV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 16:21:26 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 091KLBo7064376;
        Thu, 1 Oct 2020 15:21:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601583671;
        bh=6NG3n01K4+FgsNnxkTAsyT+h+zhaIb41wGdN/1KBajk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=kIydgDPuBr5rK/QzVcmgs3Tai2jSMw5GLP+gCK4r0aV0OOZgzzwoKJK2camYDP1X5
         aLAoDVoBJ9EkF7z2Fvm98UubPOHj8uMQcWMgHi847hoWC9Oku6sm2cSLVbw+XhFKqQ
         ZGsoi8FIlXsnl9QioyiPZoqSi22UiLCwwtdCCzAA=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 091KLB4G022026
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Oct 2020 15:21:11 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 1 Oct
 2020 15:21:11 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 1 Oct 2020 15:21:11 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 091KKkcM123930;
        Thu, 1 Oct 2020 15:21:08 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH v15 07/15] mtd: spi-nor: core: do 2 byte reads for SR and FSR in DTR mode
Date:   Fri, 2 Oct 2020 01:50:37 +0530
Message-ID: <20201001202045.21499-8-p.yadav@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201001202045.21499-1-p.yadav@ti.com>
References: <20201001202045.21499-1-p.yadav@ti.com>
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
Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/core.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index b5bb4d6cffc1..b83bf5ed2b2d 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -370,7 +370,7 @@ int spi_nor_write_disable(struct spi_nor *nor)
  * spi_nor_read_sr() - Read the Status Register.
  * @nor:	pointer to 'struct spi_nor'.
  * @sr:		pointer to a DMA-able buffer where the value of the
- *              Status Register will be written.
+ *              Status Register will be written. Should be at least 2 bytes.
  *
  * Return: 0 on success, -errno otherwise.
  */
@@ -388,6 +388,11 @@ static int spi_nor_read_sr(struct spi_nor *nor, u8 *sr)
 		if (nor->reg_proto == SNOR_PROTO_8_8_8_DTR) {
 			op.addr.nbytes = nor->params->rdsr_addr_nbytes;
 			op.dummy.nbytes = nor->params->rdsr_dummy;
+			/*
+			 * We don't want to read only one byte in DTR mode. So,
+			 * read 2 and then discard the second byte.
+			 */
+			op.data.nbytes = 2;
 		}
 
 		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
@@ -408,7 +413,8 @@ static int spi_nor_read_sr(struct spi_nor *nor, u8 *sr)
  * spi_nor_read_fsr() - Read the Flag Status Register.
  * @nor:	pointer to 'struct spi_nor'
  * @fsr:	pointer to a DMA-able buffer where the value of the
- *              Flag Status Register will be written.
+ *              Flag Status Register will be written. Should be at least 2
+ *              bytes.
  *
  * Return: 0 on success, -errno otherwise.
  */
@@ -426,6 +432,11 @@ static int spi_nor_read_fsr(struct spi_nor *nor, u8 *fsr)
 		if (nor->reg_proto == SNOR_PROTO_8_8_8_DTR) {
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

