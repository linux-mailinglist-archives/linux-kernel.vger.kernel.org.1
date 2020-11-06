Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBE42A8CDE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 03:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgKFC3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 21:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbgKFC3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 21:29:06 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21C4C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 18:29:05 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id x13so2776598pgp.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 18:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KajwE7NQHwPX6nIqBjcpKBx27sqE+z/FNufzUGqDdjM=;
        b=toXw6JmedkNveiSeA0TM382Tr6tgE2iFDbQWQVozLHz7ZPowi2D/WURBaeehSY9OdA
         cqygKpJe/a1Pz/xdMpM2pHMq7Z1+Cf6H1jzYC60zYsUZ7HhM7en3EoQDQaPoza4ONYtI
         2Pc+jLmUEKpIH6NjKQRl0AsSywqqtYjrjWnL/kCjmhdaDwleqMqZuSsB0YDjTT8MHPtv
         BKsLkCMJ/J7+UmnbD7kb/i3MeWCrPRNKm4ggAgi97WOSmlrLO18oS2EnIBoMVcVCXphI
         RKHKFRR5gYslYqMQZuq7+/W5w7aYKrJAvoIDuC09Fdhkbyd2kaQtqa19H+bb6aKKzy61
         WOag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KajwE7NQHwPX6nIqBjcpKBx27sqE+z/FNufzUGqDdjM=;
        b=T9XmJyQXMnlpbKyc+N7NJ0anHtpX7JGhB9axd6oEPo/VJeyUZltmeOlwvJFatck1Z7
         S1qQZC+BRdFDCK73Qf7Ty22zZaVZ+wUFKf8Ma9hhBMF/F9N06+97mY0JX97MU9ycuN+X
         /RbmBGgFFaHLs3wiI0J/TWSEFZO1oKlkEkgPtpkSWTEEE3CO53BKZj26fM5oYuXVpbCY
         OieekQN6JnQYlYamqsLmr+2Bfq2UNcymseWMY3peZKJYPV06IrXeBeGjP29PRPy7V9zW
         bOHO1jEzmsw7W7M5ZbEg1C1p8ZnPb2O7qHC8Hp4sdq5K0uxzzPlqPbFEMIzL1pik643a
         lTtQ==
X-Gm-Message-State: AOAM5319swwNBvaw60b4e8ycET3ynOqO+j+2QGsWYg/T5hZ6avS67Kp7
        x7/Oy28krUKYX8+yt+u3fyAzSA==
X-Google-Smtp-Source: ABdhPJzNd3OOXa65FSrXcmJwq+rpP2BQ9Rr7XBAhoBDGGf/V9wGhEw5iV+pCSKPocj/xVwB1WZKMBw==
X-Received: by 2002:a62:834a:0:b029:18a:e0b1:f0d9 with SMTP id h71-20020a62834a0000b029018ae0b1f0d9mr5389784pfe.73.1604629745059;
        Thu, 05 Nov 2020 18:29:05 -0800 (PST)
Received: from localhost.localdomain (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id m13sm3703040pjr.30.2020.11.05.18.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 18:29:04 -0800 (PST)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.1 22/27] mmc: sdhci-uhs2: add add_host() and others to set up the driver
Date:   Fri,  6 Nov 2020 11:27:21 +0900
Message-Id: <20201106022726.19831-23-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106022726.19831-1-takahiro.akashi@linaro.org>
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a UHS-II version of sdhci's add_host/remove_host operation.
Any sdhci drivers which are capable of handling UHS-II cards must
call those functions instead of the corresponding sdhci's.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/sdhci-uhs2.c | 198 ++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h |   2 +
 drivers/mmc/host/sdhci.c      |  24 +++--
 drivers/mmc/host/sdhci.h      |  10 ++
 4 files changed, 226 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index d50134e912f3..5d3362ea138f 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -15,6 +15,7 @@
 #include <linux/ktime.h>
 #include <linux/module.h>
 #include <linux/mmc/mmc.h>
+#include <linux/regulator/consumer.h>
 
 #include "sdhci.h"
 #include "sdhci-uhs2.h"
@@ -406,6 +407,15 @@ static inline void sdhci_led_deactivate(struct sdhci_host *host)
 {
 }
 #else
