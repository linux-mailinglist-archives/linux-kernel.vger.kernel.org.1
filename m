Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331BB2A2A34
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbgKBL6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729030AbgKBL5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:57:55 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF52C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:57:55 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id g12so14232759wrp.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gYXRe7D5GCobzJA+DWJKpgWmSfraOvjmjOLuPeMvqEQ=;
        b=YUhzV4Z1KwKu5zZZ5fNOa8j3qkZApJE3/EC+zTTFyky6KVhnuleCUyt/WVoTR27TO5
         U1x5FF+TVlaqa5Un/nOq3r/aYSOMi1w8fx3oPfiKOcVgUbZGj3JVIeRpdaDcwsyXY4Gu
         5GwGYIMZ7gsESPIKKqus86y9/XkxE8YiYaF6vGmqExJGc5/kEWKjxmtC3MjdkbSOrPWC
         9g4fItsZP44pppctdnIHHs5GQIFF+9ag+VecddopEkFsvNE8lrGZ2lzv1DiKxAFmIWfY
         A/MrXwehD98apCWlVuCh7gDuoKj7UB0HS0dcseuzhy6bhgiwS18EkbWATDPjb4C2YdGX
         So1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gYXRe7D5GCobzJA+DWJKpgWmSfraOvjmjOLuPeMvqEQ=;
        b=kOCjYuZ5bspMb0Xvv/CSjrU1bKbSTUpAX81U6DkRxi6GAbMY15DzaG1phwHNo4tcFG
         ZK1B/GVoexvTYaveKJtVtOlJmZM5U5kOwl2qGAf3N2PnqsQiLgRPC/dlFph3QZ+U7wvF
         cw3ZvqjriNmYiRR/+s+cElKgovmDRH0GbPN8t5sUS1j3cSDJY4VQdpmBGuLjovZsZkn2
         enYxKLHOvS+/dVAx855zKq2iPIrQrdqkZZ7zJDHLNfKQ989g6pp1QTVZDuo9ZHxWJAld
         CG5wY2hm/owiMHU6vvp67vebje+/n9C85RD7Bm9g5MrygG18xxG222KwZa3A63FlPry9
         iBWA==
X-Gm-Message-State: AOAM531O0eObfjsESy9Iz73MvKPeR3LE5sUuYMUIrDRd6KuMJ/YePRn4
        wfdXQlzKpVozNwphSjCUvYAHSg==
X-Google-Smtp-Source: ABdhPJz3RBiOw3IKAiQfQMb1zOL8HVDZeru+Q3x5fp8VtcTfsIBXm/S9VUlRRX4adV3GyMMnV+1G1w==
X-Received: by 2002:adf:ef02:: with SMTP id e2mr18866938wro.381.1604318274196;
        Mon, 02 Nov 2020 03:57:54 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id v123sm15403548wme.7.2020.11.02.03.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:57:53 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Don Brace <don.brace@microchip.com>,
        Bugfixes to <esc.storagedev@microsemi.com>,
        storagedev@microchip.com
Subject: [PATCH 19/19] scsi: hpsa: Strip out a bunch of set but unused variables
Date:   Mon,  2 Nov 2020 11:57:28 +0000
Message-Id: <20201102115728.1077697-20-lee.jones@linaro.org>
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

 drivers/scsi/hpsa.c: In function ‘hpsa_volume_offline’:
 drivers/scsi/hpsa.c:3885:5: warning: variable ‘scsi_status’ set but not used [-Wunused-but-set-variable]
 drivers/scsi/hpsa.c:3884:6: warning: variable ‘cmd_status’ set but not used [-Wunused-but-set-variable]
 drivers/scsi/hpsa.c: In function ‘hpsa_update_scsi_devices’:
 drivers/scsi/hpsa.c:4354:9: warning: variable ‘n_ext_target_devs’ set but not used [-Wunused-but-set-variable]
 drivers/scsi/hpsa.c: In function ‘hpsa_scatter_gather’:
 drivers/scsi/hpsa.c:4583:36: warning: variable ‘last_sg’ set but not used [-Wunused-but-set-variable]
 drivers/scsi/hpsa.c: In function ‘hpsa_init_one’:
 drivers/scsi/hpsa.c:8639:6: warning: variable ‘dac’ set but not used [-Wunused-but-set-variable]
 drivers/scsi/hpsa.c: In function ‘hpsa_enter_performant_mode’:
 drivers/scsi/hpsa.c:9300:7: warning: variable ‘rc’ set but not used [-Wunused-but-set-variable]

