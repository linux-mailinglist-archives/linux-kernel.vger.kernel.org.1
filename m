Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C85DD27F20B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 20:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730175AbgI3S6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 14:58:16 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44674 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730117AbgI3S57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 14:57:59 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08UIveSq118396;
        Wed, 30 Sep 2020 13:57:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601492260;
        bh=c1weCoMApOeCE10zye/e6XnzSfDakoocDIvkXnDYsBQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=d60O26AhTRlH0FzWvFtjdKAuy9JcekZFIUenf0Km40UwN0xHikrJMcpXX22cy562g
         Ls+K32XXZxqnhZveOFFGSah6wCxm08EH/ni2XQuyKkDkMp883iDkLOoaugLY9k8ieb
         6awfM8zop1R80rMK9Qh36ByoiYFnzg8HNoXZq56A=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08UIve5N064984
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Sep 2020 13:57:40 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 13:57:40 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 30 Sep 2020 13:57:39 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08UIvX3A007008;
        Wed, 30 Sep 2020 13:57:37 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH v14 01/15] mtd: spi-nor: core: use EOPNOTSUPP instead of ENOTSUPP
Date:   Thu, 1 Oct 2020 00:27:18 +0530
Message-ID: <20200930185732.6201-2-p.yadav@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930185732.6201-1-p.yadav@ti.com>
References: <20200930185732.6201-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ENOTSUPP is not a SUSV4 error code. Using EOPNOTSUPP is preferred
in its stead.

Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
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

