Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3323626802E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 18:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgIMQPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 12:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgIMQPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 12:15:45 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8C0C061787
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 09:15:45 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bh1so3338403plb.12
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 09:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=95c6QPsz7bPnVQEayO8hHcHLwY3gkWsLTvnzG7IV4QE=;
        b=JyPL2PqlbFDejFLHfPHBZRJ3A0g45iKSb5MizjskJkzz2pwhCaupLh0WcVNnNSf7J+
         pSxBNIZ+sM/I4tmzqcsjZwyvlPz8zmn3rDILaZ/2bD8Db8wqvaS1/bK2ILewkquiYRtO
         Zy334qin3biNCs588Ynpqfkzr8hsZS6XJQ3WQxKuFxArsa6ZJIPyDtv0OG+S39TTLblx
         DWT1HeNlY9H+uzzdquZ7eFQovmVce3yiFR1ilyMh0OQULp6eC8JpUoFEOrx9zzhdZwXu
         lqQhXHKVmjhFEgLxelpdc2Lv6Fa30i01M5e7X9NDlmwg1m5+KEB40yujPGr9GcwUBS9D
         VDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=95c6QPsz7bPnVQEayO8hHcHLwY3gkWsLTvnzG7IV4QE=;
        b=bB16NafSos9zKHbHB9KPMuIjA56e30EMFryhJ6xSJYzezaDjMh7Pm165h99Veh8t5x
         6prl+qrq0OAZBeLozCAJ9Wo6qXkTm7HVDB+sr5Hq9RMqCZGbnX3LIy83fe9pWzCPmWhl
         /beHzYL/Qm2UjHQQcOlFfyowan4YRVWSjQlKOIjUCSDfX2UthLk7j1roQ75f+4gEGKYJ
         4abtfzIJJA8KjOT4L+XkS53zDbKahqVfmsDrqIxr2jVspfTzVCl7N9hN0Yh+1yv0RZVT
         Iqee3rp0Ym7isjqoZ5YhArXDiybDDmtksT5LJFyD4AFPramtoOLyjcoSaSh2NiVscqtc
         S4oQ==
X-Gm-Message-State: AOAM532fDuWdMStgxdWi1vXBfnjFsbCAUJi+bYjPJYs9UcsrW0DiLe70
        XQGU8bpGe1jAzggcU/pgh1c=
X-Google-Smtp-Source: ABdhPJx1r6Cu5JCuNHrhMT9Pw2HGd3WfDv59A0SscaK1bShHv9zwyWcGn56yI4//KftEM+fpFyiryQ==
X-Received: by 2002:a17:902:8c96:b029:d0:ad87:6668 with SMTP id t22-20020a1709028c96b02900d0ad876668mr10819429plo.2.1600013745022;
        Sun, 13 Sep 2020 09:15:45 -0700 (PDT)
Received: from Thiru.localdomain ([27.104.143.83])
        by smtp.gmail.com with ESMTPSA id c202sm7833953pfc.15.2020.09.13.09.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2020 09:15:44 -0700 (PDT)
From:   Thirumalesha Narasimhappa <nthirumalesha7@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Shivamurthy Shastri <sshivamurthy@micron.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Thirumalesha Narasimhappa <nthirumalesha7@gmail.com>
Subject: [PATCH v4 1/2] mtd: spinand: micron: Generalize the function and structure names
Date:   Mon, 14 Sep 2020 00:15:32 +0800
Message-Id: <20200913161533.10655-2-nthirumalesha7@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200913161533.10655-1-nthirumalesha7@gmail.com>
References: <20200913161533.10655-1-nthirumalesha7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the oob structure and read/write/update function names to
a generic names

Signed-off-by: Thirumalesha Narasimhappa <nthirumalesha7@gmail.com>
---
 drivers/mtd/nand/spi/micron.c | 80 +++++++++++++++++------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index 5d370cfcdaaa..d1b1073d1a55 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -28,7 +28,7 @@
 
 #define MICRON_SELECT_DIE(x)	((x) << 6)
 
