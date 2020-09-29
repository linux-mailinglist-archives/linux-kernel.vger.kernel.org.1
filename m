Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8588627D96D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 22:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbgI2U6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 16:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729424AbgI2U6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 16:58:32 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5F3C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 13:58:32 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g29so4919772pgl.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 13:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iCWgxkOdTTTKUZcUUFYmA6hQXkqRRwcJ9SsWBI8BDmc=;
        b=e03h7wHWa14th/G80Sf6CJsivT5+ZUb4nDybx1dZ4s2nNxSCSiKz6JnBACckrWnmww
         t4FTSIwZ76ANG6miVooHSUJ1/LAwAUrmGbtEj74AiSr6zd3j1GzAG7n1BAIE/zX57ZEK
         1OijHNAvFRERvAyO19N2X2ug2X+cfKk+wZVug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iCWgxkOdTTTKUZcUUFYmA6hQXkqRRwcJ9SsWBI8BDmc=;
        b=qH6bMVUpFXnlwfdikorU66OErNOz0m3xQTMIxpdNzPoAxwDCg6hqUVpnGbmqWxXSv5
         gFCD4DmXz5abkXPoBGjd0s6G8YaHnhlETYOoNbIE+BZSvB0wTzxDX69zoRHlTGA0Ut8r
         PWKuCKOd2xHLQJmYx3l+RZq14rHl1pbzsw5HGszk2Cjn+KAqq7GTfBq70BpIQMK1gR5w
         dyt835/coh8CKH+Qr0p83nkN8HikDZizESc6qKZkGLYYHcuOOHvEn5skxghwW0s+Uy0t
         i5YR1ArrdJ0VhMh/THkbL4fxuIIzKSkI5F6/1z0FyjOV2pEd3THYl6hYfTVGKfdvvivj
         C9/w==
X-Gm-Message-State: AOAM533NOjIUy5V1JNtM8yAgePMjWnHOYUBRoii2wWD16cxASk4FtuYZ
        hTbQ4D6c54UMqtmbqMQw6f0UGg==
X-Google-Smtp-Source: ABdhPJxvalDJx6IwLcTJ0dyOXM4wgVcG4iuq5nBh/7e3or+LrcP1a8sWn/ZEEBMY4ewOhriHRauEtw==
X-Received: by 2002:aa7:8084:0:b029:13f:b82a:1725 with SMTP id v4-20020aa780840000b029013fb82a1725mr5832004pff.9.1601413111767;
        Tue, 29 Sep 2020 13:58:31 -0700 (PDT)
Received: from evgreen-glaptop.cheshire.ch ([2601:646:c780:1404:a2ce:c8ff:fec4:54a3])
        by smtp.gmail.com with ESMTPSA id k7sm5488101pjs.9.2020.09.29.13.58.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Sep 2020 13:58:31 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] nvmem: qfprom: Don't touch certain fuses
Date:   Tue, 29 Sep 2020 13:58:07 -0700
Message-Id: <20200929135741.3.I1bb1b0e94be3b792804e08831d6a55481e162d63@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200929205807.2360405-1-evgreen@chromium.org>
References: <20200929205807.2360405-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some fuse ranges are protected by the XPU such that the AP cannot
access them. Attempting to do so causes an SError. Use the newly
introduced per-soc compatible string to attach the set of regions
we should not access. Then tiptoe around those regions.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

 drivers/nvmem/qfprom.c | 55 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 51 insertions(+), 4 deletions(-)

diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
index 5e9e60e2e591d..feea39ae52164 100644
--- a/drivers/nvmem/qfprom.c
+++ b/drivers/nvmem/qfprom.c
@@ -12,6 +12,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/nvmem-provider.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regulator/consumer.h>
 
 /* Blow timer clock frequency in Mhz */
@@ -51,6 +52,17 @@ struct qfprom_soc_data {
 	u32 qfprom_blow_set_freq;
 };
 
