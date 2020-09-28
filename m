Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D838027A628
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 06:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgI1EKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 00:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgI1EKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 00:10:47 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767EBC0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 21:10:47 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id u24so7163685pgi.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 21:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U2zjAyHMv+vNvI44PVm7WKt9xsmBm2Pl8T9zrZbzqsE=;
        b=P8HRw07sM/afMTDqTerSbPH12CyAJVBdNySTeo7qRkYGnL6ijMSLXZXFqbRGD3GVLd
         R4u+KhahYem6mO7tN3APbLWhii7TzucUnXvMIiWMHPUXA7n+yn8t28ovDxp7L+As8GM7
         umCcJk7HFVtFiYGEbO0RF2lKqkkUX+gGJTO65XmXY7OwU/UCHUZUB4sxMWzpBFiQJlnd
         zJKyPgS3b0LqATO6ENGhUrt+Y8PjEj4GdNrUlyv1lX1b5XgBtW8xbfQY+bbEjQCcLhHg
         V9SbIZYOfToKM/mINctKx8CuUBV49Y2epUqtf5/WYGmRkR/reTdDQlgk01vvpMLpLmFD
         zrUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U2zjAyHMv+vNvI44PVm7WKt9xsmBm2Pl8T9zrZbzqsE=;
        b=hyDJpbFZfRCW802X+jJOdWzalyNeQMm77X1nwvJw1+oiGTGQbkv1xljimReEPr6q/q
         OdF9+IOQW1QNtOTNE+HOV2r/RYoxlM7PZBe65fKIrRKXcZtYWdJuVTSoBbY4M8GNgPGF
         8+jbl4uDJMi9IpzAI3qWjqvmAaOYVyX+OGWAi2tEPdYWhkufxeshnIzAbgCQX8huUip6
         /mNxvzCEHOBzGBshy7L56Dgohn1EXoSRVJY1qkgDIn34kbLoF0fBv5dY47Oxg1ZcdZIm
         ap7TeTVpD7+TyQ3N3DifnKnHNiEkcJmwwIp+epbHDWwabFnoBSliRbydf7xuzKqOA2uB
         OoJA==
X-Gm-Message-State: AOAM530pmoOCj/+DytgVZNI1qIVxhJ6SazCs6JIseWy4augEzVGawU4X
        G0j+pceA6AqGDVGo9OXCcs8h
X-Google-Smtp-Source: ABdhPJzdQLTKEt73hgHQmPsSdxsd1n13ty38qmiVicOb0sJcK7PgLdoEPAuwCPqqfpm8LUKYUmcx2w==
X-Received: by 2002:a63:4f10:: with SMTP id d16mr7486397pgb.152.1601266246973;
        Sun, 27 Sep 2020 21:10:46 -0700 (PDT)
Received: from Mani-XPS-13-9360.localdomain ([2409:4072:6003:40df:7c40:5a87:eb86:87b0])
        by smtp.gmail.com with ESMTPSA id n21sm8306322pgl.7.2020.09.27.21.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 21:10:45 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 04/21] bus: mhi: core: Use helper API to trigger a non-blocking host resume
Date:   Mon, 28 Sep 2020 09:39:34 +0530
Message-Id: <20200928040951.18207-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200928040951.18207-1-manivannan.sadhasivam@linaro.org>
References: <20200928040951.18207-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhaumik Bhatt <bbhatt@codeaurora.org>

Autonomous low power mode support requires the MHI host to resume from
multiple places and post a wakeup source to exit system suspend. This
needs to be done in a non-blocking manner. Introduce a helper API to
trigger the host resume for data transfers and other non-blocking use
cases while supporting implementation of autonomous low power modes.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/internal.h |  7 +++++++
 drivers/bus/mhi/core/main.c     | 21 +++++++--------------
 drivers/bus/mhi/core/pm.c       | 13 ++++---------
 3 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/drivers/bus/mhi/core/internal.h b/drivers/bus/mhi/core/internal.h
index bcfa7b6558ef..1bbd6e99d38d 100644
--- a/drivers/bus/mhi/core/internal.h
+++ b/drivers/bus/mhi/core/internal.h
@@ -599,6 +599,13 @@ int __mhi_device_get_sync(struct mhi_controller *mhi_cntrl);
 int mhi_send_cmd(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
 		 enum mhi_cmd_type cmd);
 
