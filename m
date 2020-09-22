Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7466C273721
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 02:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbgIVAKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 20:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729110AbgIVAKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 20:10:12 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4D3C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 17:10:09 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 34so10432806pgo.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 17:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hbk9zcYeD+9Uduv/zaUcY28B45xybgwqjUf1aBL4iW4=;
        b=omzqSKVgL//OalmQsfu68+UnR95J0iHwsG1YKjy+1hXLGT8aeWTuYLYUtcdnlO+Y2+
         AzgR4PIsV7uX+tfRJZ7DwZOiGfJqrI+b1PxMLJN/lVVLRdLkPsbnKUGO3a+l0rIF6ZHR
         Gxm7o21DvmR1FEM1Mx5lQ5g4wleLI8RQALGhLGoOJIjTgY+pkQjHaEGpmLupFBw5mV6P
         /hxJfeFYPsCGLvZozZk8yI8SPlacQ3kVue51xMKkIM7UBVyS3o+JaJfPse0Ik9W8qOZ+
         m+/1Ey/ZCbL5+GYGYcEpZW+B9TgGRFLhmwjxq0uDTiZUa/bjf1nifCAYK7wEPXagMjRC
         BZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hbk9zcYeD+9Uduv/zaUcY28B45xybgwqjUf1aBL4iW4=;
        b=ep7tYD1FLWcCH49rX1SUyvxW/4gVoHobPGH6Gdiht/v4W6FubExt65FNOe7OLTSC4N
         jpc2zWxWf8J1RULkiy6tKtrVjG9Dsf5w/qjAUFAKECtytWd/942eiS9X81iQ5Q2Q/xiu
         75A+zIZ8tng+m7pqYRsXooLYxKaN5/MCx8ARRFjZ7EuaJ6W/NecXzNg5zg1b8+MXpnnC
         f/KJvnNxQPA/3t6Qxjpkh/73Lcywjr7Wu2m176+SfM060SjMvfTIgsys17UxoXYssyFS
         NngH54Tbug3G6xPnMNANLWHqk0pv47hMT6dlUAy180Nb9WAMfJ/XNNk51DsUGAG60pm9
         1UiQ==
X-Gm-Message-State: AOAM533J25GooWtOIR/5akDxQVfNteSffEuKTQslGZ5xqSe7SERUk1J1
        41GbN6hqct+XayUti83fvmab6g==
X-Google-Smtp-Source: ABdhPJwW6NGNxac4F0FNa4kgAuMkJrJECSn3W4isTYi8h5mYWDBZvAG2PV/Gl38+oKa7Ic9dmeuVfg==
X-Received: by 2002:a17:902:8689:b029:d1:9bf7:230a with SMTP id g9-20020a1709028689b02900d19bf7230amr2276079plo.22.1600733409284;
        Mon, 21 Sep 2020 17:10:09 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id c9sm12807953pfn.78.2020.09.21.17.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 17:10:08 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        guennadi.liakhovetski@linux.intel.com
Cc:     loic.pallardy@st.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] rpmsg: Turn name service into a stand alone driver
Date:   Mon, 21 Sep 2020 18:09:56 -0600
Message-Id: <20200922001000.899956-7-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200922001000.899956-1-mathieu.poirier@linaro.org>
References: <20200922001000.899956-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaud Pouliquen <arnaud.pouliquen@st.com>

Make the RPMSG name service announcement a stand alone driver so that it
can be reused by other subsystems.  It is also the first step in making the
functionatlity transport independent, i.e that is not tied to virtIO.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/rpmsg/Kconfig          |   8 +++
 drivers/rpmsg/Makefile         |   1 +
 drivers/rpmsg/rpmsg_internal.h |  18 ++++++
 drivers/rpmsg/rpmsg_ns.c       | 110 +++++++++++++++++++++++++++++++++
 4 files changed, 137 insertions(+)
 create mode 100644 drivers/rpmsg/rpmsg_ns.c

diff --git a/drivers/rpmsg/Kconfig b/drivers/rpmsg/Kconfig
index f96716893c2a..c3fc75e6514b 100644
--- a/drivers/rpmsg/Kconfig
+++ b/drivers/rpmsg/Kconfig
@@ -15,6 +15,14 @@ config RPMSG_CHAR
 	  in /dev. They make it possible for user-space programs to send and
 	  receive rpmsg packets.
 
+config RPMSG_NS
+	tristate "RPMSG name service announcement"
+	depends on RPMSG
+	help
+	  Say Y here to enable the support of the name service announcement
+	  channel that probes the associated RPMsg device on remote endpoint
+	  service announcement.
+
 config RPMSG_MTK_SCP
 	tristate "MediaTek SCP"
 	depends on MTK_SCP
diff --git a/drivers/rpmsg/Makefile b/drivers/rpmsg/Makefile
index ffe932ef6050..8d452656f0ee 100644
--- a/drivers/rpmsg/Makefile
+++ b/drivers/rpmsg/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_RPMSG)		+= rpmsg_core.o
 obj-$(CONFIG_RPMSG_CHAR)	+= rpmsg_char.o
+obj-$(CONFIG_RPMSG_NS)		+= rpmsg_ns.o
 obj-$(CONFIG_RPMSG_MTK_SCP)	+= mtk_rpmsg.o
 qcom_glink-objs			:= qcom_glink_native.o qcom_glink_ssr.o
 obj-$(CONFIG_RPMSG_QCOM_GLINK) += qcom_glink.o
diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
index 3ea9cec26fc0..04e6cb287e18 100644
--- a/drivers/rpmsg/rpmsg_internal.h
+++ b/drivers/rpmsg/rpmsg_internal.h
@@ -15,6 +15,7 @@
 #include <linux/idr.h>
 #include <linux/mutex.h>
 #include <linux/rpmsg.h>
+#include <linux/rpmsg_ns.h>
 #include <linux/types.h>
 #include <linux/virtio.h>
 #include <linux/wait.h>
@@ -164,4 +165,21 @@ static inline int rpmsg_chrdev_register_device(struct rpmsg_device *rpdev)
 	return rpmsg_register_device(rpdev);
 }
 
+/**
+ * rpmsg_ns_register_device() - register name service device based on rpdev
+ * @rpdev: prepared rpdev to be used for creating endpoints
+ *
+ * This function wraps rpmsg_register_device() preparing the rpdev for use as
+ * basis for the rpmsg name service device.
+ */
+static inline int rpmsg_ns_register_device(struct rpmsg_device *rpdev)
+{
+	strcpy(rpdev->id.name, "rpmsg_ns");
+	rpdev->driver_override = "rpmsg_ns";
+	rpdev->src = RPMSG_NS_ADDR;
+	rpdev->dst = RPMSG_NS_ADDR;
+
+	return rpmsg_register_device(rpdev);
+}
+
 #endif
diff --git a/drivers/rpmsg/rpmsg_ns.c b/drivers/rpmsg/rpmsg_ns.c
new file mode 100644
index 000000000000..b3318bf84433
--- /dev/null
+++ b/drivers/rpmsg/rpmsg_ns.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) STMicroelectronics 2020 - All Rights Reserved
+ */
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/rpmsg.h>
+#include <linux/rpmsg_ns.h>
+#include <linux/virtio_config.h>
+#include "rpmsg_internal.h"
+
+/* Invoked when a name service announcement arrives */
+static int rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
+		       void *priv, u32 src)
+{
+	struct rpmsg_ns_msg *msg = data;
+	struct rpmsg_device *newch;
+	struct rpmsg_channel_info chinfo;
+	struct virtio_rpmsg_channel *vch = to_virtio_rpmsg_channel(rpdev);
+	struct virtproc_info *vrp = vch->vrp;
+	struct device *dev = &vrp->vdev->dev;
+	int ret;
+
+#if defined(CONFIG_DYNAMIC_DEBUG)
+	dynamic_hex_dump("NS announcement: ", DUMP_PREFIX_NONE, 16, 1,
+			 data, len, true);
+#endif
+
+	if (len != sizeof(*msg)) {
+		dev_err(dev, "malformed ns msg (%d)\n", len);
+		return -EINVAL;
+	}
+
+	/* Don't trust the remote processor for null terminating the name */
+	msg->name[RPMSG_NAME_SIZE - 1] = '\0';
+
+	strncpy(chinfo.name, msg->name, sizeof(chinfo.name));
+	chinfo.src = RPMSG_ADDR_ANY;
+	chinfo.dst = virtio32_to_cpu(vrp->vdev, msg->addr);
+
+	dev_info(dev, "%sing channel %s addr 0x%x\n",
+		 virtio32_to_cpu(vrp->vdev, msg->flags) & RPMSG_NS_DESTROY ?
+		 "destroy" : "creat", msg->name, chinfo.dst);
+
+	if (virtio32_to_cpu(vrp->vdev, msg->flags) & RPMSG_NS_DESTROY) {
+		ret = rpmsg_release_channel(rpdev, &chinfo);
+		if (ret)
+			dev_err(dev, "rpmsg_destroy_channel failed: %d\n", ret);
+	} else {
+		newch = rpmsg_create_channel(rpdev, &chinfo);
+		if (!newch)
+			dev_err(dev, "rpmsg_create_channel failed\n");
+	}
+
+	return 0;
+}
+
+static int rpmsg_ns_probe(struct rpmsg_device *rpdev)
+{
+	struct rpmsg_channel_info ns_chinfo;
+	struct rpmsg_endpoint *ns_ept;
+
+	ns_chinfo.src = RPMSG_NS_ADDR;
+	ns_chinfo.dst = RPMSG_NS_ADDR;
+	strcpy(ns_chinfo.name, "name_service");
+
+	/*
+	 * Create the NS announcement service endpoint associated to the RPMsg
+	 * device. The endpoint will be automatically destroyed when the RPMsg
+	 * device will be deleted.
+	 */
+	ns_ept = rpmsg_create_ept(rpdev, rpmsg_ns_cb, NULL, ns_chinfo);
+	if (!ns_ept) {
+		dev_err(&rpdev->dev, "failed to create the ns ept\n");
+		return -ENOMEM;
+	}
+	rpdev->ept = ns_ept;
+
+	return 0;
+}
+
+static struct rpmsg_driver rpmsg_ns_driver = {
+	.drv.name = "rpmsg_ns",
+	.probe = rpmsg_ns_probe,
+};
+
+static int rpmsg_ns_init(void)
+{
+	int ret;
+
+	ret = register_rpmsg_driver(&rpmsg_ns_driver);
+	if (ret < 0)
+		pr_err("%s: Failed to register rpmsg driver\n", __func__);
+
+	return ret;
+}
+postcore_initcall(rpmsg_ns_init);
+
+static void rpmsg_ns_exit(void)
+{
+	unregister_rpmsg_driver(&rpmsg_ns_driver);
+}
+module_exit(rpmsg_ns_exit);
+
+MODULE_DESCRIPTION("Name service announcement rpmsg Driver");
+MODULE_AUTHOR("Arnaud Pouliquen <arnaud.pouliquen@st.com>");
+MODULE_ALIAS("rpmsg_ns");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

