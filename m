Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1EE26A39C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 12:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgIOKuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 06:50:50 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:13202 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726290AbgIOKno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 06:43:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600166623; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=HUVHYi+gpgmemciLzKjuXqFBb5jZeT5vLoGGTbkyiDk=; b=dPoF6dmtCILDeqmTr0YNIe+BcA4CwN1VaXz7nmkY2iV//fNME7EYoZVzw1362HkesGvh4Fj+
 zh7V6RQcOTWPRC7q045sfOF2ztWXgX9TVKb3zLrN6xeLegjsyGuTPgEwk5SzqToIdgr/IxUq
 FkPJRe/kvfbxVNw/xAXzOBYXFWE=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f609ac1698ee477d157fcd0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Sep 2020 10:43:13
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B2435C43382; Tue, 15 Sep 2020 10:43:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tingweiz-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D5625C433C8;
        Tue, 15 Sep 2020 10:43:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D5625C433C8
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
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH v11 16/24] coresight: cti: add function to register cti associate ops
Date:   Tue, 15 Sep 2020 18:41:08 +0800
Message-Id: <20200915104116.16789-17-tingwei@codeaurora.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20200915104116.16789-1-tingwei@codeaurora.org>
References: <20200915104116.16789-1-tingwei@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add static cti_assoc_ops to coresight core driver. Let cti
driver register the add_assoc and remove_assoc call back.
Avoid coresight core driver to depend on cti driver.

Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Tested-by: Mike Leach <mike.leach@linaro.org>
Reported-by: kernel test robot <lkp@intel.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-cti.c  | 36 +++++++++++++++++---
 drivers/hwtracing/coresight/coresight-priv.h | 14 ++++----
 drivers/hwtracing/coresight/coresight.c      | 21 ++++++++++--
 3 files changed, 55 insertions(+), 16 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-cti.c b/drivers/hwtracing/coresight/coresight-cti.c
index 47f3c9abae30..5003d1f59af0 100644
--- a/drivers/hwtracing/coresight/coresight-cti.c
+++ b/drivers/hwtracing/coresight/coresight-cti.c
@@ -539,7 +539,7 @@ cti_match_fixup_csdev(struct cti_device *ctidev, const char *node_name,
  * This will set the association if CTI declared before the CS device.
  * (called from coresight_register() with coresight_mutex locked).
  */
-void cti_add_assoc_to_csdev(struct coresight_device *csdev)
+static void cti_add_assoc_to_csdev(struct coresight_device *csdev)
 {
 	struct cti_drvdata *ect_item;
 	struct cti_device *ctidev;
@@ -572,13 +572,12 @@ void cti_add_assoc_to_csdev(struct coresight_device *csdev)
 cti_add_done:
 	mutex_unlock(&ect_mutex);
 }
-EXPORT_SYMBOL_GPL(cti_add_assoc_to_csdev);
 
 /*
  * Removing the associated devices is easier.
  * A CTI will not have a value for csdev->ect_dev.
  */
-void cti_remove_assoc_from_csdev(struct coresight_device *csdev)
+static void cti_remove_assoc_from_csdev(struct coresight_device *csdev)
 {
 	struct cti_drvdata *ctidrv;
 	struct cti_trig_con *tc;
@@ -599,7 +598,15 @@ void cti_remove_assoc_from_csdev(struct coresight_device *csdev)
 	}
 	mutex_unlock(&ect_mutex);
 }
-EXPORT_SYMBOL_GPL(cti_remove_assoc_from_csdev);
+
+/*
+ * Operations to add and remove associated CTI.
+ * Register to coresight core driver as call back function.
+ */
+static struct cti_assoc_op cti_assoc_ops = {
+	.add = cti_add_assoc_to_csdev,
+	.remove = cti_remove_assoc_from_csdev
+};
 
 /*
  * Update the cross references where the associated device was found
@@ -956,4 +963,23 @@ static struct amba_driver cti_driver = {
 	.probe		= cti_probe,
 	.id_table	= cti_ids,
 };
-builtin_amba_driver(cti_driver);
+
+static int __init cti_init(void)
+{
+	int ret;
+
+	ret = amba_driver_register(&cti_driver);
+	if (ret)
+		pr_info("Error registering cti driver\n");
+	coresight_set_cti_ops(&cti_assoc_ops);
+	return ret;
+}
+
+static void __exit cti_exit(void)
+{
+	coresight_remove_cti_ops();
+	amba_driver_unregister(&cti_driver);
+}
+
+module_init(cti_init);
+module_exit(cti_exit);
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index d638c7d48815..65a29293b6cb 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -173,15 +173,13 @@ static inline int etm_readl_cp14(u32 off, unsigned int *val) { return 0; }
 static inline int etm_writel_cp14(u32 off, u32 val) { return 0; }
 #endif
 
-#ifdef CONFIG_CORESIGHT_CTI
-extern void cti_add_assoc_to_csdev(struct coresight_device *csdev);
-extern void cti_remove_assoc_from_csdev(struct coresight_device *csdev);
+struct cti_assoc_op {
+	void (*add)(struct coresight_device *csdev);
+	void (*remove)(struct coresight_device *csdev);
+};
 
-#else
-static inline void cti_add_assoc_to_csdev(struct coresight_device *csdev) {}
-static inline void
-cti_remove_assoc_from_csdev(struct coresight_device *csdev) {}
-#endif
+extern void coresight_set_cti_ops(const struct cti_assoc_op *cti_op);
+extern void coresight_remove_cti_ops(void);
 
 /*
  * Macros and inline functions to handle CoreSight UCI data and driver
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 4faa4aa3964d..4f4485b17458 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -56,6 +56,20 @@ static struct list_head *stm_path;
 const u32 coresight_barrier_pkt[4] = {0x7fffffff, 0x7fffffff, 0x7fffffff, 0x7fffffff};
 EXPORT_SYMBOL_GPL(coresight_barrier_pkt);
 
+static const struct cti_assoc_op *cti_assoc_ops;
+
+void coresight_set_cti_ops(const struct cti_assoc_op *cti_op)
+{
+	cti_assoc_ops = cti_op;
+}
+EXPORT_SYMBOL_GPL(coresight_set_cti_ops);
+
+void coresight_remove_cti_ops(void)
+{
+	cti_assoc_ops = NULL;
+}
+EXPORT_SYMBOL_GPL(coresight_remove_cti_ops);
+
 static int coresight_id_match(struct device *dev, void *data)
 {
 	int trace_id, i_trace_id;
@@ -1232,7 +1246,8 @@ static void coresight_device_release(struct device *dev)
 {
 	struct coresight_device *csdev = to_coresight_device(dev);
 
-	cti_remove_assoc_from_csdev(csdev);
+	if (cti_assoc_ops && cti_assoc_ops->remove)
+		cti_assoc_ops->remove(csdev);
 	fwnode_handle_put(csdev->dev.fwnode);
 	kfree(csdev->refcnt);
 	kfree(csdev);
@@ -1543,8 +1558,8 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 		ret = coresight_fixup_device_conns(csdev);
 	if (!ret)
 		ret = coresight_fixup_orphan_conns(csdev);
-	if (!ret)
-		cti_add_assoc_to_csdev(csdev);
+	if (!ret && cti_assoc_ops && cti_assoc_ops->add)
+		cti_assoc_ops->add(csdev);
 
 	mutex_unlock(&coresight_mutex);
 	if (ret) {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

