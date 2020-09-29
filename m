Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC6E27D505
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 19:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgI2Rwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 13:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbgI2Rwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 13:52:47 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BDAC061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 10:52:47 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 7so4448928pgm.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 10:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U2zjAyHMv+vNvI44PVm7WKt9xsmBm2Pl8T9zrZbzqsE=;
        b=w1vrD/H1wbpauynNoziIwFqp5GrIGE0eZK8nxqMdSlQAetxTouD4KLJKSF0s9C1Vpo
         C5SjVFmpfyrnj6fw/w0bXQBYN6oz5CAEP/8IZuNvOBv6up832IKo4VT55xhedd58BaWw
         JMVPQN4mLxaPxmgx1bMOpYRdyJymmy4E+i+De2oPinhVuvp3Cg+Wspjkaf89oHI4m7m/
         XV0i+zSgyPGLwiE2Coz1vnHnPR/AHEMJFUsKd0wwTMdp4jYjk2ivqtNf8m7IKQapMBPC
         jH0moGrh9gabCEfRaxhts2NDmdoaCb8Xy96O9wx1jQlFzuZiF9fDBgPncv/BgcYfxnYm
         y5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U2zjAyHMv+vNvI44PVm7WKt9xsmBm2Pl8T9zrZbzqsE=;
        b=VDsUUQE6WY98BnlKI/ejbfJ0ucBwT3gqu+tGXi5kgIHdJY3sbNxzPzSR2yc5gNglzO
         Gs73x4NCvgf4jltY2G5gK+C92OmL7Bk1zgrh2JAmRIcRUQbqWJbSSHAI30NJjU7Q7/rP
         S/cnY/Z8aFUHEYo4HhvBMZJFQqT4FTj3j1hiGbUF7J3FUBeSz0I1pyCyziDNK2cUudHj
         1O7HhRU79Hyrsn9d8wQorzZEmOep6el/OdlZ7qdEyu0mo+RrzTv0+oqaoVTZUqbL3RO7
         sGEOuy1Mc39o67TXyuCacUZgTIdEz1ltXAzhtYC6o/KcGwPOCmDuSxPXvkKbH6GIoEwe
         KgBA==
X-Gm-Message-State: AOAM5309QhnI4PrSrrva9nakAbWEVGz78QqD3aPx/cW/ynqnZ+hWrWf+
        HvonFsDhv1v93rmga5qcihAY
X-Google-Smtp-Source: ABdhPJze3VumCnlT6Qxf8nRHGmsp+oehb5IXiZt6+CM/Pj4KPXr8uWYDNfuG+4sFMQmB+9sw+ffoKA==
X-Received: by 2002:a17:902:14f:b029:d2:562d:e84 with SMTP id 73-20020a170902014fb02900d2562d0e84mr5567378plb.64.1601401967041;
        Tue, 29 Sep 2020 10:52:47 -0700 (PDT)
Received: from Mani-XPS-13-9360.localdomain ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id r188sm6271046pfc.67.2020.09.29.10.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 10:52:46 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 04/19] bus: mhi: core: Use helper API to trigger a non-blocking host resume
Date:   Tue, 29 Sep 2020 23:22:03 +0530
Message-Id: <20200929175218.8178-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929175218.8178-1-manivannan.sadhasivam@linaro.org>
References: <20200929175218.8178-1-manivannan.sadhasivam@linaro.org>
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

