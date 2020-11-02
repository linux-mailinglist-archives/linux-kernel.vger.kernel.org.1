Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1382A2CD9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 15:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgKBO0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 09:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbgKBOWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 09:22:38 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5CEC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 06:22:37 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id b3so8909305wrx.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 06:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9A0YZTtyChgf0u6PFbkMOtS/8IXdoUAvGcveYosNg8o=;
        b=Iz+6HeRyJ0MzqEaZdma++F+Cl26ft+hc4SvyuEOwHNxpA9O2d9Ccrt//8K9HHCIGeZ
         PN3iov4vxUF8uIwsXYRP/xOxjR9AG1Icc1aQarzzAZ9ds+u7ghaZnJwLeuYXdoqYJprL
         xB8zPvuA1ahdRu3rRVh598nguAmJqCg2KA4KTNPDisAigjNyFkA8Z/yh0W4W40YktLVg
         bs9JczBvspN3PnSZ738KfquAPGW2rtBneSeDWY2SSINssmt+xct8YHlDqWDp7jPOL6iz
         HGjKojUFxD2tr4fe/2JUXl6sZ7XjLoHEzurMV9I0JIaQxwP7qOFQl8Ps9bd6R/LsA4XY
         CUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9A0YZTtyChgf0u6PFbkMOtS/8IXdoUAvGcveYosNg8o=;
        b=og7mvgO0B2CW67mg7op1BxNDlgZQ+Y8e8OWZBqibBodWkOWN5ZesqlED7FkcnbmRO5
         61KTGteaIe9eimeA7YWUAgnL8wIZVeoJV6Fh9AATq6JGorsF0zibiBAy7qzivb6DZUBn
         wipaeu1w0+a5zyo0WFHIAqxkBPJdce3Na1Mn3b8Guojrcdd4RtqNTR+3zlGZqLlSKwDA
         yRPyQPRqS3y1bYxoxz6ptsvAsfry5n7yQE0JYHYfHc/rgTIOVX4t4NtpBFxRwt9+QaXE
         jTYvC9iSWREns9SasuXBTJR2X8QwzNkhbGQp3KVm72vNqZV3TVfXDOv6bYGLAsttmbbR
         CeQg==
X-Gm-Message-State: AOAM530AuSOM2EobroX5QND0nM8vQ9QLzlSlwGD2+k9Jul4EASWSe8YR
        p2QcDASRJs/QuGYd5L6tm+QcrA==
X-Google-Smtp-Source: ABdhPJzEMMHZfL1mdwXFbBpQAWTyd9NcamKKsSu8d3RLFB6kvwNmlyzoTY0otzx1aVegApUhQc86jQ==
X-Received: by 2002:adf:ea11:: with SMTP id q17mr21799947wrm.251.1604326955882;
        Mon, 02 Nov 2020 06:22:35 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id 3sm16182987wmd.19.2020.11.02.06.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 06:22:35 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 3/4] iio: adc: xilinx: use devm_krealloc_array() instead of kfree() + kcalloc()
Date:   Mon,  2 Nov 2020 15:22:27 +0100
Message-Id: <20201102142228.14949-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201102142228.14949-1-brgl@bgdev.pl>
References: <20201102142228.14949-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now have devm_krealloc_array() in the kernel Use it indstead of calling
kfree() and kcalloc() separately.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 8494eb424b33..7792aa4cf9cb 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -586,14 +586,18 @@ static int xadc_update_scan_mode(struct iio_dev *indio_dev,
 {
 	struct xadc *xadc = iio_priv(indio_dev);
 	unsigned int n;
+	void *data;
 
 	n = bitmap_weight(mask, indio_dev->masklength);
 
-	kfree(xadc->data);
-	xadc->data = kcalloc(n, sizeof(*xadc->data), GFP_KERNEL);
-	if (!xadc->data)
+	data = devm_krealloc_array(indio_dev->dev.parent, xadc->data, n,
+				   sizeof(*xadc->data), GFP_KERNEL);
+	if (!data)
 		return -ENOMEM;
 
+	memset(data, 0, n * sizeof(*xadc->data));
+	xadc->data = data;
+
 	return 0;
 }
 
@@ -1372,7 +1376,6 @@ static int xadc_remove(struct platform_device *pdev)
 	free_irq(xadc->irq, indio_dev);
 	cancel_delayed_work_sync(&xadc->zynq_unmask_work);
 	clk_disable_unprepare(xadc->clk);
-	kfree(xadc->data);
 
 	return 0;
 }
-- 
2.29.1

