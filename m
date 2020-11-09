Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E7E2AC3B2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 19:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730963AbgKISXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 13:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730263AbgKISWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 13:22:49 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D22BC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 10:22:49 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id 23so9806849wrc.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 10:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L9e594iGsPQazHtR8mr0tF4GNyBoavTbOlvYUU648dY=;
        b=Fowc4nWIl5UjfkRn1KnlXrVSIhCsQvwnyUJUB8dRFS033HoYYZsVbJCQp2FL/nW24N
         5ftinzvGbPsxHO6fOkiDCp5ivHx2mvHosErMhnQHv/Wuq2/GYBgs80xokPb+20OlfEzr
         +FHNhNcL3RNUiKUw4Hz5q9iSekIBsMvDX6H6U8K2WZpIdrKoIKYBO2lzPa6CNIQ2mO/S
         ZNO+Fi6NhxmPWJqrNrlMJnhL5uiADzl56VGSrPt6EembETnexf2swYXdO6DgSyboAa4a
         OmKwsq8Jq/7P4qczzbb/g7ogknbNqLtoTo/wq1gvzxyFgAWtm6skrKgqnqk0jNMXFjit
         LHvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L9e594iGsPQazHtR8mr0tF4GNyBoavTbOlvYUU648dY=;
        b=k6Fl64xZ+9Cxy8ekRmLvlZgRX4rKCi40o+WwfoItk+FZhMxaJ5Qk1amAEBeaZlFCgx
         aFMqrApNq21d5vtoZZQUmCIhHVkHzl8lzG6n2453TxOwmLd+WMmGTzVE5U2OgORBDr9p
         4BVKqtRfHwOSieKkPno8RRW1JUDO/9EgiDTHMb5eMfuycd1s06r8W4FmY1LGQatprTQp
         TxTDUqZPIj0DWJn/d0owwslT4LRslhgk8apKBvdWc7mKEoNB+V5vZM1PbeG/jWO2257x
         XZ7a0LMGQS43sE6AMPJf4Fee2xLmAvhH4+PchYYwZfSwooLvcryyPbyaPrfEuWKY7lUp
         rsEA==
X-Gm-Message-State: AOAM530yCs6gzfCVPo47zXKhzHXs9WQZOexXJKtu35fHolTFrPiSDoXl
        +eZStiUIizIoUJ5qQNmbAqhLZPCCO24lQaRz
X-Google-Smtp-Source: ABdhPJxmIJ9Ax6XRUDE0G/dCChXRGe/fAYbAJyqkQ7mX0pIyla0LsBqdxXqXoQObZe3CXyXscaCGkQ==
X-Received: by 2002:adf:eb4c:: with SMTP id u12mr20471487wrn.73.1604946167786;
        Mon, 09 Nov 2020 10:22:47 -0800 (PST)
Received: from dell.default ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id g186sm735365wma.1.2020.11.09.10.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 10:22:47 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jian Zhang <jzhang@ti.com>, linux-mtd@lists.infradead.org
Subject: [PATCH v3 19/23] mtd: rawnand: omap2: Fix a bunch of kernel-doc misdemeanours
Date:   Mon,  9 Nov 2020 18:22:02 +0000
Message-Id: <20201109182206.3037326-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109182206.3037326-1-lee.jones@linaro.org>
References: <20201109182206.3037326-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/mtd/nand/raw/omap2.c:191: warning: Function parameter or member 'info' not described in 'omap_prefetch_enable'
 drivers/mtd/nand/raw/omap2.c:221: warning: Function parameter or member 'cs' not described in 'omap_prefetch_reset'
 drivers/mtd/nand/raw/omap2.c:221: warning: Function parameter or member 'info' not described in 'omap_prefetch_reset'
 drivers/mtd/nand/raw/omap2.c:946: warning: Function parameter or member 'chip' not described in 'omap_enable_hwecc'
 drivers/mtd/nand/raw/omap2.c:946: warning: Excess function parameter 'mtd' description in 'omap_enable_hwecc'
 drivers/mtd/nand/raw/omap2.c:1017: warning: Function parameter or member 'chip' not described in 'omap_dev_ready'
 drivers/mtd/nand/raw/omap2.c:1017: warning: Excess function parameter 'mtd' description in 'omap_dev_ready'
 drivers/mtd/nand/raw/omap2.c:1036: warning: Function parameter or member 'chip' not described in 'omap_enable_hwecc_bch'
 drivers/mtd/nand/raw/omap2.c:1036: warning: Excess function parameter 'mtd' description in 'omap_enable_hwecc_bch'
 drivers/mtd/nand/raw/omap2.c:1142: warning: Function parameter or member 'ecc_calc' not described in '_omap_calculate_ecc_bch'
 drivers/mtd/nand/raw/omap2.c:1142: warning: Excess function parameter 'ecc_code' description in '_omap_calculate_ecc_bch'
 drivers/mtd/nand/raw/omap2.c:1270: warning: Function parameter or member 'ecc_calc' not described in 'omap_calculate_ecc_bch_sw'
 drivers/mtd/nand/raw/omap2.c:1270: warning: Excess function parameter 'ecc_code' description in 'omap_calculate_ecc_bch_sw'
 drivers/mtd/nand/raw/omap2.c:1284: warning: Function parameter or member 'ecc_calc' not described in 'omap_calculate_ecc_bch_multi'
 drivers/mtd/nand/raw/omap2.c:1284: warning: Excess function parameter 'ecc_code' description in 'omap_calculate_ecc_bch_multi'
 drivers/mtd/nand/raw/omap2.c:1681: warning: Function parameter or member 'info' not described in 'is_elm_present'
 drivers/mtd/nand/raw/omap2.c:1681: warning: Function parameter or member 'elm_node' not described in 'is_elm_present'
 drivers/mtd/nand/raw/omap2.c:1681: warning: Excess function parameter 'omap_nand_info' description in 'is_elm_present'

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Jian Zhang <jzhang@ti.com>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/nand/raw/omap2.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/raw/omap2.c b/drivers/mtd/nand/raw/omap2.c
index 4cc47ab7f01ad..fbb9955f24671 100644
--- a/drivers/mtd/nand/raw/omap2.c
+++ b/drivers/mtd/nand/raw/omap2.c
@@ -184,6 +184,7 @@ static inline struct omap_nand_info *mtd_to_omap(struct mtd_info *mtd)
  * @dma_mode: dma mode enable (1) or disable (0)
  * @u32_count: number of bytes to be transferred
  * @is_write: prefetch read(0) or write post(1) mode
