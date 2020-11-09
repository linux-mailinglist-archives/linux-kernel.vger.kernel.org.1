Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842592AC3AB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 19:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730899AbgKISXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 13:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729533AbgKISWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 13:22:55 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455FFC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 10:22:54 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id r17so5895740wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 10:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q+vNLwe5F16Z2TBJiX30i47rVXn5mHmSvb3WUTRtIMc=;
        b=IDxwDos0ZqyXaUBmX8kcKVFpfxXiUnyoyn8FO4jGl5UHzO5yZ4HZfVuTkc/T9PDm9G
         qrv/jg/JfJyTaspuL9X9Gr5MEwUrLHznOHHsMb+Zyktq+JH1sxpOozZVwXfNXKVC/ixj
         ve357FCE6UgYCsWZHawY1Tdr7onDrq8uMxtEzMeugxb5QND4NyqY25qDmQmjBOtBr3wt
         2A2CpCENAnHDNbPYtz3//dG0iBseKMSs+74zBO+MDI221fFg0txgIZBiDpcJdi8SpgA1
         duuT8VdM96odaPJ6LBorG83zVDmP1WqCKZkoc1tPSgS7Me31R7wbOKF6/4QiQCuUiFqm
         akHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q+vNLwe5F16Z2TBJiX30i47rVXn5mHmSvb3WUTRtIMc=;
        b=XHnhk4scWAcvdhWw9JHzzxpGvX8qPeehDEAsWRSGeDEQ3Lv8s5jz31xK0AZENgGlLB
         C6zDLY3cU+/NGWFwZCW4edoUSnQWl5App0v+ifvxIKpiloErHaaL93W6mH9S+Vww4Atr
         ZZeGhp6VGN/G/KxziPB8je12x4/P+hmRj8GMLBwRZfa/XzCBWHrVtmXgH18Zhe/N7rkA
         OZUgnxm7gj1J3MLOn/gqFWj6GwWo70p4ZhtmOyVmcZYGQ/KHX32en2rEP3PxlMlMxFvD
         Pg47x5wJSOHd7JB9aPWYSXPmW3C1Y3j7XxscGpohUj98Kb5LTc5TPSDQG9Ganv8C5RG+
         Y3Vg==
X-Gm-Message-State: AOAM530GxhFbZ/IyKEGrCbXm3bSh/5M9HlpntSODo2Qu4VBPTLOUhA20
        sobvmscqJSIhU5f1gI1Qe+H90A==
X-Google-Smtp-Source: ABdhPJwlWC9twFBtFzruUjBpFp6whGUUQ1fu9D7vijyIxobnG+zIexFYe1UHFnSg3p8n1aCqNSOs1Q==
X-Received: by 2002:a5d:60c4:: with SMTP id x4mr20715233wrt.175.1604946172941;
        Mon, 09 Nov 2020 10:22:52 -0800 (PST)
Received: from dell.default ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id g186sm735365wma.1.2020.11.09.10.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 10:22:52 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH v3 22/23] mtd: onenand: Fix some kernel-doc misdemeanours
Date:   Mon,  9 Nov 2020 18:22:05 +0000
Message-Id: <20201109182206.3037326-23-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109182206.3037326-1-lee.jones@linaro.org>
References: <20201109182206.3037326-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/mtd/nand/onenand/onenand_base.c:140: warning: Function parameter or member 'mtd' not described in 'onenand_ooblayout_32_64_ecc'
 drivers/mtd/nand/onenand/onenand_base.c:140: warning: Function parameter or member 'section' not described in 'onenand_ooblayout_32_64_ecc'
 drivers/mtd/nand/onenand/onenand_base.c:140: warning: Function parameter or member 'oobregion' not described in 'onenand_ooblayout_32_64_ecc'
 drivers/mtd/nand/onenand/onenand_base.c:1436: warning: bad line:
 drivers/mtd/nand/onenand/onenand_base.c:1971: warning: Function parameter or member 'ops' not described in 'onenand_write_oob_nolock'
 drivers/mtd/nand/onenand/onenand_base.c:1971: warning: Excess function parameter 'len' description in 'onenand_write_oob_nolock'
 drivers/mtd/nand/onenand/onenand_base.c:1971: warning: Excess function parameter 'retlen' description in 'onenand_write_oob_nolock'
 drivers/mtd/nand/onenand/onenand_base.c:1971: warning: Excess function parameter 'buf' description in 'onenand_write_oob_nolock'
 drivers/mtd/nand/onenand/onenand_base.c:1971: warning: Excess function parameter 'mode' description in 'onenand_write_oob_nolock'
 drivers/mtd/nand/onenand/onenand_base.c:2156: warning: Function parameter or member 'block_size' not described in 'onenand_multiblock_erase'
 drivers/mtd/nand/onenand/onenand_base.c:2156: warning: Excess function parameter 'region' description in 'onenand_multiblock_erase'
 drivers/mtd/nand/onenand/onenand_base.c:2771: warning: Function parameter or member 'ops' not described in 'onenand_otp_write_oob_nolock'
 drivers/mtd/nand/onenand/onenand_base.c:2771: warning: Excess function parameter 'len' description in 'onenand_otp_write_oob_nolock'
 drivers/mtd/nand/onenand/onenand_base.c:2771: warning: Excess function parameter 'retlen' description in 'onenand_otp_write_oob_nolock'
 drivers/mtd/nand/onenand/onenand_base.c:2771: warning: Excess function parameter 'buf' description in 'onenand_otp_write_oob_nolock'
 drivers/mtd/nand/onenand/onenand_base.c:3387: warning: Function parameter or member 'mtd' not described in 'flexonenand_get_boundary'
 drivers/mtd/nand/onenand/onenand_base.c:3387: warning: Excess function parameter 'onenand_info' description in 'flexonenand_get_boundary'
 drivers/mtd/nand/onenand/onenand_base.c:3509: warning: Function parameter or member 'mtd' not described in 'flexonenand_check_blocks_erased'
 drivers/mtd/nand/onenand/onenand_base.c:3509: warning: Excess function parameter 'mtd_info' description in 'flexonenand_check_blocks_erased'
 drivers/mtd/nand/onenand/onenand_base.c:3557: warning: Function parameter or member 'die' not described in 'flexonenand_set_boundary'
 drivers/mtd/nand/onenand/onenand_base.c:3557: warning: Function parameter or member 'boundary' not described in 'flexonenand_set_boundary'
 drivers/mtd/nand/onenand/onenand_base.c:3557: warning: Function parameter or member 'lock' not described in 'flexonenand_set_boundary'

Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/nand/onenand/onenand_base.c | 36 +++++++++++--------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/drivers/mtd/nand/onenand/onenand_base.c b/drivers/mtd/nand/onenand/onenand_base.c
index 9fca3988ee236..a9fdea26ea464 100644
--- a/drivers/mtd/nand/onenand/onenand_base.c
+++ b/drivers/mtd/nand/onenand/onenand_base.c
@@ -132,7 +132,7 @@ static const struct mtd_ooblayout_ops onenand_oob_128_ooblayout_ops = {
 	.free = onenand_ooblayout_128_free,
 };
 
