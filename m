Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5317E2A9F27
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgKFVhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728322AbgKFVhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:37:07 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C7CC0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 13:37:05 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id h2so2824485wmm.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 13:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9CIbThDh8w4ecoFBEiHRVWIUMSh9NKlwBvM35bRIyLc=;
        b=r/my7WbpEOyCCzdAYJHenJY7+ZRTPML12M8gxtN/c7mVmjJKeYdiP0jqSyW1m3IRd9
         XJK6bSw+iQp0YL+ssmWV2y0xOABLvncM8tNU3LtGydQpetfHyAPKM80sYrhCpEoBBN22
         JAFr6miL4B+fluBPVb0jHhFE5EMdDq0ISc1wqhFOJw116YXiD1gZAsFINwb72gZvVkMY
         1NtZZ+OfrzHrKt/zjGtlnqC+Bq0wt79kmG9KPs67KEanmR931uyFgTFhsIvs3wDzNVIx
         +JNYtmb66IuzMTF3p01+tHFnhDJ6Q+aG3bpa6nTiqgXFnIIJGhAs0DuFyiolioXTw6zn
         TmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9CIbThDh8w4ecoFBEiHRVWIUMSh9NKlwBvM35bRIyLc=;
        b=inCDsrMHWKI63/58hjMh8dsUhGbYQ9HBEjaW7ZK7dCAisGbcbSDTaiNbsTLfxUhbBF
         ROHGeratZpxMgJlFmfWuX8+WvdRqaf4/h8k5uOqr+TRHh5U/Fd+pGf43QihJiWQzRTfz
         fF4Po6Gefho8PXnuEmWCGpG7sQT0ivr/nnU7bqC7Nhc+njoLD2uH8uQITaEJ0hKMCR++
         Uk7CIZndv0YLBG1DbYYI0+gBPkDNHunnhRLOgtYdOcHh9nzaEayDkPruC6p4v6JsqmI3
         okTE96wpm7W0bjGeO2gX6sh4mmudCgsv50ZbnmvKbvfHuiN7CP76SMP/Hgm4C5UHFYZk
         6mPw==
X-Gm-Message-State: AOAM5335KQOL9F45g+IV+Agt8TAZgdw4+tmmkW3o2RJM1r/NMAMaEe0T
        ikxsSP30p+QnfZWsZcHBonNe46/OP/TZfRDE
X-Google-Smtp-Source: ABdhPJz+318iLFSKWIrZnI3iVegUxKx/6SXh25/mwhNjIE8+Vzs73GT3w+6e9vpFAd5P9BU1/2s8JQ==
X-Received: by 2002:a7b:c08e:: with SMTP id r14mr1605124wmh.165.1604698623933;
        Fri, 06 Nov 2020 13:37:03 -0800 (PST)
Received: from dell.default ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id d16sm3984942wrw.17.2020.11.06.13.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:37:03 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Adrian Hunter <ext-adrian.hunter@nokia.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH v2 03/23] mtd: nand: onenand: onenand_base: Fix expected kernel-doc formatting
Date:   Fri,  6 Nov 2020 21:36:35 +0000
Message-Id: <20201106213655.1838861-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106213655.1838861-1-lee.jones@linaro.org>
References: <20201106213655.1838861-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/mtd/nand/onenand/onenand_base.c:140: warning: Function parameter or member 'mtd' not described in 'onenand_ooblayout_32_64_ecc'
 drivers/mtd/nand/onenand/onenand_base.c:140: warning: Function parameter or member 'section' not described in 'onenand_ooblayout_32_64_ecc'
 drivers/mtd/nand/onenand/onenand_base.c:140: warning: Function parameter or member 'oobregion' not described in 'onenand_ooblayout_32_64_ecc'
 drivers/mtd/nand/onenand/onenand_base.c:200: warning: Function parameter or member 'addr' not described in 'onenand_readw'
 drivers/mtd/nand/onenand/onenand_base.c:212: warning: Function parameter or member 'value' not described in 'onenand_writew'
 drivers/mtd/nand/onenand/onenand_base.c:212: warning: Function parameter or member 'addr' not described in 'onenand_writew'
 drivers/mtd/nand/onenand/onenand_base.c:225: warning: Function parameter or member 'this' not described in 'onenand_block_address'
 drivers/mtd/nand/onenand/onenand_base.c:225: warning: Function parameter or member 'block' not described in 'onenand_block_address'
 drivers/mtd/nand/onenand/onenand_base.c:242: warning: Function parameter or member 'this' not described in 'onenand_bufferram_address'
 drivers/mtd/nand/onenand/onenand_base.c:242: warning: Function parameter or member 'block' not described in 'onenand_bufferram_address'

 NB: Snipped 200 lines for brevity.

Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Adrian Hunter <ext-adrian.hunter@nokia.com>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/nand/onenand/onenand_base.c | 438 ++++++++++++------------
 1 file changed, 219 insertions(+), 219 deletions(-)

