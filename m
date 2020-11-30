Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8082C8D29
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 19:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388213AbgK3Snr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 13:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbgK3Snq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 13:43:46 -0500
Received: from mail-oi1-x264.google.com (mail-oi1-x264.google.com [IPv6:2607:f8b0:4864:20::264])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA60C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:43:06 -0800 (PST)
Received: by mail-oi1-x264.google.com with SMTP id f11so15264951oij.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qB/6eJ42tyIvtpbCnGlJTbau1XpjjWuW/IZSaS5puSc=;
        b=XffXhdJtPjmAUpFaN0pNXjei2PkjBATcx6gox5Qn7lPDkE/T0sgsl0nHWtOMPYKhn0
         IaHu+HZrpHQSFHRxiprNQzMkuftwRnRpBKAA3N1nMUk53X4ovehKMAkq0Q6bOAEEx+0C
         NznkdN1F90XM3ZvFxTsQJG7Q3ue0ielvllFrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qB/6eJ42tyIvtpbCnGlJTbau1XpjjWuW/IZSaS5puSc=;
        b=Xfnuv+OtvJEBjBXwGU5QfHJajL0Skmlz3VjadjHMvqadzEsYrG45h9btNjBVt7Taqf
         zr9p9cT/g8dtL0nit5qmbbFbAntLoOoXapldJ5HSnuozY5Sqz+dz1QaC/9CrCm43GjhU
         jgY6FqKnj+/XOJyAs3CkmZFZSxCJPw4v2zG9qZfQZe5C0AifmSjvOLqSopv1KhrNRyS7
         JosHy4aqV2cJs+sKdN3U+Cj7uTZUokytInA8gVXDGsNgwi4Vcu90b2R8IeMTfMJ9OlU9
         EnEVEujcQYm4VDxE4AVknGQRe13Hb7LRfYarQM8Xgc06uQTUzmE7Z37lmJ4RITIYdVfK
         fh/g==
X-Gm-Message-State: AOAM531eFC68nxlgItyOGvlDZJMbDOQNaInlDwr/R/pcFM6k1tuQmfxR
        68G2oZuiQAxKUNubMCsyWCoP3tCPukHnellkboRFZvvEJY2O
X-Google-Smtp-Source: ABdhPJyP/f9tKgXCBYQz1VcH5P1HUVmEf+3oilA5rK22xZ1hDAvqfbhOUaNZX0+RYo57SpZD9XiFPPIsaS5R
X-Received: by 2002:aca:3284:: with SMTP id y126mr209299oiy.32.1606761785791;
        Mon, 30 Nov 2020 10:43:05 -0800 (PST)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp-relay.gmail.com with ESMTPS id z21sm1909069ooe.19.2020.11.30.10.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 10:43:05 -0800 (PST)
X-Relaying-Domain: broadcom.com
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Desmond Yan <desmond.yan@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH v8 08/13] misc: bcm-vk: add get_card_info, peerlog_info, and proc_mon_info
Date:   Mon, 30 Nov 2020 10:41:55 -0800
Message-Id: <20201130184200.5095-9-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201130184200.5095-1-scott.branden@broadcom.com>
References: <20201130184200.5095-1-scott.branden@broadcom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to get card_info (details about card),
peerlog_info (to get details of peerlog on card),
and proc_mon_info (process monitoring on card).

This info is used for collection of logs via direct
read of BAR space and by sysfs access (in a follow on commit).

Co-developed-by: Desmond Yan <desmond.yan@broadcom.com>
Signed-off-by: Desmond Yan <desmond.yan@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/misc/bcm-vk/bcm_vk.h     |  60 ++++++++++++++++++
 drivers/misc/bcm-vk/bcm_vk_dev.c | 105 +++++++++++++++++++++++++++++++
 2 files changed, 165 insertions(+)

