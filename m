Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732542BB888
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 22:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbgKTVmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 16:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728509AbgKTVmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 16:42:52 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE3EC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 13:42:52 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id b63so9122024pfg.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 13:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YpJGL4iVaQpB7OmyOGqz/Jf0POXHK+Nggf2uFVT9Buw=;
        b=rsprrXgQJ8Uxq1riKWhihy1oQMH/BBT8pLh6Z5YIbfumyJK4ixSQK3k6LnsVGQ1WOE
         EID9fHBgPrYlxGubouynSgoa/cjJZwycBwZPRP2gzxDiyi0Pyl1i+lRu4J/E7npqafBl
         kAKwcXcog/Kir1pfvgk+Fg7LQ239DGndiqza9kdbGoBa+gJE40fZdw5uyE+YxTGHan8x
         D6688IWtT7RThWkrPGHfTrkDIV8yUSRnn8Q+hBSVxBUS4DxJzfcO8r/Ja2WYxu3AUbnV
         0AWocaPeoBm5aLIQmfZOEHf4a9r7kr5h9u0zLnumaIk46MaeS/zytw/cwXF0MX3lMqgB
         zbRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YpJGL4iVaQpB7OmyOGqz/Jf0POXHK+Nggf2uFVT9Buw=;
        b=eI2MNgGpOeOAlD/sr6PpwGje/NREnvipLAhrnQjz4af1tHfHQnT1oX2HF7mdwowAT3
         1KrBCC3k9gzinKfep7YcOb9p9001Cj4ooHi0trtcA/M76/2NhwDTE8m7kuUksltVARlr
         FqmzTjB0zI5xsIxeJn42a5agt1FWWdQhw+XCVJbiE0g/nSqOQVIGOrXc4KoqbBfK3qO/
         19K3EWq9cIG58Rsfd0hEgAjGln987s+bjAyNz4JrqwxFakLpo2cI0k2XIELegh1y8Jcq
         VNmCqZ0e1f1x/oRvGGx849Iz8NVcsZW0pYQOMRdKMjgkXYmqbc81dS1ssIgzkTLWS/ac
         wLgQ==
X-Gm-Message-State: AOAM530z4K8oNS/9Whue9czxYKY9YLRiiXElkJdp3VR6+A9GOPv7bKKB
        VIMQMY6ORr6FqtCNJ1R0pqf2Bg==
X-Google-Smtp-Source: ABdhPJwG8ojTAM3LzlvZko1yKgzZTHIM/kSHXTPEW1lLwhIcriYMoHO4WDHWxjOocTsdcRguRLxlSw==
X-Received: by 2002:a63:f944:: with SMTP id q4mr18079882pgk.98.1605908571882;
        Fri, 20 Nov 2020 13:42:51 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e8sm4713197pfj.157.2020.11.20.13.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 13:42:51 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     guennadi.liakhovetski@linux.intel.com, arnaud.pouliquen@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 5/8] rpmsg: core: Add channel creation internal API
Date:   Fri, 20 Nov 2020 14:42:42 -0700
Message-Id: <20201120214245.172963-6-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120214245.172963-1-mathieu.poirier@linaro.org>
References: <20201120214245.172963-1-mathieu.poirier@linaro.org>
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

