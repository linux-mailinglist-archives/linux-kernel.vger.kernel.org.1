Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7B331CEACD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 04:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgELCdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 22:33:42 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:21517 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728593AbgELCdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 22:33:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589250820; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=OGI8yDTVct0p5oMeYV6kM9AJFHplQPergOwGqrlARyE=; b=FwddHRqGe37sTHDhd9pZyCxCQ49F8lS6mwMFAoFExHvSerIsKaiHdz4QAhKcFgEXjnLAXwGq
 9Bjjde9vIl9FspzCZ+R+Aa1m6eP2j3P4q0aeEKpuCZ64ycJJRtvL7ZrtjCe9Jsju2uC5eWdd
 /wXnNIn6b7O50Q4xjVsyF1XfZQk=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eba0af6.7ffa8fbc0df8-smtp-out-n04;
 Tue, 12 May 2020 02:33:26 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1D33EC44792; Tue, 12 May 2020 02:33:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from bbhatt-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C87C7C433CB;
        Tue, 12 May 2020 02:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C87C7C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=bbhatt@codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        hemantk@codeaurora.org, jhugo@codeaurora.org,
        Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: [PATCH v1 1/6] bus: mhi: core: Introduce independent voting mechanism
Date:   Mon, 11 May 2020 19:33:11 -0700
Message-Id: <1589250796-32020-2-git-send-email-bbhatt@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1589250796-32020-1-git-send-email-bbhatt@codeaurora.org>
References: <1589250796-32020-1-git-send-email-bbhatt@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow independent votes from clients such that they can choose to vote
for either the device or the bus or both. This helps in cases where the
device supports autonomous low power mode wherein it can move to M2
state without the need to notify the host. Clients can also vote only to
keep the underlying bus active without having the device in M0 state to
support offload use cases.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
---
 drivers/bus/mhi/core/init.c | 15 +++++----
 drivers/bus/mhi/core/pm.c   | 75 ++++++++++++++++++++++++++++++++-------------
 include/linux/mhi.h         | 21 ++++++++-----
 3 files changed, 77 insertions(+), 34 deletions(-)

diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index 12207cc..d5bebe5 100644
--- a/drivers/bus/mhi/core/init.c
+++ b/drivers/bus/mhi/core/init.c
@@ -1061,7 +1061,8 @@ struct mhi_device *mhi_alloc_device(struct mhi_controller *mhi_cntrl)
 	dev->release = mhi_release_device;
 	dev->parent = mhi_cntrl->cntrl_dev;
 	mhi_dev->mhi_cntrl = mhi_cntrl;
-	mhi_dev->dev_wake = 0;
+	atomic_set(&mhi_dev->dev_vote, 0);
+	atomic_set(&mhi_dev->bus_vote, 0);
 
 	return mhi_dev;
 }
@@ -1078,7 +1079,7 @@ static int mhi_driver_probe(struct device *dev)
 	int ret;
 
 	/* Bring device out of LPM */
-	ret = mhi_device_get_sync(mhi_dev);
+	ret = mhi_device_get_sync(mhi_dev, MHI_VOTE_DEVICE);
 	if (ret)
 		return ret;
 
@@ -1137,14 +1138,14 @@ static int mhi_driver_probe(struct device *dev)
 	if (dl_chan && dl_chan->auto_start)
 		mhi_prepare_channel(mhi_cntrl, dl_chan);
 
-	mhi_device_put(mhi_dev);
+	mhi_device_put(mhi_dev, MHI_VOTE_DEVICE);
 
 	return ret;
 
 exit_probe:
 	mhi_unprepare_from_transfer(mhi_dev);
 
-	mhi_device_put(mhi_dev);
+	mhi_device_put(mhi_dev, MHI_VOTE_DEVICE);
 
 	return ret;
 }
@@ -1213,8 +1214,10 @@ static int mhi_driver_remove(struct device *dev)
 	}
 
 	read_lock_bh(&mhi_cntrl->pm_lock);