diff --git a/drivers/mtd/nand/onenand/onenand_base.c b/drivers/mtd/nand/onenand/onenand_base.c
index 188b8061e1f79..9fca3988ee236 100644
--- a/drivers/mtd/nand/onenand/onenand_base.c
+++ b/drivers/mtd/nand/onenand/onenand_base.c
@@ -192,7 +192,7 @@ static const unsigned char ffchars[] = {
 
 /**
  * onenand_readw - [OneNAND Interface] Read OneNAND register
- * @param addr		address to read
+ * @addr:		address to read
  *
  * Read OneNAND register
  */
@@ -203,8 +203,8 @@ static unsigned short onenand_readw(void __iomem *addr)
 
 /**
  * onenand_writew - [OneNAND Interface] Write OneNAND register with value
- * @param value		value to write
- * @param addr		address to write
+ * @value:		value to write
+ * @addr:		address to write
  *
  * Write OneNAND register with value
  */
@@ -215,8 +215,8 @@ static void onenand_writew(unsigned short value, void __iomem *addr)
 
 /**
  * onenand_block_address - [DEFAULT] Get block address
- * @param this		onenand chip data structure
- * @param block		the block
+ * @this:		onenand chip data structure
+ * @block:		the block
  * @return		translated block address if DDP, otherwise same
  *
  * Setup Start Address 1 Register (F100h)
@@ -232,8 +232,8 @@ static int onenand_block_address(struct onenand_chip *this, int block)
 
 /**
  * onenand_bufferram_address - [DEFAULT] Get bufferram address
- * @param this		onenand chip data structure
- * @param block		the block
+ * @this:		onenand chip data structure
+ * @block:		the block
  * @return		set DBS value if DDP, otherwise 0
  *
  * Setup Start Address 2 Register (F101h) for DDP
@@ -249,8 +249,8 @@ static int onenand_bufferram_address(struct onenand_chip *this, int block)
 
 /**
  * onenand_page_address - [DEFAULT] Get page address
- * @param page		the page address
- * @param sector	the sector address
+ * @page:		the page address
+ * @sector:	the sector address
  * @return		combined page and sector address
  *
  * Setup Start Address 8 Register (F107h)
@@ -268,9 +268,9 @@ static int onenand_page_address(int page, int sector)
 
 /**
  * onenand_buffer_address - [DEFAULT] Get buffer address
- * @param dataram1	DataRAM index
- * @param sectors	the sector address
- * @param count		the number of sectors
+ * @dataram1:	DataRAM index
+ * @sectors:	the sector address
+ * @count:		the number of sectors
  * @return		the start buffer value
  *
  * Setup Start Buffer Register (F200h)
@@ -295,8 +295,8 @@ static int onenand_buffer_address(int dataram1, int sectors, int count)
 
 /**
  * flexonenand_block- For given address return block number
- * @param this         - OneNAND device structure
- * @param addr		- Address for which block number is needed
+ * @this:         - OneNAND device structure
+ * @addr:		- Address for which block number is needed
  */
 static unsigned flexonenand_block(struct onenand_chip *this, loff_t addr)
 {
@@ -359,7 +359,7 @@ EXPORT_SYMBOL(onenand_addr);
 
 /**
  * onenand_get_density - [DEFAULT] Get OneNAND density
- * @param dev_id	OneNAND device ID
+ * @dev_id:	OneNAND device ID
  *
  * Get OneNAND density from device ID
  */
@@ -371,8 +371,8 @@ static inline int onenand_get_density(int dev_id)
 
 /**
  * flexonenand_region - [Flex-OneNAND] Return erase region of addr
- * @param mtd		MTD device structure
- * @param addr		address whose erase region needs to be identified
+ * @mtd:		MTD device structure
+ * @addr:		address whose erase region needs to be identified
  */
 int flexonenand_region(struct mtd_info *mtd, loff_t addr)
 {
@@ -387,10 +387,10 @@ EXPORT_SYMBOL(flexonenand_region);
 
 /**
  * onenand_command - [DEFAULT] Send command to OneNAND device
- * @param mtd		MTD device structure
- * @param cmd		the command to be sent
- * @param addr		offset to read from or write to
- * @param len		number of bytes to read or write
+ * @mtd:		MTD device structure
+ * @cmd:		the command to be sent
+ * @addr:		offset to read from or write to
+ * @len:		number of bytes to read or write
  *
  * Send command to OneNAND device. This function is used for middle/large page
  * devices (1KB/2KB Bytes per page)
@@ -519,7 +519,7 @@ static int onenand_command(struct mtd_info *mtd, int cmd, loff_t addr, size_t le
 
 /**
  * onenand_read_ecc - return ecc status
- * @param this		onenand chip structure
+ * @this:		onenand chip structure
  */
 static inline int onenand_read_ecc(struct onenand_chip *this)
 {
@@ -543,8 +543,8 @@ static inline int onenand_read_ecc(struct onenand_chip *this)
 
 /**
  * onenand_wait - [DEFAULT] wait until the command is done
- * @param mtd		MTD device structure
- * @param state		state to select the max. timeout value
+ * @mtd:		MTD device structure
+ * @state:		state to select the max. timeout value
  *
  * Wait for command done. This applies to all OneNAND command
  * Read can take up to 30us, erase up to 2ms and program up to 350us
@@ -625,8 +625,8 @@ static int onenand_wait(struct mtd_info *mtd, int state)
 
 /*
  * onenand_interrupt - [DEFAULT] onenand interrupt handler
- * @param irq		onenand interrupt number
- * @param dev_id	interrupt data
+ * @irq:		onenand interrupt number
+ * @dev_id:	interrupt data
  *
  * complete the work
  */
@@ -643,8 +643,8 @@ static irqreturn_t onenand_interrupt(int irq, void *data)
 
 /*
  * onenand_interrupt_wait - [DEFAULT] wait until the command is done
- * @param mtd		MTD device structure
- * @param state		state to select the max. timeout value
+ * @mtd:		MTD device structure
+ * @state:		state to select the max. timeout value
  *
  * Wait for command done.
  */
@@ -659,8 +659,8 @@ static int onenand_interrupt_wait(struct mtd_info *mtd, int state)
 
 /*
  * onenand_try_interrupt_wait - [DEFAULT] try interrupt wait
- * @param mtd		MTD device structure
- * @param state		state to select the max. timeout value
+ * @mtd:		MTD device structure
+ * @state:		state to select the max. timeout value
  *
  * Try interrupt based wait (It is used one-time)
  */
@@ -689,7 +689,7 @@ static int onenand_try_interrupt_wait(struct mtd_info *mtd, int state)
 
 /*
  * onenand_setup_wait - [OneNAND Interface] setup onenand wait method
- * @param mtd		MTD device structure
+ * @mtd:		MTD device structure
  *
  * There's two method to wait onenand work
  * 1. polling - read interrupt status register
@@ -724,8 +724,8 @@ static void onenand_setup_wait(struct mtd_info *mtd)
 
 /**
  * onenand_bufferram_offset - [DEFAULT] BufferRAM offset
- * @param mtd		MTD data structure
- * @param area		BufferRAM area
+ * @mtd:		MTD data structure
+ * @area:		BufferRAM area
  * @return		offset given area
  *
  * Return BufferRAM offset given area
@@ -747,11 +747,11 @@ static inline int onenand_bufferram_offset(struct mtd_info *mtd, int area)
 
 /**
  * onenand_read_bufferram - [OneNAND Interface] Read the bufferram area
- * @param mtd		MTD data structure
- * @param area		BufferRAM area
- * @param buffer	the databuffer to put/get data
- * @param offset	offset to read from or write to
- * @param count		number of bytes to read/write
+ * @mtd:		MTD data structure
+ * @area:		BufferRAM area
+ * @buffer:	the databuffer to put/get data
+ * @offset:	offset to read from or write to
+ * @count:		number of bytes to read/write
  *
  * Read the BufferRAM area
  */
@@ -783,11 +783,11 @@ static int onenand_read_bufferram(struct mtd_info *mtd, int area,
 
 /**
  * onenand_sync_read_bufferram - [OneNAND Interface] Read the bufferram area with Sync. Burst mode
- * @param mtd		MTD data structure
- * @param area		BufferRAM area
- * @param buffer	the databuffer to put/get data
- * @param offset	offset to read from or write to
- * @param count		number of bytes to read/write
+ * @mtd:		MTD data structure
+ * @area:		BufferRAM area
+ * @buffer:	the databuffer to put/get data
+ * @offset:	offset to read from or write to
+ * @count:		number of bytes to read/write
  *
  * Read the BufferRAM area with Sync. Burst Mode
  */
@@ -823,11 +823,11 @@ static int onenand_sync_read_bufferram(struct mtd_info *mtd, int area,
 
 /**
  * onenand_write_bufferram - [OneNAND Interface] Write the bufferram area
- * @param mtd		MTD data structure
- * @param area		BufferRAM area
- * @param buffer	the databuffer to put/get data
- * @param offset	offset to read from or write to
- * @param count		number of bytes to read/write
+ * @mtd:		MTD data structure
+ * @area:		BufferRAM area
+ * @buffer:	the databuffer to put/get data
+ * @offset:	offset to read from or write to
+ * @count:		number of bytes to read/write
  *
  * Write the BufferRAM area
  */
@@ -864,8 +864,8 @@ static int onenand_write_bufferram(struct mtd_info *mtd, int area,
 
 /**
  * onenand_get_2x_blockpage - [GENERIC] Get blockpage at 2x program mode
- * @param mtd		MTD data structure
- * @param addr		address to check
+ * @mtd:		MTD data structure
+ * @addr:		address to check
  * @return		blockpage address
  *
  * Get blockpage address at 2x program mode
@@ -888,8 +888,8 @@ static int onenand_get_2x_blockpage(struct mtd_info *mtd, loff_t addr)
 
 /**
  * onenand_check_bufferram - [GENERIC] Check BufferRAM information
- * @param mtd		MTD data structure
- * @param addr		address to check
+ * @mtd:		MTD data structure
+ * @addr:		address to check
  * @return		1 if there are valid data, otherwise 0
  *
  * Check bufferram if there is data we required
@@ -930,9 +930,9 @@ static int onenand_check_bufferram(struct mtd_info *mtd, loff_t addr)
 
 /**
  * onenand_update_bufferram - [GENERIC] Update BufferRAM information
- * @param mtd		MTD data structure
- * @param addr		address to update
- * @param valid		valid flag
+ * @mtd:		MTD data structure
+ * @addr:		address to update
+ * @valid:		valid flag
  *
  * Update BufferRAM information
  */
@@ -963,9 +963,9 @@ static void onenand_update_bufferram(struct mtd_info *mtd, loff_t addr,
 
 /**
  * onenand_invalidate_bufferram - [GENERIC] Invalidate BufferRAM information
- * @param mtd		MTD data structure
- * @param addr		start address to invalidate
- * @param len		length to invalidate
+ * @mtd:		MTD data structure
+ * @addr:		start address to invalidate
+ * @len:		length to invalidate
  *
  * Invalidate BufferRAM information
  */
@@ -986,8 +986,8 @@ static void onenand_invalidate_bufferram(struct mtd_info *mtd, loff_t addr,
 
 /**
  * onenand_get_device - [GENERIC] Get chip for selected access
- * @param mtd		MTD device structure
- * @param new_state	the state which is requested
+ * @mtd:		MTD device structure
+ * @new_state:	the state which is requested
  *
  * Get the device and lock it for exclusive access
  */
@@ -1024,7 +1024,7 @@ static int onenand_get_device(struct mtd_info *mtd, int new_state)
 
 /**
  * onenand_release_device - [GENERIC] release chip
- * @param mtd		MTD device structure
+ * @mtd:		MTD device structure
  *
  * Deselect, release chip lock and wake up anyone waiting on the device
  */
@@ -1043,10 +1043,10 @@ static void onenand_release_device(struct mtd_info *mtd)
 
 /**
  * onenand_transfer_auto_oob - [INTERN] oob auto-placement transfer
- * @param mtd		MTD device structure
- * @param buf		destination address
- * @param column	oob offset to read from
- * @param thislen	oob length to read
+ * @mtd:		MTD device structure
+ * @buf:		destination address
+ * @column:	oob offset to read from
+ * @thislen:	oob length to read
  */
 static int onenand_transfer_auto_oob(struct mtd_info *mtd, uint8_t *buf, int column,
 				int thislen)
@@ -1061,9 +1061,9 @@ static int onenand_transfer_auto_oob(struct mtd_info *mtd, uint8_t *buf, int col
 
 /**
  * onenand_recover_lsb - [Flex-OneNAND] Recover LSB page data
- * @param mtd		MTD device structure
- * @param addr		address to recover
- * @param status	return value from onenand_wait / onenand_bbt_wait
+ * @mtd:		MTD device structure
+ * @addr:		address to recover
+ * @status:	return value from onenand_wait / onenand_bbt_wait
  *
  * MLC NAND Flash cell has paired pages - LSB page and MSB page. LSB page has
  * lower page address and MSB page has higher page address in paired pages.
@@ -1104,9 +1104,9 @@ static int onenand_recover_lsb(struct mtd_info *mtd, loff_t addr, int status)
 
 /**
  * onenand_mlc_read_ops_nolock - MLC OneNAND read main and/or out-of-band
- * @param mtd		MTD device structure
- * @param from		offset to read from
- * @param ops:		oob operation description structure
+ * @mtd:		MTD device structure
+ * @from:		offset to read from
+ * @ops:		oob operation description structure
  *
  * MLC OneNAND / Flex-OneNAND has 4KB page size and 4KB dataram.
  * So, read-while-load is not present.
@@ -1206,9 +1206,9 @@ static int onenand_mlc_read_ops_nolock(struct mtd_info *mtd, loff_t from,
 
 /**
  * onenand_read_ops_nolock - [OneNAND Interface] OneNAND read main and/or out-of-band
- * @param mtd		MTD device structure
- * @param from		offset to read from
- * @param ops:		oob operation description structure
+ * @mtd:		MTD device structure
+ * @from:		offset to read from
+ * @ops:		oob operation description structure
  *
  * OneNAND read main and/or out-of-band data
  */
@@ -1335,9 +1335,9 @@ static int onenand_read_ops_nolock(struct mtd_info *mtd, loff_t from,
 
 /**
  * onenand_read_oob_nolock - [MTD Interface] OneNAND read out-of-band
- * @param mtd		MTD device structure
- * @param from		offset to read from
- * @param ops:		oob operation description structure
+ * @mtd:		MTD device structure
+ * @from:		offset to read from
+ * @ops:		oob operation description structure
  *
  * OneNAND read out-of-band data from the spare area
  */
@@ -1430,9 +1430,9 @@ static int onenand_read_oob_nolock(struct mtd_info *mtd, loff_t from,
 
 /**
  * onenand_read_oob - [MTD Interface] Read main and/or out-of-band
- * @param mtd:		MTD device structure
- * @param from:		offset to read from
- * @param ops:		oob operation description structure
+ * @mtd:		MTD device structure
+ * @from:		offset to read from
+ * @ops:		oob operation description structure
 
  * Read main and/or out-of-band
  */
@@ -1466,8 +1466,8 @@ static int onenand_read_oob(struct mtd_info *mtd, loff_t from,
 
 /**
  * onenand_bbt_wait - [DEFAULT] wait until the command is done
- * @param mtd		MTD device structure
- * @param state		state to select the max. timeout value
+ * @mtd:		MTD device structure
+ * @state:		state to select the max. timeout value
  *
  * Wait for command done.
  */
@@ -1517,9 +1517,9 @@ static int onenand_bbt_wait(struct mtd_info *mtd, int state)
 
 /**
  * onenand_bbt_read_oob - [MTD Interface] OneNAND read out-of-band for bbt scan
- * @param mtd		MTD device structure
- * @param from		offset to read from
- * @param ops		oob operation description structure
+ * @mtd:		MTD device structure
+ * @from:		offset to read from
+ * @ops:		oob operation description structure
  *
  * OneNAND read out-of-band data from the spare area for bbt scan
  */
@@ -1594,9 +1594,9 @@ int onenand_bbt_read_oob(struct mtd_info *mtd, loff_t from,
 #ifdef CONFIG_MTD_ONENAND_VERIFY_WRITE
 /**
  * onenand_verify_oob - [GENERIC] verify the oob contents after a write
- * @param mtd		MTD device structure
- * @param buf		the databuffer to verify
- * @param to		offset to read from
+ * @mtd:		MTD device structure
+ * @buf:		the databuffer to verify
+ * @to:		offset to read from
  */
 static int onenand_verify_oob(struct mtd_info *mtd, const u_char *buf, loff_t to)
 {
@@ -1622,10 +1622,10 @@ static int onenand_verify_oob(struct mtd_info *mtd, const u_char *buf, loff_t to
 
 /**
  * onenand_verify - [GENERIC] verify the chip contents after a write
- * @param mtd          MTD device structure
- * @param buf          the databuffer to verify
- * @param addr         offset to read from
- * @param len          number of bytes to read and compare
+ * @mtd:          MTD device structure
+ * @buf:          the databuffer to verify
+ * @addr:         offset to read from
+ * @len:          number of bytes to read and compare
  */
 static int onenand_verify(struct mtd_info *mtd, const u_char *buf, loff_t addr, size_t len)
 {
@@ -1684,11 +1684,11 @@ static void onenand_panic_wait(struct mtd_info *mtd)
 
 /**
  * onenand_panic_write - [MTD Interface] write buffer to FLASH in a panic context
- * @param mtd		MTD device structure
- * @param to		offset to write to
- * @param len		number of bytes to write
- * @param retlen	pointer to variable to store the number of written bytes
- * @param buf		the data to write
+ * @mtd:		MTD device structure
+ * @to:		offset to write to
+ * @len:		number of bytes to write
+ * @retlen:	pointer to variable to store the number of written bytes
+ * @buf:		the data to write
  *
  * Write with ECC
  */
@@ -1762,11 +1762,11 @@ static int onenand_panic_write(struct mtd_info *mtd, loff_t to, size_t len,
 
 /**
  * onenand_fill_auto_oob - [INTERN] oob auto-placement transfer
- * @param mtd		MTD device structure
- * @param oob_buf	oob buffer
- * @param buf		source address
- * @param column	oob offset to write to
- * @param thislen	oob length to write
+ * @mtd:		MTD device structure
+ * @oob_buf:	oob buffer
+ * @buf:		source address
+ * @column:	oob offset to write to
+ * @thislen:	oob length to write
  */
 static int onenand_fill_auto_oob(struct mtd_info *mtd, u_char *oob_buf,
 				  const u_char *buf, int column, int thislen)
@@ -1776,9 +1776,9 @@ static int onenand_fill_auto_oob(struct mtd_info *mtd, u_char *oob_buf,
 
 /**
  * onenand_write_ops_nolock - [OneNAND Interface] write main and/or out-of-band
- * @param mtd		MTD device structure
- * @param to		offset to write to
- * @param ops		oob operation description structure
+ * @mtd:		MTD device structure
+ * @to:		offset to write to
+ * @ops:		oob operation description structure
  *
  * Write main and/or oob with ECC
  */
@@ -1957,12 +1957,12 @@ static int onenand_write_ops_nolock(struct mtd_info *mtd, loff_t to,
 
 /**
  * onenand_write_oob_nolock - [INTERN] OneNAND write out-of-band
- * @param mtd		MTD device structure
- * @param to		offset to write to
- * @param len		number of bytes to write
- * @param retlen	pointer to variable to store the number of written bytes
- * @param buf		the data to write
- * @param mode		operation mode
+ * @mtd:		MTD device structure
+ * @to:		offset to write to
+ * @len:		number of bytes to write
+ * @retlen:	pointer to variable to store the number of written bytes
+ * @buf:		the data to write
+ * @mode:		operation mode
  *
  * OneNAND write out-of-band
  */
@@ -2070,9 +2070,9 @@ static int onenand_write_oob_nolock(struct mtd_info *mtd, loff_t to,
 
 /**
  * onenand_write_oob - [MTD Interface] NAND write data and/or out-of-band
- * @param mtd:		MTD device structure
- * @param to:		offset to write
- * @param ops:		oob operation description structure
+ * @mtd:		MTD device structure
+ * @to:			offset to write
+ * @ops:		oob operation description structure
  */
 static int onenand_write_oob(struct mtd_info *mtd, loff_t to,
 			     struct mtd_oob_ops *ops)
@@ -2101,9 +2101,9 @@ static int onenand_write_oob(struct mtd_info *mtd, loff_t to,
 
 /**
  * onenand_block_isbad_nolock - [GENERIC] Check if a block is marked bad
- * @param mtd		MTD device structure
- * @param ofs		offset from device start
- * @param allowbbt	1, if its allowed to access the bbt area
+ * @mtd:		MTD device structure
+ * @ofs:		offset from device start
+ * @allowbbt:	1, if its allowed to access the bbt area
  *
  * Check, if the block is bad. Either by reading the bad block table or
  * calling of the scan function.
@@ -2144,9 +2144,9 @@ static int onenand_multiblock_erase_verify(struct mtd_info *mtd,
 
 /**
  * onenand_multiblock_erase - [INTERN] erase block(s) using multiblock erase
- * @param mtd		MTD device structure
- * @param instr		erase instruction
- * @param region	erase region
+ * @mtd:		MTD device structure
+ * @instr:		erase instruction
+ * @region:	erase region
  *
  * Erase one or more blocks up to 64 block at a time
  */
@@ -2254,10 +2254,10 @@ static int onenand_multiblock_erase(struct mtd_info *mtd,
 
 /**
  * onenand_block_by_block_erase - [INTERN] erase block(s) using regular erase
- * @param mtd		MTD device structure
- * @param instr		erase instruction
- * @param region	erase region
- * @param block_size	erase block size
+ * @mtd:		MTD device structure
+ * @instr:		erase instruction
+ * @region:	erase region
+ * @block_size:	erase block size
  *
  * Erase one or more blocks one block at a time
  */
@@ -2326,8 +2326,8 @@ static int onenand_block_by_block_erase(struct mtd_info *mtd,
 
 /**
  * onenand_erase - [MTD Interface] erase block(s)
- * @param mtd		MTD device structure
- * @param instr		erase instruction
+ * @mtd:		MTD device structure
+ * @instr:		erase instruction
  *
  * Erase one or more blocks
  */
@@ -2391,7 +2391,7 @@ static int onenand_erase(struct mtd_info *mtd, struct erase_info *instr)
 
 /**
  * onenand_sync - [MTD Interface] sync
- * @param mtd		MTD device structure
+ * @mtd:		MTD device structure
  *
  * Sync is actually a wait for chip ready function
  */
@@ -2408,8 +2408,8 @@ static void onenand_sync(struct mtd_info *mtd)
 
 /**
  * onenand_block_isbad - [MTD Interface] Check whether the block at the given offset is bad
- * @param mtd		MTD device structure
- * @param ofs		offset relative to mtd start
+ * @mtd:		MTD device structure
+ * @ofs:		offset relative to mtd start
  *
  * Check whether the block is bad
  */
@@ -2425,8 +2425,8 @@ static int onenand_block_isbad(struct mtd_info *mtd, loff_t ofs)
 
 /**
  * onenand_default_block_markbad - [DEFAULT] mark a block bad
- * @param mtd		MTD device structure
- * @param ofs		offset from device start
+ * @mtd:		MTD device structure
+ * @ofs:		offset from device start
  *
  * This is the default implementation, which can be overridden by
  * a hardware specific driver.
@@ -2460,8 +2460,8 @@ static int onenand_default_block_markbad(struct mtd_info *mtd, loff_t ofs)
 
 /**
  * onenand_block_markbad - [MTD Interface] Mark the block at the given offset as bad
- * @param mtd		MTD device structure
- * @param ofs		offset relative to mtd start
+ * @mtd:		MTD device structure
+ * @ofs:		offset relative to mtd start
  *
  * Mark the block as bad
  */
@@ -2486,10 +2486,10 @@ static int onenand_block_markbad(struct mtd_info *mtd, loff_t ofs)
 
 /**
  * onenand_do_lock_cmd - [OneNAND Interface] Lock or unlock block(s)
- * @param mtd		MTD device structure
- * @param ofs		offset relative to mtd start
- * @param len		number of bytes to lock or unlock
- * @param cmd		lock or unlock command
+ * @mtd:		MTD device structure
+ * @ofs:		offset relative to mtd start
+ * @len:		number of bytes to lock or unlock
+ * @cmd:		lock or unlock command
  *
  * Lock or unlock one or more blocks
  */
@@ -2566,9 +2566,9 @@ static int onenand_do_lock_cmd(struct mtd_info *mtd, loff_t ofs, size_t len, int
 
 /**
  * onenand_lock - [MTD Interface] Lock block(s)
- * @param mtd		MTD device structure
- * @param ofs		offset relative to mtd start
- * @param len		number of bytes to unlock
+ * @mtd:		MTD device structure
+ * @ofs:		offset relative to mtd start
+ * @len:		number of bytes to unlock
  *
  * Lock one or more blocks
  */
@@ -2584,9 +2584,9 @@ static int onenand_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 
 /**
  * onenand_unlock - [MTD Interface] Unlock block(s)
- * @param mtd		MTD device structure
- * @param ofs		offset relative to mtd start
- * @param len		number of bytes to unlock
+ * @mtd:		MTD device structure
+ * @ofs:		offset relative to mtd start
+ * @len:		number of bytes to unlock
  *
  * Unlock one or more blocks
  */
@@ -2602,7 +2602,7 @@ static int onenand_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 
 /**
  * onenand_check_lock_status - [OneNAND Interface] Check lock status
- * @param this		onenand chip data structure
+ * @this:		onenand chip data structure
  *
  * Check lock status
  */
@@ -2636,7 +2636,7 @@ static int onenand_check_lock_status(struct onenand_chip *this)
 
 /**
  * onenand_unlock_all - [OneNAND Interface] unlock all blocks
- * @param mtd		MTD device structure
+ * @mtd:		MTD device structure
  *
  * Unlock all blocks
  */
@@ -2683,10 +2683,10 @@ static void onenand_unlock_all(struct mtd_info *mtd)
 
 /**
  * onenand_otp_command - Send OTP specific command to OneNAND device
- * @param mtd	 MTD device structure
- * @param cmd	 the command to be sent
- * @param addr	 offset to read from or write to
- * @param len	 number of bytes to read or write
+ * @mtd:	 MTD device structure
+ * @cmd:	 the command to be sent
+ * @addr:	 offset to read from or write to
+ * @len:	 number of bytes to read or write
  */
 static int onenand_otp_command(struct mtd_info *mtd, int cmd, loff_t addr,
 				size_t len)
@@ -2758,11 +2758,11 @@ static int onenand_otp_command(struct mtd_info *mtd, int cmd, loff_t addr,
 
 /**
  * onenand_otp_write_oob_nolock - [INTERN] OneNAND write out-of-band, specific to OTP
- * @param mtd		MTD device structure
- * @param to		offset to write to
- * @param len		number of bytes to write
- * @param retlen	pointer to variable to store the number of written bytes
- * @param buf		the data to write
+ * @mtd:		MTD device structure
+ * @to:		offset to write to
+ * @len:		number of bytes to write
+ * @retlen:	pointer to variable to store the number of written bytes
+ * @buf:		the data to write
  *
  * OneNAND write out-of-band only for OTP
  */
@@ -2889,11 +2889,11 @@ typedef int (*otp_op_t)(struct mtd_info *mtd, loff_t form, size_t len,
 
 /**
  * do_otp_read - [DEFAULT] Read OTP block area
- * @param mtd		MTD device structure
- * @param from		The offset to read
- * @param len		number of bytes to read
- * @param retlen	pointer to variable to store the number of readbytes
- * @param buf		the databuffer to put/get data
+ * @mtd:		MTD device structure
+ * @from:		The offset to read
+ * @len:		number of bytes to read
+ * @retlen:	pointer to variable to store the number of readbytes
+ * @buf:		the databuffer to put/get data
  *
  * Read OTP block area.
  */
@@ -2926,11 +2926,11 @@ static int do_otp_read(struct mtd_info *mtd, loff_t from, size_t len,
 
 /**
  * do_otp_write - [DEFAULT] Write OTP block area
- * @param mtd		MTD device structure
- * @param to		The offset to write
- * @param len		number of bytes to write
- * @param retlen	pointer to variable to store the number of write bytes
- * @param buf		the databuffer to put/get data
+ * @mtd:		MTD device structure
+ * @to:		The offset to write
+ * @len:		number of bytes to write
+ * @retlen:	pointer to variable to store the number of write bytes
+ * @buf:		the databuffer to put/get data
  *
  * Write OTP block area.
  */
@@ -2970,11 +2970,11 @@ static int do_otp_write(struct mtd_info *mtd, loff_t to, size_t len,
 
 /**
  * do_otp_lock - [DEFAULT] Lock OTP block area
- * @param mtd		MTD device structure
- * @param from		The offset to lock
- * @param len		number of bytes to lock
- * @param retlen	pointer to variable to store the number of lock bytes
- * @param buf		the databuffer to put/get data
+ * @mtd:		MTD device structure
+ * @from:		The offset to lock
+ * @len:		number of bytes to lock
+ * @retlen:	pointer to variable to store the number of lock bytes
+ * @buf:		the databuffer to put/get data
  *
  * Lock OTP block area.
  */
@@ -3018,13 +3018,13 @@ static int do_otp_lock(struct mtd_info *mtd, loff_t from, size_t len,
 
 /**
  * onenand_otp_walk - [DEFAULT] Handle OTP operation
- * @param mtd		MTD device structure
- * @param from		The offset to read/write
- * @param len		number of bytes to read/write
- * @param retlen	pointer to variable to store the number of read bytes
- * @param buf		the databuffer to put/get data
- * @param action	do given action
- * @param mode		specify user and factory
+ * @mtd:		MTD device structure
+ * @from:		The offset to read/write
+ * @len:		number of bytes to read/write
+ * @retlen:	pointer to variable to store the number of read bytes
+ * @buf:		the databuffer to put/get data
+ * @action:	do given action
+ * @mode:		specify user and factory
  *
  * Handle OTP operation.
  */
@@ -3099,10 +3099,10 @@ static int onenand_otp_walk(struct mtd_info *mtd, loff_t from, size_t len,
 
 /**
  * onenand_get_fact_prot_info - [MTD Interface] Read factory OTP info
- * @param mtd		MTD device structure
- * @param len		number of bytes to read
- * @param retlen	pointer to variable to store the number of read bytes
- * @param buf		the databuffer to put/get data
+ * @mtd:		MTD device structure
+ * @len:		number of bytes to read
+ * @retlen:	pointer to variable to store the number of read bytes
+ * @buf:		the databuffer to put/get data
  *
  * Read factory OTP info.
  */
@@ -3115,11 +3115,11 @@ static int onenand_get_fact_prot_info(struct mtd_info *mtd, size_t len,
 
 /**
  * onenand_read_fact_prot_reg - [MTD Interface] Read factory OTP area
- * @param mtd		MTD device structure
- * @param from		The offset to read
- * @param len		number of bytes to read
- * @param retlen	pointer to variable to store the number of read bytes
- * @param buf		the databuffer to put/get data
+ * @mtd:		MTD device structure
+ * @from:		The offset to read
+ * @len:		number of bytes to read
+ * @retlen:	pointer to variable to store the number of read bytes
+ * @buf:		the databuffer to put/get data
  *
  * Read factory OTP area.
  */
@@ -3131,10 +3131,10 @@ static int onenand_read_fact_prot_reg(struct mtd_info *mtd, loff_t from,
 
 /**
  * onenand_get_user_prot_info - [MTD Interface] Read user OTP info
- * @param mtd		MTD device structure
- * @param retlen	pointer to variable to store the number of read bytes
- * @param len		number of bytes to read
- * @param buf		the databuffer to put/get data
+ * @mtd:		MTD device structure
+ * @retlen:	pointer to variable to store the number of read bytes
+ * @len:		number of bytes to read
+ * @buf:		the databuffer to put/get data
  *
  * Read user OTP info.
  */
@@ -3147,11 +3147,11 @@ static int onenand_get_user_prot_info(struct mtd_info *mtd, size_t len,
 
 /**
  * onenand_read_user_prot_reg - [MTD Interface] Read user OTP area
- * @param mtd		MTD device structure
- * @param from		The offset to read
- * @param len		number of bytes to read
- * @param retlen	pointer to variable to store the number of read bytes
- * @param buf		the databuffer to put/get data
+ * @mtd:		MTD device structure
+ * @from:		The offset to read
+ * @len:		number of bytes to read
+ * @retlen:	pointer to variable to store the number of read bytes
+ * @buf:		the databuffer to put/get data
  *
  * Read user OTP area.
  */
@@ -3163,11 +3163,11 @@ static int onenand_read_user_prot_reg(struct mtd_info *mtd, loff_t from,
 
 /**
  * onenand_write_user_prot_reg - [MTD Interface] Write user OTP area
- * @param mtd		MTD device structure
- * @param from		The offset to write
- * @param len		number of bytes to write
- * @param retlen	pointer to variable to store the number of write bytes
- * @param buf		the databuffer to put/get data
+ * @mtd:		MTD device structure
+ * @from:		The offset to write
+ * @len:		number of bytes to write
+ * @retlen:	pointer to variable to store the number of write bytes
+ * @buf:		the databuffer to put/get data
  *
  * Write user OTP area.
  */
@@ -3179,9 +3179,9 @@ static int onenand_write_user_prot_reg(struct mtd_info *mtd, loff_t from,
 
 /**
  * onenand_lock_user_prot_reg - [MTD Interface] Lock user OTP area
- * @param mtd		MTD device structure
- * @param from		The offset to lock
- * @param len		number of bytes to unlock
+ * @mtd:		MTD device structure
+ * @from:		The offset to lock
+ * @len:		number of bytes to unlock
  *
  * Write lock mark on spare area in page 0 in OTP block
  */
@@ -3234,7 +3234,7 @@ static int onenand_lock_user_prot_reg(struct mtd_info *mtd, loff_t from,
 
 /**
  * onenand_check_features - Check and set OneNAND features
- * @param mtd		MTD data structure
+ * @mtd:		MTD data structure
  *
  * Check and set OneNAND features
  * - lock scheme
@@ -3324,8 +3324,8 @@ static void onenand_check_features(struct mtd_info *mtd)
 
 /**
  * onenand_print_device_info - Print device & version ID
- * @param device        device ID
- * @param version	version ID
+ * @device:        device ID
+ * @version:	version ID
  *
  * Print device & version ID
  */
@@ -3355,7 +3355,7 @@ static const struct onenand_manufacturers onenand_manuf_ids[] = {
 
 /**
  * onenand_check_maf - Check manufacturer ID
- * @param manuf         manufacturer ID
+ * @manuf:         manufacturer ID
  *
  * Check manufacturer ID
  */
@@ -3381,7 +3381,7 @@ static int onenand_check_maf(int manuf)
 
 /**
 * flexonenand_get_boundary	- Reads the SLC boundary
-* @param onenand_info		- onenand info structure
+* @onenand_info:		- onenand info structure
 **/
 static int flexonenand_get_boundary(struct mtd_info *mtd)
 {
@@ -3422,7 +3422,7 @@ static int flexonenand_get_boundary(struct mtd_info *mtd)
 /**
  * flexonenand_get_size - Fill up fields in onenand_chip and mtd_info
  * 			  boundary[], diesize[], mtd->size, mtd->erasesize
- * @param mtd		- MTD device structure
+ * @mtd:		- MTD device structure
  */
 static void flexonenand_get_size(struct mtd_info *mtd)
 {
@@ -3493,9 +3493,9 @@ static void flexonenand_get_size(struct mtd_info *mtd)
 
 /**
  * flexonenand_check_blocks_erased - Check if blocks are erased
- * @param mtd_info	- mtd info structure
- * @param start		- first erase block to check
- * @param end		- last erase block to check
+ * @mtd_info:	- mtd info structure
+ * @start:		- first erase block to check
+ * @end:		- last erase block to check
  *
  * Converting an unerased block from MLC to SLC
  * causes byte values to change. Since both data and its ECC
@@ -3550,7 +3550,7 @@ static int flexonenand_check_blocks_erased(struct mtd_info *mtd, int start, int
 
 /**
  * flexonenand_set_boundary	- Writes the SLC boundary
- * @param mtd			- mtd info structure
+ * @mtd:			- mtd info structure
  */
 static int flexonenand_set_boundary(struct mtd_info *mtd, int die,
 				    int boundary, int lock)
@@ -3640,7 +3640,7 @@ static int flexonenand_set_boundary(struct mtd_info *mtd, int die,
 
 /**
  * onenand_chip_probe - [OneNAND Interface] The generic chip probe
- * @param mtd		MTD device structure
+ * @mtd:		MTD device structure
  *
  * OneNAND detection method:
  *   Compare the values from command with ones from register
@@ -3688,7 +3688,7 @@ static int onenand_chip_probe(struct mtd_info *mtd)
 
 /**
  * onenand_probe - [OneNAND Interface] Probe the OneNAND device
- * @param mtd		MTD device structure
+ * @mtd:		MTD device structure
  */
 static int onenand_probe(struct mtd_info *mtd)
 {
@@ -3783,7 +3783,7 @@ static int onenand_probe(struct mtd_info *mtd)
 
 /**
  * onenand_suspend - [MTD Interface] Suspend the OneNAND flash
- * @param mtd		MTD device structure
+ * @mtd:		MTD device structure
  */
 static int onenand_suspend(struct mtd_info *mtd)
 {
@@ -3792,7 +3792,7 @@ static int onenand_suspend(struct mtd_info *mtd)
 
 /**
  * onenand_resume - [MTD Interface] Resume the OneNAND flash
- * @param mtd		MTD device structure
+ * @mtd:		MTD device structure
  */
 static void onenand_resume(struct mtd_info *mtd)
 {
@@ -3807,8 +3807,8 @@ static void onenand_resume(struct mtd_info *mtd)
 
 /**
  * onenand_scan - [OneNAND Interface] Scan for the OneNAND device
- * @param mtd		MTD device structure
- * @param maxchips	Number of chips to scan for
+ * @mtd:		MTD device structure
+ * @maxchips:	Number of chips to scan for
  *
  * This fills out all the not initialized function pointers
  * with the defaults.
@@ -3985,7 +3985,7 @@ int onenand_scan(struct mtd_info *mtd, int maxchips)
 
 /**
  * onenand_release - [OneNAND Interface] Free resources held by the OneNAND device
- * @param mtd		MTD device structure
+ * @mtd:		MTD device structure
  */
 void onenand_release(struct mtd_info *mtd)
 {
-- 
2.25.1