+ * @info: NAND device structure containing platform data
  */
 static int omap_prefetch_enable(int cs, int fifo_th, int dma_mode,
 	unsigned int u32_count, int is_write, struct omap_nand_info *info)
@@ -213,7 +214,7 @@ static int omap_prefetch_enable(int cs, int fifo_th, int dma_mode,
 	return 0;
 }
 
-/**
+/*
  * omap_prefetch_reset - disables and stops the prefetch engine
  */
 static int omap_prefetch_reset(int cs, struct omap_nand_info *info)
@@ -938,7 +939,7 @@ static int omap_calculate_ecc(struct nand_chip *chip, const u_char *dat,
 
 /**
  * omap_enable_hwecc - This function enables the hardware ecc functionality
- * @mtd: MTD device structure
+ * @chip: NAND chip object
  * @mode: Read/Write mode
  */
 static void omap_enable_hwecc(struct nand_chip *chip, int mode)
@@ -1008,7 +1009,7 @@ static int omap_wait(struct nand_chip *this)
 
 /**
  * omap_dev_ready - checks the NAND Ready GPIO line
- * @mtd: MTD device structure
+ * @chip: NAND chip object
  *
  * Returns true if ready and false if busy.
  */
@@ -1021,7 +1022,7 @@ static int omap_dev_ready(struct nand_chip *chip)
 
 /**
  * omap_enable_hwecc_bch - Program GPMC to perform BCH ECC calculation
- * @mtd: MTD device structure
+ * @chip: NAND chip object
  * @mode: Read/Write mode
  *
  * When using BCH with SW correction (i.e. no ELM), sector size is set
@@ -1130,7 +1131,7 @@ static u8  bch8_polynomial[] = {0xef, 0x51, 0x2e, 0x09, 0xed, 0x93, 0x9a, 0xc2,
  * _omap_calculate_ecc_bch - Generate ECC bytes for one sector
  * @mtd:	MTD device structure
  * @dat:	The pointer to data on which ecc is computed
- * @ecc_code:	The ecc_code buffer
+ * @ecc_calc:	The ecc_code buffer
  * @i:		The sector number (for a multi sector page)
  *
  * Support calculating of BCH4/8/16 ECC vectors for one sector
@@ -1258,7 +1259,7 @@ static int _omap_calculate_ecc_bch(struct mtd_info *mtd,
  * omap_calculate_ecc_bch_sw - ECC generator for sector for SW based correction
  * @chip:	NAND chip object
  * @dat:	The pointer to data on which ecc is computed
- * @ecc_code:	The ecc_code buffer
+ * @ecc_calc:	Buffer storing the calculated ECC bytes
  *
  * Support calculating of BCH4/8/16 ECC vectors for one sector. This is used
  * when SW based correction is required as ECC is required for one sector
@@ -1274,7 +1275,7 @@ static int omap_calculate_ecc_bch_sw(struct nand_chip *chip,
  * omap_calculate_ecc_bch_multi - Generate ECC for multiple sectors
  * @mtd:	MTD device structure
  * @dat:	The pointer to data on which ecc is computed
- * @ecc_code:	The ecc_code buffer
+ * @ecc_calc:	Buffer storing the calculated ECC bytes
  *
  * Support calculating of BCH4/8/16 ecc vectors for the entire page in one go.
  */
@@ -1673,7 +1674,8 @@ static int omap_read_page_bch(struct nand_chip *chip, uint8_t *buf,
 
 /**
  * is_elm_present - checks for presence of ELM module by scanning DT nodes
- * @omap_nand_info: NAND device structure containing platform data
+ * @info: NAND device structure containing platform data
+ * @elm_node: ELM's DT node
  */
 static bool is_elm_present(struct omap_nand_info *info,
 			   struct device_node *elm_node)
-- 
2.25.1

