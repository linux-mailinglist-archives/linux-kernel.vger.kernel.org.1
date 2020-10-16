Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFC2290C43
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 21:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436507AbgJPT1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 15:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393122AbgJPT1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 15:27:44 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B803C061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 12:27:44 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x13so2047091pfa.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 12:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gwho7eLt542zXegP2RQ51fiuuomCt1yep2uFs4+I0jY=;
        b=go1maH2na4CGeD0jcdqwEf4ShyvZ12NcGMRmZQZ6HD2Qbblzp48VJI1U55M4x4STU/
         Zm3So27mX/KOas1bobi4uoMMMNELsfG8uN8/zfmJGZbFdASP9GiQq5PHmLyuYnYlcRiw
         Y4W/Pp005keVgCemV90eDGuo6b0IHvofj4wqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gwho7eLt542zXegP2RQ51fiuuomCt1yep2uFs4+I0jY=;
        b=MxyXVU5Sw6L/sjlOcih3NqfIjE6ooJQzzZrRLdnSagn6EXQt9hhzyPmI/jbPxiYmXm
         RwJy2Jj1TcOEuWz77V5ukhrjMWl0zdcZLwT50bPx9C792AL6VKggCFcobGRtntCxScuU
         J3yJZiRet7yAgG+XnD0ttA6cgFiGBzIc+GTEf6DYBy4pWIfIiuSeejokVDl2Kdb+PtY4
         1xMrlQ0Uc3vtvjS9OP6Cp5MKcMnGqxg4uFp85nu9G2XA/a/GFsVN0m+egdkipkw8/xYb
         XUhcc+SdAlpRYIz5QVvFLXbSSjbeokAH4AYT1e06+tL2gy7tKlUGyH2oXtZ3Wkga8mEM
         XfoA==
X-Gm-Message-State: AOAM533fskm33wZgucbHD3SzEWXEdYq6F6j9ZcIj12ljLVGqP6Xsglls
        8GKTQ2ZhpUMofmmK7xAe7eenbw==
X-Google-Smtp-Source: ABdhPJw9OkWnjUOG/1oeXPzshYRgRrs/vlWqOg8dhDVY1KtxFCcT+4hbF0HXWwQ8I7RZRgkLYLDlCg==
X-Received: by 2002:a63:5d03:: with SMTP id r3mr4250848pgb.2.1602876463594;
        Fri, 16 Oct 2020 12:27:43 -0700 (PDT)
Received: from evgreen-glaptop.cheshire.ch ([2601:646:c780:1404:a2ce:c8ff:fec4:54a3])
        by smtp.gmail.com with ESMTPSA id lb13sm3566622pjb.5.2020.10.16.12.27.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Oct 2020 12:27:43 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Evan Green <evgreen@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] nvmem: qfprom: Don't touch certain fuses
Date:   Fri, 16 Oct 2020 12:26:54 -0700
Message-Id: <20201016122559.v2.4.I1bb1b0e94be3b792804e08831d6a55481e162d63@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201016192654.32610-1-evgreen@chromium.org>
References: <20201016192654.32610-1-evgreen@chromium.org>
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
---

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

