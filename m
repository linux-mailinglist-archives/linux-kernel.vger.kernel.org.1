Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E458829DC6B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388559AbgJ2AaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728084AbgJ2A2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:28:53 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF053C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 17:28:51 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id 1so471975ple.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 17:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4GxBpzcLxQqXmNPRolKFYsv73UOGK+e1VzfCCXT1DLY=;
        b=AL2KbpxAbk75PiCXR9zLs6fyiWkb0t1kxXyih9x8YFW1ie2xvhIRspSFHyfwpRzZiv
         Vn+4fkdP6fGkDqKVVKzfYMZQKxduZXckJ0XTIIhLB/eMsKo1CJDNW5XO7YczhfziZsgf
         crkoV/l2GJvdazjO5/52HV06B3nIeydd3KwWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4GxBpzcLxQqXmNPRolKFYsv73UOGK+e1VzfCCXT1DLY=;
        b=RC8vXHU+PynFa3pVnbY+9Vbkclw1ZDPtnalhKTd3YnQF6Mct1jzm+99yc1tFmCAU/R
         RFQ0mCiyAT7wbu8Cj3dIuqQ8287nmLlMwrVAFdTwjrzYcY0UZ5TQ5BVJPze3Aac2jWCL
         olSp7LWxh/X9PzOFL/O/w9JznsVWs3vJHLu+YFpgIFHedZMYSDyUUH+dbJ01SlmKqXM1
         q7k8YasLwBhc9TeNOU1RwBVWI1hAkM49qTlEY160Jkg3PTJCblh+A8muXXl058bGIzXm
         xGpfs3DlRLT6JP8+RzNZztFKhPKVB/BVUXv2xLpU+dtf514JzgnOx4fpCo2dcOOGp/cW
         pFwg==
X-Gm-Message-State: AOAM5320qcFQN79WaGgkzUrevGmiGr0lP89yTnNETurnbia+h3VmZA2s
        wSyNkP3Nqg0DPcOyUvkvFG5RrFBtDbi+v/E+
X-Google-Smtp-Source: ABdhPJxfReljQ/c/6er7pgZYJBGOskR5YtiE0gn2u0EiF1qUkmkAiGB7nvD3bVdhCOtvbl4wNgVYWw==
X-Received: by 2002:a17:902:8eca:b029:d2:4276:1b2d with SMTP id x10-20020a1709028ecab02900d242761b2dmr1711066plo.17.1603931331288;
        Wed, 28 Oct 2020 17:28:51 -0700 (PDT)
Received: from evgreen-glaptop.cheshire.ch ([2601:646:c780:1404:250:b6ff:fee1:7d4c])
        by smtp.gmail.com with ESMTPSA id u13sm743625pfl.162.2020.10.28.17.28.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Oct 2020 17:28:50 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] nvmem: qfprom: Don't touch certain fuses
Date:   Wed, 28 Oct 2020 17:28:27 -0700
Message-Id: <20201028172737.v3.4.I1bb1b0e94be3b792804e08831d6a55481e162d63@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201029002827.1729915-1-evgreen@chromium.org>
References: <20201029002827.1729915-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some fuse ranges are protected by the XPU such that the AP cannot
access them. Attempting to do so causes an SError. Use the newly
introduced per-soc compatible string, and the newly introduced
nvmem keepout support to attach the set of regions
we should not access.

Signed-off-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v2)

Changes in v2:
 - Use new core support in qfprom (Srini)

 drivers/nvmem/qfprom.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
index 5e9e60e2e591d..6cace24dfbf73 100644
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
2.26.2