-	while (mhi_dev->dev_wake)
-		mhi_device_put(mhi_dev);
+	while (atomic_read(&mhi_dev->dev_vote))
+		mhi_device_put(mhi_dev, MHI_VOTE_DEVICE);
+	while (atomic_read(&mhi_dev->bus_vote))
+		mhi_device_put(mhi_dev, MHI_VOTE_BUS);
 	read_unlock_bh(&mhi_cntrl->pm_lock);
 
 	return 0;
diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
index de5abb2..0b68dcd 100644
--- a/drivers/bus/mhi/core/pm.c
+++ b/drivers/bus/mhi/core/pm.c
@@ -675,7 +675,8 @@ void mhi_pm_st_worker(struct work_struct *work)
 int mhi_pm_suspend(struct mhi_controller *mhi_cntrl)
 {
 	struct mhi_chan *itr, *tmp;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	struct mhi_device *mhi_dev = mhi_cntrl->mhi_dev;
+	struct device *dev = &mhi_dev->dev;
 	enum mhi_pm_state new_state;
 	int ret;
 
@@ -686,7 +687,8 @@ int mhi_pm_suspend(struct mhi_controller *mhi_cntrl)
 		return -EIO;
 
 	/* Return busy if there are any pending resources */
-	if (atomic_read(&mhi_cntrl->dev_wake))
+	if (atomic_read(&mhi_cntrl->dev_wake) ||
+	    atomic_read(&mhi_dev->bus_vote))
 		return -EBUSY;
 
 	/* Take MHI out of M2 state */
@@ -712,10 +714,9 @@ int mhi_pm_suspend(struct mhi_controller *mhi_cntrl)
 
 	write_lock_irq(&mhi_cntrl->pm_lock);
 
-	if (atomic_read(&mhi_cntrl->dev_wake)) {
-		write_unlock_irq(&mhi_cntrl->pm_lock);
+	if (atomic_read(&mhi_cntrl->dev_wake) ||
+	    atomic_read(&mhi_dev->bus_vote))
 		return -EBUSY;
-	}
 
 	dev_info(dev, "Allowing M3 transition\n");
 	new_state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_M3_ENTER);
@@ -1080,42 +1081,74 @@ int mhi_force_rddm_mode(struct mhi_controller *mhi_cntrl)
 }
 EXPORT_SYMBOL_GPL(mhi_force_rddm_mode);
 
-void mhi_device_get(struct mhi_device *mhi_dev)
+void mhi_device_get(struct mhi_device *mhi_dev, int vote)
 {
 	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
 
-	mhi_dev->dev_wake++;
-	read_lock_bh(&mhi_cntrl->pm_lock);
-	mhi_cntrl->wake_get(mhi_cntrl, true);
-	read_unlock_bh(&mhi_cntrl->pm_lock);
+	if (vote & MHI_VOTE_DEVICE) {
+		atomic_inc(&mhi_dev->dev_vote);
+		read_lock_bh(&mhi_cntrl->pm_lock);
+		mhi_cntrl->wake_get(mhi_cntrl, true);
+		read_unlock_bh(&mhi_cntrl->pm_lock);
+	}
+
+	if (vote & MHI_VOTE_BUS) {
+		atomic_inc(&mhi_dev->bus_vote);
+		mhi_cntrl->runtime_get(mhi_cntrl);
+	}
 }
 EXPORT_SYMBOL_GPL(mhi_device_get);
 
-int mhi_device_get_sync(struct mhi_device *mhi_dev)
+int mhi_device_get_sync(struct mhi_device *mhi_dev, int vote)
 {
 	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
 	int ret;
 
+	/* bring device out of low power modes regardless of the type of vote */
 	ret = __mhi_device_get_sync(mhi_cntrl);
-	if (!ret)
-		mhi_dev->dev_wake++;
+	if (ret)
+		return ret;
+
+	if (vote & MHI_VOTE_DEVICE) {
+		atomic_inc(&mhi_dev->dev_vote);
+	} else {
+		/* remove device vote as it was not requested */
+		read_lock_bh(&mhi_cntrl->pm_lock);
+		mhi_cntrl->wake_put(mhi_cntrl, false);
+		read_unlock_bh(&mhi_cntrl->pm_lock);
+	}
+
+	if (vote & MHI_VOTE_BUS) {
+		atomic_inc(&mhi_dev->bus_vote);
+		mhi_cntrl->runtime_get(mhi_cntrl);
+	}
 
 	return ret;
 }
 EXPORT_SYMBOL_GPL(mhi_device_get_sync);
 
