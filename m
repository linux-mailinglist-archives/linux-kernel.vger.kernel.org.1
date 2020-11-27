Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E609E2C6307
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 11:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbgK0KZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 05:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728315AbgK0KZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 05:25:14 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96FBC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 02:25:13 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id l1so5004731wrb.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 02:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JUU5D1MegB2iwczB9PRYaPxcUosO5rt/7hKyRUCQOqY=;
        b=imzt/KVy4KaI1cnJwr/tIwecUjzIv5aFVezIlce6VESlPlpeSgZbwpg3sYhDwTQg5/
         XGwMFYVfHle7pZ+geMfoRR5vtsXu57A9Lb10h8zNldv5aCP7T2rlY/25/ok5U8yiGo5A
         0tDGxIipE5mvjjUlYzuvRc0xxH49NKPFu4w5kxzGZCGVWE+qAEwJ+09XJQ+F3P3Ukal9
         RkU+8I749vczIjzVwpqXNIWDX4S5tGtfXwtqiVEH8eu+jQ9CdM35Gx/nEdiGZJ3AaQ19
         F2llaTOqJmSjV6srl5Nk1x37NDcWZV1c/5D7raSHHyGISKCwrxnfwYQr4Yk/W0l/lp6j
         Hdlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JUU5D1MegB2iwczB9PRYaPxcUosO5rt/7hKyRUCQOqY=;
        b=dXPYreY9OSuEryI51P8h9OJ8DGSm7vhu46wj+wlZtkWjfFyIcj1chaHoxm4/nm0hnO
         N6niaoQjGDyN81u6VsOr6y2nLW56TlNmXCn/wngpN4pBkhVCIg6EACRMYhHsRlXLE/tK
         GI888l79fS3BfBvWxIR0tGQMg3E89j27DM8nsnqE0zZTmH9S4RkxAItWGKzYDdJbS6lo
         fa0IBA5VwCjKjbK4Gfjl2mmxBY3trLQ2UPbxdrPdwTJLQ8uEpjfx2S2DEVEJVjf5NMS/
         XHVnzIfw1g3bgkaX1xfgUkspXsb+SyPxfAgXPajyoiBOgpfgD5dmBEp4sBEwhvYD4dWz
         Z+kg==
X-Gm-Message-State: AOAM5316yJwMwPbYeoXaasaRG03IN/J/Sw8bSpO17TEpASmc/Qyx5Sw7
        +8ZoqmkEQpA22M6VN6TLpsfJ3A==
X-Google-Smtp-Source: ABdhPJwtjK1K7uwo8fzE4rRVQ4b/vBgwmTk9Tez9ci74wJyHLh+Cwl89kz6YPX1KDbKotTPQz1bbXA==
X-Received: by 2002:a5d:570d:: with SMTP id a13mr9285414wrv.193.1606472712737;
        Fri, 27 Nov 2020 02:25:12 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id x4sm13942024wrv.81.2020.11.27.02.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 02:25:12 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/7] slimbus: qcom-ngd-ctrl: add Protection Domain Restart Support
Date:   Fri, 27 Nov 2020 10:24:47 +0000
Message-Id: <20201127102451.17114-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201127102451.17114-1-srinivas.kandagatla@linaro.org>
References: <20201127102451.17114-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to protection domain restart. Protection domain restart
would also restart the service just like SSR.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/Kconfig         |  1 +
 drivers/slimbus/qcom-ngd-ctrl.c | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/slimbus/Kconfig b/drivers/slimbus/Kconfig
index 02534ce86e46..7d59956b5dfb 100644
--- a/drivers/slimbus/Kconfig
+++ b/drivers/slimbus/Kconfig
@@ -26,6 +26,7 @@ config SLIM_QCOM_NGD_CTRL
 	depends on ARCH_QCOM || COMPILE_TEST
 	select QCOM_QMI_HELPERS
 	select QCOM_RPROC_COMMON
+	select QCOM_PDR_HELPERS
 	help
 	  Select driver if Qualcomm's SLIMbus Satellite Non-Generic Device
 	  Component is programmed using Linux kernel.
diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index d32e6b37514d..943d55a0bc59 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -19,6 +19,7 @@
 #include <linux/of.h>
 #include <linux/io.h>
 #include <linux/soc/qcom/qmi.h>
+#include <linux/soc/qcom/pdr.h>
 #include <net/sock.h>
 #include "slimbus.h"
 
@@ -166,6 +167,7 @@ struct qcom_slim_ngd_ctrl {
 	struct mutex ssr_lock;
 	struct notifier_block nb;
 	void *notifier;
+	struct pdr_handle *pdr;
 	enum qcom_slim_ngd_state state;
 	dma_addr_t rx_phys_base;
 	dma_addr_t tx_phys_base;
@@ -1382,6 +1384,7 @@ static int qcom_slim_ngd_ssr_pdr_notify(struct qcom_slim_ngd_ctrl *ctrl,
 {
 	switch (action) {
 	case QCOM_SSR_BEFORE_SHUTDOWN:
+	case SERVREG_SERVICE_STATE_DOWN:
 		/* Make sure the last dma xfer is finished */
 		mutex_lock(&ctrl->tx_lock);
 		if (ctrl->state != QCOM_SLIM_NGD_CTRL_DOWN) {
@@ -1393,6 +1396,7 @@ static int qcom_slim_ngd_ssr_pdr_notify(struct qcom_slim_ngd_ctrl *ctrl,
 		mutex_unlock(&ctrl->tx_lock);
 		break;
 	case QCOM_SSR_AFTER_POWERUP:
+	case SERVREG_SERVICE_STATE_UP:
 		schedule_work(&ctrl->ngd_up_work);
 		break;
 	default:
@@ -1412,6 +1416,12 @@ static int qcom_slim_ngd_ssr_notify(struct notifier_block *nb,
 	return qcom_slim_ngd_ssr_pdr_notify(ctrl, action);
 }
 
+static void slim_pd_status(int state, char *svc_path, void *priv)
+{
+	struct qcom_slim_ngd_ctrl *ctrl = (struct qcom_slim_ngd_ctrl *)priv;
+
+	qcom_slim_ngd_ssr_pdr_notify(ctrl, state);
+}
 static int of_qcom_slim_ngd_register(struct device *parent,
 				     struct qcom_slim_ngd_ctrl *ctrl)
 {
@@ -1499,6 +1509,7 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 	struct qcom_slim_ngd_ctrl *ctrl;
 	struct resource *res;
 	int ret;
+	struct pdr_service *pds;
 
 	ctrl = devm_kzalloc(dev, sizeof(*ctrl), GFP_KERNEL);
 	if (!ctrl)
@@ -1549,6 +1560,18 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 	init_completion(&ctrl->qmi.qmi_comp);
 	init_completion(&ctrl->qmi_up);
 
+	ctrl->pdr = pdr_handle_alloc(slim_pd_status, ctrl);
+	if (IS_ERR(ctrl->pdr)) {
+		dev_err(dev, "Failed to init PDR handle\n");
+		return PTR_ERR(ctrl->pdr);
+	}
+
+	pds = pdr_add_lookup(ctrl->pdr, "avs/audio", "msm/adsp/audio_pd");
+	if (IS_ERR(pds) && PTR_ERR(pds) != -EALREADY) {
+		dev_err(dev, "pdr add lookup failed: %d\n", ret);
+		return PTR_ERR(pds);
+	}
+
 	platform_driver_register(&qcom_slim_ngd_driver);
 	return of_qcom_slim_ngd_register(dev, ctrl);
 }
@@ -1565,6 +1588,7 @@ static int qcom_slim_ngd_remove(struct platform_device *pdev)
 	struct qcom_slim_ngd_ctrl *ctrl = platform_get_drvdata(pdev);
 
 	pm_runtime_disable(&pdev->dev);
+	pdr_handle_release(ctrl->pdr);
 	qcom_unregister_ssr_notifier(ctrl->notifier, &ctrl->nb);
 	qcom_slim_ngd_enable(ctrl, false);
 	qcom_slim_ngd_exit_dma(ctrl);
-- 
2.21.0

