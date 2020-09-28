Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E365327A62C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 06:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgI1EK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 00:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgI1EK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 00:10:56 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7082C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 21:10:55 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id s31so2890984pga.7
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 21:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Sxs+p0qJGwlXlYqr5DnhuqsFJ9uI4G3h2LLCfE221Y0=;
        b=cmfJOFLt+hXPrXXbkHEAXFz8nPhToOeufju7CxHnVqHyKI6uccDkriiAyaxm4sx3Bt
         19rklAdbaApNUy9HqKXWq2l+r+DtreSXRqxb8RCmJH6BN1VcYXvK5C5H3/5DNTg0FrtW
         vAU4aYLkjDRN2jggi/MA89f4hsPu2eQQmWBFpkj13cY5SxUDJAqBdGBLKiPNko4PXZ0K
         52rQEcJBcKpbU7l3Z05gU1Cm0j48C8IrnHzdGA3dj/WsggkuhB+WxL769OKC4Asm8Dqq
         cthbF/iREyQ3cDx8GpJ/1JthqKqZ3oWMr6/x2Y2CdPisqSOqB9T+dEj3RqHSiHJfCmSN
         FHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Sxs+p0qJGwlXlYqr5DnhuqsFJ9uI4G3h2LLCfE221Y0=;
        b=bYSX9dK2cdH8mlw5mbIs/aBWdw1erkGpiD94dvozQ/+4i3+ZgKMsOSbNNjbtIM35uH
         MLjo5F58ZlptTwXSVLhQ+ZTXBbcAH+GNGEpJnJvhSGEu9CTLCq/5E4vmdu+E0FVLEhdE
         6L4QnppzOTCWSCbQ805BOF1vRwkepiP7pYWn6fsBLTbQpR/dMU1bsTVWsOqtyJdk4QYg
         L6tRHOPEzKsw/nP16joO7w5ox2dHkXw0tAT2zKkYUl/xoAxHCneQdoP91jW7Fs2SeFdr
         EvuasXGeIBJ4BWvQyw+CZnBNpqLPjN5Mswys/VEDOoVkP1uJEkwPQHbuJRW3Z1HqGeyW
         CueA==
X-Gm-Message-State: AOAM5307YtqIxzwH3gZzY/w5fvVClDHhPnZseOjivJ7NBo0S7GufI21X
        1J5RW/pqqvYjZdDzTIYd1rB+
X-Google-Smtp-Source: ABdhPJwW/soFnhyF/P0hV3/oRZBmnj1P9ecMyWs1Wql7Rw8q7XqXOL+ja0YP+SYfFqYb8CHJJpbcaw==
X-Received: by 2002:a62:6dc3:0:b029:13c:1611:658d with SMTP id i186-20020a626dc30000b029013c1611658dmr8611001pfc.10.1601266255388;
        Sun, 27 Sep 2020 21:10:55 -0700 (PDT)
Received: from Mani-XPS-13-9360.localdomain ([2409:4072:6003:40df:7c40:5a87:eb86:87b0])
        by smtp.gmail.com with ESMTPSA id n21sm8306322pgl.7.2020.09.27.21.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 21:10:54 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 06/21] bus: mhi: core: Use generic name field for an MHI device
Date:   Mon, 28 Sep 2020 09:39:36 +0530
Message-Id: <20200928040951.18207-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200928040951.18207-1-manivannan.sadhasivam@linaro.org>
References: <20200928040951.18207-1-manivannan.sadhasivam@linaro.org>
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

