Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF3126A35E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 12:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgIOKnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 06:43:04 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:61760 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726357AbgIOKm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 06:42:29 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600166548; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=okazmhXZpoupNz1FvPJOTzYNXrNAHsOdniGfyvBHuSg=; b=uNTAtLwRcRSxeLIulLCaHaPvZhbT+MVXd14es7wS+ccV2iak6OrU6fksbGz7gjitpWy77HFM
 /D7zyB00G0+a5q02S/6tOiR5EmCc5080V5A5wCbWq9xv+4TTucJhAkm/5alBcdFsrR2wnuZO
 mgy95o65wMSzUqHPmzjjW2TG5ok=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5f609a929bdf68cc035a255c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Sep 2020 10:42:26
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 23A33C433F1; Tue, 15 Sep 2020 10:42:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tingweiz-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 77B5DC43395;
        Tue, 15 Sep 2020 10:42:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 77B5DC43395
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=tingwei@codeaurora.org
From:   Tingwei Zhang <tingwei@codeaurora.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>
Cc:     Tingwei Zhang <tingwei@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leo Yan <leo.yan@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Kim Phillips <kim.phillips@arm.com>,
        Mian Yousaf Kaukab <ykaukab@suse.de>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v11 06/24] coresight: add try_get_module() in coresight_grab_device()
Date:   Tue, 15 Sep 2020 18:40:58 +0800
Message-Id: <20200915104116.16789-7-tingwei@codeaurora.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20200915104116.16789-1-tingwei@codeaurora.org>
References: <20200915104116.16789-1-tingwei@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When coresight device is in an active session, driver module of
that device should not be removed. Use try_get_module() in
coresight_grab_device() to prevent module to be unloaded.
Use get_device()/put_device() to protect device data
in the middle of active session.

Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Tested-by: Mike Leach <mike.leach@linaro.org>
Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
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
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

