Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8122C6308
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 11:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbgK0KZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 05:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbgK0KZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 05:25:14 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BC8C0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 02:25:13 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id r3so5038347wrt.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 02:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q9x+pZSTU0zGm8ir1yf0ufNI+zfqSbLQaoIoIGyHUGs=;
        b=YstC06miUXS6OW6gNsjVnX8Ngl7o8dOqr1vUz5DB8F4ya/ad3PUOzwX4fgMQ1oRtz+
         rgBmWLA79pqmWbfw3ZjL7Tq4WiW7CTLBf+9LbGsXdmi25bdsm+4BHa2WPIJKytp2KRAb
         Xn/PUaKoAyGVl7amk5HYhgZw03RAqIUTrCVxquiuLDJbXLu3BlHUYmUscCZQ0A6Y4OaD
         2N+wbU8LXzdRrMVbAps4ZvSVUlcUNUxnQlBx2ZlQv4jyb/QVtQxODpFgUmo65ZRZ/uVP
         qgfboTw5iVaieV6dvKlS/+3rV8OkT60hk//Jp4J/ErPbPfYwm8AV7Hc5zofT2E5Muqa9
         eG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q9x+pZSTU0zGm8ir1yf0ufNI+zfqSbLQaoIoIGyHUGs=;
        b=HxzCALp2gnJWZq7UPjnjn8kajokT6STs/ybvrbRpFr51zcbruiYjHxVUTOQvrPU1lH
         R1em6ra6G9DTVvdTh7l0Ngy15kBD7YkZyUxojgjeXe+xyFitOsVxusi27ZlmHLoBl6cI
         bjo/OvvKrJ1zF4qE4Mi6/zIseZLmQO1wkUSq7xSdjPWcXYf/U1K43cE6Yh2RKhTvvdba
         ZNY2X5BXue5ntIDwYOA+F3uT+MdTDkqd6ErJf3hXVH71Q7Fdjbcj8yp3xDWcRf/UlWHW
         5vMIXFjvUS7w9Fie1gNB4PdWoPXh7Sw7DE1Tla4QaaRTETYrhkKiZxfeJozS7/4EbITB
         woog==
X-Gm-Message-State: AOAM533Vg9WkTYTY32ZhcXFLoCiNQKHGmkK8L4QPyVEgWk6I5DSv8Lch
        EvFvFU+vPrnMVH3UzETxblAu3A==
X-Google-Smtp-Source: ABdhPJxZYZptdbecVhJPslznfPBQ1pRtz0M0N9r6XpPiJgw4A9AmPRsveE2/wlTLh8QHnUJVazLQtQ==
X-Received: by 2002:a5d:4585:: with SMTP id p5mr9486516wrq.65.1606472711745;
        Fri, 27 Nov 2020 02:25:11 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id x4sm13942024wrv.81.2020.11.27.02.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 02:25:11 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/7] slimbus: qcom-ngd-ctrl: add Sub System Restart support
Date:   Fri, 27 Nov 2020 10:24:46 +0000
Message-Id: <20201127102451.17114-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201127102451.17114-1-srinivas.kandagatla@linaro.org>
References: <20201127102451.17114-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds SSR(SubSystem Restart) support which includes, synchronisation
between SSR and QMI server notifications. Also with this patch now NGD is taken
down by SSR instead of QMI server down notification.

NGD up path now relies on both SSR and QMI notifications and particularly
sequence of SSR up followed by QMI server up notification.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/Kconfig         |  3 +-
 drivers/slimbus/qcom-ngd-ctrl.c | 97 +++++++++++++++++++++++++++++++--
 2 files changed, 95 insertions(+), 5 deletions(-)

diff --git a/drivers/slimbus/Kconfig b/drivers/slimbus/Kconfig
index 8cd595148d17..02534ce86e46 100644
--- a/drivers/slimbus/Kconfig
+++ b/drivers/slimbus/Kconfig
@@ -22,9 +22,10 @@ config SLIM_QCOM_CTRL
 
 config SLIM_QCOM_NGD_CTRL
 	tristate "Qualcomm SLIMbus Satellite Non-Generic Device Component"
-	depends on HAS_IOMEM && DMA_ENGINE && NET
+	depends on HAS_IOMEM && DMA_ENGINE && NET && REMOTEPROC
 	depends on ARCH_QCOM || COMPILE_TEST
 	select QCOM_QMI_HELPERS
+	select QCOM_RPROC_COMMON
 	help
 	  Select driver if Qualcomm's SLIMbus Satellite Non-Generic Device
 	  Component is programmed using Linux kernel.
diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 218aefc3531c..d32e6b37514d 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -13,6 +13,9 @@
 #include <linux/slimbus.h>
 #include <linux/delay.h>
 #include <linux/pm_runtime.h>
+#include <linux/mutex.h>
+#include <linux/notifier.h>
+#include <linux/remoteproc/qcom_rproc.h>
 #include <linux/of.h>
 #include <linux/io.h>
 #include <linux/soc/qcom/qmi.h>
@@ -155,8 +158,14 @@ struct qcom_slim_ngd_ctrl {
 	struct qcom_slim_ngd_dma_desc txdesc[QCOM_SLIM_NGD_DESC_NUM];
 	struct completion reconf;
 	struct work_struct m_work;
+	struct work_struct ngd_up_work;
 	struct workqueue_struct *mwq;
+	struct completion qmi_up;
 	spinlock_t tx_buf_lock;
+	struct mutex tx_lock;
+	struct mutex ssr_lock;
+	struct notifier_block nb;
+	void *notifier;
 	enum qcom_slim_ngd_state state;
 	dma_addr_t rx_phys_base;
 	dma_addr_t tx_phys_base;
@@ -868,14 +877,18 @@ static int qcom_slim_ngd_xfer_msg(struct slim_controller *sctrl,
 	if (txn->msg && txn->msg->wbuf)
 		memcpy(puc, txn->msg->wbuf, txn->msg->num_bytes);
 
+	mutex_lock(&ctrl->tx_lock);
 	ret = qcom_slim_ngd_tx_msg_post(ctrl, pbuf, txn->rl);
-	if (ret)
+	if (ret) {
+		mutex_unlock(&ctrl->tx_lock);
 		return ret;
+	}
 
 	timeout = wait_for_completion_timeout(&tx_sent, HZ);
 	if (!timeout) {
 		dev_err(sctrl->dev, "TX timed out:MC:0x%x,mt:0x%x", txn->mc,
 					txn->mt);
+		mutex_unlock(&ctrl->tx_lock);
 		return -ETIMEDOUT;
 	}
 
@@ -884,10 +897,12 @@ static int qcom_slim_ngd_xfer_msg(struct slim_controller *sctrl,
 		if (!timeout) {
 			dev_err(sctrl->dev, "TX timed out:MC:0x%x,mt:0x%x",
 				txn->mc, txn->mt);
+			mutex_unlock(&ctrl->tx_lock);
 			return -ETIMEDOUT;
 		}
 	}
 
+	mutex_unlock(&ctrl->tx_lock);
 	return 0;
 }
 
@@ -1200,6 +1215,13 @@ static void qcom_slim_ngd_master_worker(struct work_struct *work)
 	}
 }
 
