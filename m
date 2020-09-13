Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 525DA268030
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 18:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbgIMQQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 12:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgIMQPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 12:15:48 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2B1C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 09:15:48 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id k15so10479559pfc.12
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 09:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KwZK3cynzlKs4fDm6cpdhaPJl7Rn30I8P2QHQetryVE=;
        b=jpJ2LY7DRgcUiKFMO8Y4KMDyC0lbaQYduYjpnt+fP5Bim8bTzxhH8Ex4Wy0iKo2e27
         pt9JxY8NAMXQvLffRT477rhzGcNxhovFdexnc030KOgSJQRMODRHsc8Sd4z6wIKYgUG8
         4heSQTBewf1ce7l0IOL7x1QFwKOHBDVLsVjAxMqV6ajkL0Ac+jsCythA2kXSALDAfZE0
         lJBql1yDeR8x9dcA8t815TYqLH5G/enKWuGmEhJjLdza7jqZVrQ2o+e1mamJq1o/v51d
         cCY4ieRaxCklTZaYrKyNisSsHtFGBDGwN6jbuhnfIq2zElJ5NuoJLFj9jYkUkS3mqAcK
         QO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KwZK3cynzlKs4fDm6cpdhaPJl7Rn30I8P2QHQetryVE=;
        b=gSxho49rrPIFZcPy/t2cjattO2VPebHe74nRAT6MNRNEDr4kvXwX2PuvH3z4RdSYDX
         tcohFc/Xj63hdZSIYMdY3c77AwsH2Ua7LUksUqLzOi4h70JZRCocleX44tOA7HddCRB6
         gPPCPSxZmgI5Nwu9h0Rh0VAEKX46DdCdEy4tewQ1UZrIkDUXkeF40zMUGekooiZzjC0Z
         4+P4OdJYy5r5dFhH6K11Co0UD6o2yvN8b3Kwad8NVXSniJNTlcGMn+ZY2dUW4mSDqLBa
         0+7y7suEa9eOMZ1nrfKsn2kDwSEGPaTgaXGl345YPi4AAv7CJInD62W6zDy4JlXgDU2t
         JaiQ==
X-Gm-Message-State: AOAM533k0ROpNzc+Yql9LCTL6Nn++V1hQuGhJolT9HFmPxLd7B8IAk40
        9HZb/3jSdZCg2cGlDoYwQz8=
X-Google-Smtp-Source: ABdhPJyAzttJgtBOiaVhGFDYmCSgIOJsaHRKVzXqP07zpGCZOHyZvdNB88neUBHUg9D1hThHOQUvhg==
X-Received: by 2002:a62:1984:: with SMTP id 126mr10112286pfz.17.1600013747817;
        Sun, 13 Sep 2020 09:15:47 -0700 (PDT)
Received: from Thiru.localdomain ([27.104.143.83])
        by smtp.gmail.com with ESMTPSA id c202sm7833953pfc.15.2020.09.13.09.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2020 09:15:47 -0700 (PDT)
From:   Thirumalesha Narasimhappa <nthirumalesha7@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Shivamurthy Shastri <sshivamurthy@micron.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Thirumalesha Narasimhappa <nthirumalesha7@gmail.com>
Subject: [PATCH v4 2/2] mtd: spinand: micron: add support for MT29F2G01AAAED
Date:   Mon, 14 Sep 2020 00:15:33 +0800
Message-Id: <20200913161533.10655-3-nthirumalesha7@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200913161533.10655-1-nthirumalesha7@gmail.com>
References: <20200913161533.10655-1-nthirumalesha7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MT29F2G01AAAED is a single die, 2Gb Micron SPI NAND Flash with 4-bit
ECC

Signed-off-by: Thirumalesha Narasimhappa <nthirumalesha7@gmail.com>
---
 drivers/mtd/nand/spi/micron.c | 64 +++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index d1b1073d1a55..dae3f7189880 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -44,6 +44,19 @@ static SPINAND_OP_VARIANTS(x4_update_cache_variants,
 		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
 		SPINAND_PROG_LOAD(false, 0, NULL, 0));
 
+/* Micron  MT29F2G01AAAED Device */
+static SPINAND_OP_VARIANTS(x4_read_cache_variants,
+		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+
+static SPINAND_OP_VARIANTS(x1_write_cache_variants,
+			   SPINAND_PROG_LOAD(true, 0, NULL, 0));
+
+static SPINAND_OP_VARIANTS(x1_update_cache_variants,
+			   SPINAND_PROG_LOAD(false, 0, NULL, 0));
+
 static int micron_8_ooblayout_ecc(struct mtd_info *mtd, int section,
 				  struct mtd_oob_region *region)
 {
@@ -74,6 +87,47 @@ static const struct mtd_ooblayout_ops micron_grouped_ooblayout = {
 	.free = micron_8_ooblayout_free,
 };
 
+static int micron_4_ooblayout_ecc(struct mtd_info *mtd, int section,
+				  struct mtd_oob_region *region)
+{
+	struct spinand_device *spinand = mtd_to_spinand(mtd);
+
+	if (section >= spinand->base.memorg.pagesize /
+			mtd->ecc_step_size)
+		return -ERANGE;
+
+	region->offset = (section * 16) + 8;
+	region->length = 8;
+
+	return 0;
+}
+
+static int micron_4_ooblayout_free(struct mtd_info *mtd, int section,
+				   struct mtd_oob_region *region)
+{
+	struct spinand_device *spinand = mtd_to_spinand(mtd);
+
+	if (section >= spinand->base.memorg.pagesize /
+			mtd->ecc_step_size)
+		return -ERANGE;
+
+	if (section) {
+		region->offset = 16 * section;
+		region->length = 8;
+	} else {
+		/* section 0 has two bytes reserved for the BBM */
+		region->offset = 2;
+		region->length = 6;
+	}
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops micron_interleaved_ooblayout = {
+	.ecc = micron_4_ooblayout_ecc,
+	.free = micron_4_ooblayout_free,
+};
+
 static int micron_select_target(struct spinand_device *spinand,
 				unsigned int target)
 {
@@ -217,6 +271,16 @@ static const struct spinand_info micron_spinand_table[] = {
 		     SPINAND_ECCINFO(&micron_grouped_ooblayout,
 				     micron_8_ecc_get_status),
 		     SPINAND_SELECT_TARGET(micron_select_target)),
+	/* M69A 2Gb 3.3V */
+	SPINAND_INFO("MT29F2G01AAAED",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x9F),
+		     NAND_MEMORG(1, 2048, 64, 64, 2048, 80, 2, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&x4_read_cache_variants,
+					      &x1_write_cache_variants,
+					      &x1_update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&micron_interleaved_ooblayout, NULL)),
 };
 
 static int micron_spinand_init(struct spinand_device *spinand)
-- 
2.25.1