-static SPINAND_OP_VARIANTS(read_cache_variants,
+static SPINAND_OP_VARIANTS(quadio_read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
@@ -36,11 +36,11 @@ static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
 
-static SPINAND_OP_VARIANTS(write_cache_variants,
+static SPINAND_OP_VARIANTS(x4_write_cache_variants,
 		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
 		SPINAND_PROG_LOAD(true, 0, NULL, 0));
 
-static SPINAND_OP_VARIANTS(update_cache_variants,
+static SPINAND_OP_VARIANTS(x4_update_cache_variants,
 		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
 		SPINAND_PROG_LOAD(false, 0, NULL, 0));
 
@@ -69,7 +69,7 @@ static int micron_8_ooblayout_free(struct mtd_info *mtd, int section,
 	return 0;
 }
 
-static const struct mtd_ooblayout_ops micron_8_ooblayout = {
+static const struct mtd_ooblayout_ops micron_grouped_ooblayout = {
 	.ecc = micron_8_ooblayout_ecc,
 	.free = micron_8_ooblayout_free,
 };
@@ -120,55 +120,55 @@ static const struct spinand_info micron_spinand_table[] = {
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x24),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 2, 1, 1),
 		     NAND_ECCREQ(8, 512),
-		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
-					      &write_cache_variants,
-					      &update_cache_variants),
+		     SPINAND_INFO_OP_VARIANTS(&quadio_read_cache_variants,
+					      &x4_write_cache_variants,
+					      &x4_update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&micron_8_ooblayout,
+		     SPINAND_ECCINFO(&micron_grouped_ooblayout,
 				     micron_8_ecc_get_status)),
 	/* M79A 2Gb 1.8V */
 	SPINAND_INFO("MT29F2G01ABBGD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x25),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 2, 1, 1),
 		     NAND_ECCREQ(8, 512),
-		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
-					      &write_cache_variants,
-					      &update_cache_variants),
+		     SPINAND_INFO_OP_VARIANTS(&quadio_read_cache_variants,
+					      &x4_write_cache_variants,
+					      &x4_update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&micron_8_ooblayout,
+		     SPINAND_ECCINFO(&micron_grouped_ooblayout,
 				     micron_8_ecc_get_status)),
 	/* M78A 1Gb 3.3V */
 	SPINAND_INFO("MT29F1G01ABAFD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x14),
 		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
-		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
-					      &write_cache_variants,
-					      &update_cache_variants),
+		     SPINAND_INFO_OP_VARIANTS(&quadio_read_cache_variants,
+					      &x4_write_cache_variants,
+					      &x4_update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&micron_8_ooblayout,
+		     SPINAND_ECCINFO(&micron_grouped_ooblayout,
 				     micron_8_ecc_get_status)),
 	/* M78A 1Gb 1.8V */
 	SPINAND_INFO("MT29F1G01ABAFD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x15),
 		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
-		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
-					      &write_cache_variants,
-					      &update_cache_variants),
+		     SPINAND_INFO_OP_VARIANTS(&quadio_read_cache_variants,
+					      &x4_write_cache_variants,
+					      &x4_update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&micron_8_ooblayout,
+		     SPINAND_ECCINFO(&micron_grouped_ooblayout,
 				     micron_8_ecc_get_status)),
 	/* M79A 4Gb 3.3V */
 	SPINAND_INFO("MT29F4G01ADAGD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x36),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 80, 2, 1, 2),
 		     NAND_ECCREQ(8, 512),
-		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
-					      &write_cache_variants,
-					      &update_cache_variants),
+		     SPINAND_INFO_OP_VARIANTS(&quadio_read_cache_variants,
+					      &x4_write_cache_variants,
+					      &x4_update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&micron_8_ooblayout,
+		     SPINAND_ECCINFO(&micron_grouped_ooblayout,
 				     micron_8_ecc_get_status),
 		     SPINAND_SELECT_TARGET(micron_select_target)),
 	/* M70A 4Gb 3.3V */
@@ -176,33 +176,33 @@ static const struct spinand_info micron_spinand_table[] = {
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x34),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
-		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
-					      &write_cache_variants,
-					      &update_cache_variants),
+		     SPINAND_INFO_OP_VARIANTS(&quadio_read_cache_variants,
+					      &x4_write_cache_variants,
+					      &x4_update_cache_variants),
 		     SPINAND_HAS_CR_FEAT_BIT,
-		     SPINAND_ECCINFO(&micron_8_ooblayout,
+		     SPINAND_ECCINFO(&micron_grouped_ooblayout,
 				     micron_8_ecc_get_status)),
 	/* M70A 4Gb 1.8V */
 	SPINAND_INFO("MT29F4G01ABBFD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x35),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
-		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
-					      &write_cache_variants,
-					      &update_cache_variants),
+		     SPINAND_INFO_OP_VARIANTS(&quadio_read_cache_variants,
+					      &x4_write_cache_variants,
+					      &x4_update_cache_variants),
 		     SPINAND_HAS_CR_FEAT_BIT,
-		     SPINAND_ECCINFO(&micron_8_ooblayout,
+		     SPINAND_ECCINFO(&micron_grouped_ooblayout,
 				     micron_8_ecc_get_status)),
 	/* M70A 8Gb 3.3V */
 	SPINAND_INFO("MT29F8G01ADAFD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x46),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 2),
 		     NAND_ECCREQ(8, 512),
-		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
-					      &write_cache_variants,
-					      &update_cache_variants),
+		     SPINAND_INFO_OP_VARIANTS(&quadio_read_cache_variants,
+					      &x4_write_cache_variants,
+					      &x4_update_cache_variants),
 		     SPINAND_HAS_CR_FEAT_BIT,
-		     SPINAND_ECCINFO(&micron_8_ooblayout,
+		     SPINAND_ECCINFO(&micron_grouped_ooblayout,
 				     micron_8_ecc_get_status),
 		     SPINAND_SELECT_TARGET(micron_select_target)),
 	/* M70A 8Gb 1.8V */
@@ -210,11 +210,11 @@ static const struct spinand_info micron_spinand_table[] = {
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x47),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 2),
 		     NAND_ECCREQ(8, 512),
-		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
-					      &write_cache_variants,
-					      &update_cache_variants),
+		     SPINAND_INFO_OP_VARIANTS(&quadio_read_cache_variants,
+					      &x4_write_cache_variants,
+					      &x4_update_cache_variants),
 		     SPINAND_HAS_CR_FEAT_BIT,
-		     SPINAND_ECCINFO(&micron_8_ooblayout,
+		     SPINAND_ECCINFO(&micron_grouped_ooblayout,
 				     micron_8_ecc_get_status),
 		     SPINAND_SELECT_TARGET(micron_select_target)),
 };
-- 
2.25.1

