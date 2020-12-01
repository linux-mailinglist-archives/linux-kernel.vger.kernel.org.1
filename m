Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1142C9F29
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 11:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729806AbgLAK2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 05:28:22 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42216 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729748AbgLAK2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 05:28:20 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0B1ARM7W046696;
        Tue, 1 Dec 2020 04:27:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1606818442;
        bh=/Bx4dPRtGekE5t4BCcSHdS8meYGSR/c3Qd7aQPPMvlw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=EcSRTsq6Cp4fUfBzloDGKMtJ/jTNPWmMbqvqatA8gd28kWaq43+4f6e0f07Sv0wG0
         AyMMsgM4Jtk+za5l/jZmJojyE3fy5DGkOLKyo5W3JrZ7HISjeaLzt6+vj03lDDMDn4
         6iJyvjHaqe4+dTr3r4qDOW1Td3YpmLOX7lVVQbKM=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0B1ARMSe095974
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Dec 2020 04:27:22 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 1 Dec
 2020 04:27:22 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 1 Dec 2020 04:27:22 -0600
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0B1ARCub080862;
        Tue, 1 Dec 2020 04:27:20 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>
Subject: [PATCH v3 3/3] mtd: spi-nor: spansion: Set ECC block size
Date:   Tue, 1 Dec 2020 15:57:11 +0530
Message-ID: <20201201102711.8727-4-p.yadav@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201201102711.8727-1-p.yadav@ti.com>
References: <20201201102711.8727-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The S28 flash family uses 2-bit ECC by default with each ECC block being
16 bytes. Under this scheme multi-pass programming to an ECC block is
not allowed. Set the writesize to make sure multi-pass programming is
not attempted on the flash.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---

Notes:
    No changes in v3
    
    New in v2.

 drivers/mtd/spi-nor/spansion.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index e487fd341a56..b0c5521c1e27 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -109,6 +109,7 @@ static int spi_nor_cypress_octal_dtr_enable(struct spi_nor *nor, bool enable)
 static void s28hs512t_default_init(struct spi_nor *nor)
 {
 	nor->params->octal_dtr_enable = spi_nor_cypress_octal_dtr_enable;
+	nor->params->writesize = 16;
 }
 
 static void s28hs512t_post_sfdp_fixup(struct spi_nor *nor)
-- 
2.28.0

