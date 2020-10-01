Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9EA228085C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 22:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733125AbgJAUV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 16:21:26 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40554 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733109AbgJAUVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 16:21:21 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 091KL8Mi064365;
        Thu, 1 Oct 2020 15:21:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601583668;
        bh=BJqCGX9X3t8Cje5i2Bz3GRmY8vEXd5BjTewAqCBn7Sw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=uE3N0avIzJUmUk9L1/6xRmN1HOshs4uEUsVYVJCKURJxidDTViuX4qmBYqtXMszLH
         sz9PFJ+AyPd5qB/LGf79N3RiuvEY70cNpIMVT7j8nGz4f0OToZln3kBmGJq+JNKxAR
         f4JvHkgv9kNTHneXY9qNks1V7tzHO9Mo4mPWTq9E=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 091KL8Ae071293
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Oct 2020 15:21:08 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 1 Oct
 2020 15:21:08 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 1 Oct 2020 15:21:07 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 091KKkcL123930;
        Thu, 1 Oct 2020 15:21:05 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH v15 06/15] mtd: spi-nor: core: use dummy cycle and address width info from SFDP
Date:   Fri, 2 Oct 2020 01:50:36 +0530
Message-ID: <20201001202045.21499-7-p.yadav@ti.com>
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

The xSPI Profile 1.0 table specifies how many dummy cycles and address
bytes are needed for the Read Status Register command in octal DTR mode.
Use that information to send the correct Read SR command.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index ad280874a2e8..b5bb4d6cffc1 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -385,6 +385,11 @@ static int spi_nor_read_sr(struct spi_nor *nor, u8 *sr)
 				   SPI_MEM_OP_NO_DUMMY,
 				   SPI_MEM_OP_DATA_IN(1, sr, 0));
 
+		if (nor->reg_proto == SNOR_PROTO_8_8_8_DTR) {
+			op.addr.nbytes = nor->params->rdsr_addr_nbytes;
+			op.dummy.nbytes = nor->params->rdsr_dummy;
+		}
+
 		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
@@ -418,6 +423,11 @@ static int spi_nor_read_fsr(struct spi_nor *nor, u8 *fsr)
 				   SPI_MEM_OP_NO_DUMMY,
 				   SPI_MEM_OP_DATA_IN(1, fsr, 0));
 
+		if (nor->reg_proto == SNOR_PROTO_8_8_8_DTR) {
+			op.addr.nbytes = nor->params->rdsr_addr_nbytes;
+			op.dummy.nbytes = nor->params->rdsr_dummy;
+		}
+
 		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
-- 
2.28.0