+static int qcom_slim_ngd_update_device_status(struct device *dev, void *null)
+{
+	slim_report_absent(to_slim_device(dev));
+
+	return 0;
+}
+
 static int qcom_slim_ngd_runtime_resume(struct device *dev)
 {
 	struct qcom_slim_ngd_ctrl *ctrl = dev_get_drvdata(dev);
@@ -1267,7 +1289,7 @@ static int qcom_slim_ngd_qmi_new_server(struct qmi_handle *hdl,
 	qmi->svc_info.sq_node = service->node;
 	qmi->svc_info.sq_port = service->port;
 
-	qcom_slim_ngd_enable(ctrl, true);
+	complete(&ctrl->qmi_up);
 
 	return 0;
 }
@@ -1280,10 +1302,9 @@ static void qcom_slim_ngd_qmi_del_server(struct qmi_handle *hdl,
 	struct qcom_slim_ngd_ctrl *ctrl =
 		container_of(qmi, struct qcom_slim_ngd_ctrl, qmi);
 
+	reinit_completion(&ctrl->qmi_up);
 	qmi->svc_info.sq_node = 0;
 	qmi->svc_info.sq_port = 0;
-
-	qcom_slim_ngd_enable(ctrl, false);
 }
 
 static struct qmi_ops qcom_slim_ngd_qmi_svc_event_ops = {
@@ -1333,6 +1354,64 @@ static const struct of_device_id qcom_slim_ngd_dt_match[] = {
 
 MODULE_DEVICE_TABLE(of, qcom_slim_ngd_dt_match);
 
+static void qcom_slim_ngd_down(struct qcom_slim_ngd_ctrl *ctrl)
+{
+	mutex_lock(&ctrl->ssr_lock);
+	device_for_each_child(ctrl->ctrl.dev, NULL,
+			      qcom_slim_ngd_update_device_status);
+	qcom_slim_ngd_enable(ctrl, false);
+	mutex_unlock(&ctrl->ssr_lock);
+}
+
+static void qcom_slim_ngd_up_worker(struct work_struct *work)
+{
+	struct qcom_slim_ngd_ctrl *ctrl;
+
+	ctrl = container_of(work, struct qcom_slim_ngd_ctrl, ngd_up_work);
+
+	/* Make sure qmi service is up before continuing */
+	wait_for_completion_interruptible(&ctrl->qmi_up);
+
+	mutex_lock(&ctrl->ssr_lock);
+	qcom_slim_ngd_enable(ctrl, true);
+	mutex_unlock(&ctrl->ssr_lock);
+}
+
+static int qcom_slim_ngd_ssr_pdr_notify(struct qcom_slim_ngd_ctrl *ctrl,
+					unsigned long action)
+{
+	switch (action) {
+	case QCOM_SSR_BEFORE_SHUTDOWN:
+		/* Make sure the last dma xfer is finished */
+		mutex_lock(&ctrl->tx_lock);
+		if (ctrl->state != QCOM_SLIM_NGD_CTRL_DOWN) {
+			pm_runtime_get_noresume(ctrl->dev);
+			ctrl->state = QCOM_SLIM_NGD_CTRL_DOWN;
+			qcom_slim_ngd_down(ctrl);
+			qcom_slim_ngd_exit_dma(ctrl);
+		}
+		mutex_unlock(&ctrl->tx_lock);
+		break;
+	case QCOM_SSR_AFTER_POWERUP:
+		schedule_work(&ctrl->ngd_up_work);
+		break;
+	default:
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static int qcom_slim_ngd_ssr_notify(struct notifier_block *nb,
+				    unsigned long action,
+				    void *data)
+{
+	struct qcom_slim_ngd_ctrl *ctrl = container_of(nb,
+					       struct qcom_slim_ngd_ctrl, nb);
+
+	return qcom_slim_ngd_ssr_pdr_notify(ctrl, action);
+}
+
 static int of_qcom_slim_ngd_register(struct device *parent,
 				     struct qcom_slim_ngd_ctrl *ctrl)
 {
@@ -1397,6 +1476,7 @@ static int qcom_slim_ngd_probe(struct platform_device *pdev)
 	}
 
 	INIT_WORK(&ctrl->m_work, qcom_slim_ngd_master_worker);
+	INIT_WORK(&ctrl->ngd_up_work, qcom_slim_ngd_up_worker);
 	ctrl->mwq = create_singlethread_workqueue("ngd_master");
 	if (!ctrl->mwq) {
 		dev_err(&pdev->dev, "Failed to start master worker\n");
@@ -1444,6 +1524,11 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ctrl->nb.notifier_call = qcom_slim_ngd_ssr_notify;
+	ctrl->notifier = qcom_register_ssr_notifier("lpass", &ctrl->nb);
+	if (IS_ERR(ctrl->notifier))
+		return PTR_ERR(ctrl->notifier);
+
 	ctrl->dev = dev;
 	ctrl->framer.rootfreq = SLIM_ROOT_FREQ >> 3;
 	ctrl->framer.superfreq =
@@ -1457,9 +1542,12 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 	ctrl->ctrl.wakeup = NULL;
 	ctrl->state = QCOM_SLIM_NGD_CTRL_DOWN;
 
+	mutex_init(&ctrl->tx_lock);
+	mutex_init(&ctrl->ssr_lock);
 	spin_lock_init(&ctrl->tx_buf_lock);
 	init_completion(&ctrl->reconf);
 	init_completion(&ctrl->qmi.qmi_comp);
+	init_completion(&ctrl->qmi_up);
 
 	platform_driver_register(&qcom_slim_ngd_driver);
 	return of_qcom_slim_ngd_register(dev, ctrl);
@@ -1477,6 +1565,7 @@ static int qcom_slim_ngd_remove(struct platform_device *pdev)
 	struct qcom_slim_ngd_ctrl *ctrl = platform_get_drvdata(pdev);
 
 	pm_runtime_disable(&pdev->dev);
+	qcom_unregister_ssr_notifier(ctrl->notifier, &ctrl->nb);
 	qcom_slim_ngd_enable(ctrl, false);
 	qcom_slim_ngd_exit_dma(ctrl);
 	qcom_slim_ngd_qmi_svc_event_deinit(&ctrl->qmi);
-- 
2.21.0

