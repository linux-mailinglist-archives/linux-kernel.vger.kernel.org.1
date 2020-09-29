Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6612027D508
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 19:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgI2Rw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 13:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbgI2Rw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 13:52:56 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B466FC0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 10:52:55 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id k8so5329597pfk.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 10:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Sxs+p0qJGwlXlYqr5DnhuqsFJ9uI4G3h2LLCfE221Y0=;
        b=FRnczYI+v1u4dF861GnaIOp7rwgHlWVR54rKOOmduQRHcCn3R9o1CGzz6CzA7vTVAx
         +n0kG7P2oIRLzc7CveQVunt6YFEXfvggLu99xyxEPv0TVORLTjGm7TC2stGi4DWp5HPK
         PlEurju2WE5NhammvldF/Lf4DgPtxVXomb1i1W6tXyStIXSCGEnBb0Bf/8F7/ebdFPpH
         0qFcSlWnP5XPpLzYycAIwDsCFycikhr0xerBMxjs1FzYC3mJqCf2fOe0paDndJFRu0EC
         9e924nDYpiBYwgaD8c7Hz+jCLgBBodCtfWvHUBBaboMiV8z29WRrWA2hA7k1QhBVcg34
         DwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Sxs+p0qJGwlXlYqr5DnhuqsFJ9uI4G3h2LLCfE221Y0=;
        b=WO5MkWyqvcx+gRVWT8b4W7OiQ90QspK07Kwp61qkoQs1heyeFRtnBhBa1xCfpXkiEl
         N5g+I+Ya77dlbXJz/srH+8jCketWxIRpoI/AY4K/L+qVBk1aswbpGHg1Dwt0lWwNpaUQ
         2N3OhpYOyjAT+ohRGOSyRYt6RtwPOeS9wdFkPMsEKtjEjmHTO4S+SxPiv3q2yhH9kQxa
         oTqGD3vc7r/ub/jgzeMkVxRHeB+7hm03uysUzzJWAOHDAxGdp4OGgemw0k1rR7p9uaRC
         mfvPAVjsUDxrWbw898j6wUBgjuvbs0cN9kVUq1meAgpOn/QEvanwUir/cQ4FVHdwufW9
         M1tg==
X-Gm-Message-State: AOAM531OenovXwU88jshr9stba/AoXrOsAfLndvZIFqOSD7DPq6yKRDW
        LDIN+8XWh3eNTrFFRK7upDoO
X-Google-Smtp-Source: ABdhPJz7HbkWz/+MiuN5TUw2klFfMVw6d+fVFvpDeQy34/on+mPPovOK6c7kBXNRCy+BhyVVNhD+WA==
X-Received: by 2002:a63:5821:: with SMTP id m33mr4064260pgb.16.1601401975150;
        Tue, 29 Sep 2020 10:52:55 -0700 (PDT)
Received: from Mani-XPS-13-9360.localdomain ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id r188sm6271046pfc.67.2020.09.29.10.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 10:52:54 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 06/19] bus: mhi: core: Use generic name field for an MHI device
Date:   Tue, 29 Sep 2020 23:22:05 +0530
Message-Id: <20200929175218.8178-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929175218.8178-1-manivannan.sadhasivam@linaro.org>
References: <20200929175218.8178-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhaumik Bhatt <bbhatt@codeaurora.org>

An MHI device is not necessarily associated with only channels as we can
have one associated with the controller itself. Hence, the chan_name
field within the mhi_device structure should instead be replaced with a
generic name to accurately reflect any type of MHI device.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/init.c | 5 +++--
 drivers/bus/mhi/core/main.c | 6 +++---
 include/linux/mhi.h         | 8 ++++----
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index e43a190a7a36..e2011ec46b92 100644
--- a/drivers/bus/mhi/core/init.c
+++ b/drivers/bus/mhi/core/init.c
@@ -904,6 +904,7 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
 	mhi_dev->dev_type = MHI_DEVICE_CONTROLLER;
 	mhi_dev->mhi_cntrl = mhi_cntrl;
 	dev_set_name(&mhi_dev->dev, "%s", dev_name(mhi_cntrl->cntrl_dev));
+	mhi_dev->name = dev_name(mhi_cntrl->cntrl_dev);
 
 	/* Init wakeup source */
 	device_init_wakeup(&mhi_dev->dev, true);
@@ -1249,7 +1250,7 @@ static int mhi_uevent(struct device *dev, struct kobj_uevent_env *env)
 	struct mhi_device *mhi_dev = to_mhi_device(dev);
 
 	return add_uevent_var(env, "MODALIAS=" MHI_DEVICE_MODALIAS_FMT,
-					mhi_dev->chan_name);
+					mhi_dev->name);
 }
 
 static int mhi_match(struct device *dev, struct device_driver *drv)
@@ -1266,7 +1267,7 @@ static int mhi_match(struct device *dev, struct device_driver *drv)
 		return 0;
 
 	for (id = mhi_drv->id_table; id->chan[0]; id++)
-		if (!strcmp(mhi_dev->chan_name, id->chan)) {
+		if (!strcmp(mhi_dev->name, id->chan)) {
 			mhi_dev->id = id;
 			return 1;
 		}
diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
index 79be18ec2ebf..2cff5ddff225 100644
--- a/drivers/bus/mhi/core/main.c
+++ b/drivers/bus/mhi/core/main.c
@@ -249,7 +249,7 @@ int mhi_destroy_device(struct device *dev, void *data)
 		put_device(&mhi_dev->dl_chan->mhi_dev->dev);
 
 	dev_dbg(&mhi_cntrl->mhi_dev->dev, "destroy device for chan:%s\n",
-		 mhi_dev->chan_name);
+		 mhi_dev->name);
 
 	/* Notify the client and remove the device from MHI bus */
 	device_del(dev);
@@ -327,10 +327,10 @@ void mhi_create_devices(struct mhi_controller *mhi_cntrl)
 		}
 
 		/* Channel name is same for both UL and DL */
-		mhi_dev->chan_name = mhi_chan->name;
+		mhi_dev->name = mhi_chan->name;
 		dev_set_name(&mhi_dev->dev, "%s_%s",
 			     dev_name(mhi_cntrl->cntrl_dev),
-			     mhi_dev->chan_name);
+			     mhi_dev->name);
 
 		/* Init wakeup source if available */
 		if (mhi_dev->dl_chan && mhi_dev->dl_chan->wake_capable)
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index 0779bc689b3e..bb337d163dda 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -438,10 +438,10 @@ struct mhi_controller {
 };
 
 /**
- * struct mhi_device - Structure representing a MHI device which binds
- *                     to channels
+ * struct mhi_device - Structure representing an MHI device which binds
+ *                     to channels or is associated with controllers
  * @id: Pointer to MHI device ID struct
- * @chan_name: Name of the channel to which the device binds
+ * @name: Name of the associated MHI device
  * @mhi_cntrl: Controller the device belongs to
  * @ul_chan: UL channel for the device
  * @dl_chan: DL channel for the device
@@ -453,7 +453,7 @@ struct mhi_controller {
  */
 struct mhi_device {
 	const struct mhi_device_id *id;
-	const char *chan_name;
+	const char *name;
 	struct mhi_controller *mhi_cntrl;
 	struct mhi_chan *ul_chan;
 	struct mhi_chan *dl_chan;
-- 
2.17.1

