Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14034280857
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 22:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732925AbgJAUVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 16:21:07 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40480 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbgJAUVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 16:21:07 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 091KKrCg064297;
        Thu, 1 Oct 2020 15:20:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601583653;
        bh=dgLCDmGqqsDBbyMIliBwVzUNzePc3HpV7xTby1yCRi8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ZMaPxH2XfI3jlhW/QznOBUhrHYMS17ENc5o1aX7a00jatmfho+STsTp4k65c9oZNo
         PJUj+yG84uMc8nZwtXtKsPb1C/QhR2+WXVbZ2hacjRDTKt7CSOczWW9uPXITP21Ogi
         rl+GcGC/n3IIx3LzaJ3ETu4tPtupz7T8UucPpJ44=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 091KKrsN125930
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Oct 2020 15:20:53 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 1 Oct
 2020 15:20:52 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 1 Oct 2020 15:20:52 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 091KKkcG123930;
        Thu, 1 Oct 2020 15:20:50 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH v15 01/15] mtd: spi-nor: core: use EOPNOTSUPP instead of ENOTSUPP
Date:   Fri, 2 Oct 2020 01:50:31 +0530
Message-ID: <20201001202045.21499-2-p.yadav@ti.com>
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

ENOTSUPP is not a SUSV4 error code. Using EOPNOTSUPP is preferred
in its stead.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 0369d98b2d12..4d0f8d165544 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2281,7 +2281,7 @@ static int spi_nor_hwcaps_pp2cmd(u32 hwcaps)
  *@nor:        pointer to a 'struct spi_nor'
  *@op:         pointer to op template to be checked
  *
- * Returns 0 if operation is supported, -ENOTSUPP otherwise.
+ * Returns 0 if operation is supported, -EOPNOTSUPP otherwise.
  */
 static int spi_nor_spimem_check_op(struct spi_nor *nor,
 				   struct spi_mem_op *op)
@@ -2295,12 +2295,12 @@ static int spi_nor_spimem_check_op(struct spi_nor *nor,
 	op->addr.nbytes = 4;
 	if (!spi_mem_supports_op(nor->spimem, op)) {
 		if (nor->mtd.size > SZ_16M)
-			return -ENOTSUPP;
+			return -EOPNOTSUPP;
 
 		/* If flash size <= 16MB, 3 address bytes are sufficient */
 		op->addr.nbytes = 3;
 		if (!spi_mem_supports_op(nor->spimem, op))
-			return -ENOTSUPP;
+			return -EOPNOTSUPP;
 	}
 
 	return 0;
@@ -2312,7 +2312,7 @@ static int spi_nor_spimem_check_op(struct spi_nor *nor,
  *@nor:         pointer to a 'struct spi_nor'
  *@read:        pointer to op template to be checked
  *
- * Returns 0 if operation is supported, -ENOTSUPP otherwise.
+ * Returns 0 if operation is supported, -EOPNOTSUPP otherwise.
  */
 static int spi_nor_spimem_check_readop(struct spi_nor *nor,
 				       const struct spi_nor_read_command *read)
@@ -2338,7 +2338,7 @@ static int spi_nor_spimem_check_readop(struct spi_nor *nor,
  *@nor:         pointer to a 'struct spi_nor'
  *@pp:          pointer to op template to be checked
  *
- * Returns 0 if operation is supported, -ENOTSUPP otherwise.
+ * Returns 0 if operation is supported, -EOPNOTSUPP otherwise.
  */
 static int spi_nor_spimem_check_pp(struct spi_nor *nor,
 				   const struct spi_nor_pp_command *pp)
-- 
2.28.0

