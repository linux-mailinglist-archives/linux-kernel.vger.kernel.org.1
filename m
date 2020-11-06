Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A842A2A9F2A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbgKFVhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbgKFVhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:37:09 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5043AC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 13:37:09 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id w1so2768633wrm.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 13:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4n/4+2lBYe8KEpcSc+k+jaUcNkTMwSw5Q+II+p0iyss=;
        b=E1jmcNObPpOFAHqOiArNxpkGlw9Xo5gZkeh7M/ODJbeB9NBlxV9QjsO8ibIaw6sN7H
         4ynd+QJxlFIDKHDbtIyWiw9iTCSdgcAD9yURYwuna0zJ7eBjXBzOCKnvH+Ktj6d74/X1
         830yGufI3GL9HH7ngOMkelJcTtehVTWJSSS42zTF0svRJ18TSt08TNgmGR6a0T21JyIH
         at61Glf59Wbx1WZSA+p8LhCXIecr/kHQjRK4rRZfVj67/Qrk5GNklpKeMP2mYU8fEhoa
         l5DguekHO8FEVIcQFgUHCxXpkjX7hZwFyiVnyn5uJ9UXIvraXdrJgLBGJ0FECHw+Z/uG
         b+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4n/4+2lBYe8KEpcSc+k+jaUcNkTMwSw5Q+II+p0iyss=;
        b=YV424EipNScSJqDgFgj5pFSj3Isg29IAvAzWTfDu7hNH5NDtndeVDBjGiBEbmbTML6
         JEb9y0Jg6ftYh9gAqUy5F+qgMCFKu70wWIQxs9gSOCD46eXIk8XTSOjVqqPbHJvE6ZEE
         c52wxlpSD1eDCkMW5nyj4836CzNrY6Kqqy0dHjSF5wktXvv7MNjIz/cAUPRbNQYL71nh
         2YUzv6l5YepiZmHEV3f+VlTF6CzmNZmuOzD2QKlzB2nTTaOM3yjcthkCp/9cye2tN8TY
         G5NYBe/egZO6am/1IBcd7UKtjYtfzaEuq2MKlxhxtHrEfoOIe2qmmrduKDWmDFud18SR
         o7NA==
X-Gm-Message-State: AOAM530OLTk29JGeTIPnDdAHFHu+lCcnlhY4wzfET3DXra/IsOX3bTT+
        annhF/WXiEWKqeE6dy5AFqYdL8IA5G+8xwgD
X-Google-Smtp-Source: ABdhPJwUR+1Evv+PkcCkaMHMH5kbjDzfUksJd9J8W72gMGDc4DtY2RyMLaISy4TjBi8Xzhfro7AAjg==
X-Received: by 2002:a5d:6b8e:: with SMTP id n14mr4502896wrx.238.1604698628060;
        Fri, 06 Nov 2020 13:37:08 -0800 (PST)
Received: from dell.default ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id d16sm3984942wrw.17.2020.11.06.13.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:37:07 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH v2 06/23] mtd: nand: onenand: onenand_bbt: Fix expected kernel-doc formatting
Date:   Fri,  6 Nov 2020 21:36:38 +0000
Message-Id: <20201106213655.1838861-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106213655.1838861-1-lee.jones@linaro.org>
References: <20201106213655.1838861-1-lee.jones@linaro.org>
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

