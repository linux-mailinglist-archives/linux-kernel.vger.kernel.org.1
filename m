Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA3B27F766
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 03:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730957AbgJAB3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 21:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730458AbgJAB2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 21:28:54 -0400
Received: from mail-vs1-xe64.google.com (mail-vs1-xe64.google.com [IPv6:2607:f8b0:4864:20::e64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17922C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 18:28:54 -0700 (PDT)
Received: by mail-vs1-xe64.google.com with SMTP id j3so1872163vsm.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 18:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kAbZ5ent0PFVzLzNEvnQ50RqL9MTBl1G7uaz4qoV4aA=;
        b=X3TviXHKicFn0SNRImKDvuy5XhDRMc6bJSVKNC8vTayU2uQS4HM5wikUwl6w4DlWGi
         jtfsLEcbaSTOK+lhMqxCkpQg8wtD7fMjN//w8grRwsdwKzVUpo5yhvCl+TyehYnKwHTx
         up0JCU6MIF377CEs928PZ/4FgbhQKfxcvBfaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kAbZ5ent0PFVzLzNEvnQ50RqL9MTBl1G7uaz4qoV4aA=;
        b=TF/Si12a08a4XdR16cF9CnaQRap532aYd8m9J9PZ4rbVfTp6r4L4fI6bcPKFNZUYPd
         DhP7cRNQd4r9IsGU3TTB0EWPk0rLXH1kuvsCDuFMwyoBVjStApec/n5oeD9yovfb/okx
         nvZ31tfFJ/poDzz4hE6OmSzbFFowtFIib4eypesgzG9VpdyZeQ4FQ6XZDbAXXEtkZ+T5
         yOJW6xzk5ooICqN2iO1vvoe0WhbxhnbLmHBBCjpMuzGtWCoSb4drCYHvleCZ05qRXDcL
         Lroh0aq6bT6jD6pLKN6J/GMTHWSYGZnH2XCVy+kvK7rTribNZCHBLC60dtODfCUVq43C
         g0Aw==
X-Gm-Message-State: AOAM531eBRz2a0r46sMiI4/lC5riz1uN9NzfLeMmIuR9TCJnYD8zeVzC
        xl0BYRW28cKlP/WCKaBjnxIULt4a6qbzysuNIS1X1HM6Eh14
X-Google-Smtp-Source: ABdhPJzK6Ja/HnwwbEdYqSDyhihaVvwzDLw5CV+KZYAzmqeOhNZzDXq+Boqly6v6hbMHqxIzUcWhJmvaAlUJ
X-Received: by 2002:a67:7dcb:: with SMTP id y194mr3747872vsc.26.1601515733166;
        Wed, 30 Sep 2020 18:28:53 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp-relay.gmail.com with ESMTPS id r25sm520472vkq.14.2020.09.30.18.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 18:28:53 -0700 (PDT)
X-Relaying-Domain: broadcom.com
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Desmond Yan <desmond.yan@broadcom.com>
Subject: [PATCH v5 08/15] misc: bcm-vk: add get_card_info, peerlog_info, and proc_mon_info
Date:   Wed, 30 Sep 2020 18:28:03 -0700
Message-Id: <20201001012810.4172-9-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201001012810.4172-1-scott.branden@broadcom.com>
References: <20201001012810.4172-1-scott.branden@broadcom.com>
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
 drivers/misc/bcm-vk/bcm_vk.h     | 58 +++++++++++++++++++++
 drivers/misc/bcm-vk/bcm_vk_dev.c | 87 ++++++++++++++++++++++++++++++++
 2 files changed, 145 insertions(+)

diff --git a/drivers/misc/bcm-vk/bcm_vk.h b/drivers/misc/bcm-vk/bcm_vk.h
index 726aab71bb6b..452333a32604 100644
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
@@ -215,10 +230,47 @@ struct bcm_vk_dauth_info {
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
@@ -240,6 +292,12 @@ struct bcm_vk {
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
index 77af701cf579..a8bbc58bef9f 100644
--- a/drivers/misc/bcm-vk/bcm_vk_dev.c
+++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
@@ -172,6 +172,86 @@ static inline int bcm_vk_wait(struct bcm_vk *vk, enum pci_barno bar,
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
+	dev_dbg(dev, "Peer log: Size 0x%x(0x%x), [Rd Wr] = [%d %d]\n",
+		vk->peerlog_info.buf_size,
+		vk->peerlog_info.mask,
+		vk->peerlog_info.rd_idx,
+		vk->peerlog_info.wr_idx);
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
@@ -193,6 +273,13 @@ static int bcm_vk_sync_card_info(struct bcm_vk *vk)
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

