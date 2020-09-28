Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9E427B20F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgI1Qge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 12:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbgI1QfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:35:22 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6272C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:21 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 34so1296767pgo.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ez4LWIQoeyGf2VTxB83p0ifF8EHclgO0IOs2psbJ0hU=;
        b=SKEOX13/WnvoWJd9IhPVayw5UH+4LkiPWZmUtQ6QVkceYFlowc61HnDyhaQRfC7q3n
         IRHXvJFSsIcvH3PXoyFuESFdztXAPJRiYeXfNQ1i2FBnpu8Gh0/qaFykKcjuG7Iqk/FZ
         fHvXAu08YsGb0I0NNm3Of+Lme9zidVmtDbKyiOUj9yMWl3HweHjFxOX/kWuCSzL52/z0
         7C3v/6nImfrG/Q+DumpD+mFCMDCy5/z3mkvp37ryW2eBkTCihHw886rIoJJl3ps/UtA1
         RRXB/PB8Cag00NCjmpiP6iqpqs4u8e2GZowtzsKtYjzBJ/xiRcVAR9UtQUj9wPbUp8lr
         J4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ez4LWIQoeyGf2VTxB83p0ifF8EHclgO0IOs2psbJ0hU=;
        b=rsjKmjLYbNJ1aJzq5HP/Ff2wg+imyhBViAAfj5XdtVZaYHaU/LcPHPZDGd99Ho+VZi
         AauQ9X3y4tBTfbgiPHfg/H36HZMO8zGWV8ViSexAJ9jPREOMEcitNK0liiuJm0tVSJos
         QZtJqkAnIIbK4YtekXXHgpqOglk0Z24SSA0oyttOxMhiSTPx9z5UKrGibygleAAs3Pb7
         FCaWbElYAPDwajPSk4D/jWuRivHcZEmk3IEtcjF7lbyO4XgtFh7k9HkeZ5ScDRRXbeqo
         nnWydfmeolNEX5Tb4n/pNBYcheliDpUDLyxUhi5WRVQ3OmPoJD3RDONCHBF3CU6hYHKG
         tqUA==
X-Gm-Message-State: AOAM532Y1kKOvJ3kM3xD1Z7ANY+dBAsMKw+aWpBXmbdnOtxtqCVAVE6R
        0nOAR1EX5C+Q17JRygIOZ6698w==
X-Google-Smtp-Source: ABdhPJxPedhVcg8S3n31HR9Hw3o8M9RSKN43o1bmDzOqCJZmi4xgcBsE3zwzb6QqNCmsBvlq3TpT6g==
X-Received: by 2002:a62:cfc4:0:b029:142:440e:231d with SMTP id b187-20020a62cfc40000b0290142440e231dmr218346pfg.7.1601310921347;
        Mon, 28 Sep 2020 09:35:21 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id f19sm2345640pfd.45.2020.09.28.09.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 09:35:20 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/25] coresight: Add try_get_module() in coresight_grab_device()
Date:   Mon, 28 Sep 2020 10:34:54 -0600
Message-Id: <20200928163513.70169-7-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200928163513.70169-1-mathieu.poirier@linaro.org>
References: <20200928163513.70169-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tingwei Zhang <tingwei@codeaurora.org>

When coresight device is in an active session, driver module of
that device should not be removed. Use try_get_module() in
coresight_grab_device() to prevent module to be unloaded.
Use get_device()/put_device() to protect device data
in the middle of active session.

Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Tested-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight.c | 60 ++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index d1aea3a1e7b6..4faa4aa3964d 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -629,13 +629,45 @@ struct coresight_device *coresight_get_sink_by_id(u32 id)
 	return dev ? to_coresight_device(dev) : NULL;
 }
 
+/**
+ * coresight_get_ref- Helper function to increase reference count to module
+ * and device.
+ * Return true in successful case and power up the device.
+ * Return false when failed to get reference of module.
+ */
+static inline bool coresight_get_ref(struct coresight_device *csdev)
+{
+	struct device *dev = csdev->dev.parent;
+
+	/* Make sure the driver can't be removed */
+	if (!try_module_get(dev->driver->owner))
+		return false;
+	/* Make sure the device can't go away */
+	get_device(dev);
+	pm_runtime_get_sync(dev);
+	return true;
+}
+
+/**
+ * coresight_put_ref- Helper function to decrease reference count to module
+ * and device. Power off the device.
+ */
+static inline void coresight_put_ref(struct coresight_device *csdev)
+{
+	struct device *dev = csdev->dev.parent;
+
+	pm_runtime_put(dev);
+	put_device(dev);
+	module_put(dev->driver->owner);
+}
+
 /*
  * coresight_grab_device - Power up this device and any of the helper
  * devices connected to it for trace operation. Since the helper devices
  * don't appear on the trace path, they should be handled along with the
  * the master device.
  */
-static void coresight_grab_device(struct coresight_device *csdev)
+static int coresight_grab_device(struct coresight_device *csdev)
 {
 	int i;
 
@@ -644,9 +676,20 @@ static void coresight_grab_device(struct coresight_device *csdev)
 
 		child  = csdev->pdata->conns[i].child_dev;
 		if (child && child->type == CORESIGHT_DEV_TYPE_HELPER)
-			pm_runtime_get_sync(child->dev.parent);
+			if (!coresight_get_ref(child))
+				goto err;
+	}
+	if (coresight_get_ref(csdev))
+		return 0;
+err:
+	for (i--; i >= 0; i--) {
+		struct coresight_device *child;
+
+		child  = csdev->pdata->conns[i].child_dev;
+		if (child && child->type == CORESIGHT_DEV_TYPE_HELPER)
+			coresight_put_ref(child);
 	}
-	pm_runtime_get_sync(csdev->dev.parent);
+	return -ENODEV;
 }
 
 /*
@@ -657,13 +700,13 @@ static void coresight_drop_device(struct coresight_device *csdev)
 {
 	int i;
 
-	pm_runtime_put(csdev->dev.parent);
+	coresight_put_ref(csdev);
 	for (i = 0; i < csdev->pdata->nr_outport; i++) {
 		struct coresight_device *child;
 
 		child  = csdev->pdata->conns[i].child_dev;
 		if (child && child->type == CORESIGHT_DEV_TYPE_HELPER)
-			pm_runtime_put(child->dev.parent);
+			coresight_put_ref(child);
 	}
 }
 
@@ -682,7 +725,7 @@ static int _coresight_build_path(struct coresight_device *csdev,
 				 struct coresight_device *sink,
 				 struct list_head *path)
 {
-	int i;
+	int i, ret;
 	bool found = false;
 	struct coresight_node *node;
 
@@ -712,11 +755,14 @@ static int _coresight_build_path(struct coresight_device *csdev,
 	 * is tell the PM runtime core we need this element and add a node
 	 * for it.
 	 */
+	ret = coresight_grab_device(csdev);
+	if (ret)
+		return ret;
+
 	node = kzalloc(sizeof(struct coresight_node), GFP_KERNEL);
 	if (!node)
 		return -ENOMEM;
 
-	coresight_grab_device(csdev);
 	node->csdev = csdev;
 	list_add(&node->link, path);
 
-- 
2.25.1

