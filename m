Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D2E26DA26
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgIQL2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:28:25 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:53792 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgIQL10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:27:26 -0400
X-Greylist: delayed 24715 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 07:27:22 EDT
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08GCiVBW073693;
        Wed, 16 Sep 2020 07:44:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600260271;
        bh=7yLvwu2MAxF5LKrNrXaI5zS4oSoxKLc/kllxfRx8vMY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=lDO9dSZDhDkwss8KPz61CFQktgcTWoxwKfWzCO4cbvOlyG26ynvKYnBVb7hk4kVhh
         hLflwwF3ibjZA2DkR/0Dwg9tGkwkmW9/hVTZILPOQnnXtO2uKCJLVB44vgixgItxVQ
         ajZHzJrcXlQ8gwCnekBhm34xda1Sb3am83iB10Jg=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08GCiVEE069545
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Sep 2020 07:44:31 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 16
 Sep 2020 07:44:31 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 16 Sep 2020 07:44:31 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08GCiIpX125391;
        Wed, 16 Sep 2020 07:44:28 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH v13 03/15] mtd: spi-nor: core: add spi_nor_controller_ops_erase helper
Date:   Wed, 16 Sep 2020 18:14:06 +0530
Message-ID: <20200916124418.833-4-p.yadav@ti.com>
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

It is a thin wrapper around nor->controller_ops->erase(). In a future
commit DTR support will be added. These ops can not be supported by the
erase() hook and this helper will make it easier to reject those calls.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/mtd/spi-nor/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index cbfc4c2df79d..7009cb702e22 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -94,6 +94,11 @@ static int spi_nor_write_reg(struct spi_nor *nor, u8 opcode, const u8 *buf,
 	return nor->controller_ops->write_reg(nor, opcode, buf, len);
 }
 
+static int spi_nor_controller_ops_erase(struct spi_nor *nor, loff_t offs)
+{
+	return nor->controller_ops->erase(nor, offs);
+}
+
 /**
  * spi_nor_spimem_read_data() - read data from flash's memory region via
  *                              spi-mem
@@ -1145,7 +1150,7 @@ static int spi_nor_erase_sector(struct spi_nor *nor, u32 addr)
 
 		return spi_mem_exec_op(nor->spimem, &op);
 	} else if (nor->controller_ops->erase) {
-		return nor->controller_ops->erase(nor, addr);
+		return spi_nor_controller_ops_erase(nor, addr);
 	}
 
 	/*
-- 
2.28.0

