Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4966627F763
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 03:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730707AbgJAB3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 21:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730415AbgJAB3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 21:29:00 -0400
Received: from mail-vk1-xa61.google.com (mail-vk1-xa61.google.com [IPv6:2607:f8b0:4864:20::a61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94ECBC0613D2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 18:29:00 -0700 (PDT)
Received: by mail-vk1-xa61.google.com with SMTP id c25so752293vkm.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 18:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H/OA5EDL2m+AvcSSydEz6xXZy2UcfFkodsv+wQAQipk=;
        b=CsJ1vBSbUt7aFEL3+ClG2Jeag++udGWJe4qa6v+bVOB7Hz+Q5wLm6gkvqBAq0RwYhm
         Rr/lt4otlvfGrJAZcESTzIfmuVUhq/LAUcpbejVn3mvVxJX64JvKrwxbpnh/XOqp+EbI
         xXOrDgsGljlzQa44pp+xO1FfPqpgZ1xM3HrbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H/OA5EDL2m+AvcSSydEz6xXZy2UcfFkodsv+wQAQipk=;
        b=cKD9uqSYEDuXJDVYFsuPvPdQ7P8NttGXHiXEAizKtRYgYT+wBqLAfoGrSp1SAinazO
         Gbq3AYXekl/DvR+ryR4KlyHMt4+Hzjg5uJ9RmAPRoXQQVLdVoCsPVZTE/qh/rx2nW3Sp
         ecSbIuQuHhjZ18Hru3xHmrWUJUo/8XZtlWi7KcYmC2s/X5jTgdstnygDvsCcmi4fW5Jr
         yl01zMPhlIwPx8BFHDnd5/O917Smqwcvo+8OmD4nv/LFpmck4aGHvDZe0Vm4ogKOSsdy
         JvrQQet7HAAyO/hAfhJhHaxoTmTg2i8V+kpnAArf05Yf9+UKXmWmJerWs2Vo7fySJuuU
         KJjg==
X-Gm-Message-State: AOAM530ydgHdTuzipoDTlYFXazLJVZ9rdbQ/FnLRWKKHYG9zKxjJm0SD
        irIRAipRAzVVSPsoQgWxHChApxRgnERG4JMenXCqSC05PS5L
X-Google-Smtp-Source: ABdhPJw0DAAciqDWkXqE+4FhsLJdlXd8Cmcr6OjI4OEUzgyHgS5E2u5nFneWphlwAbmxYN6LJU65DKsXoCM6
X-Received: by 2002:a1f:2d0c:: with SMTP id t12mr3533279vkt.0.1601515739728;
        Wed, 30 Sep 2020 18:28:59 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp-relay.gmail.com with ESMTPS id r25sm520472vkq.14.2020.09.30.18.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 18:28:59 -0700 (PDT)
X-Relaying-Domain: broadcom.com
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Desmond Yan <desmond.yan@broadcom.com>
Subject: [PATCH v5 11/15] misc: bcm-vk: add BCM_VK_QSTATS
Date:   Wed, 30 Sep 2020 18:28:06 -0700
Message-Id: <20201001012810.4172-12-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201001012810.4172-1-scott.branden@broadcom.com>
References: <20201001012810.4172-1-scott.branden@broadcom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add BCM_VK_QSTATS Kconfig option to allow for enabling debug VK
queue statistics.

These statistics keep track of max, abs_max, and average for the
messages queues.

Co-developed-by: Desmond Yan <desmond.yan@broadcom.com>
Signed-off-by: Desmond Yan <desmond.yan@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/misc/bcm-vk/Kconfig      | 14 +++++++++
 drivers/misc/bcm-vk/bcm_vk_dev.c |  9 ++++++
 drivers/misc/bcm-vk/bcm_vk_msg.c | 52 +++++++++++++++++++++++++++++++-
 drivers/misc/bcm-vk/bcm_vk_msg.h | 12 ++++++++
 4 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/bcm-vk/Kconfig b/drivers/misc/bcm-vk/Kconfig
index 2272e47655ed..a3a020b19e3b 100644
--- a/drivers/misc/bcm-vk/Kconfig
+++ b/drivers/misc/bcm-vk/Kconfig
@@ -13,3 +13,17 @@ config BCM_VK
 	  accelerators via /dev/bcm-vk.N devices.
 
 	  If unsure, say N.
+
+if BCM_VK
+
+config BCM_VK_QSTATS
+	bool "VK Queue Statistics"
+	help
+	  Turn on to enable Queue Statistics.
+	  These are useful for debugging purposes.
+	  Some performance loss by enabling this debug config.
+	  For properly operating PCIe hardware no need to enable this.
+
+	  If unsure, say N.
+
+endif
diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_vk_dev.c
index 7fdf245b0436..0ecf2b8e5e11 100644
--- a/drivers/misc/bcm-vk/bcm_vk_dev.c
+++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
@@ -1097,6 +1097,15 @@ static int bcm_vk_trigger_reset(struct bcm_vk *vk)
 	vkwrite32(vk, 0, BAR_0, BAR_INTF_VER);
 	memset(&vk->host_alert, 0, sizeof(vk->host_alert));
 	memset(&vk->peer_alert, 0, sizeof(vk->peer_alert));
+#if defined(CONFIG_BCM_VK_QSTATS)
+	/* clear qstats */
+	for (i = 0; i < VK_MSGQ_MAX_NR; i++) {
+		memset(&vk->to_v_msg_chan.qstats[i].qcnts, 0,
+		       sizeof(vk->to_v_msg_chan.qstats[i].qcnts));
+		memset(&vk->to_h_msg_chan.qstats[i].qcnts, 0,
+		       sizeof(vk->to_h_msg_chan.qstats[i].qcnts));
+	}
+#endif
 	/* clear 4096 bits of bitmap */
 	bitmap_clear(vk->bmap, 0, VK_MSG_ID_BITMAP_SIZE);
 
diff --git a/drivers/misc/bcm-vk/bcm_vk_msg.c b/drivers/misc/bcm-vk/bcm_vk_msg.c
index e31d41400199..1f520506a352 100644
--- a/drivers/misc/bcm-vk/bcm_vk_msg.c
+++ b/drivers/misc/bcm-vk/bcm_vk_msg.c
@@ -91,6 +91,44 @@ u32 msgq_avail_space(const struct bcm_vk_msgq __iomem *msgq,
 	return (qinfo->q_size - msgq_occupied(msgq, qinfo) - 1);
 }
 
+#if defined(CONFIG_BCM_VK_QSTATS)
+
+/* Use default value of 20000 rd/wr per update */
+#if !defined(BCM_VK_QSTATS_ACC_CNT)
+#define BCM_VK_QSTATS_ACC_CNT 20000
+#endif
+
+static void bcm_vk_update_qstats(struct bcm_vk *vk,
+				 const char *tag,
+				 struct bcm_vk_qstats *qstats,
+				 u32 occupancy)
+{
+	struct bcm_vk_qs_cnts *qcnts = &qstats->qcnts;
+
+	if (occupancy > qcnts->max_occ) {
+		qcnts->max_occ = occupancy;
+		if (occupancy > qcnts->max_abs)
+			qcnts->max_abs = occupancy;
+	}
+
+	qcnts->acc_sum += occupancy;
+	if (++qcnts->cnt >= BCM_VK_QSTATS_ACC_CNT) {
+		/* log average and clear counters */
+		dev_info(&vk->pdev->dev,
+			 "%s[%d]: Max: [%3d/%3d] Acc %d num %d, Aver %d\n",
+			 tag, qstats->q_num,
+			 qcnts->max_occ, qcnts->max_abs,
+			 qcnts->acc_sum,
+			 qcnts->cnt,
+			 qcnts->acc_sum / qcnts->cnt);
+
+		qcnts->cnt = 0;
+		qcnts->max_occ = 0;
+		qcnts->acc_sum = 0;
+	}
+}
+#endif
+
 /* number of retries when enqueue message fails before returning EAGAIN */
 #define BCM_VK_H2VK_ENQ_RETRY 10
 #define BCM_VK_H2VK_ENQ_RETRY_DELAY_MS 50
@@ -495,8 +533,12 @@ static int bcm_vk_msg_chan_init(struct bcm_vk_msg_chan *chan)
 
 	mutex_init(&chan->msgq_mutex);
 	spin_lock_init(&chan->pendq_lock);
-	for (i = 0; i < VK_MSGQ_MAX_NR; i++)
+	for (i = 0; i < VK_MSGQ_MAX_NR; i++) {
 		INIT_LIST_HEAD(&chan->pendq[i]);
+#if defined(CONFIG_BCM_VK_QSTATS)
+		chan->qstats[i].q_num = i;
+#endif
+	}
 
 	return 0;
 }
@@ -605,6 +647,10 @@ static int bcm_to_v_msg_enqueue(struct bcm_vk *vk, struct bcm_vk_wkent *entry)
 
 	avail = msgq_avail_space(msgq, qinfo);
 
+#if defined(CONFIG_BCM_VK_QSTATS)
+	bcm_vk_update_qstats(vk, "to_v", &chan->qstats[q_num],
+			     qinfo->q_size - avail);
+#endif
 	/* if not enough space, return EAGAIN and let app handles it */
 	retry = 0;
 	while ((avail < entry->to_v_blks) &&
@@ -818,6 +864,10 @@ s32 bcm_to_h_msg_dequeue(struct bcm_vk *vk)
 				goto idx_err;
 			}
 
+#if defined(CONFIG_BCM_VK_QSTATS)
+			bcm_vk_update_qstats(vk, "to_h", &chan->qstats[q_num],
+					     msgq_occupied(msgq, qinfo));
+#endif
 			num_blks = src_size + 1;
 			data = kzalloc(num_blks * VK_MSGQ_BLK_SIZE, GFP_KERNEL);
 			if (data) {
diff --git a/drivers/misc/bcm-vk/bcm_vk_msg.h b/drivers/misc/bcm-vk/bcm_vk_msg.h
index 637c5d662eb7..d00d9707bd01 100644
--- a/drivers/misc/bcm-vk/bcm_vk_msg.h
+++ b/drivers/misc/bcm-vk/bcm_vk_msg.h
@@ -125,6 +125,14 @@ struct bcm_vk_qs_cnts {
 	u32 max_abs; /* the abs max since reset */
 };
 
+#if defined(CONFIG_BCM_VK_QSTATS)
+/* stats structure */
+struct bcm_vk_qstats {
+	u32 q_num;
+	struct bcm_vk_qs_cnts qcnts;
+};
+#endif
+
 /* control channel structure for either to_v or to_h communication */
 struct bcm_vk_msg_chan {
 	u32 q_nr;
@@ -138,6 +146,10 @@ struct bcm_vk_msg_chan {
 	struct list_head pendq[VK_MSGQ_MAX_NR];
 	/* static queue info from the sync */
 	struct bcm_vk_sync_qinfo sync_qinfo[VK_MSGQ_MAX_NR];
+#if defined(CONFIG_BCM_VK_QSTATS)
+	/* qstats */
+	struct bcm_vk_qstats qstats[VK_MSGQ_MAX_NR];
+#endif
 };
 
 /* total number of supported ctx, 32 ctx each for 5 components */
-- 
2.17.1

