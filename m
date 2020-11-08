Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5842E2AAABA
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 12:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbgKHLhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 06:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbgKHLht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 06:37:49 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BDFC0613CF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Nov 2020 03:37:49 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id i7so4487260pgh.6
        for <linux-kernel@vger.kernel.org>; Sun, 08 Nov 2020 03:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GYoHiYlx9UghIDvWrFDWg6JDwlt3tel+kK4HoN87nLs=;
        b=mXBR5JZWrLpB6s9IP3POfkZPiNL2RodeHAfwmcZ39R9c9TAjUpA8NFIUVgrarqYfhn
         FAR4AWzw6//Y/tJ7cLm537fadvazKncdlcLowV/nCv86IRscZi+y1VbYWBoiYPvDc4Qq
         KG6uzrOe8Owd6C7qB+uEYQ1/ooFSDc2VBgRcM35muX2VbHq3dfcrjbicIasl/p0e6TTR
         kQAFuCSJxVhgoRlLeAvYL2Iclz331bMEWSA85fv9YkoGGteFHUL8qLVONbn1E1+ltaC7
         Hzw5vfxahPKRgekxyxJ8mtWfcLLuQj6M0RybVBjwB4XgWLI9UJ0otQt8TVB7tAxAuXxU
         ZSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GYoHiYlx9UghIDvWrFDWg6JDwlt3tel+kK4HoN87nLs=;
        b=Er+I3RK9EOKPoVGhfQdF9yH7iUb+zqdIfLYZk7jhbbe0f6QA12sfZEjZZ8Lne3hf8Y
         Yfb7dw410ow0YIkdWJ5wUqYr2ajrVsrp3PNgTsFbKzFnjL0JjwLnZCB6hfL4gA29uRLj
         Ho4poYQSjd73ES4cb8p8hXPJA36ku6SQ4/RN4Wtgab+eDwxFHvisBSOT2mSWB5RkLEjb
         Vz8fdhC2TrEc9n1ExwLZrF0dxKkMxyEHljaNWC/hXNp/Q6HmBOjmlgqhrngLxZFD6/TI
         ump1TvyRwB+FISLo8f05luONgbAGTXBlMEhWJezKhlltHhgrvR06Q+Q1kH76GvgmvAsQ
         mRTw==
X-Gm-Message-State: AOAM531SZ1ZGUEBqp7xbYM118P/zi2c67vZLx96l7NVJ5a85au6hf0Dg
        4cduaehUl4Ve4O51WhRB15w=
X-Google-Smtp-Source: ABdhPJxNVydSoGufRXWP4lE8LLTfBLbDGDWVtkbCaiP3lNn0L6tmduj8/hYHvJi0/BLHzDxmovWN7g==
X-Received: by 2002:a63:ea0f:: with SMTP id c15mr9007599pgi.367.1604835468798;
        Sun, 08 Nov 2020 03:37:48 -0800 (PST)
Received: from IGL6397W.cw01.contiwan.com ([27.104.143.83])
        by smtp.gmail.com with ESMTPSA id t85sm7230263pgb.29.2020.11.08.03.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 03:37:48 -0800 (PST)
From:   Thirumalesha Narasimhappa <nthirumalesha7@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Shivamurthy Shastri <sshivamurthy@micron.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Thirumalesha Narasimhappa <nthirumalesha7@gmail.com>
Subject: [PATCH v7 2/2] mtd: spinand: micron: Add support for MT29F2G01AAAED
Date:   Sun,  8 Nov 2020 19:37:35 +0800
Message-Id: <20201108113735.2533-3-nthirumalesha7@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201108113735.2533-1-nthirumalesha7@gmail.com>
References: <20201108113735.2533-1-nthirumalesha7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index afe3ba37dcfb..50b7295bc922 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -44,6 +44,19 @@ static SPINAND_OP_VARIANTS(x4_update_cache_variants,
 		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
 		SPINAND_PROG_LOAD(false, 0, NULL, 0));
 
+/* Micron  MT29F2G01AAAED Device */
+static SPINAND_OP_VARIANTS(x4_read_cache_variants,
+			   SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+			   SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
+			   SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
+			   SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
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
@@ -74,6 +87,47 @@ static const struct mtd_ooblayout_ops micron_8_ooblayout = {
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
+static const struct mtd_ooblayout_ops micron_4_ooblayout = {
+	.ecc = micron_4_ooblayout_ecc,
+	.free = micron_4_ooblayout_free,
+};
+
 static int micron_select_target(struct spinand_device *spinand,
 				unsigned int target)
 {
@@ -217,6 +271,16 @@ static const struct spinand_info micron_spinand_table[] = {
 		     SPINAND_ECCINFO(&micron_8_ooblayout,
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
+		     SPINAND_ECCINFO(&micron_4_ooblayout, NULL)),
 };
 
 static int micron_spinand_init(struct spinand_device *spinand)
-- 
2.25.1

