Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6EE21B3623
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 06:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgDVEUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 00:20:17 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:10561 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726396AbgDVEUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 00:20:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587529201; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=B9QhyAjKdbua8fY9DrfrNQ5WfANanGspAv/4uS5Zs6U=; b=RuFMmEgdhW745+YkiIwz4ta/px3QrV+LlWQcYksa24YTNjGgz+17VPBkf6vNX3xsqGiMuLBK
 mzCAR8rS+7J44kLSLEjx4RJbGfRE8dmO9ZVQm5AAlyyN7nz377/k14WUOkM+aKyUo+m5C1Vn
 nH9sYpxUfrYI1mAe+3uTmPPiaCo=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9fc5e8.7f887afc2650-smtp-out-n01;
 Wed, 22 Apr 2020 04:19:52 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8583AC433CB; Wed, 22 Apr 2020 04:19:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from bbhatt-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BA53DC433F2;
        Wed, 22 Apr 2020 04:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BA53DC433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=bbhatt@codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: [PATCH v1 4/8] bus: mhi: core: Handle firmware load using state worker
Date:   Tue, 21 Apr 2020 21:19:31 -0700
Message-Id: <1587529175-27778-5-git-send-email-bbhatt@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1587529175-27778-1-git-send-email-bbhatt@codeaurora.org>
References: <1587529175-27778-1-git-send-email-bbhatt@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upon power up, driver queues firmware worker thread if the execution
environment is PBL. Firmware worker is blocked with a timeout until
state worker gets a chance to run and unblock firmware worker. An
endpoint power up failure can be seen if state worker gets a chance to
run after firmware worker has timed out. Remove this dependency and
handle firmware load directly using state worker thread.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
---
 drivers/bus/mhi/core/boot.c     | 18 +++---------------
 drivers/bus/mhi/core/init.c     |  1 -
 drivers/bus/mhi/core/internal.h |  1 +
 drivers/bus/mhi/core/pm.c       |  6 +-----
 include/linux/mhi.h             |  2 --
 5 files changed, 5 insertions(+), 23 deletions(-)

diff --git a/drivers/bus/mhi/core/boot.c b/drivers/bus/mhi/core/boot.c
index ebad5eb..17c636b 100644
--- a/drivers/bus/mhi/core/boot.c
+++ b/drivers/bus/mhi/core/boot.c
@@ -377,30 +377,18 @@ static void mhi_firmware_copy(struct mhi_controller *mhi_cntrl,
 	}
 }
 
-void mhi_fw_load_worker(struct work_struct *work)
+void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
 {
-	struct mhi_controller *mhi_cntrl;
 	const struct firmware *firmware = NULL;
 	struct image_info *image_info;
-	struct device *dev;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
 	const char *fw_name;
 	void *buf;
 	dma_addr_t dma_addr;
 	size_t size;
 	int ret;
 
-	mhi_cntrl = container_of(work, struct mhi_controller, fw_worker);
-	dev = &mhi_cntrl->mhi_dev->dev;
-
-	dev_dbg(dev, "Waiting for device to enter PBL from: %s\n",
-		TO_MHI_EXEC_STR(mhi_cntrl->ee));
-
-	ret = wait_event_timeout(mhi_cntrl->state_event,
-				 MHI_IN_PBL(mhi_cntrl->ee) ||
-				 MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
-				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
-
-	if (!ret || MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
+	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
 		dev_err(dev, "Device MHI is not in valid state\n");
 		return;
 	}
diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index 4dc7f22..e92a20a 100644
--- a/drivers/bus/mhi/core/init.c
+++ b/drivers/bus/mhi/core/init.c
@@ -836,7 +836,6 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
 	spin_lock_init(&mhi_cntrl->wlock);
 	INIT_WORK(&mhi_cntrl->st_worker, mhi_pm_st_worker);
 	INIT_WORK(&mhi_cntrl->syserr_worker, mhi_pm_sys_err_worker);
-	INIT_WORK(&mhi_cntrl->fw_worker, mhi_fw_load_worker);
 	init_waitqueue_head(&mhi_cntrl->state_event);
 
 	mhi_cmd = mhi_cntrl->mhi_cmd;
diff --git a/drivers/bus/mhi/core/internal.h b/drivers/bus/mhi/core/internal.h
index 5deadfa..4919a43 100644
--- a/drivers/bus/mhi/core/internal.h
+++ b/drivers/bus/mhi/core/internal.h
@@ -630,6 +630,7 @@ void mhi_ring_chan_db(struct mhi_controller *mhi_cntrl,
 void mhi_deinit_free_irq(struct mhi_controller *mhi_cntrl);
 void mhi_rddm_prepare(struct mhi_controller *mhi_cntrl,
 		      struct image_info *img_info);
+void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl);
 int mhi_prepare_channel(struct mhi_controller *mhi_cntrl,
 			struct mhi_chan *mhi_chan);
 int mhi_init_chan_ctxt(struct mhi_controller *mhi_cntrl,
diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
index 52690cb..dc90a71 100644
--- a/drivers/bus/mhi/core/pm.c
+++ b/drivers/bus/mhi/core/pm.c
@@ -528,7 +528,6 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl,
 	dev_dbg(dev, "Waiting for all pending threads to complete\n");
 	wake_up_all(&mhi_cntrl->state_event);
 	flush_work(&mhi_cntrl->st_worker);
-	flush_work(&mhi_cntrl->fw_worker);
 
 	dev_dbg(dev, "Reset all active channels and remove MHI devices\n");
 	device_for_each_child(mhi_cntrl->cntrl_dev, NULL, mhi_destroy_device);
@@ -643,7 +642,7 @@ void mhi_pm_st_worker(struct work_struct *work)
 				mhi_cntrl->ee = mhi_get_exec_env(mhi_cntrl);
 			write_unlock_irq(&mhi_cntrl->pm_lock);
 			if (MHI_IN_PBL(mhi_cntrl->ee))
-				wake_up_all(&mhi_cntrl->state_event);
+				mhi_fw_load_handler(mhi_cntrl);
 			break;
 		case DEV_ST_TRANSITION_SBL:
 			write_lock_irq(&mhi_cntrl->pm_lock);
@@ -833,9 +832,6 @@ int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
 	next_state = MHI_IN_PBL(current_ee) ?
 		DEV_ST_TRANSITION_PBL : DEV_ST_TRANSITION_READY;
 
-	if (next_state == DEV_ST_TRANSITION_PBL)
-		schedule_work(&mhi_cntrl->fw_worker);
-
 	mhi_queue_state_transition(mhi_cntrl, next_state);
 
 	mutex_unlock(&mhi_cntrl->pm_mutex);
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index ad19960..cda7305 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -331,7 +331,6 @@ struct mhi_controller_config {
  * @wlock: Lock for protecting device wakeup
  * @mhi_link_info: Device bandwidth info
  * @st_worker: State transition worker
- * @fw_worker: Firmware download worker
  * @syserr_worker: System error worker
  * @state_event: State change event
  * @status_cb: CB function to notify power states of the device (required)
@@ -411,7 +410,6 @@ struct mhi_controller {
 	spinlock_t wlock;
 	struct mhi_link_info mhi_link_info;
 	struct work_struct st_worker;
-	struct work_struct fw_worker;
 	struct work_struct syserr_worker;
 	wait_queue_head_t state_event;
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
