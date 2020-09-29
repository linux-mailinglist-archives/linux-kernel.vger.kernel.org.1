Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E107127B8B6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 02:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgI2AN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 20:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbgI2ANU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 20:13:20 -0400
Received: from mail-pg1-x563.google.com (mail-pg1-x563.google.com [IPv6:2607:f8b0:4864:20::563])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C6FC0613D5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 17:13:20 -0700 (PDT)
Received: by mail-pg1-x563.google.com with SMTP id o25so2386171pgm.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 17:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VdIfV7ALnGeX2Y36QaNX0l/+2DfzixjHXCsImQVtXD4=;
        b=Q+TY+waxU2B/DAuIT4TAbo4YK9m6pcVwFALjcV82d5/DDL2YEbgK722ktSia2ZH3kq
         JaEMfrBoHkxmi4+vc5WJtd7w1/Rvr6l+CN3Jk+RU23PHiZLpsOzoUUJIX43UaVfJUKTj
         xjha3Xd8m7ZyB9//9gkhTk44F2JbHjVI1kcqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VdIfV7ALnGeX2Y36QaNX0l/+2DfzixjHXCsImQVtXD4=;
        b=XDAsntc34/B3C3y6PkLfnu7xmu+IWqXVU0Wo/rIEGV039qNTjxHbG6BYkI4wYo7gaE
         GmSexzrAtvJtIBm50RaWZqecIchn/CeNaw1kXKivdcr3XF5dJR+2u50lPigdruTdpN/3
         O4mPz9cru7Xt6LMT7Lb8qC7xvMYEtdJBCVO/vmubr6+4wwcVgb+tOg4snGf+TeErI727
         7/v39mTq651fyR7Fk3+aZr4gsoLsjV5DaEdeEUO3G0WouLilG0p38w0fDHbk6ZIF3JwR
         RnoswskLrCPHnL6ZYcuPm/uCg6UldIT5RIFoFUPDSAu+s10LKpPT71RZTsqB+NmF4tTX
         UgSw==
X-Gm-Message-State: AOAM533svas4sblZplMAZO0IZapzf+HR1Gxs9phmzd3ewAiE3AYzFp1R
        xVwQZ3lvklxI2Qs2lsFKNjOiR6RY4F9FCDSxetSPFF3NHwIp
X-Google-Smtp-Source: ABdhPJw8MTwvpUUsqMqt5Roo3go6lDlOVJXfv+1NZ2iQRbJi6z2Ih82wsOxQu7epDdkcNFtCYnQhP7CixZVB
X-Received: by 2002:a63:5d08:: with SMTP id r8mr1148987pgb.174.1601338400125;
        Mon, 28 Sep 2020 17:13:20 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp-relay.gmail.com with ESMTPS id t1sm1047973pjr.8.2020.09.28.17.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 17:13:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Desmond Yan <desmond.yan@broadcom.com>
Subject: [PATCH v4 12/16] misc: bcm-vk: add BCM_VK_QSTATS
Date:   Mon, 28 Sep 2020 17:12:05 -0700
Message-Id: <20200929001209.16393-13-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929001209.16393-1-scott.branden@broadcom.com>
References: <20200929001209.16393-1-scott.branden@broadcom.com>
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
index e33f18bc2dd7..76fe58fc98e2 100644
--- a/drivers/misc/bcm-vk/bcm_vk_dev.c
+++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
@@ -1098,6 +1098,15 @@ static int bcm_vk_trigger_reset(struct bcm_vk *vk)
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

