Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21EA72B829C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 18:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgKRRDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 12:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbgKRRDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 12:03:21 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1019C061A4F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 09:03:20 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a3so3379468wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 09:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/woKeC5KGNH7T/xAX1AxjALkVqvprR8gaAK4xA3oo5s=;
        b=Cwomn+wxk4TpP9Q1CovJ8LXgrq/XaZVqHwkTs9e7Z2XG4LL1ZV0Kg96ssuPfZh3SqJ
         8hObLgj8AAoBhJ4FEC4GOsShwySqBDt74C2VOoZ/QjgpJAjZejaCAbk7U1AXU7ma4kQH
         Rsfi+e855GEX30rE0v73w1djExqiYkNukF9x7s0+yg2CG7l2KXAOuM0rFhkOP0ZRrHng
         v3YVM2X96ucTKh57Za3qXcvbnRTg+IVPw6oGmkPA2P5Jx5fDMppED3eRR3DIS6G06xaY
         MaR2b+Ylcsz9WgIthC8vwt2I6CbTeupO3lZ3bwKtlldOHE01e4u1bnSXy9mwYhqXwqVu
         VVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/woKeC5KGNH7T/xAX1AxjALkVqvprR8gaAK4xA3oo5s=;
        b=C7ELbHeg9BYuw5nTBnR5w6H8XKyQHYMAfvswWIGnMjoUMJXuVICSlpBU7gmzwQhw+m
         KINDIPT3l/DOIwqi81PYHwe2izqv+PctpguGJpUdkP/vW2i7fwgs/2lQBWF9HzbbKFFT
         fYhtwRgBU/zfSuhbQ5JsxVqnfqbfAETPh73oiAgw+Ne3LmdPJmDUxyIYOwAwsPOmtmUJ
         Gdh6y8zOEcNZSVyQsj+MMRqZluFsbMEXI3C+gI6QQwghEJO5/XBM5Az3O0CicddZzLmB
         ITHVQ4DNFz+REbsIw6K9iAbxQ8wvuj8bVnUPwsWdRzF3i5RUcpHfjWKWTItA0PvINrus
         yg6Q==
X-Gm-Message-State: AOAM533x/+/+46lXkyRDKQKdfGrIcaILdlxQjKzZoo7mZVmlbs/aWqum
        KWcG65QyvtRfqXNksgwyo4J/yQ==
X-Google-Smtp-Source: ABdhPJxpYksQa3n/Yd7hzS4PjipFts8SYkUlPiPMNc5G3xr8yEGbze95pQFeIwLcQmIPZBYri1H/ow==
X-Received: by 2002:a05:600c:290a:: with SMTP id i10mr1035685wmd.187.1605718999252;
        Wed, 18 Nov 2020 09:03:19 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id x13sm44233wmi.20.2020.11.18.09.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 09:03:17 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     srinivas.kandagatla@linaro.org, srini@kernel.org
Cc:     bjorn.andersson@linaro.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 2/2] slimbus: qcom-ngd-ctrl: add Protection Domain Restart Support
Date:   Wed, 18 Nov 2020 17:02:46 +0000
Message-Id: <20201118170246.16588-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201118170246.16588-1-srinivas.kandagatla@linaro.org>
References: <20201118170246.16588-1-srinivas.kandagatla@linaro.org>
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
index 7c950948a9ec..060a2c65978a 100644
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
index f62693653d2b..d8decb345e9d 100644
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

