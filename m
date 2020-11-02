Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA20C2A2A33
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbgKBL55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbgKBL5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:57:53 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2844EC061A47
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:57:53 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id i16so8846406wrv.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DRufDNzm9kpYb+RMx6EOR5JDO8dhM8oippZOTHhZhUw=;
        b=ruvCx8x/g7zGkr4kj60/QUlZTUppYMA5FY/7dyS839hSQGBRyMGUM4SHPGZVDO9tK2
         cReKtJLucEK7tPOI1GC1vMm+Pf+cxbF7vSeop36X/o+kMYQIB/sIVst53wCht4SORCwd
         04t/wBPAJG6hPUU8PRpnGIWtpEXaFsQeYBAZHJUQZITALF2Oldh6/7KUkdInc9bDYdq+
         BrOsJMrcrsOtTF0tMtdyzndxR2TO/a5bjcKZeO/2M/jkeUzexuzQyW5tAYjXag9rFelo
         haBP1kxeIg+2HHFIfDCXMi0G63HxbeDk0N32dcCIkhfG6RIwn7/ZRpXdSKkldfCDEq+B
         oAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DRufDNzm9kpYb+RMx6EOR5JDO8dhM8oippZOTHhZhUw=;
        b=ckhGcPspJIwjK93IeoLVj6CbScTe6KDHPyne9YGs1rTGju4p9qVAjg6vnFv7p0BgDa
         gIwCQFw+WFLiy+GUx89tOf2fLzi6IDpgKt0CGhgQDlqj077BDrCU1vmspn8ktWOU2HYg
         wPXoS1tSeHIy1qVk1q10RoOcaz/YvtfFWHSxshSVOV7GHFhW7gZh+WPrSq2pbbHlJjSf
         N5DTSXz7XnQWYOp/q5a3F/2lROtSc62TCzna1EU6OYdS/yTkyw0F6StaDHe9ZkmtkNxo
         +iiqRbDprryLDAyy59mBJN3W9lpNSrESR24r0Q2pPIeim6V8omfUkzlNgfKqNN70acMR
         1+QA==
X-Gm-Message-State: AOAM530UPaP+L9PU5yNaxmddnusPA7ExVnUQhOu+6xdZaCHbNqAtrBAC
        sT5Rrknf4DfH1/1YWVlieKE2sA==
X-Google-Smtp-Source: ABdhPJyBdoPKeI2viqQg3o9C5rSprGgztDMJinvLPAgzcVbocyICN45MIcjGg/CZAYEVRsNMsbx2xg==
X-Received: by 2002:a5d:4dc7:: with SMTP id f7mr19297439wru.375.1604318271929;
        Mon, 02 Nov 2020 03:57:51 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id v123sm15403548wme.7.2020.11.02.03.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:57:51 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Oliver Neukum <oliver@neukum.org>,
        Ali Akcaagac <aliakc@web.de>,
        Jamie Lenehan <lenehan@twibble.org>,
        "C.L. Huang" <ching@tekram.com.tw>,
        Erich Chen <erich@tekram.com.tw>,
        Kurt Garloff <garloff@suse.de>, dc395x@twibble.org
Subject: [PATCH 17/19] scsi: dc395x: Remove a few unused variables
Date:   Mon,  2 Nov 2020 11:57:26 +0000
Message-Id: <20201102115728.1077697-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102115728.1077697-1-lee.jones@linaro.org>
References: <20201102115728.1077697-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/dc395x.c: In function ‘data_io_transfer’:
 drivers/scsi/dc395x.c:2400:16: warning: variable ‘data2’ set but not used [-Wunused-but-set-variable]
 drivers/scsi/dc395x.c:2400:6: warning: variable ‘data’ set but not used [-Wunused-but-set-variable]
 drivers/scsi/dc395x.c: In function ‘reselect’:
 drivers/scsi/dc395x.c:2992:5: warning: variable ‘arblostflag’ set but not used [-Wunused-but-set-variable]
 drivers/scsi/dc395x.c: In function ‘doing_srb_done’:
 drivers/scsi/dc395x.c:3393:28: warning: variable ‘dir’ set but not used [-Wunused-but-set-variable]

