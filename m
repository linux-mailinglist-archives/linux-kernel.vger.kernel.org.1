Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19BAB246E2C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 19:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389958AbgHQRYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 13:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388485AbgHQRGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 13:06:06 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AC8C061347
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 10:05:44 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l2so15700554wrc.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 10:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QPQnmI/58kOYJX5JO2+CM6DvjdssZDc2jVBjt8SVn9Y=;
        b=YuiXi/kinFP88R0aPiCU55Nprn56KeOKbH+KhhoCxduo6j7FzXH12C+I/rUVFF2MTP
         rUNab8Es+pEUJ0mOl0o47LkZ9vxB88jk2clqVQO4YC3EMN54iij8Dg8f1X9T9s8V8I+t
         K67UfagZ+rIkHxaCUmX6dl/fnHdP01O4+yLsnKvnlNwfJ0VVDsBuk2m/Wi0mwtG58Ypl
         AT44t4dH86MBjKLlQOp8xEQEF9c3YypxpUYLgQAuAR9MU4UWZR68FGdiuu+hNZEmv4Tm
         pX8UkOQzp2mYLfUXDwUq29cTK6tNS0ySm+dy5EOekUvDleo+l/oguSRijKxKZraz93xt
         27hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QPQnmI/58kOYJX5JO2+CM6DvjdssZDc2jVBjt8SVn9Y=;
        b=tmRFjXjfqsC/8QJhf/G1Tny53JQ1NbtqDOS/I0Ltf2EV1t4WsLyS3YyS5s11hqTmlr
         sABrijqBp7h293z3/IA08hoS9DJq2Ezg9YAFL2Dfylyl0albgt5JNjkUPBAWZK0jhPuz
         qJD3iQEwCOS3cuTSilFSHVij1rIM87GVhjRBKC2ZvBPwgMChdT/rtXcqD14BG2rljuIJ
         8gtAwHjPiS+tRwCYPUJXtxXlECxtmFzLSOQLeEsu8q1PCHg2lRd4so9lmcTQpsKrggDS
         jrZwnUCA+P++ZUdMLP4v0QHhPzJX9S8OgUBlsV6o6h8DAhWjD3BrkhWKv8lbCjv4id15
         HJVQ==
X-Gm-Message-State: AOAM532/mtogldg6xMgfZ4SD6TjMh7V3QTuxlsOWXIdX5LpFI7Ed+1jm
        o7HpiwzDUqlNuuYBjzQuWu8saptojVHBLA==
X-Google-Smtp-Source: ABdhPJzidFcB7ZIzIx5H9eHYngnMFhnJsHpdbQQUC3IPtgHxLJxrUgwpePI6OmXWPyKufiK3Jko02g==
X-Received: by 2002:adf:ef92:: with SMTP id d18mr17541341wro.71.1597683943032;
        Mon, 17 Aug 2020 10:05:43 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id k184sm29747177wme.1.2020.08.17.10.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 10:05:42 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v7 3/3] iio: adc: xilinx-xadc: use devm_krealloc()
Date:   Mon, 17 Aug 2020 19:05:35 +0200
Message-Id: <20200817170535.17041-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200817170535.17041-1-brgl@bgdev.pl>
References: <20200817170535.17041-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use the managed variant of krealloc() and shrink the code a bit.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index d0b7ef296afb..f93c34fe5873 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1092,6 +1092,7 @@ MODULE_DEVICE_TABLE(of, xadc_of_match_table);
 static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
 	unsigned int *conf)
 {
+	struct device *dev = indio_dev->dev.parent;
 	struct xadc *xadc = iio_priv(indio_dev);
 	struct iio_chan_spec *channels, *chan;
 	struct device_node *chan_node, *child;
@@ -1136,7 +1137,8 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
 		*conf |= XADC_CONF0_MUX | XADC_CONF0_CHAN(ext_mux_chan);
 	}
 
-	channels = kmemdup(xadc_channels, sizeof(xadc_channels), GFP_KERNEL);
+	channels = devm_kmemdup(dev, xadc_channels,
+				sizeof(xadc_channels), GFP_KERNEL);
 	if (!channels)
 		return -ENOMEM;
 
@@ -1172,8 +1174,9 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
 	of_node_put(chan_node);
 
 	indio_dev->num_channels = num_channels;
-	indio_dev->channels = krealloc(channels, sizeof(*channels) *
-					num_channels, GFP_KERNEL);
+	indio_dev->channels = devm_krealloc(dev, channels,
+					    sizeof(*channels) * num_channels,
+					    GFP_KERNEL);
 	/* If we can't resize the channels array, just use the original */
 	if (!indio_dev->channels)
 		indio_dev->channels = channels;
@@ -1225,14 +1228,14 @@ static int xadc_probe(struct platform_device *pdev)
 
 	ret = xadc_parse_dt(indio_dev, pdev->dev.of_node, &conf0);
 	if (ret)
-		goto err_device_free;
+		return ret;
 
 	if (xadc->ops->flags & XADC_FLAGS_BUFFERED) {
 		ret = iio_triggered_buffer_setup(indio_dev,
 			&iio_pollfunc_store_time, &xadc_trigger_handler,
 			&xadc_buffer_ops);
 		if (ret)
-			goto err_device_free;
+			return ret;
 
 		xadc->convst_trigger = xadc_alloc_trigger(indio_dev, "convst");
 		if (IS_ERR(xadc->convst_trigger)) {
@@ -1350,8 +1353,6 @@ static int xadc_probe(struct platform_device *pdev)
 err_triggered_buffer_cleanup:
 	if (xadc->ops->flags & XADC_FLAGS_BUFFERED)
 		iio_triggered_buffer_cleanup(indio_dev);
-err_device_free:
-	kfree(indio_dev->channels);
 
 	return ret;
 }
@@ -1371,7 +1372,6 @@ static int xadc_remove(struct platform_device *pdev)
 	cancel_delayed_work_sync(&xadc->zynq_unmask_work);
 	clk_disable_unprepare(xadc->clk);
 	kfree(xadc->data);
-	kfree(indio_dev->channels);
 
 	return 0;
 }
-- 
2.26.1

