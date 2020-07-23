Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0596B22B018
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 15:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbgGWNM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 09:12:57 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:35667 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgGWNM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 09:12:56 -0400
X-Originating-IP: 42.109.196.68
Received: from localhost.localdomain (unknown [42.109.196.68])
        (Authenticated sender: me@yadavpratyush.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id EABE71C0009;
        Thu, 23 Jul 2020 13:12:50 +0000 (UTC)
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sekhar Nori <nsekhar@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Pratyush Yadav <me@yadavpratyush.com>
Subject: [PATCH v11 07/14] mtd: spi-nor: core: do 2 byte reads for SR and FSR in DTR mode
Date:   Thu, 23 Jul 2020 18:41:56 +0530
Message-Id: <20200723131203.40916-8-me@yadavpratyush.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200723131203.40916-1-me@yadavpratyush.com>
References: <20200723131203.40916-1-me@yadavpratyush.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pratyush Yadav <p.yadav@ti.com>

Some controllers, like the cadence qspi controller, have trouble reading
only 1 byte in DTR mode. So, do 2 byte reads for SR and FSR commands in
DTR mode, and then discard the second byte.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/mtd/spi-nor/core.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 185ca1fa2b50..6efc86e2aba0 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -364,7 +364,7 @@ int spi_nor_write_disable(struct spi_nor *nor)
  * spi_nor_read_sr() - Read the Status Register.
  * @nor:	pointer to 'struct spi_nor'.
  * @sr:		pointer to a DMA-able buffer where the value of the
- *              Status Register will be written.
+ *              Status Register will be written. Should be at least 2 bytes.
  *
  * Return: 0 on success, -errno otherwise.
  */
@@ -382,6 +382,11 @@ static int spi_nor_read_sr(struct spi_nor *nor, u8 *sr)
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
@@ -400,7 +405,8 @@ static int spi_nor_read_sr(struct spi_nor *nor, u8 *sr)
  * spi_nor_read_fsr() - Read the Flag Status Register.
  * @nor:	pointer to 'struct spi_nor'
  * @fsr:	pointer to a DMA-able buffer where the value of the
- *              Flag Status Register will be written.
+ *              Flag Status Register will be written. Should be at least 2
+ *              bytes.
  *
  * Return: 0 on success, -errno otherwise.
  */
@@ -418,6 +424,11 @@ static int spi_nor_read_fsr(struct spi_nor *nor, u8 *fsr)
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
2.27.0