+static inline void mhi_trigger_resume(struct mhi_controller *mhi_cntrl)
+{
+	pm_wakeup_event(&mhi_cntrl->mhi_dev->dev, 0);
+	mhi_cntrl->runtime_get(mhi_cntrl);
+	mhi_cntrl->runtime_put(mhi_cntrl);
+}
+
 /* Register access methods */
 void mhi_db_brstmode(struct mhi_controller *mhi_cntrl, struct db_cfg *db_cfg,
 		     void __iomem *db_addr, dma_addr_t db_val);
diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
index 1f622ce6be8b..79be18ec2ebf 100644
--- a/drivers/bus/mhi/core/main.c
+++ b/drivers/bus/mhi/core/main.c
@@ -909,8 +909,7 @@ void mhi_ctrl_ev_task(unsigned long data)
 		 * process it since we are probably in a suspended state,
 		 * so trigger a resume.
 		 */
-		mhi_cntrl->runtime_get(mhi_cntrl);
-		mhi_cntrl->runtime_put(mhi_cntrl);
+		mhi_trigger_resume(mhi_cntrl);
 
 		return;
 	}
@@ -971,10 +970,8 @@ int mhi_queue_skb(struct mhi_device *mhi_dev, enum dma_data_direction dir,
 	}
 
 	/* we're in M3 or transitioning to M3 */
-	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state)) {
-		mhi_cntrl->runtime_get(mhi_cntrl);
-		mhi_cntrl->runtime_put(mhi_cntrl);
-	}
+	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state))
+		mhi_trigger_resume(mhi_cntrl);
 
 	/* Toggle wake to exit out of M2 */
 	mhi_cntrl->wake_toggle(mhi_cntrl);
@@ -1032,10 +1029,8 @@ int mhi_queue_dma(struct mhi_device *mhi_dev, enum dma_data_direction dir,
 	}
 
 	/* we're in M3 or transitioning to M3 */
-	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state)) {
-		mhi_cntrl->runtime_get(mhi_cntrl);
-		mhi_cntrl->runtime_put(mhi_cntrl);
-	}
+	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state))
+		mhi_trigger_resume(mhi_cntrl);
 
 	/* Toggle wake to exit out of M2 */
 	mhi_cntrl->wake_toggle(mhi_cntrl);
@@ -1147,10 +1142,8 @@ int mhi_queue_buf(struct mhi_device *mhi_dev, enum dma_data_direction dir,
 	read_lock_irqsave(&mhi_cntrl->pm_lock, flags);
 
 	/* we're in M3 or transitioning to M3 */
-	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state)) {
-		mhi_cntrl->runtime_get(mhi_cntrl);
-		mhi_cntrl->runtime_put(mhi_cntrl);
-	}
+	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state))
+		mhi_trigger_resume(mhi_cntrl);
 
 	/* Toggle wake to exit out of M2 */
 	mhi_cntrl->wake_toggle(mhi_cntrl);
diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
index 661d704c8093..b227d415e937 100644
--- a/drivers/bus/mhi/core/pm.c
+++ b/drivers/bus/mhi/core/pm.c
@@ -824,11 +824,8 @@ int __mhi_device_get_sync(struct mhi_controller *mhi_cntrl)
 	/* Wake up the device */
 	read_lock_bh(&mhi_cntrl->pm_lock);
 	mhi_cntrl->wake_get(mhi_cntrl, true);
-	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state)) {
-		pm_wakeup_event(&mhi_cntrl->mhi_dev->dev, 0);
-		mhi_cntrl->runtime_get(mhi_cntrl);
-		mhi_cntrl->runtime_put(mhi_cntrl);
-	}
+	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state))
+		mhi_trigger_resume(mhi_cntrl);
 	read_unlock_bh(&mhi_cntrl->pm_lock);
 
 	ret = wait_event_timeout(mhi_cntrl->state_event,
@@ -1139,10 +1136,8 @@ void mhi_device_put(struct mhi_device *mhi_dev)
 
 	mhi_dev->dev_wake--;
 	read_lock_bh(&mhi_cntrl->pm_lock);
-	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state)) {
-		mhi_cntrl->runtime_get(mhi_cntrl);
-		mhi_cntrl->runtime_put(mhi_cntrl);
-	}
+	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state))
+		mhi_trigger_resume(mhi_cntrl);
 
 	mhi_cntrl->wake_put(mhi_cntrl, false);
 	read_unlock_bh(&mhi_cntrl->pm_lock);
-- 
2.17.1