Cc: Oliver Neukum <oliver@neukum.org>
Cc: Ali Akcaagac <aliakc@web.de>
Cc: Jamie Lenehan <lenehan@twibble.org>
Cc: "C.L. Huang" <ching@tekram.com.tw>
Cc: Erich Chen <erich@tekram.com.tw>
Cc: Kurt Garloff <garloff@suse.de>
Cc: dc395x@twibble.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/dc395x.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/dc395x.c b/drivers/scsi/dc395x.c
index fa16894d8758c..f838fe8d74578 100644
--- a/drivers/scsi/dc395x.c
+++ b/drivers/scsi/dc395x.c
@@ -2397,7 +2397,6 @@ static void data_io_transfer(struct AdapterCtlBlk *acb,
 	}
 #endif				/* DC395x_LASTPIO */
 	else {		/* xfer pad */
-		u8 data = 0, data2 = 0;
 		if (srb->sg_count) {
 			srb->adapter_status = H_OVER_UNDER_RUN;
 			srb->status |= OVER_RUN;
@@ -2412,8 +2411,8 @@ static void data_io_transfer(struct AdapterCtlBlk *acb,
 			DC395x_write8(acb, TRM_S1040_SCSI_CONFIG2,
 				      CFG2_WIDEFIFO);
 			if (io_dir & DMACMD_DIR) {
-				data = DC395x_read8(acb, TRM_S1040_SCSI_FIFO);
-				data2 = DC395x_read8(acb, TRM_S1040_SCSI_FIFO);
+				DC395x_read8(acb, TRM_S1040_SCSI_FIFO);
+				DC395x_read8(acb, TRM_S1040_SCSI_FIFO);
 			} else {
 				/* Danger, Robinson: If you find KGs
 				 * scattered over the wide disk, the driver
@@ -2427,7 +2426,7 @@ static void data_io_transfer(struct AdapterCtlBlk *acb,
 			/* Danger, Robinson: If you find a collection of Ks on your disk
 			 * something broke :-( */
 			if (io_dir & DMACMD_DIR)
-				data = DC395x_read8(acb, TRM_S1040_SCSI_FIFO);
+				DC395x_read8(acb, TRM_S1040_SCSI_FIFO);
 			else
 				DC395x_write8(acb, TRM_S1040_SCSI_FIFO, 'K');
 		}
@@ -2989,7 +2988,6 @@ static void reselect(struct AdapterCtlBlk *acb)
 	struct ScsiReqBlk *srb = NULL;
 	u16 rsel_tar_lun_id;
 	u8 id, lun;
-	u8 arblostflag = 0;
 	dprintkdbg(DBG_0, "reselect: acb=%p\n", acb);
 
 	clear_fifo(acb, "reselect");
@@ -3011,7 +3009,6 @@ static void reselect(struct AdapterCtlBlk *acb)
 				srb->cmd, dcb->target_id,
 				dcb->target_lun, rsel_tar_lun_id,
 				DC395x_read16(acb, TRM_S1040_SCSI_STATUS));
-			arblostflag = 1;
 			/*srb->state |= SRB_DISCONNECT; */
 
 			srb->state = SRB_READY;
@@ -3042,7 +3039,7 @@ static void reselect(struct AdapterCtlBlk *acb)
 			"disconnection? <%02i-%i>\n",
 			dcb->target_id, dcb->target_lun);
 
-	if (dcb->sync_mode & EN_TAG_QUEUEING /*&& !arblostflag */) {
+	if (dcb->sync_mode & EN_TAG_QUEUEING) {
 		srb = acb->tmp_srb;
 		dcb->active_srb = srb;
 	} else {
@@ -3390,11 +3387,9 @@ static void doing_srb_done(struct AdapterCtlBlk *acb, u8 did_flag,
 		struct scsi_cmnd *p;
 
 		list_for_each_entry_safe(srb, tmp, &dcb->srb_going_list, list) {
-			enum dma_data_direction dir;
 			int result;
 
 			p = srb->cmd;
-			dir = p->sc_data_direction;
 			result = MK_RES(0, did_flag, 0, 0);
 			printk("G:%p(%02i-%i) ", p,
 			       p->device->id, (u8)p->device->lun);
-- 
2.25.1