-void mhi_device_put(struct mhi_device *mhi_dev)
+void mhi_device_put(struct mhi_device *mhi_dev, int vote)
 {
 	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
 
-	mhi_dev->dev_wake--;
-	read_lock_bh(&mhi_cntrl->pm_lock);
-	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state)) {
-		mhi_cntrl->runtime_get(mhi_cntrl);
-		mhi_cntrl->runtime_put(mhi_cntrl);
+	if (vote & MHI_VOTE_DEVICE) {
+		atomic_dec(&mhi_dev->dev_vote);
+		read_lock_bh(&mhi_cntrl->pm_lock);
+		if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state)) {
+			mhi_cntrl->runtime_get(mhi_cntrl);
+			mhi_cntrl->runtime_put(mhi_cntrl);
+		}
+		mhi_cntrl->wake_put(mhi_cntrl, false);
+		read_unlock_bh(&mhi_cntrl->pm_lock);
 	}
 
-	mhi_cntrl->wake_put(mhi_cntrl, false);
-	read_unlock_bh(&mhi_cntrl->pm_lock);
+	if (vote & MHI_VOTE_BUS) {
+		atomic_dec(&mhi_dev->bus_vote);
+		mhi_cntrl->runtime_put(mhi_cntrl);
+
+		/* notify controller that all bus votes are removed */
+		if (!atomic_read(&mhi_dev->bus_vote))
+			mhi_cntrl->status_cb(mhi_cntrl, MHI_CB_IDLE);
+	}
 }
 EXPORT_SYMBOL_GPL(mhi_device_put);
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index b008914..10fcb52 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -16,6 +16,9 @@
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 
+#define MHI_VOTE_BUS BIT(0) /* do not disable the mhi bus */
+#define MHI_VOTE_DEVICE BIT(1) /* prevent mhi device from entering lpm */
+
 struct mhi_chan;
 struct mhi_event;
 struct mhi_ctxt;
@@ -459,7 +462,8 @@ struct mhi_device {
 	enum mhi_device_type dev_type;
 	int ul_chan_id;
 	int dl_chan_id;
-	u32 dev_wake;
+	atomic_t dev_vote;
+	atomic_t bus_vote;
 };
 
 /**
@@ -644,23 +648,26 @@ void mhi_set_mhi_state(struct mhi_controller *mhi_cntrl,
 enum mhi_state mhi_get_mhi_state(struct mhi_controller *mhi_cntrl);
 
 /**
- * mhi_device_get - Disable device low power mode
+ * mhi_device_get - Disable device and/or bus low power mode
  * @mhi_dev: Device associated with the channel
+ * @vote: requested vote (bus, device or both)
  */
-void mhi_device_get(struct mhi_device *mhi_dev);
+void mhi_device_get(struct mhi_device *mhi_dev, int vote);
 
 /**
- * mhi_device_get_sync - Disable device low power mode. Synchronously
+ * mhi_device_get_sync - Disable device and/or bus low power mode. Synchronously
  *                       take the controller out of suspended state
  * @mhi_dev: Device associated with the channel
+ * @vote: requested vote (bus, device or both)
  */
-int mhi_device_get_sync(struct mhi_device *mhi_dev);
+int mhi_device_get_sync(struct mhi_device *mhi_dev, int vote);
 
 /**
- * mhi_device_put - Re-enable device low power mode
+ * mhi_device_put - Re-enable device and/or bus low power mode
  * @mhi_dev: Device associated with the channel
+ * @vote: vote(s) to remove (bus, device or both)
  */
-void mhi_device_put(struct mhi_device *mhi_dev);
+void mhi_device_put(struct mhi_device *mhi_dev, int vote);
 
 /**
  * mhi_prepare_for_transfer - Setup channel for data transfer
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
