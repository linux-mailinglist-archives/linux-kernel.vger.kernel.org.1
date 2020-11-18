Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098272B86EA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 22:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbgKRVh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 16:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbgKRVhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 16:37:08 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92D4C0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 13:37:07 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id t21so2206125pgl.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 13:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YpJGL4iVaQpB7OmyOGqz/Jf0POXHK+Nggf2uFVT9Buw=;
        b=Y+5VPhwluelryGOQCt3n3SLvjhuuBuGqMkLhujB4uQYgQFEmpW1VtT+R2h5FjpMVam
         QZ/+hbIPzVkdLVm6Xi4r5vIcBFrZYlmWam9WdErqkFSyTCWTIaA65gFBn3BeBCnjYkqj
         07AQYXYcCc+abgZN6IFLtlQTMTiI2T9XMeCntMGvzXhCwUXoiqUcYOxWODcBj1KGilpj
         untdq2Ijm29Xf1sFR8YZ8RSEG/OIDZipc+ExWrgoaycXiLwXn2Bty4skr81+T1UYo08I
         +CuHidQMa23Z/PhfDzYcBVFLaQTNefZNJ+1CnomlPhItmI7IBxP7l4jaFmE4rccHJ74K
         rZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YpJGL4iVaQpB7OmyOGqz/Jf0POXHK+Nggf2uFVT9Buw=;
        b=JZ2nE546ELwELAZI7KuVkuiNv6XsIaTngi9RU3wb9mBdDeYcjD4rtU6Px30jMwRztZ
         dNsXIEnPwkyaGnraU8iOAfdY5//X1J8GPTUPT+uLSQ6sNczfXKxcoQ93D6nS+UyRXzHp
         Ey2w4JnphRzWuxINOfocotRTbiFJfkvTEQT3ybjPPFM9o6F9z91gX1Zy//tX1sYx1o6c
         7XZYn+35gQYwfj0/T/h5hs/3f7s/9tIxGqzhuTW1f5FHo4V/dCCLGzlktckkQzvpRMbe
         iHW2sgadqnJHXZI6mIAdOpfXZj6E/rvNUYTwsZBDVZfHAHstUSbuvhq7Wa/2x9jedtLL
         auLA==
X-Gm-Message-State: AOAM5308CE0rEiabvVJD2HKHvhUnXLGUId1c2iFkKM77ppY5Z9SD6KYR
        EZ9GYji8rjccWngbcK1p56yzQw==
X-Google-Smtp-Source: ABdhPJwsUsXFF9FMgUN8DIMvjHiLqOfSJCNaXznrpB/8orPbOgGOmPHLoZNHgr/DAnezYeTM6CpaYw==
X-Received: by 2002:a63:3116:: with SMTP id x22mr9671299pgx.278.1605735427551;
        Wed, 18 Nov 2020 13:37:07 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e6sm26575694pfn.190.2020.11.18.13.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 13:37:07 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     guennadi.liakhovetski@linux.intel.com, arnaud.pouliquen@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 5/8] rpmsg: core: Add channel creation internal API
Date:   Wed, 18 Nov 2020 14:36:57 -0700
Message-Id: <20201118213700.74106-6-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201118213700.74106-1-mathieu.poirier@linaro.org>
References: <20201118213700.74106-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaud Pouliquen <arnaud.pouliquen@st.com>

Add the channel creation API as a first step to be able to define the
name service announcement as a rpmsg driver independent from the RPMsg
virtio bus.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
---
 drivers/rpmsg/rpmsg_core.c     | 44 ++++++++++++++++++++++++++++++++++
 drivers/rpmsg/rpmsg_internal.h | 10 ++++++++
 2 files changed, 54 insertions(+)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index 91de940896e3..e5daee4f9373 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -20,6 +20,50 @@
 
 #include "rpmsg_internal.h"
 
+/**
+ * rpmsg_create_channel() - create a new rpmsg channel
+ * using its name and address info.
+ * @rpdev: rpmsg device
+ * @chinfo: channel_info to bind
+ *
+ * Returns a pointer to the new rpmsg device on success, or NULL on error.
+ */
+struct rpmsg_device *rpmsg_create_channel(struct rpmsg_device *rpdev,
+					  struct rpmsg_channel_info *chinfo)
+{
+	if (WARN_ON(!rpdev))
+		return NULL;
+	if (!rpdev->ops || !rpdev->ops->create_channel) {
+		dev_err(&rpdev->dev, "no create_channel ops found\n");
+		return NULL;
+	}
+
+	return rpdev->ops->create_channel(rpdev, chinfo);
+}
+EXPORT_SYMBOL(rpmsg_create_channel);
+
+/**
+ * rpmsg_release_channel() - release a rpmsg channel
+ * using its name and address info.
+ * @rpdev: rpmsg device
+ * @chinfo: channel_info to bind
+ *
+ * Returns 0 on success or an appropriate error value.
+ */
+int rpmsg_release_channel(struct rpmsg_device *rpdev,
+			  struct rpmsg_channel_info *chinfo)
+{
+	if (WARN_ON(!rpdev))
+		return -EINVAL;
+	if (!rpdev->ops || !rpdev->ops->release_channel) {
+		dev_err(&rpdev->dev, "no release_channel ops found\n");
+		return -ENXIO;
+	}
+
+	return rpdev->ops->release_channel(rpdev, chinfo);
+}
+EXPORT_SYMBOL(rpmsg_release_channel);
+
 /**
  * rpmsg_create_ept() - create a new rpmsg_endpoint
  * @rpdev: rpmsg channel device
diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
index 3fc83cd50e98..f1de73e0f2d6 100644
--- a/drivers/rpmsg/rpmsg_internal.h
+++ b/drivers/rpmsg/rpmsg_internal.h
@@ -20,6 +20,8 @@
 
 /**
  * struct rpmsg_device_ops - indirection table for the rpmsg_device operations
+ * @create_channel:	create backend-specific channel, optional
+ * @release_channel:	release backend-specific channel, optional
  * @create_ept:		create backend-specific endpoint, required
  * @announce_create:	announce presence of new channel, optional
  * @announce_destroy:	announce destruction of channel, optional
@@ -29,6 +31,10 @@
  * advertise new channels implicitly by creating the endpoints.
  */
 struct rpmsg_device_ops {
+	struct rpmsg_device *(*create_channel)(struct rpmsg_device *rpdev,
+					       struct rpmsg_channel_info *chinfo);
+	int (*release_channel)(struct rpmsg_device *rpdev,
+			       struct rpmsg_channel_info *chinfo);
 	struct rpmsg_endpoint *(*create_ept)(struct rpmsg_device *rpdev,
 					    rpmsg_rx_cb_t cb, void *priv,
 					    struct rpmsg_channel_info chinfo);
@@ -75,6 +81,10 @@ int rpmsg_unregister_device(struct device *parent,
 struct device *rpmsg_find_device(struct device *parent,
 				 struct rpmsg_channel_info *chinfo);
 
+struct rpmsg_device *rpmsg_create_channel(struct rpmsg_device *rpdev,
+					  struct rpmsg_channel_info *chinfo);
+int rpmsg_release_channel(struct rpmsg_device *rpdev,
+			  struct rpmsg_channel_info *chinfo);
 /**
  * rpmsg_chrdev_register_device() - register chrdev device based on rpdev
  * @rpdev:	prepared rpdev to be used for creating endpoints
-- 
2.25.1