+/**
+ * struct qfprom_keepout_region - registers to avoid touching.
+ *
+ * @start: The first byte offset to avoid.
+ * @end: One after the last byte offset to avoid.
+ */
+struct qfprom_keepout_region {
+	u32 start;
+	u32 end;
+};
+
 /**
  * struct qfprom_priv - structure holding qfprom attributes
  *
@@ -63,6 +75,7 @@ struct qfprom_soc_data {
  * @secclk:       Clock supply.
  * @vcc:          Regulator supply.
  * @soc_data:     Data that for things that varies from SoC to SoC.
+ * @keepout:      Fuse regions not to access, as they may cause SErrors.
  */
 struct qfprom_priv {
 	void __iomem *qfpraw;
@@ -73,6 +86,7 @@ struct qfprom_priv {
 	struct clk *secclk;
 	struct regulator *vcc;
 	const struct qfprom_soc_data *soc_data;
+	const struct qfprom_keepout_region *keepout;
 };
 
 /**
@@ -88,6 +102,12 @@ struct qfprom_touched_values {
 	u32 timer_val;
 };
 
+const struct qfprom_keepout_region sc7180_qfprom[] = {
+	{.start = 0x128, .end = 0x148},
+	{.start = 0x220, .end = 0x228},
+	{} /* Sentinal where start == end. */
+};
+
 /**
  * qfprom_disable_fuse_blowing() - Undo enabling of fuse blowing.
  * @priv: Our driver data.
@@ -171,6 +191,23 @@ static int qfprom_enable_fuse_blowing(const struct qfprom_priv *priv,
 	return ret;
 }
 
+static int qfprom_check_reg(struct qfprom_priv *priv, unsigned int reg)
+{
+	const struct qfprom_keepout_region *keepout = priv->keepout;
+
+	if (!keepout)
+		return 1;
+
+	while (keepout->start != keepout->end) {
+		if ((reg >= keepout->start) && (reg < keepout->end))
+			return 0;
+
+		keepout++;
+	}
+
+	return 1;
+}
+
 /**
  * qfprom_efuse_reg_write() - Write to fuses.
  * @context: Our driver data.
@@ -228,8 +265,10 @@ static int qfprom_reg_write(void *context, unsigned int reg, void *_val,
 		goto exit_enabled_fuse_blowing;
 	}
 
-	for (i = 0; i < words; i++)
-		writel(value[i], priv->qfpraw + reg + (i * 4));
+	for (i = 0; i < words; i++) {
+		if (qfprom_check_reg(priv, reg + (i * 4)))
+			writel(value[i], priv->qfpraw + reg + (i * 4));
+	}
 
 	ret = readl_relaxed_poll_timeout(
 		priv->qfpconf + QFPROM_BLOW_STATUS_OFFSET,
@@ -257,8 +296,14 @@ static int qfprom_reg_read(void *context,
 	if (read_raw_data && priv->qfpraw)
 		base = priv->qfpraw;
 
-	while (words--)
-		*val++ = readb(base + reg + i++);
+	while (words--) {
+		if (qfprom_check_reg(priv, reg + i))
+			*val++ = readb(base + reg + i);
+		else
+			*val++ = 0;
+
+		i++;
+	}
 
 	return 0;
 }
@@ -299,6 +344,7 @@ static int qfprom_probe(struct platform_device *pdev)
 	econfig.priv = priv;
 
 	priv->dev = dev;
+	priv->keepout = device_get_match_data(dev);
 
 	/*
 	 * If more than one region is provided then the OS has the ability
@@ -354,6 +400,7 @@ static int qfprom_probe(struct platform_device *pdev)
 
 static const struct of_device_id qfprom_of_match[] = {
 	{ .compatible = "qcom,qfprom",},
+	{ .compatible = "qcom,sc7180-qfprom", .data = &sc7180_qfprom},
 	{/* sentinel */},
 };
 MODULE_DEVICE_TABLE(of, qfprom_of_match);
-- 
2.26.2

