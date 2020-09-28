Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C43127B209
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgI1QgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 12:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgI1Qfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:35:32 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A946C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:32 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id k13so1537891pfg.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IpatMEPJJ14BSXBClV0KrHKcOb/q5ewFCZIj8n6XC30=;
        b=mk7VkhZ15yLWQKbSUJd17gBGjqFDl7+pJSl0ixp9l0s58jU4SkHX492O7+H7CQsit4
         1aE4ILUzgnTL0Gl8kBAoeF6C2e2nyBxAbCtTOwn5ocbQgqJ/OE/AuJ0dwtEf6+NhiTQe
         MIuOHFyGTxpyHQ8l/bZXD4AGNL+rtQPVsQ29ofV13kM1tia8/X0f3nwtixtUtr/k6iuN
         zMXWj7xEn+7neK3z4uWhSycTB/Gt604ngXVgSDtxvRfXtjNhseNCcw6rGb1gKdYAGSvy
         kxncXHjnrx6Y0L8Y4o7OXTGtsZwmEuwOvlujIjs/q4jb2vE0Yneup3FXOtsfflHQfR6w
         azUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IpatMEPJJ14BSXBClV0KrHKcOb/q5ewFCZIj8n6XC30=;
        b=RH5vEKAxPxJk62CN2D8KtSzPZoigLH4vUXwpeoWonCogPa1tLVpDRmttUq9BLxHSjf
         Nvj02n5/KIZb2HJpUdibUf7tS/sna5sddT4ekQuuecK5rC2c8y2mhPexUaOk8UEM8ZyC
         f2bdVeJlxujWlwql6n6Fwd0dmf9k+yPZuh1ZmdKqlHWAw1ay+5lPHrgk9vfYUWztLgEw
         s50w8NBXz9i3SDiv1bHtzvpLta6NeGve+LOz3KkexpqwhUu8a6hHYE423ZfFD+dEI4Kq
         3s8WEzV74VV//qKOhyGfu5yjdsGM29D37aV+J3ZCChuTMzbdliw8wa0yJ1RNT2bx99zj
         0Kdw==
X-Gm-Message-State: AOAM531iZna7DBP6piWK/+eKDR/zHAUOialoeuLovSrhFrsK0GiWPYlG
        7uyu7qUOCzBEU1MTpPHaKo/pwxDpFVK8+w==
X-Google-Smtp-Source: ABdhPJzS7WIL651OcX+O+/eP89XDg3TG62Tvhki5Z9YwTzag0U0nhYGfmVnqnAMpokJGCyWpXC3DlQ==
X-Received: by 2002:a17:902:6bc1:b029:d0:cbe1:e73d with SMTP id m1-20020a1709026bc1b02900d0cbe1e73dmr375908plt.24.1601310932022;
        Mon, 28 Sep 2020 09:35:32 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id f19sm2345640pfd.45.2020.09.28.09.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 09:35:31 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 16/25] coresight: cti: Add function to register cti associate ops
Date:   Mon, 28 Sep 2020 10:35:04 -0600
Message-Id: <20200928163513.70169-17-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200928163513.70169-1-mathieu.poirier@linaro.org>
References: <20200928163513.70169-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tingwei Zhang <tingwei@codeaurora.org>

Add static cti_assoc_ops to coresight core driver. Let cti
driver register the add_assoc and remove_assoc call back.
Avoid coresight core driver to depend on cti driver.

Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Tested-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
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
2.25.1