+static inline int sdhci_led_register(struct sdhci_host *host)
+{
+	return 0;
+}
+
+static inline void sdhci_led_unregister(struct sdhci_host *host)
+{
+}
+
 static inline void sdhci_led_activate(struct sdhci_host *host)
 {
 	__sdhci_led_activate(host);
@@ -1298,6 +1308,194 @@ static irqreturn_t sdhci_uhs2_thread_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+/*****************************************************************************\
+ *
+ * Device allocation/registration                                            *
+ *                                                                           *
+\*****************************************************************************/
+
+static int __sdhci_uhs2_add_host_v4(struct sdhci_host *host, u32 caps1)
+{
+	struct mmc_host *mmc;
+	u32 max_current_caps2;
+
+	if (host->version < SDHCI_SPEC_400)
+		return 0;
+
+	mmc = host->mmc;
+
+	/* Support UHS2 */
+	if (caps1 & SDHCI_SUPPORT_UHS2)
+		mmc->caps |= MMC_CAP_UHS2;
+
+	max_current_caps2 = sdhci_readl(host, SDHCI_MAX_CURRENT_1);
+
+	if ((caps1 & SDHCI_SUPPORT_VDD2_180) &&
+	    !max_current_caps2 &&
+	    !IS_ERR(mmc->supply.vmmc2)) {
+		/* UHS2 - VDD2 */
+		int curr = regulator_get_current_limit(mmc->supply.vmmc2);
+
+		if (curr > 0) {
+			/* convert to SDHCI_MAX_CURRENT format */
+			curr = curr / 1000;  /* convert to mA */
+			curr = curr / SDHCI_MAX_CURRENT_MULTIPLIER;
+			curr = min_t(u32, curr, SDHCI_MAX_CURRENT_LIMIT);
+			max_current_caps2 = curr;
+		}
+	}
+
+	if (caps1 & SDHCI_SUPPORT_VDD2_180) {
+		mmc->ocr_avail_uhs2 |= MMC_VDD2_165_195;
+		/*
+		 * UHS2 doesn't require this. Only UHS-I bus needs to set
+		 * max current.
+		 */
+		mmc->max_current_180_vdd2 = (max_current_caps2 &
+					SDHCI_MAX_CURRENT_VDD2_180_MASK) *
+					SDHCI_MAX_CURRENT_MULTIPLIER;
+	} else {
+		mmc->caps &= ~MMC_CAP_UHS2;
+	}
+
+	return 0;
+}
+
+static int sdhci_uhs2_host_ops_init(struct sdhci_host *host);
+
+static int __sdhci_uhs2_add_host(struct sdhci_host *host)
+{
+	unsigned int flags = WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_HIGHPRI;
+	struct mmc_host *mmc = host->mmc;
+	int ret;
+
+	if ((mmc->caps2 & MMC_CAP2_CQE) &&
+	    (host->quirks & SDHCI_QUIRK_BROKEN_CQE)) {
+		mmc->caps2 &= ~MMC_CAP2_CQE;
+		mmc->cqe_ops = NULL;
+	}
+
+	/* overwrite ops */
+	if (mmc->caps & MMC_CAP_UHS2)
+		sdhci_uhs2_host_ops_init(host);
+
+	host->complete_wq = alloc_workqueue("sdhci", flags, 0);
+	if (!host->complete_wq)
+		return -ENOMEM;
+
+	INIT_WORK(&host->complete_work, sdhci_uhs2_complete_work);
+
+	timer_setup(&host->timer, sdhci_timeout_timer, 0);
+	timer_setup(&host->data_timer, sdhci_timeout_data_timer, 0);
+
+	init_waitqueue_head(&host->buf_ready_int);
+
+	sdhci_init(host, 0);
+
+	ret = request_threaded_irq(host->irq, sdhci_irq,
+				   sdhci_uhs2_thread_irq,
+				   IRQF_SHARED,	mmc_hostname(mmc), host);
+	if (ret) {
+		pr_err("%s: Failed to request IRQ %d: %d\n",
+		       mmc_hostname(mmc), host->irq, ret);
+		goto unwq;
+	}
+
+	ret = sdhci_led_register(host);
+	if (ret) {
+		pr_err("%s: Failed to register LED device: %d\n",
+		       mmc_hostname(mmc), ret);
+		goto unirq;
+	}
+
+	ret = mmc_add_host(mmc);
+	if (ret)
+		goto unled;
+
+	pr_info("%s: SDHCI controller on %s [%s] using %s\n",
+		mmc_hostname(mmc), host->hw_name, dev_name(mmc_dev(mmc)),
+		host->use_external_dma ? "External DMA" :
+		(host->flags & SDHCI_USE_ADMA) ?
+		(host->flags & SDHCI_USE_64_BIT_DMA) ? "ADMA 64-bit" : "ADMA" :
+		(host->flags & SDHCI_USE_SDMA) ? "DMA" : "PIO");
+
+	sdhci_enable_card_detection(host);
+
+	return 0;
+
+unled:
+	sdhci_led_unregister(host);
+unirq:
+	sdhci_do_reset(host, SDHCI_RESET_ALL);
+	sdhci_writel(host, 0, SDHCI_INT_ENABLE);
+	sdhci_writel(host, 0, SDHCI_SIGNAL_ENABLE);
+	free_irq(host->irq, host);
+unwq:
+	destroy_workqueue(host->complete_wq);
+
+	return ret;
+}
+
+static void __sdhci_uhs2_remove_host(struct sdhci_host *host, int dead)
+{
+	if (!(host->mmc) || !(host->mmc->flags & MMC_UHS2_SUPPORT))
+		return;
+
+	if (!dead)
+		sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_FULL);
+
+	sdhci_writel(host, 0, SDHCI_UHS2_ERR_INT_STATUS_EN);
+	sdhci_writel(host, 0, SDHCI_UHS2_ERR_INT_SIG_EN);
+	host->mmc->flags &= ~MMC_UHS2_INITIALIZED;
+}
+
+int sdhci_uhs2_add_host(struct sdhci_host *host)
+{
+	struct mmc_host *mmc = host->mmc;
+	int ret;
+
+	ret = sdhci_setup_host(host);
+	if (ret)
+		return ret;
+
+	if (host->version >= SDHCI_SPEC_400) {
+               ret = __sdhci_uhs2_add_host_v4(host, host->caps1);
+               if (ret)
+                       goto cleanup;
+	}
+
+	if ((mmc->caps & MMC_CAP_UHS2) && !host->v4_mode)
+		/* host doesn't want to enable UHS2 support */
+		/* FIXME: Do we have to do some cleanup here? */
+		mmc->caps &= ~MMC_CAP_UHS2;
+
+	ret = __sdhci_uhs2_add_host(host);
+	if (ret)
+		goto cleanup2;
+
+	return 0;
+
+cleanup2:
+	/*
+	 * TODO: Is this a right cleanup?
+	 */
+	if (host->version >= SDHCI_SPEC_400)
+		__sdhci_uhs2_remove_host(host, 0);
+cleanup:
+	sdhci_cleanup_host(host);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_add_host);
+
+void sdhci_uhs2_remove_host(struct sdhci_host *host, int dead)
+{
+	__sdhci_uhs2_remove_host(host, dead);
+
+	sdhci_uhs2_remove_host(host, dead);
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_remove_host);
+
 /*****************************************************************************\
  *                                                                           *
  * Driver init/exit                                                          *
diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
index b74af641d00e..34e140f21284 100644
--- a/drivers/mmc/host/sdhci-uhs2.h
+++ b/drivers/mmc/host/sdhci-uhs2.h
@@ -218,5 +218,7 @@ void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set);
 void sdhci_uhs2_request(struct mmc_host *mmc, struct mmc_request *mrq);
 int sdhci_uhs2_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq);
 u32 sdhci_uhs2_irq(struct sdhci_host *host, u32 intmask);
+int sdhci_uhs2_add_host(struct sdhci_host *host);
+void sdhci_uhs2_remove_host(struct sdhci_host *host, int dead);
 
 #endif /* __SDHCI_UHS2_H */
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index e2dfc7767bcf..d37c3edb1ed0 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -176,10 +176,11 @@ static void sdhci_set_card_detection(struct sdhci_host *host, bool enable)
 	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
 }
 
