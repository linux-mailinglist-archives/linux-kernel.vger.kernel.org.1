Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98A42A74FB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 02:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731513AbgKEBoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 20:44:30 -0500
Received: from twhmllg4.macronix.com ([122.147.135.202]:53575 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKEBoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 20:44:30 -0500
Received: from localhost.localdomain ([172.17.195.95])
        by TWHMLLG4.macronix.com with ESMTP id 0A51hJih070037;
        Thu, 5 Nov 2020 09:43:19 +0800 (GMT-8)
        (envelope-from ycllin@mxic.com.tw)
From:   YouChing Lin <ycllin@mxic.com.tw>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     juliensu@mxic.com.tw, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, ycllin@mxic.com.tw
Subject: [PATCH v2] mtd: spinand: macronix: Add support for MX35LFxGE4AD
Date:   Thu,  5 Nov 2020 09:43:13 +0800
Message-Id: <1604540593-9829-1-git-send-email-ycllin@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
X-MAIL: TWHMLLG4.macronix.com 0A51hJih070037
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Macronix MX35LF2GE4AD / MX35LF4GE4AD are 3V, 2G / 4Gbit serial
SLC NAND flash device (with on-die ECC).

Validated by read, erase, read back, write, read back and nandtest
on Xilinx Zynq PicoZed FPGA board which included Macronix SPI Host
(drivers/spi/spi-mxic.c).

v2: Removed the unnecessary "/*SPINAND_HAS_QE_BIT*/" as per the comments.

v1: Add support for MX35LFxGE4AD

Signed-off-by: YouChing Lin <ycllin@mxic.com.tw>
---
 drivers/mtd/nand/spi/macronix.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
index 8e801e4..3786b1b 100644
--- a/drivers/mtd/nand/spi/macronix.c
+++ b/drivers/mtd/nand/spi/macronix.c
@@ -119,6 +119,26 @@ static int mx35lf1ge4ab_ecc_get_status(struct spinand_device *spinand,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
+	SPINAND_INFO("MX35LF2GE4AD",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x26),
+		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35LF4GE4AD",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x37),
+		     NAND_MEMORG(1, 4096, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
 	SPINAND_INFO("MX31LF1GE4BC",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x1e),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
-- 
1.9.1

