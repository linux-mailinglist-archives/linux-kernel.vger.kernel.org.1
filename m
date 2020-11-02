Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0BB2A2A21
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbgKBLzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbgKBLyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:54:22 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E70AC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:54:22 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id y12so14250082wrp.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4n/4+2lBYe8KEpcSc+k+jaUcNkTMwSw5Q+II+p0iyss=;
        b=iwc3rXe54abh0IHTgT8GJR7Ns9AFQ7uTzRFMH9TYCsgpN7aaTodko0Sqz7REftrzXB
         LpBvtJR8QSrIbHwXqeLx26kD+v6j/Ucf7/lSUy4f3F0EO0vh08+76ebSvforYcOwsv4q
         BROkYCbfu+Lu65EUy2c3+KDEe9aOlPW0JhQ0ftFNQDVg1crYkFcKu66zpbUDctqFznKT
         XnSYA0Zh/V2iF4PdxTCiVnVjLrQHk2Bfvg5hZv3mL4bQXlCrPOTRvebZjVkwcZJ5bJOO
         SgDW3ky2+6+Y7YyOWjSU3mxvPNuKal2OhrMAAPObvBHfXPVbimtPkZQLFx15Rr4y4yYr
         wXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4n/4+2lBYe8KEpcSc+k+jaUcNkTMwSw5Q+II+p0iyss=;
        b=eVqBic8Q8COlMUnDZGBqABbrQsbqjImlvor8WjjrCDIa6FNP2eHVrwDfA1sHetOfn7
         c8MqnJjXVrDYFW8BI+sgFqq2kCuf3tIl+4vJg+r2wHCLGUflaK47FvixbhKmT6RjQmwg
         +j029nUFa9g/zOs9zplzEUW7x8SnwvLjk/De0GB7vyywigPqdsEQnae6Q/aCS9lgc4WC
         cOCTzGIcwNB8DVREGbLBdx0I0065u5PwCTmcYxPtQdPOlR0/15dC+ce2LK9afyaJlpjG
         bKHZfq10DYzQOLnITvFzTP+OFcjn8udL8TEVJiBleoMf1et/voErSF8XHEL8e+jlOG6P
         fZEg==
X-Gm-Message-State: AOAM5326CEbaJcEjmsNx4KYFkGfgYJaqZnphQD6H9QjbyKcGp4K6B+M/
        GHiO/b4PVQOGGUcoQCsietolcJc9j1sjDQ==