-/**
+/*
  * onenand_oob_32_64 - oob info for large (2KB) page
  */
 static int onenand_ooblayout_32_64_ecc(struct mtd_info *mtd, int section,
@@ -271,7 +271,7 @@ static int onenand_page_address(int page, int sector)
  * @dataram1:	DataRAM index
  * @sectors:	the sector address
  * @count:		the number of sectors
- * @return		the start buffer value
+ * Return:		the start buffer value
  *
  * Setup Start Buffer Register (F200h)
  */
@@ -1433,7 +1433,7 @@ static int onenand_read_oob_nolock(struct mtd_info *mtd, loff_t from,
  * @mtd:		MTD device structure
  * @from:		offset to read from
  * @ops:		oob operation description structure
-
+ *
  * Read main and/or out-of-band
  */
 static int onenand_read_oob(struct mtd_info *mtd, loff_t from,
@@ -1958,11 +1958,8 @@ static int onenand_write_ops_nolock(struct mtd_info *mtd, loff_t to,
 /**
  * onenand_write_oob_nolock - [INTERN] OneNAND write out-of-band
  * @mtd:		MTD device structure
- * @to:		offset to write to
- * @len:		number of bytes to write
- * @retlen:	pointer to variable to store the number of written bytes
- * @buf:		the data to write
- * @mode:		operation mode
+ * @to:			offset to write to
+ * @ops:                oob operation description structure
  *
  * OneNAND write out-of-band
  */
@@ -2146,7 +2143,7 @@ static int onenand_multiblock_erase_verify(struct mtd_info *mtd,
  * onenand_multiblock_erase - [INTERN] erase block(s) using multiblock erase
  * @mtd:		MTD device structure
  * @instr:		erase instruction
- * @region:	erase region
+ * @block_size:		block size
  *
  * Erase one or more blocks up to 64 block at a time
  */
@@ -2759,10 +2756,8 @@ static int onenand_otp_command(struct mtd_info *mtd, int cmd, loff_t addr,
 /**
  * onenand_otp_write_oob_nolock - [INTERN] OneNAND write out-of-band, specific to OTP
  * @mtd:		MTD device structure
- * @to:		offset to write to
- * @len:		number of bytes to write
- * @retlen:	pointer to variable to store the number of written bytes
- * @buf:		the data to write
+ * @to:			offset to write to
+ * @ops:                oob operation description structure
  *
  * OneNAND write out-of-band only for OTP
  */
@@ -3380,9 +3375,9 @@ static int onenand_check_maf(int manuf)
 }
 
 /**
-* flexonenand_get_boundary	- Reads the SLC boundary
-* @onenand_info:		- onenand info structure
-**/
+ * flexonenand_get_boundary	- Reads the SLC boundary
+ * @mtd:		MTD data structure
+ */
 static int flexonenand_get_boundary(struct mtd_info *mtd)
 {
 	struct onenand_chip *this = mtd->priv;
@@ -3493,9 +3488,9 @@ static void flexonenand_get_size(struct mtd_info *mtd)
 
 /**
  * flexonenand_check_blocks_erased - Check if blocks are erased
- * @mtd_info:	- mtd info structure
- * @start:		- first erase block to check
- * @end:		- last erase block to check
+ * @mtd:	mtd info structure
+ * @start:	first erase block to check
+ * @end:	last erase block to check
  *
  * Converting an unerased block from MLC to SLC
  * causes byte values to change. Since both data and its ECC
@@ -3548,9 +3543,8 @@ static int flexonenand_check_blocks_erased(struct mtd_info *mtd, int start, int
 	return 0;
 }
 
-/**
+/*
  * flexonenand_set_boundary	- Writes the SLC boundary
- * @mtd:			- mtd info structure
  */
 static int flexonenand_set_boundary(struct mtd_info *mtd, int die,
 				    int boundary, int lock)
-- 
2.25.1