Cc: Don Brace <don.brace@microchip.com>
Cc: Bugfixes to <esc.storagedev@microsemi.com>
Cc: storagedev@microchip.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/hpsa.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 16fd378285d27..02e20bed8a484 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -3881,8 +3881,6 @@ static unsigned char hpsa_volume_offline(struct ctlr_info *h,
 	u8 sense_key, asc, ascq;
 	int sense_len;
 	int rc, ldstat = 0;
-	u16 cmd_status;
-	u8 scsi_status;
 #define ASC_LUN_NOT_READY 0x04
 #define ASCQ_LUN_NOT_READY_FORMAT_IN_PROGRESS 0x04
 #define ASCQ_LUN_NOT_READY_INITIALIZING_CMD_REQ 0x02
@@ -3902,8 +3900,6 @@ static unsigned char hpsa_volume_offline(struct ctlr_info *h,
 	else
 		sense_len = c->err_info->SenseLen;
 	decode_sense_data(sense, sense_len, &sense_key, &asc, &ascq);
-	cmd_status = c->err_info->CommandStatus;
-	scsi_status = c->err_info->ScsiStatus;
 	cmd_free(h, c);
 
 	/* Determine the reason for not ready state */
@@ -4351,7 +4347,7 @@ static void hpsa_update_scsi_devices(struct ctlr_info *h)
 	u32 ndev_allocated = 0;
 	struct hpsa_scsi_dev_t **currentsd, *this_device, *tmpdevice;
 	int ncurrent = 0;
-	int i, n_ext_target_devs, ndevs_to_allocate;
+	int i, ndevs_to_allocate;
 	int raid_ctlr_position;
 	bool physical_device;
 	DECLARE_BITMAP(lunzerobits, MAX_EXT_TARGETS);
@@ -4416,7 +4412,6 @@ static void hpsa_update_scsi_devices(struct ctlr_info *h)
 		raid_ctlr_position = nphysicals + nlogicals;
 
 	/* adjust our table of devices */
-	n_ext_target_devs = 0;
 	for (i = 0; i < nphysicals + nlogicals + 1; i++) {
 		u8 *lunaddrbytes, is_OBDR = 0;
 		int rc = 0;
@@ -4580,7 +4575,7 @@ static int hpsa_scatter_gather(struct ctlr_info *h,
 		struct scsi_cmnd *cmd)
 {
 	struct scatterlist *sg;
-	int use_sg, i, sg_limit, chained, last_sg;
+	int use_sg, i, sg_limit, chained;
 	struct SGDescriptor *curr_sg;
 
 	BUG_ON(scsi_sg_count(cmd) > h->maxsgentries);
@@ -4602,7 +4597,6 @@ static int hpsa_scatter_gather(struct ctlr_info *h,
 	curr_sg = cp->SG;
 	chained = use_sg > h->max_cmd_sg_entries;
 	sg_limit = chained ? h->max_cmd_sg_entries - 1 : use_sg;
-	last_sg = scsi_sg_count(cmd) - 1;
 	scsi_for_each_sg(cmd, sg, sg_limit, i) {
 		hpsa_set_sg_descriptor(curr_sg, sg);
 		curr_sg++;
@@ -8635,7 +8629,7 @@ static struct ctlr_info *hpda_alloc_ctlr_info(void)
 
 static int hpsa_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
-	int dac, rc;
+	int rc;
 	struct ctlr_info *h;
 	int try_soft_reset = 0;
 	unsigned long flags;
@@ -8711,13 +8705,9 @@ static int hpsa_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	/* configure PCI DMA stuff */
 	rc = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
-	if (rc == 0) {
-		dac = 1;
-	} else {
+	if (rc != 0)
 		rc = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
-		if (rc == 0) {
-			dac = 0;
-		} else {
+		if (rc != 0) {
 			dev_err(&pdev->dev, "no suitable DMA available\n");
 			goto clean3;	/* shost, pci, lu, aer/h */
 		}
@@ -9298,10 +9288,9 @@ static int hpsa_enter_performant_mode(struct ctlr_info *h, u32 trans_support)
 	} else if (trans_support & CFGTBL_Trans_io_accel2) {
 		u64 cfg_offset, cfg_base_addr_index;
 		u32 bft2_offset, cfg_base_addr;
-		int rc;
 
-		rc = hpsa_find_cfg_addrs(h->pdev, h->vaddr, &cfg_base_addr,
-			&cfg_base_addr_index, &cfg_offset);
+		hpsa_find_cfg_addrs(h->pdev, h->vaddr, &cfg_base_addr,
+				    &cfg_base_addr_index, &cfg_offset);
 		BUILD_BUG_ON(offsetof(struct io_accel2_cmd, sg) != 64);
 		bft2[15] = h->ioaccel_maxsg + HPSA_IOACCEL2_HEADER_SZ;
 		calc_bucket_map(bft2, ARRAY_SIZE(bft2), h->ioaccel_maxsg,
-- 
2.25.1

