Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE3C28DD8B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 11:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730492AbgJNJZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 05:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730490AbgJNJTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:19:41 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECBCC08EA79
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 16:25:29 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id j18so832502pfa.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 16:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8tfc/u3ngEc2adMkpXKOCwsLWllqbd3pOy732+G3iRI=;
        b=HVXiZAFVOrExa9CAZlR5lqXmXH32M58FgQ6yC9YjSndiHdQlPJOluTRq/whQ3c2e0U
         78WK+rX3UxbIqDWJ0yj9cGgTDJY7fbIFmn6EyJqQFoeJw6DJnGpD0H+d9u1Pkspc1p5e
         6cQPuqUcmFlTDtoGbGeCNK9QIWxNJwpgSqGeCAJNja/SzK2zw1YkIlSbSJlwXiOcRZxL
         3I81GvyY6um130OnMKmIEafCi8WF0IpE7AjVm87bbG4DAAnvgaDq1fycixsI1a983OkA
         yb/YykcYA9P6EpJVHk/g4OxLHskH7rI0twN8zkJsa8uKnW9FAsCb2nGagzCG4uBOSKhd
         YPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8tfc/u3ngEc2adMkpXKOCwsLWllqbd3pOy732+G3iRI=;
        b=fmt2uvT7iXYwwdxPriZpT2Mq//X+Bs9xDLSPjORZDoIpy3l+tSJPWDZDW6cLX40quf
         qpLvDjtOtEOw/6UVrfcjfnvNIQ9y0fakb+I/8BzpahQt+sZ1ADH8DmFQQDEh9MTlyIpw
         nKCe2JmpRWuDjbnYg5n9Giy3RrLwHg6ontFcSMKFVij34ERMx84vHlkbJbFVQwbxaGl4
         DwCde6sOqz2/791fhUj5wcElc3s6Q4kYgBIXWaxZzQD7R2MQQmSJfpShuT4cc0tJBnfY
         DmCr1QbLiSNiFqJ3Y7SiWK5i9NYLtkERzMbwI6j3lX7z7pCtEEo57QisI83b1hoGT0sy
         ojUQ==
X-Gm-Message-State: AOAM532ZhedExOPC1q+u5wZt9loULQpOHfSNsJiYxGRjXmxE5queGPh5
        L6xbjsfJuH8wxzrqOsjJLVZAbw==
X-Google-Smtp-Source: ABdhPJyfoG92S8sHKc8MSRzmfOC0+fOu2gOflvc1K9c8N/Hd34BGD+ryO4otBZ8765yE61Fmxcd6wQ==
X-Received: by 2002:a63:4810:: with SMTP id v16mr1566057pga.374.1602631528718;
        Tue, 13 Oct 2020 16:25:28 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id b8sm791871pfr.159.2020.10.13.16.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 16:25:28 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     guennadi.liakhovetski@linux.intel.com, arnaud.pouliquen@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/9] rpmsg: core: Add channel creation internal API
Date:   Tue, 13 Oct 2020 17:25:16 -0600
Message-Id: <20201013232519.1367542-7-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201013232519.1367542-1-mathieu.poirier@linaro.org>
References: <20201013232519.1367542-1-mathieu.poirier@linaro.org>
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
---
 drivers/rpmsg/rpmsg_core.c     | 44 ++++++++++++++++++++++++++++++++++
 drivers/rpmsg/rpmsg_internal.h |  4 ++++
 include/linux/rpmsg.h          |  6 +++++
 3 files changed, 54 insertions(+)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index a6361cad608b..a5c4b80debf3 100644
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
+struct rpmsg_device * rpmsg_create_channel(struct rpmsg_device *rpdev,
+					   struct rpmsg_channel_info *chinfo)
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
index 094cf968d2d3..b9b34b416b7b 100644
--- a/drivers/rpmsg/rpmsg_internal.h
+++ b/drivers/rpmsg/rpmsg_internal.h
@@ -56,6 +56,10 @@ int rpmsg_unregister_device(struct device *parent,
 struct device *rpmsg_find_device(struct device *parent,
 				 struct rpmsg_channel_info *chinfo);
 
+struct rpmsg_device * rpmsg_create_channel(struct rpmsg_device *rpdev,
+					   struct rpmsg_channel_info *chinfo);
+int rpmsg_release_channel(struct rpmsg_device *rpdev,
+			  struct rpmsg_channel_info *chinfo);
 /**
  * rpmsg_chrdev_register_device() - register chrdev device based on rpdev
  * @rpdev:	prepared rpdev to be used for creating endpoints
diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
index 165e4c6d4cd3..eb70463a9f2e 100644
--- a/include/linux/rpmsg.h
+++ b/include/linux/rpmsg.h
@@ -42,6 +42,8 @@ typedef int (*rpmsg_rx_cb_t)(struct rpmsg_device *, void *, int, void *, u32);
 /**
  * struct rpmsg_device_ops - indirection table for the rpmsg_device operations
  * @is_little_endian:	returns true if using little endian byte ordering
+ * @create_channel:	create backend-specific channel, optional
+ * @release_channel:	release backend-specific channel, optional
  * @create_ept:		create backend-specific endpoint, required
  * @announce_create:	announce presence of new channel, optional
  * @announce_destroy:	announce destruction of channel, optional
@@ -52,6 +54,10 @@ typedef int (*rpmsg_rx_cb_t)(struct rpmsg_device *, void *, int, void *, u32);
  */
 struct rpmsg_device_ops {
 	bool (*is_little_endian)(struct rpmsg_device *rpdev);
+	struct rpmsg_device *(*create_channel)(struct rpmsg_device *rpdev,
+					       struct rpmsg_channel_info *chinfo);
+	int (*release_channel)(struct rpmsg_device *rpdev,
+			       struct rpmsg_channel_info *chinfo);
 	struct rpmsg_endpoint *(*create_ept)(struct rpmsg_device *rpdev,
 					    rpmsg_rx_cb_t cb, void *priv,
 					    struct rpmsg_channel_info chinfo);
-- 
2.25.1

