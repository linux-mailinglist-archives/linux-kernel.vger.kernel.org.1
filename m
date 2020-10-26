Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B23CC298E19
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 14:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1780233AbgJZNg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 09:36:26 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52673 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1780180AbgJZNgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 09:36:24 -0400
Received: by mail-wm1-f67.google.com with SMTP id c194so11678018wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 06:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oc+CRyq0MP1rGPx6qu4fJIiuXgNVzq5WpNvySKjLu6M=;
        b=ETNQ5C4O4Im+z0OFc2LmdOrgCbdwcTHV3i/sud6MR3r4APa/DibA2O/U7gKfdhQtcD
         GyAC8xb4Z1kpnIu1iiF7XUI3Brt3EafJsFgfgxnSrRFgXrBAJ/h35VjL/IZBqjBU36V9
         7abLJobIJsHmrGESMQ9uBBYvHLfTAaxOU0L4xz+Iv3dR0QI48jjWKBNZv21Rnw3FnzPo
         BP1hBl+MYk949RWjY9XvWCr5WQM6IqnCuRTXiWPgJPZ4w7s1kozW/FJRw+iWdvYXMvBU
         mgsiWrgZfJOxqnfRlN96vgoRWjxogl/Ei1RrQe5WSMCzaID4NvAvXfnMMB35tqBNzrSn
         yE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oc+CRyq0MP1rGPx6qu4fJIiuXgNVzq5WpNvySKjLu6M=;
        b=ES3XcvR01pyxpegt47aTyZW75ITTETYJ/oqriWrOIjfiHGM2ms9sU7RHlKejYMzfnP
         ZAKu6fhaaHPYRggddJ3v82p9DZPdFjRSIljBNuzkhwvLTMH0xcb/sLH8StvM5LFNU07X
         OW3Lb/E0TlhA2L0MRaijQLKt5Ybqj72PmYd3aTfVcLZgoWSjsA8Apto+ddNdeDxwYaNQ
         34ron+pMyscurEQSE/r7/Eaq2pFnyFzNxKbjAfzVtVvDyEXTKJHU23yr2rOWr8a8rNPD
         +H8Lcd6HMtmLIL4L7IqimSNSFlci85QgiVqrom5RHQVB/A0qz3Sd5WJ+54H8I++5ttYn
         LHMA==
X-Gm-Message-State: AOAM531P/RFB1bpkk66/Q3mRWjAthH84u7EC3fY9TACUzqzc8cx43DHi
        1U68MXm04bc1RHkmiPnAghmpng==
X-Google-Smtp-Source: ABdhPJxRBZnwVrN5mfPlZqgpI52Qd3hNu9GOYY/E9bIWA0MosamJ/tI/ASBpOEiIxMQWYBucoMAVUA==
X-Received: by 2002:a1c:2601:: with SMTP id m1mr15236488wmm.12.1603719381363;
        Mon, 26 Oct 2020 06:36:21 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-190-206.w2-15.abo.wanadoo.fr. [2.15.39.206])
        by smtp.gmail.com with ESMTPSA id f7sm23688991wrx.64.2020.10.26.06.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 06:36:20 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 1/5] iio: adc: xilinx: use helper variable for &pdev->dev
Date:   Mon, 26 Oct 2020 14:36:05 +0100
Message-Id: <20201026133609.24262-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201026133609.24262-1-brgl@bgdev.pl>
References: <20201026133609.24262-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

It's more elegant to use a helper local variable to store the address
of the underlying struct device than to dereference pdev everywhere.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index f93c34fe5873..8494eb424b33 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1186,6 +1186,7 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
 
 static int xadc_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	const struct of_device_id *id;
 	struct iio_dev *indio_dev;
 	unsigned int bipolar_mask;
@@ -1195,10 +1196,10 @@ static int xadc_probe(struct platform_device *pdev)
 	int irq;
 	int i;
 
-	if (!pdev->dev.of_node)
+	if (!dev->of_node)
 		return -ENODEV;
 
-	id = of_match_node(xadc_of_match_table, pdev->dev.of_node);
+	id = of_match_node(xadc_of_match_table, dev->of_node);
 	if (!id)
 		return -EINVAL;
 
@@ -1206,7 +1207,7 @@ static int xadc_probe(struct platform_device *pdev)
 	if (irq <= 0)
 		return -ENXIO;
 
-	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*xadc));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*xadc));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -1226,7 +1227,7 @@ static int xadc_probe(struct platform_device *pdev)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &xadc_info;
 
-	ret = xadc_parse_dt(indio_dev, pdev->dev.of_node, &conf0);
+	ret = xadc_parse_dt(indio_dev, dev->of_node, &conf0);
 	if (ret)
 		return ret;
 
@@ -1250,7 +1251,7 @@ static int xadc_probe(struct platform_device *pdev)
 		}
 	}
 
-	xadc->clk = devm_clk_get(&pdev->dev, NULL);
+	xadc->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(xadc->clk)) {
 		ret = PTR_ERR(xadc->clk);
 		goto err_free_samplerate_trigger;
@@ -1276,7 +1277,7 @@ static int xadc_probe(struct platform_device *pdev)
 	}
 
 	ret = request_irq(xadc->irq, xadc->ops->interrupt_handler, 0,
-			dev_name(&pdev->dev), indio_dev);
+			  dev_name(dev), indio_dev);
 	if (ret)
 		goto err_clk_disable_unprepare;
 
-- 
2.29.1