-static void sdhci_enable_card_detection(struct sdhci_host *host)
+void sdhci_enable_card_detection(struct sdhci_host *host)
 {
 	sdhci_set_card_detection(host, true);
 }
+EXPORT_SYMBOL_GPL(sdhci_enable_card_detection);
 
 static void sdhci_disable_card_detection(struct sdhci_host *host)
 {
@@ -237,7 +238,7 @@ void sdhci_reset(struct sdhci_host *host, u8 mask)
 }
 EXPORT_SYMBOL_GPL(sdhci_reset);
 
-static void sdhci_do_reset(struct sdhci_host *host, u8 mask)
+void sdhci_do_reset(struct sdhci_host *host, u8 mask)
 {
 	if (host->quirks & SDHCI_QUIRK_NO_CARD_NO_RESET) {
 		struct mmc_host *mmc = host->mmc;
@@ -258,6 +259,7 @@ static void sdhci_do_reset(struct sdhci_host *host, u8 mask)
 		host->preset_enabled = false;
 	}
 }
+EXPORT_SYMBOL_GPL(sdhci_do_reset);
 
 static void sdhci_set_default_irqs(struct sdhci_host *host)
 {
@@ -321,7 +323,7 @@ static void sdhci_config_dma(struct sdhci_host *host)
 	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
 }
 
