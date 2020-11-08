Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59B22AAAB9
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 12:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgKHLhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 06:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbgKHLhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 06:37:46 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD34C0613CF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Nov 2020 03:37:46 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id m17so1770435pjz.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Nov 2020 03:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aB4WwGKR70yONlWJx+YO2+K1cBRtMLw1WCeTBhf6I0Y=;
        b=QvCLndGPBskmluRDXVJVH/4aVlyTBBXO2Cb8OC9H5LJtz93CAepMfhZ9A2tf+LYy00
         XshJRhVtCQj3SjC1PtafbSsHqVTxVdsnGn/2vmMhcUSjMyWXRsQG2ROaX2CY67E1/egD
         hPw1Tg8h2o1kSqTAvo062LuVC6z7fBtnqBrGEd2CQ9wfeXIKH6fK4gNyUGlSUCx4Mih2
         l1WbRK2s6lnl5ESpJrvc3UPMMRjGAmMMg7VOi/wXAi34z5zofM1z5/N+Ye0/QK2zKrGq
         0cpP8YgO9YQGOcUlYEehWpvsCD/1CEtOf0DvhR/1b0jdfEWrXUdIuIlHeu4KFANQz3X0
         gcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aB4WwGKR70yONlWJx+YO2+K1cBRtMLw1WCeTBhf6I0Y=;
        b=mi9D2VHks8suFlXyA6+W3oM9Mrs5evByKiGQQrfiEMkuDb6+jTwGJ+ZxmaEnlqdXHK
         FPF99twxSr/zDT2Dvgpf9WckIEdSiWLUBVLZcN8G2HoAvCJ2QR632eTXsF+pb6S5VF8D
         TT6ns0MWaJIoTrVCVzoiKSIbU31yCwAJHNjnbVQ02ohgnPDQS/dzdHj60h7o2pBGwXzM
         9Zc3VsQoDpORut8XW5MWm6cQ6FYq82VqMGPp7uIWHeGh5niyeAuf/yr934nZqr2w6eFP
         OCqWbykV4sRmTzAjhkk+Yr+eqn4P2DZFEOqgvAJvHybN4duE6AxlVcMN3XW93/5/YZL7
         6fxA==
X-Gm-Message-State: AOAM531Pv1b8fjLJBxOHjVo2x+LYooIhCcAvulTK/SA9NA/HB/SLo03o
        dhlmFSN26XVrvkb/sPy4uRI=
X-Google-Smtp-Source: ABdhPJzbM4MA4FD2yAry7JUysEifKKcn5JtRKbXjn3IBP/9Qc0MMYfROsn94OmltghFJVjf1q0nL/A==
X-Received: by 2002:a17:902:728f:b029:d6:fcbe:99c5 with SMTP id d15-20020a170902728fb02900d6fcbe99c5mr8682167pll.20.1604835466003;
        Sun, 08 Nov 2020 03:37:46 -0800 (PST)
Received: from IGL6397W.cw01.contiwan.com ([27.104.143.83])
        by smtp.gmail.com with ESMTPSA id t85sm7230263pgb.29.2020.11.08.03.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 03:37:45 -0800 (PST)
From:   Thirumalesha Narasimhappa <nthirumalesha7@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Shivamurthy Shastri <sshivamurthy@micron.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Thirumalesha Narasimhappa <nthirumalesha7@gmail.com>
Subject: [PATCH v7 1/2] mtd: spinand: micron: Generalize the structure names
Date:   Sun,  8 Nov 2020 19:37:34 +0800
Message-Id: <20201108113735.2533-2-nthirumalesha7@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201108113735.2533-1-nthirumalesha7@gmail.com>
References: <20201108113735.2533-1-nthirumalesha7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the read/write/update of SPINAND_OP_VARIANTS() to a generic names

Signed-off-by: Thirumalesha Narasimhappa <nthirumalesha7@gmail.com>
---
 drivers/mtd/nand/spi/micron.c | 60 +++++++++++++++++------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index 5d370cfcdaaa..afe3ba37dcfb 100644
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
 
@@ -120,9 +120,9 @@ static const struct spinand_info micron_spinand_table[] = {
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
 		     SPINAND_ECCINFO(&micron_8_ooblayout,
 				     micron_8_ecc_get_status)),
@@ -131,9 +131,9 @@ static const struct spinand_info micron_spinand_table[] = {
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
 		     SPINAND_ECCINFO(&micron_8_ooblayout,
 				     micron_8_ecc_get_status)),
@@ -142,9 +142,9 @@ static const struct spinand_info micron_spinand_table[] = {
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
 		     SPINAND_ECCINFO(&micron_8_ooblayout,
 				     micron_8_ecc_get_status)),
@@ -153,9 +153,9 @@ static const struct spinand_info micron_spinand_table[] = {
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
 		     SPINAND_ECCINFO(&micron_8_ooblayout,
 				     micron_8_ecc_get_status)),
@@ -164,9 +164,9 @@ static const struct spinand_info micron_spinand_table[] = {
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
 		     SPINAND_ECCINFO(&micron_8_ooblayout,
 				     micron_8_ecc_get_status),
@@ -176,9 +176,9 @@ static const struct spinand_info micron_spinand_table[] = {
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
 		     SPINAND_ECCINFO(&micron_8_ooblayout,
 				     micron_8_ecc_get_status)),
@@ -187,9 +187,9 @@ static const struct spinand_info micron_spinand_table[] = {
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
 		     SPINAND_ECCINFO(&micron_8_ooblayout,
 				     micron_8_ecc_get_status)),
@@ -198,9 +198,9 @@ static const struct spinand_info micron_spinand_table[] = {
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
 		     SPINAND_ECCINFO(&micron_8_ooblayout,
 				     micron_8_ecc_get_status),
@@ -210,9 +210,9 @@ static const struct spinand_info micron_spinand_table[] = {
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
 		     SPINAND_ECCINFO(&micron_8_ooblayout,
 				     micron_8_ecc_get_status),
-- 
2.25.1