diff --git a/drivers/misc/bcm-vk/bcm_vk.h b/drivers/misc/bcm-vk/bcm_vk.h
index 726aab71bb6b..50f2a0cd6e13 100644
--- a/drivers/misc/bcm-vk/bcm_vk.h
+++ b/drivers/misc/bcm-vk/bcm_vk.h
@@ -205,6 +205,21 @@ enum pci_barno {
 
 #define BCM_VK_NUM_TTY 2
 
+/* VK device max power state, supports 3, full, reduced and low */
+#define MAX_OPP 3
+#define MAX_CARD_INFO_TAG_SIZE 64
+
+struct bcm_vk_card_info {
+	u32 version;
+	char os_tag[MAX_CARD_INFO_TAG_SIZE];
+	char cmpt_tag[MAX_CARD_INFO_TAG_SIZE];
+	u32 cpu_freq_mhz;
+	u32 cpu_scale[MAX_OPP];
+	u32 ddr_freq_mhz;
+	u32 ddr_size_MB;
+	u32 video_core_freq_mhz;
+};
+
 /* DAUTH related info */
 struct bcm_vk_dauth_key {
 	char store[VK_BAR1_DAUTH_STORE_SIZE];
@@ -215,10 +230,49 @@ struct bcm_vk_dauth_info {
 	struct bcm_vk_dauth_key keys[VK_BAR1_DAUTH_MAX];
 };
 
+/*
+ * Control structure of logging messages from the card.  This
+ * buffer is for logmsg that comes from vk
+ */
+struct bcm_vk_peer_log {
+	u32 rd_idx;
+	u32 wr_idx;
+	u32 buf_size;
+	u32 mask;
+	char data[0];
+};
+
+/* max buf size allowed */
+#define BCM_VK_PEER_LOG_BUF_MAX SZ_16K
+/* max size per line of peer log */
+#define BCM_VK_PEER_LOG_LINE_MAX  256
+
+/*
+ * single entry for processing type + utilization
+ */
+#define BCM_VK_PROC_TYPE_TAG_LEN 8
+struct bcm_vk_proc_mon_entry_t {
+	char tag[BCM_VK_PROC_TYPE_TAG_LEN];
+	u32 used;
+	u32 max; /**< max capacity */
+};
+
+/**
+ * Structure for run time utilization
+ */
+#define BCM_VK_PROC_MON_MAX 8 /* max entries supported */
+struct bcm_vk_proc_mon_info {
+	u32 num; /**< no of entries */
+	u32 entry_size; /**< per entry size */
+	struct bcm_vk_proc_mon_entry_t entries[BCM_VK_PROC_MON_MAX];
+};
+
 struct bcm_vk {
 	struct pci_dev *pdev;
 	void __iomem *bar[MAX_BAR];
 
+	struct bcm_vk_card_info card_info;
+	struct bcm_vk_proc_mon_info proc_mon_info;
 	struct bcm_vk_dauth_info dauth_info;
 
 	/* mutex to protect the ioctls */
@@ -240,6 +294,12 @@ struct bcm_vk {
 	dma_addr_t tdma_addr; /* test dma segment bus addr */
 
 	struct notifier_block panic_nb;
+
+	/* offset of the peer log control in BAR2 */
+	u32 peerlog_off;
+	struct bcm_vk_peer_log peerlog_info; /* record of peer log info */
+	/* offset of processing monitoring info in BAR2 */
+	u32 proc_mon_off;
 };
 
 /* wq offload work items bits definitions */
diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_vk_dev.c
index 203a1cf2bae3..a63208513c64 100644
--- a/drivers/misc/bcm-vk/bcm_vk_dev.c
+++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
@@ -172,6 +172,104 @@ static inline int bcm_vk_wait(struct bcm_vk *vk, enum pci_barno bar,
 	return 0;
 }
 
+static void bcm_vk_get_card_info(struct bcm_vk *vk)
+{
+	struct device *dev = &vk->pdev->dev;
+	u32 offset;
+	int i;
+	u8 *dst;
+	struct bcm_vk_card_info *info = &vk->card_info;
+
+	/* first read the offset from spare register */
+	offset = vkread32(vk, BAR_0, BAR_CARD_STATIC_INFO);
+	offset &= (pci_resource_len(vk->pdev, BAR_2 * 2) - 1);
+
+	/* based on the offset, read info to internal card info structure */
+	dst = (u8 *)info;
+	for (i = 0; i < sizeof(*info); i++)
+		*dst++ = vkread8(vk, BAR_2, offset++);
+
+#define CARD_INFO_LOG_FMT "version   : %x\n" \
+			  "os_tag    : %s\n" \
+			  "cmpt_tag  : %s\n" \
+			  "cpu_freq  : %d MHz\n" \
+			  "cpu_scale : %d full, %d lowest\n" \
+			  "ddr_freq  : %d MHz\n" \
+			  "ddr_size  : %d MB\n" \
+			  "video_freq: %d MHz\n"
+	dev_dbg(dev, CARD_INFO_LOG_FMT, info->version, info->os_tag,
+		info->cmpt_tag, info->cpu_freq_mhz, info->cpu_scale[0],
+		info->cpu_scale[MAX_OPP - 1], info->ddr_freq_mhz,
+		info->ddr_size_MB, info->video_core_freq_mhz);
+
+	/*
+	 * get the peer log pointer, only need the offset, and get record
+	 * of the log buffer information which would be used for checking
+	 * before dump, in case the BAR2 memory has been corrupted.
+	 */
+	vk->peerlog_off = offset;
+	memcpy_fromio(&vk->peerlog_info, vk->bar[BAR_2] + vk->peerlog_off,
+		      sizeof(vk->peerlog_info));
+
+	/*
+	 * Do a range checking and if out of bound, the record will be zeroed
+	 * which guarantees that nothing would be dumped.  In other words,
+	 * peer dump is disabled.
+	 */
+	if ((vk->peerlog_info.buf_size > BCM_VK_PEER_LOG_BUF_MAX) ||
+	    (vk->peerlog_info.mask != (vk->peerlog_info.buf_size - 1)) ||
+	    (vk->peerlog_info.rd_idx > vk->peerlog_info.mask) ||
+	    (vk->peerlog_info.wr_idx > vk->peerlog_info.mask)) {
+		dev_err(dev, "Peer log disabled - range error: Size 0x%x(0x%x), [Rd Wr] = [%d %d]\n",
+			vk->peerlog_info.buf_size,
+			vk->peerlog_info.mask,
+			vk->peerlog_info.rd_idx,
+			vk->peerlog_info.wr_idx);
+		memset(&vk->peerlog_info, 0, sizeof(vk->peerlog_info));
+	} else {
+		dev_dbg(dev, "Peer log: Size 0x%x(0x%x), [Rd Wr] = [%d %d]\n",
+			vk->peerlog_info.buf_size,
+			vk->peerlog_info.mask,
+			vk->peerlog_info.rd_idx,
+			vk->peerlog_info.wr_idx);
+	}
+}
+
+static void bcm_vk_get_proc_mon_info(struct bcm_vk *vk)
+{
+	struct device *dev = &vk->pdev->dev;
+	struct bcm_vk_proc_mon_info *mon = &vk->proc_mon_info;
+	u32 num, entry_size, offset, buf_size;
+	u8 *dst;
+
+	/* calculate offset which is based on peerlog offset */
+	buf_size = vkread32(vk, BAR_2,
+			    vk->peerlog_off
+			    + offsetof(struct bcm_vk_peer_log, buf_size));
+	offset = vk->peerlog_off + sizeof(struct bcm_vk_peer_log)
+		 + buf_size;
+
+	/* first read the num and entry size */
+	num = vkread32(vk, BAR_2, offset);
+	entry_size = vkread32(vk, BAR_2, offset + sizeof(num));
+
+	/* check for max allowed */
+	if (num > BCM_VK_PROC_MON_MAX) {
+		dev_err(dev, "Processing monitoring entry %d exceeds max %d\n",
+			num, BCM_VK_PROC_MON_MAX);
+		return;
+	}
+	mon->num = num;
+	mon->entry_size = entry_size;
+
+	vk->proc_mon_off = offset;
+
+	/* read it once that will capture those static info */
+	dst = (u8 *)&mon->entries[0];
+	offset += sizeof(num) + sizeof(entry_size);
+	memcpy_fromio(dst, vk->bar[BAR_2] + offset, num * entry_size);
+}
+
 static int bcm_vk_sync_card_info(struct bcm_vk *vk)
 {
 	u32 rdy_marker = vkread32(vk, BAR_1, VK_BAR1_MSGQ_DEF_RDY);
@@ -193,6 +291,13 @@ static int bcm_vk_sync_card_info(struct bcm_vk *vk)
 		vkwrite32(vk, nr_scratch_pages * PAGE_SIZE, BAR_1,
 			  VK_BAR1_SCRATCH_SZ_ADDR);
 	}
+
+	/* get static card info, only need to read once */
+	bcm_vk_get_card_info(vk);
+
+	/* get the proc mon info once */
+	bcm_vk_get_proc_mon_info(vk);
+
 	return 0;
 }
 
-- 
2.17.1