X-Google-Smtp-Source: ABdhPJxeMB2reRQ16Bvj9g+9zwEA93NttwfMke0pPcXrs4Vw3KAh14l50poNFbDYG7hOWVp5QcZq4w==
X-Received: by 2002:a05:6000:36f:: with SMTP id f15mr19634536wrf.78.1604318061197;
        Mon, 02 Nov 2020 03:54:21 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id t23sm14284010wmn.13.2020.11.02.03.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:54:20 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     vigneshr@ti.com
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org
Subject: [PATCH 06/23] mtd: nand: onenand: onenand_bbt: Fix expected kernel-doc formatting
Date:   Mon,  2 Nov 2020 11:53:49 +0000
Message-Id: <20201102115406.1074327-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102115406.1074327-1-lee.jones@linaro.org>
References: <20201102115406.1074327-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/mtd/nand/onenand/onenand_bbt.c:33: warning: Function parameter or member 'buf' not described in 'check_short_pattern'
 drivers/mtd/nand/onenand/onenand_bbt.c:33: warning: Function parameter or member 'len' not described in 'check_short_pattern'
 drivers/mtd/nand/onenand/onenand_bbt.c:33: warning: Function parameter or member 'paglen' not described in 'check_short_pattern'
 drivers/mtd/nand/onenand/onenand_bbt.c:33: warning: Function parameter or member 'td' not described in 'check_short_pattern'
 drivers/mtd/nand/onenand/onenand_bbt.c:57: warning: Function parameter or member 'mtd' not described in 'create_bbt'
 drivers/mtd/nand/onenand/onenand_bbt.c:57: warning: Function parameter or member 'buf' not described in 'create_bbt'
 drivers/mtd/nand/onenand/onenand_bbt.c:57: warning: Function parameter or member 'bd' not described in 'create_bbt'
 drivers/mtd/nand/onenand/onenand_bbt.c:57: warning: Function parameter or member 'chip' not described in 'create_bbt'
 drivers/mtd/nand/onenand/onenand_bbt.c:132: warning: Function parameter or member 'mtd' not described in 'onenand_memory_bbt'
 drivers/mtd/nand/onenand/onenand_bbt.c:132: warning: Function parameter or member 'bd' not described in 'onenand_memory_bbt'
 drivers/mtd/nand/onenand/onenand_bbt.c:145: warning: Function parameter or member 'mtd' not described in 'onenand_isbad_bbt'
 drivers/mtd/nand/onenand/onenand_bbt.c:145: warning: Function parameter or member 'offs' not described in 'onenand_isbad_bbt'
 drivers/mtd/nand/onenand/onenand_bbt.c:145: warning: Function parameter or member 'allowbbt' not described in 'onenand_isbad_bbt'
 drivers/mtd/nand/onenand/onenand_bbt.c:182: warning: Function parameter or member 'mtd' not described in 'onenand_scan_bbt'
 drivers/mtd/nand/onenand/onenand_bbt.c:182: warning: Function parameter or member 'bd' not described in 'onenand_scan_bbt'
 drivers/mtd/nand/onenand/onenand_bbt.c:230: warning: Function parameter or member 'mtd' not described in 'onenand_default_bbt'

Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/nand/onenand/onenand_bbt.c | 32 +++++++++++++-------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/mtd/nand/onenand/onenand_bbt.c b/drivers/mtd/nand/onenand/onenand_bbt.c
index 57c31c81be186..def89f1080071 100644
--- a/drivers/mtd/nand/onenand/onenand_bbt.c
+++ b/drivers/mtd/nand/onenand/onenand_bbt.c
@@ -18,10 +18,10 @@
 
 /**
  * check_short_pattern - [GENERIC] check if a pattern is in the buffer
- * @param buf		the buffer to search
- * @param len		the length of buffer to search
- * @param paglen	the pagelength
- * @param td		search pattern descriptor
+ * @buf:		the buffer to search
+ * @len:		the length of buffer to search
+ * @paglen:	the pagelength
+ * @td:		search pattern descriptor
  *
  * Check for a pattern at the given place. Used to search bad block
  * tables and good / bad block identifiers. Same as check_pattern, but
@@ -44,10 +44,10 @@ static int check_short_pattern(uint8_t *buf, int len, int paglen, struct nand_bb
 
 /**
  * create_bbt - [GENERIC] Create a bad block table by scanning the device
- * @param mtd		MTD device structure
- * @param buf		temporary buffer
- * @param bd		descriptor for the good/bad block search pattern
- * @param chip		create the table for a specific chip, -1 read all chips.
+ * @mtd:		MTD device structure
+ * @buf:		temporary buffer
+ * @bd:		descriptor for the good/bad block search pattern
+ * @chip:		create the table for a specific chip, -1 read all chips.
  *              Applies only if NAND_BBT_PERCHIP option is set
  *
  * Create a bad block table by scanning the device
@@ -122,8 +122,8 @@ static int create_bbt(struct mtd_info *mtd, uint8_t *buf, struct nand_bbt_descr
 
 /**
  * onenand_memory_bbt - [GENERIC] create a memory based bad block table
- * @param mtd		MTD device structure
- * @param bd		descriptor for the good/bad block search pattern
+ * @mtd:		MTD device structure
+ * @bd:		descriptor for the good/bad block search pattern
  *
  * The function creates a memory based bbt by scanning the device
  * for manufacturer / software marked good / bad blocks
@@ -137,9 +137,9 @@ static inline int onenand_memory_bbt (struct mtd_info *mtd, struct nand_bbt_desc
 
 /**
  * onenand_isbad_bbt - [OneNAND Interface] Check if a block is bad
- * @param mtd		MTD device structure
- * @param offs		offset in the device
- * @param allowbbt	allow access to bad block table region
+ * @mtd:		MTD device structure
+ * @offs:		offset in the device
+ * @allowbbt:	allow access to bad block table region
  */
 static int onenand_isbad_bbt(struct mtd_info *mtd, loff_t offs, int allowbbt)
 {
@@ -166,8 +166,8 @@ static int onenand_isbad_bbt(struct mtd_info *mtd, loff_t offs, int allowbbt)
 
 /**
  * onenand_scan_bbt - [OneNAND Interface] scan, find, read and maybe create bad block table(s)
- * @param mtd		MTD device structure
- * @param bd		descriptor for the good/bad block search pattern
+ * @mtd:		MTD device structure
+ * @bd:		descriptor for the good/bad block search pattern
  *
  * The function checks, if a bad block table(s) is/are already
  * available. If not it scans the device for manufacturer
@@ -221,7 +221,7 @@ static struct nand_bbt_descr largepage_memorybased = {
 
 /**
  * onenand_default_bbt - [OneNAND Interface] Select a default bad block table for the device
- * @param mtd		MTD device structure
+ * @mtd:		MTD device structure
  *
  * This function selects the default bad block table
  * support for the device and calls the onenand_scan_bbt function
-- 
2.25.1

