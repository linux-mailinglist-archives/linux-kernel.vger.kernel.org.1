Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743CB2A979C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 15:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbgKFO2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 09:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgKFO2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 09:28:48 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFF3C0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 06:28:48 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id z24so1070975pgk.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 06:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m4sL72j84R47QycVsnsicRm6ltqmghjuS6NlUF00PZI=;
        b=VF21kubqqziFC4me+QI38duNcceD9mNHFSMrDlgo5oJMSxIQAfXVIQ2X2uw0H93wzG
         2WYarJmeHJtmfpIexbDnudvJSdrUj0xF9HmwXYCp8i7eabbNTja+zKKykZrq5JWmKGpd
         j/9XiDi30PGPTZaVtlYh9QQGAqiChCfIbCKTVG2owJ0wslz41mVjMM+Q5zhEMjijNyH+
         FPvJoWkuI2+UfsNJ4vopOAVaDPrl527JwhtSdY0lwChkRX2NVO6uGx2PiXTmH5n5h7d/
         zi0q4l19lXNfYZFjsdB6CupJyu9F/6LE9WUJqsAKddnX0OsoZiCFEBTPhhEirRzZ4LW7
         IgqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m4sL72j84R47QycVsnsicRm6ltqmghjuS6NlUF00PZI=;
        b=diD5TFHVJdcMED1TQxs3cx0uyIBGN0q52Y/EYcXy1C0osT4nf7DDzG19/HbXQyFSU6
         XY3O30za5nbsStcjnOPTMKx09f+q4aw/5tuJM9Ns2IPnl5+aE/LE32LcSCr7ZVsS3LQe
         NJYIER1AtuKX/PY5CS6ejtOO7STe3OAljUIDx056GFS2V1Z6C+28BkyoOiPHt5NWA4Qn
         exGn9pAoe4MWSCOK+BwuGRuXyOD0qB9ltibHhgCY+2FgE0+rm/lQ9pyPOWls56FSYzGy
         MTZqrqwpfVvGFtMl9yVIf0FJKBidz6iFEqvhLirguG6vBzGRQSHlECMEmgHdJvlTlRZf
         VnEQ==
X-Gm-Message-State: AOAM531+lk00ej1qoI0vzSzo8HD+VYB60Zzb81+IrBZTIdevK19rNmAw
        CpsEMsObnZ6PNk+SxcxNId4=
X-Google-Smtp-Source: ABdhPJzAI5vxv166BttXFT+ZsydXjoMrwvkfmli1wq1cIJ+nuEgeG+HAdbGW6jrDXFh+yVsZLDzPVg==
X-Received: by 2002:a17:90a:c7c3:: with SMTP id gf3mr2837790pjb.140.1604672928091;
        Fri, 06 Nov 2020 06:28:48 -0800 (PST)
Received: from IGL6397W.cw01.contiwan.com ([27.104.143.83])
        by smtp.gmail.com with ESMTPSA id gq24sm2919989pjb.30.2020.11.06.06.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 06:28:46 -0800 (PST)
From:   Thirumalesha Narasimhappa <nthirumalesha7@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Shivamurthy Shastri <sshivamurthy@micron.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Thirumalesha Narasimhappa <nthirumalesha7@gmail.com>
Subject: [PATCH v6] mtd: spinand: micron: add support for MT29F2G01AAAED
Date:   Fri,  6 Nov 2020 22:28:38 +0800
Message-Id: <20201106142838.7772-1-nthirumalesha7@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MT29F2G01AAAED is a single die, 2Gb Micron SPI NAND Flash with 4-bit
ECC

Signed-off-by: Thirumalesha Narasimhappa <nthirumalesha7@gmail.com>
---

v6: Reverted the SPINAND_OP_VARIANTS() as they were in v4 for
MT29F2G01AAAED device

v5: As per the review comments, the changes were reverted to the v2,
except the MT29F2G01AAAED device related (including the review comments)

v4: Split patch into two parts,
    1. Generalise the oob structure name & function names as show in v3
    2. Add support for MT29F2G01AAAED device
       a. Add oob section check in micron_ooblayout_free function
       b. Rename mt29f2g01aaaed_* to generic name micron_4_*

v3: As per the review comments,
     1. Renamed read_cache_variants as quadio_read_cache_variants,
write_cache_variants as
      x4_write_cache_variants/x1_write_cache_variants,
update_cache_variants as
      x4_update_cache_variants/x1_update_cache_variants,
read_cache_variants as x4_read_cache_variants
     2. Renamed micron_8_ooblayout as micron_grouped_ooblayout &
mt29f2g01aaaed_ooblayout as
      micron_interleaved_ooblayout
     3. Generalized page size based oob section check in
mt29f2g01aaaed_ooblayout_ecc function
      and separate case check for two bytes BBM reserved in
mt29f2g01aaaed_ooblayout_free function
     4. Removed mt29f2g01aaaed_ecc_get_status function &
MICRON_STATUS_ECC_1TO4_BITFLIPS

v2: Removed SPINAND_SELECT_TARGET as per the comments & fixed typo
errors

v1: Add support for Micron SPI Nand device MT29F2G01AAAED

 drivers/mtd/nand/spi/micron.c | 64 +++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index 5d370cfcdaaa..317866c077de 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -44,6 +44,19 @@ static SPINAND_OP_VARIANTS(update_cache_variants,
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

