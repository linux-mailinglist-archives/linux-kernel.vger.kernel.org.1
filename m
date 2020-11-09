Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D942AC3B4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 19:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730318AbgKISWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 13:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730241AbgKISW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 13:22:29 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4EFC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 10:22:29 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id h62so379638wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 10:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4n/4+2lBYe8KEpcSc+k+jaUcNkTMwSw5Q+II+p0iyss=;
        b=Uj0ilgS29+osExv/bvismVAT/PLBPQdjidoQmjYo/Ro+UVwUGL/jffTPU1iY4aCacY
         Es0GGJnPhXgtd7nKKaseNluDzNC5K52t6wmmT/9T25hAfOKi4q97MkOuZjTxchbhYCOL
         sTyXzuH2q3L3QTQixux3i/SA1TEK7nPZUP0ewXsAk5z0XtW4am/wEmYE/ijjML5LVsv3
         KBCcmYKSq3IpFBQ7vdOz78aE0rN42Ze8eSDT7Uj8l69xepN7VnUJ2Pedk8qRPbj4RUgm
         Kvca8JpHPpGK8bRgF1nn0H0cNT1GpYDidE0IDI6WpsJ1TGJ9uc45oO086N3lkI4uVBe4
         Txag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4n/4+2lBYe8KEpcSc+k+jaUcNkTMwSw5Q+II+p0iyss=;
        b=nB0JzfWjRpUb/IeEUfpZOMnlNQqxAOqUZvhe2DK8lZpuZ4t6g2bKj2nTaycd+NC5t6
         i6FKHOXUCkkjxPU9nENwvX3WJ0ZGpzxr3+n33p998mUg60gv3MzePCl5zSvB0V2KX8+T
         93C0GM5Pwhw2W2HHUIGyeoNQyKpQyAxai6Fu8Jy68sNS7MT7ntRE7NUzgOAxRGnKUPM6
         DP1V/QDJxN9XS5p/HMdSNbBKa7+GGNFSVqYobzPGoaiOnq2rs66E1Hh/bxfOn1pXIwP3
         n2iS+Of5xMn30My+L9FXcrv7z5HHvIlyBykfKQTgVcHEK9JjbZ9HFisf2zMPnLvytmiJ
         if4g==
X-Gm-Message-State: AOAM533Zw6IHi4+GcStCCKS0y7Iqd7ghf4+PljG7j8dLMVIzbw/AjY/Z
        eAObhVwseRBh9xAALdaeRlIqEw==
X-Google-Smtp-Source: ABdhPJxne+218nhdAKjWSPlWYr1ILoyDRrHJiB+zJafRcnkKvf38RggDQlhDOX0FoDEpqX3XFES0Yw==
X-Received: by 2002:a7b:cbd7:: with SMTP id n23mr484206wmi.142.1604946148324;
        Mon, 09 Nov 2020 10:22:28 -0800 (PST)
Received: from dell.default ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id g186sm735365wma.1.2020.11.09.10.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 10:22:27 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH v3 06/23] mtd: onenand: onenand_bbt: Fix expected kernel-doc formatting
Date:   Mon,  9 Nov 2020 18:21:49 +0000
Message-Id: <20201109182206.3037326-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109182206.3037326-1-lee.jones@linaro.org>
References: <20201109182206.3037326-1-lee.jones@linaro.org>
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