-static void sdhci_init(struct sdhci_host *host, int soft)
+void sdhci_init(struct sdhci_host *host, int soft)
 {
 	struct mmc_host *mmc = host->mmc;
 	unsigned long flags;
@@ -346,6 +348,7 @@ static void sdhci_init(struct sdhci_host *host, int soft)
 		mmc->ops->set_ios(mmc, &mmc->ios);
 	}
 }
+EXPORT_SYMBOL_GPL(sdhci_init);
 
 static void sdhci_reinit(struct sdhci_host *host)
 {
@@ -410,7 +413,7 @@ static void sdhci_led_control(struct led_classdev *led,
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
-static int sdhci_led_register(struct sdhci_host *host)
+int sdhci_led_register(struct sdhci_host *host)
 {
 	struct mmc_host *mmc = host->mmc;
 
@@ -427,14 +430,16 @@ static int sdhci_led_register(struct sdhci_host *host)
 
 	return led_classdev_register(mmc_dev(mmc), &host->led);
 }
+EXPORT_SYMBOL_GPL(sdhci_led_register);
 
-static void sdhci_led_unregister(struct sdhci_host *host)
+void sdhci_led_unregister(struct sdhci_host *host)
 {
 	if (host->quirks & SDHCI_QUIRK_NO_LED)
 		return;
 
 	led_classdev_unregister(&host->led);
 }
+EXPORT_SYMBOL_GPL(sdhci_led_unregister);
 
 static inline void sdhci_led_activate(struct sdhci_host *host)
 {
@@ -3175,7 +3180,7 @@ static void sdhci_complete_work(struct work_struct *work)
 		;
 }
 
-static void sdhci_timeout_timer(struct timer_list *t)
+void sdhci_timeout_timer(struct timer_list *t)
 {
 	struct sdhci_host *host;
 	unsigned long flags;
@@ -3195,8 +3200,9 @@ static void sdhci_timeout_timer(struct timer_list *t)
 
 	spin_unlock_irqrestore(&host->lock, flags);
 }
+EXPORT_SYMBOL_GPL(sdhci_timeout_timer);
 
-static void sdhci_timeout_data_timer(struct timer_list *t)
+void sdhci_timeout_data_timer(struct timer_list *t)
 {
 	struct sdhci_host *host;
 	unsigned long flags;
@@ -3226,6 +3232,7 @@ static void sdhci_timeout_data_timer(struct timer_list *t)
 
 	spin_unlock_irqrestore(&host->lock, flags);
 }
+EXPORT_SYMBOL_GPL(sdhci_timeout_data_timer);
 
 /*****************************************************************************\
  *                                                                           *
@@ -3469,7 +3476,7 @@ static inline bool sdhci_defer_done(struct sdhci_host *host,
 		data->host_cookie == COOKIE_MAPPED);
 }
 
-static irqreturn_t sdhci_irq(int irq, void *dev_id)
+irqreturn_t sdhci_irq(int irq, void *dev_id)
 {
 	struct mmc_request *mrqs_done[SDHCI_MAX_MRQS] = {0};
 	irqreturn_t result = IRQ_NONE;
@@ -3609,6 +3616,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 
 	return result;
 }
+EXPORT_SYMBOL_GPL(sdhci_irq);
 
 static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
 {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 74572b54ec47..b1d856664b58 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -832,8 +832,15 @@ static inline void sdhci_read_caps(struct sdhci_host *host)
 }
 
 bool sdhci_data_line_cmd(struct mmc_command *cmd);
+void sdhci_enable_card_detection(struct sdhci_host *host);
 void sdhci_runtime_pm_bus_on(struct sdhci_host *host);
 void sdhci_runtime_pm_bus_off(struct sdhci_host *host);
+void sdhci_do_reset(struct sdhci_host *host, u8 mask);
+void sdhci_init(struct sdhci_host *host, int soft);
+#if IS_REACHABLE(CONFIG_LEDS_CLASS)
+int sdhci_led_register(struct sdhci_host *host);
+void sdhci_led_unregister(struct sdhci_host *host);
+#endif
 void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request *mrq,
                      unsigned long timeout);
 void sdhci_initialize_data(struct sdhci_host *host, struct mmc_data *data);
@@ -884,6 +891,9 @@ int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable);
 void sdhci_request_done_dma(struct sdhci_host *host, struct mmc_request *mrq);
 bool sdhci_request_done(struct sdhci_host *host);
+void sdhci_timeout_timer(struct timer_list *t);
+void sdhci_timeout_data_timer(struct timer_list *t);
+irqreturn_t sdhci_irq(int irq, void *dev_id);
 void sdhci_adma_write_desc(struct sdhci_host *host, void **desc,
 			   dma_addr_t addr, int len, unsigned int cmd);
 
-- 
2.28.0

