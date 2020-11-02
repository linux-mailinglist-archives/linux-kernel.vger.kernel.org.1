Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F912A2A0F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbgKBLyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728910AbgKBLym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:54:42 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FA1C061A04
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:54:42 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id e2so9222214wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RHW6hv3HQDhXKb7Tcc3axGr3ISjQx/RmYNs9PyUPWj4=;
        b=zOqV3h84h029TT5fJvetDC+KOHjw7I73frFXei4HPfT9kMBV6k87o3mJu6HyXOLp5j
         1FCKrFdGkqRSw6lHtre/f9wzjrgRhsrXQhdw/mNXOE84Pd5/53U8zTNyjA4GE9CT77yr
         te+T5YjreoGpTEih+OIN0oNqcvHvmvJIHznh0vrgl0Owj9DOGPHZHQIz1xbEpcy9L4GJ
         oYNHWR6RBdETZvYKqkcepncxc1bVx+19tzC8ufVduy+G9AhtsxWJXGljFwNesOp4WhLW
         cGAP2NC19m5JgDW3fKlWPM+1VwzuBAfk38ZfDfAd60uR0UZt6UIn/eSZcgS6C5RTtZGt
         0c9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RHW6hv3HQDhXKb7Tcc3axGr3ISjQx/RmYNs9PyUPWj4=;
        b=k0n1ftMXjEQUTTJd9opOL5qrVNSXjs4eINBhlSXdvZzhv2AifIth6WFkIfuxy7Vi/w
         wGKpNDL0bToXeGfkpDG+9kK6lwRhLBpcxZzat3E9PEl7acP9h2+xCoinaW0pYTVTsZ1O
         8TK102f2WasiO1uAQcl/pffLiwuAFfJer2PugDZt/TcvKU9wG99q7prdmneO21qGmTKH
         aSDUo6KPRF0//TuS2lSquFR4XqzUrx4ByuTWVIiiD/7eXOydxanomvBwVpfjtIXA3dT2
         Y6oUm2xDhRc7jm6Jclkmx+C+V1XJWW48+qWxK4RFTR87j5YTzcO9PLs2A2QUjSonctrP
         1Drg==
X-Gm-Message-State: AOAM530L3U6eeCMCLJiIcuGrbKGORbiWqtZhW4eSLatLyJGe/3g+y5uz
        st/v6O/gGCmhA/yvlklqf4SmhA==
X-Google-Smtp-Source: ABdhPJzL7VS6H+GFjoiylbSU4BHxRU7+xCN+rhO9bKEOfTW57Gr+2WQ+gOc4bmpja0a6RXHx0h7zkA==
X-Received: by 2002:a1c:df89:: with SMTP id w131mr16752508wmg.164.1604318080867;
        Mon, 02 Nov 2020 03:54:40 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id t23sm14284010wmn.13.2020.11.02.03.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:54:40 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     vigneshr@ti.com
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Adrian Hunter <ext-adrian.hunter@nokia.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH 22/23] mtd: nand: onenand: onenand_base: Fix some kernel-doc misdemeanours
Date:   Mon,  2 Nov 2020 11:54:05 +0000
Message-Id: <20201102115406.1074327-23-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102115406.1074327-1-lee.jones@linaro.org>
References: <20201102115406.1074327-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/mtd/nand/onenand/onenand_base.c:140: warning: Function parameter or member 'mtd' not described in 'onenand_ooblayout_32_64_ecc'
 drivers/mtd/nand/onenand/onenand_base.c:140: warning: Function parameter or member 'section' not described in 'onenand_ooblayout_32_64_ecc'
 drivers/mtd/nand/onenand/onenand_base.c:140: warning: Function parameter or member 'oobregion' not described in 'onenand_ooblayout_32_64_ecc'
 drivers/mtd/nand/onenand/onenand_base.c:279: warning: Function parameter or member 'dataram1' not described in 'onenand_buffer_address'
 drivers/mtd/nand/onenand/onenand_base.c:279: warning: Excess function parameter 'dataram' description in 'onenand_buffer_address'
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
Cc: Adrian Hunter <ext-adrian.hunter@nokia.com>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/nand/onenand/onenand_base.c | 38 +++++++++++--------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/mtd/nand/onenand/onenand_base.c b/drivers/mtd/nand/onenand/onenand_base.c
index 35f851bf90a3c..a9fdea26ea464 100644
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
@@ -268,10 +268,10 @@ static int onenand_page_address(int page, int sector)
 
 /**
  * onenand_buffer_address - [DEFAULT] Get buffer address
- * @dataram:1	DataRAM index
+ * @dataram1:	DataRAM index
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

