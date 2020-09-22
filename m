Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057B1273720
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 02:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbgIVAKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 20:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728938AbgIVAKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 20:10:04 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58FFC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 17:10:04 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id s14so522470pju.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 17:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p5nUSjWR/Mldt926WccD+ixHckUqZWbkV5NJAtOcn6E=;
        b=cTp/+Bcc9YipIXPEO6XZqsd/9WvRKr1y2j/W4LPFU28CM2WSQ/Ep7N1jSM1X6AVHKp
         SZakUDkRjaXctBfz3Q4IlRlupml4Sdfu2jyqr8Qsmcv5wawvLtL3hJKB8UTg3BhgPp27
         5lTO32++TnYxQWUOwdWy5BODlro1iGLPyhbbpGvubse+rV5yfphlaBS4X2BdZDzghY0N
         yQiLOF+sFVnD18V3EwMUV+xchQ44Oyko9fDSGIeO5vwdgo9xUncbCa+iN9Dg4VanGnem
         mriRnDhGBSOjPbKvwxlikyha3I9qICggJ1H4nG4IugXCIff+Qw2tWHazX4M5LOUEKbCo
         bj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p5nUSjWR/Mldt926WccD+ixHckUqZWbkV5NJAtOcn6E=;
        b=cbCu0nDsjgMnBD6+sJwQ3+lKMOArh8FhKEsJAr6byM7lnxJt/fzP23gTF6Lqrh/sR3
         2iOREAaklfASIxZZMAWoB+r8MRDqpwbecb+QKaOfgEBvxDVdd1+1Pd5Xh7bQriSkjMQm
         TIEDyElN3IPOTSfN1dnJGPpDoszovQI1AXPzqoyQf8juavrb8vCgiOEKLndPCobMkN2L
         xXvhO1HcSNTwzyd7ULkz4mL+sIvqzXX0z8C9DNtsEXuz3Abra5j9W5X8flcPm54R1g4B
         nqZYrMX0iXe+We5ofsvG2VBTGO1nKijG1Ey33yVXOERtj4C+zUmYtQ9PhNiP9RmIuhFx
         Ttiw==
X-Gm-Message-State: AOAM530IAXWX9nkKX3rKAyMTyoBpfppmpA5rRhPWrUnP4mDhkl+JY99t
        YiuKAe/+eTjd1PlBVdWE6tH24Q==
X-Google-Smtp-Source: ABdhPJyU0YaxKBuB+bPZ/8ZbSIAV7XjWH8vR1OVs8fAL2OZoxEJii9k/0fXt8shgVKw4YMNuwkR1dg==
X-Received: by 2002:a17:90a:54f:: with SMTP id h15mr1550832pjf.191.1600733404171;
        Mon, 21 Sep 2020 17:10:04 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id c9sm12807953pfn.78.2020.09.21.17.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 17:10:03 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        guennadi.liakhovetski@linux.intel.com
Cc:     loic.pallardy@st.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] rpmsg: core: Add channel creation internal API
Date:   Mon, 21 Sep 2020 18:09:52 -0600
Message-Id: <20200922001000.899956-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200922001000.899956-1-mathieu.poirier@linaro.org>
References: <20200922001000.899956-1-mathieu.poirier@linaro.org>
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
---
 drivers/rpmsg/rpmsg_core.c     | 45 ++++++++++++++++++++++++++++++++++
 drivers/rpmsg/rpmsg_internal.h | 12 +++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index 91de940896e3..50a835eaf1ba 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -20,6 +20,51 @@
 
 #include "rpmsg_internal.h"
 
+/**
+ * rpmsg_create_channel() - create a new rpmsg channel
+ * using its name and address info.
+ * @rpdev: rpmsg driver
+ * @chinfo: channel_info to bind
+ *
+ * Returns a pointer to the new rpmsg device on success, or NULL on error.
+ */
+struct rpmsg_device *
+	rpmsg_create_channel(struct rpmsg_device *rpdev,
+			     struct rpmsg_channel_info *chinfo)
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
+ * @rpdev: rpmsg driver
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
+		return -EPERM;
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
index 3fc83cd50e98..587f723757d4 100644
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
@@ -29,6 +31,11 @@
  * advertise new channels implicitly by creating the endpoints.
  */
 struct rpmsg_device_ops {
+	struct rpmsg_device *(*create_channel)(struct rpmsg_device *rpdev,
+					     struct rpmsg_channel_info *chinfo);
+	int (*release_channel)(struct rpmsg_device *rpdev,
+			       struct rpmsg_channel_info *chinfo);
+
 	struct rpmsg_endpoint *(*create_ept)(struct rpmsg_device *rpdev,
 					    rpmsg_rx_cb_t cb, void *priv,
 					    struct rpmsg_channel_info chinfo);
@@ -75,6 +82,11 @@ int rpmsg_unregister_device(struct device *parent,
 struct device *rpmsg_find_device(struct device *parent,
 				 struct rpmsg_channel_info *chinfo);
 
+struct rpmsg_device *
+rpmsg_create_channel(struct rpmsg_device *rpdev,
+		     struct rpmsg_channel_info *chinfo);
+int rpmsg_release_channel(struct rpmsg_device *rpdev,
+			  struct rpmsg_channel_info *chinfo);
 /**
  * rpmsg_chrdev_register_device() - register chrdev device based on rpdev
  * @rpdev:	prepared rpdev to be used for creating endpoints
-- 
2.25.1

