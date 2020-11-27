Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8B32C6314
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 11:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbgK0K2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 05:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729045AbgK0K2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 05:28:52 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1D4C0613D4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 02:28:50 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id p8so5022796wrx.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 02:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wxCuANfKRhjqikDqDFbzz3IdER5dA9jjrzANAD+5XmI=;
        b=Y+HvmvE3uXb33B3nRL92d1vdM1viGpR7G26sTCfRjVPo4XB/+26oyoufxJ5Q5WpZ3N
         yAbQJ5mOkC/AJLRxkuJAHLXZvlX/XSP3/kmtxozL1hPlWLN1KLGdqOZgq0RcmlEyJCsQ
         s9UOylY/29UpD8zQ3aHS3BW337nEiWWJXjdLg+XCW9YrXWoMEboCwyxBzTkacfaho8Ku
         bPTqiokAZyACqDTzPOJm/E/72vPbWVicH/vxjE4i6qZUulq2FiJnh4R96BiZR0c6DHcn
         NPQ3xCxJWsMhtKLpgx6WwT8WpXLDDP1ruDxovLsV8vBZpuHucxke5hSjwvZnk/9MtH58
         rRJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wxCuANfKRhjqikDqDFbzz3IdER5dA9jjrzANAD+5XmI=;
        b=ZwVBq1F1fjqeHpoDZu6mHsKMbJukOBUv/8pXXbE/opgSVLvufUqFjF6YYtEkjbM2zM
         iA+uxIrHocdW9vIqVRzhRAXOU+cGqZUpL1mt1vGSZTCN45hF5C1AI1U6lM/h8pXZ5aJG
         D+Ugn4YewiGvQEu+DSNle+1oCGoa6TnbSzAzlfXYxYceZZUT3VxOmW/4riuGioz1NKee
         A/YI3UYa7U9/DCOHu1tLEVrMLXdX6vLKItNVoi48xQ1dU6iah4DIeG9kySPRZkq4C83K
         idxbO3c2mkT6fZGrCayVPkONH5E48qavC+/fG582btKMv3XgSAHwL78rg5GlOb129Coq
         lHZw==
X-Gm-Message-State: AOAM533tjhByB7OBssrpLFZmFtyRTnRW21MP3Rnb4UmlgCoWC1yunyBW
        3MQBhfABDZ5fEUzdJ7Tx61UKTQ==
X-Google-Smtp-Source: ABdhPJw9IHwdtxdr2qYmMlVLtoGXUmg9k+YBZlzpO47N7l4lCqDWNEK7Egrl77N+4WF6JEn2LtJOVQ==
X-Received: by 2002:adf:e481:: with SMTP id i1mr9339224wrm.282.1606472929182;
        Fri, 27 Nov 2020 02:28:49 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id d8sm14073051wrp.44.2020.11.27.02.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 02:28:48 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/5] nvmem: qfprom: Don't touch certain fuses
Date:   Fri, 27 Nov 2020 10:28:36 +0000
Message-Id: <20201127102837.19366-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201127102837.19366-1-srinivas.kandagatla@linaro.org>
References: <20201127102837.19366-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evan Green <evgreen@chromium.org>

Some fuse ranges are protected by the XPU such that the AP cannot
access them. Attempting to do so causes an SError. Use the newly
introduced per-soc compatible string, and the newly introduced
nvmem keepout support to attach the set of regions
we should not access.

Signed-off-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/qfprom.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
index 5e9e60e2e591..6cace24dfbf7 100644
--- a/drivers/nvmem/qfprom.c
+++ b/drivers/nvmem/qfprom.c
@@ -12,6 +12,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/nvmem-provider.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regulator/consumer.h>
 
 /* Blow timer clock frequency in Mhz */
@@ -88,6 +89,28 @@ struct qfprom_touched_values {
 	u32 timer_val;
 };
 
+/**
+ * struct qfprom_soc_compatible_data - Data matched against the SoC
+ * compatible string.
+ *
+ * @keepout: Array of keepout regions for this SoC.
+ * @nkeepout: Number of elements in the keepout array.
+ */
+struct qfprom_soc_compatible_data {
+	const struct nvmem_keepout *keepout;
+	unsigned int nkeepout;
+};
+
+static const struct nvmem_keepout sc7180_qfprom_keepout[] = {
+	{.start = 0x128, .end = 0x148},
+	{.start = 0x220, .end = 0x228}
+};
+
+static const struct qfprom_soc_compatible_data sc7180_qfprom = {
+	.keepout = sc7180_qfprom_keepout,
+	.nkeepout = ARRAY_SIZE(sc7180_qfprom_keepout)
+};
+
 /**
  * qfprom_disable_fuse_blowing() - Undo enabling of fuse blowing.
  * @priv: Our driver data.
@@ -281,6 +304,7 @@ static int qfprom_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct resource *res;
 	struct nvmem_device *nvmem;
+	const struct qfprom_soc_compatible_data *soc_data;
 	struct qfprom_priv *priv;
 	int ret;
 
@@ -299,6 +323,11 @@ static int qfprom_probe(struct platform_device *pdev)
 	econfig.priv = priv;
 
 	priv->dev = dev;
+	soc_data = device_get_match_data(dev);
+	if (soc_data) {
+		econfig.keepout = soc_data->keepout;
+		econfig.nkeepout = soc_data->nkeepout;
+	}
 
 	/*
 	 * If more than one region is provided then the OS has the ability
@@ -354,6 +383,7 @@ static int qfprom_probe(struct platform_device *pdev)
 
 static const struct of_device_id qfprom_of_match[] = {
 	{ .compatible = "qcom,qfprom",},
+	{ .compatible = "qcom,sc7180-qfprom", .data = &sc7180_qfprom},
 	{/* sentinel */},
 };
 MODULE_DEVICE_TABLE(of, qfprom_of_match);
-- 
2.21.0

