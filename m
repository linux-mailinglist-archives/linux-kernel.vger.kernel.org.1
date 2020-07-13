Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9614F21D952
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 16:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbgGMO7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 10:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730035AbgGMO7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 10:59:49 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96258C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:59:49 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j4so16900486wrp.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AR4pD/vZwN2JP47WtR5Vfk5V/YokTCEDqho1kec2JCE=;
        b=UT49nUv50rfkVE34LzYzCUN0MzEtJUk/hHQU7Yoiq4SYrI6OS+HIXgj7MMtYTMb/UW
         lS6D1Fbx2CsDabTrAve2C9SMY5SqBjKgGL0mG4UiV95E668adMxp9MERWVlBwE3HCFGd
         dPhLl5e75N2rR7AfxpjORZq5CPLsWT7MpAbqfHuv/F5Az3caWZcGEnq2L4Jn1qHSbcbL
         MtXQbsSK8a2AfYO7e64tGBeFzo0u6PylqUUDBCj8jqNVLpltCH2M0Da7LSK33uguM0V9
         BH93Iujz9fKJFr8Xiq9/3a1yce/8iPU4rMTgXS1BQFq/sYsFsEWC5BJh65pv385yedp0
         OBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AR4pD/vZwN2JP47WtR5Vfk5V/YokTCEDqho1kec2JCE=;
        b=TsXtMm0CUk3YGPsbfFwnGUhWv1wwBQ7SfS5abUbQz9ps8sLCXKOGPmcO/E1EtO37AX
         gzTNYJy/6puouTuOxWlA4zkwqUMSPbWRju/twpX2J6QK2NSWsQctO+FyI3A4tqFU6kVf
         vDYG7TOI9Q+Ll/m/e5wwDFavGTnZCO83rpSxoimOm0Q2TSgqcglPn+zuhxXvqnp/7hbe
         BpUpcL9hFgOlCWG+5fNuQk/mStOGZMrn4CGgN+n3EFWdPDFdhpOf3HNcFAFXAY/UVe08
         pRYy2k2DZ/iNcUHOF3weMJu1vr5jGFr2Tzn4BWaj8dKHe3apqftmzQKnQwgfT0bARZy/
         eJYw==
X-Gm-Message-State: AOAM5311C/7mnUGkFXXsQdAoK5JEJBWSxQh45TzbazCqXPJdJi3lwXRO
        SLx7YqhF0LE9vcQwAFTcrxa2NQ==
X-Google-Smtp-Source: ABdhPJzxLWXdgm9jFVVW4np6605Vs5gN0IJc/FptyfVS18DJKRb00triNmLMkoUaIVNauvJ8+1nbXA==
X-Received: by 2002:adf:8b5a:: with SMTP id v26mr79075013wra.165.1594652388415;
        Mon, 13 Jul 2020 07:59:48 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id u20sm21991145wmm.15.2020.07.13.07.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 07:59:47 -0700 (PDT)
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
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 2/3] hwmon: pmbus: use more devres helpers
Date:   Mon, 13 Jul 2020 16:59:33 +0200
Message-Id: <20200713145934.18243-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200713145934.18243-1-brgl@bgdev.pl>
References: <20200713145934.18243-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Shrink pmbus code by using devm_hwmon_device_register_with_groups()
and devm_krealloc() instead of their non-managed variants.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pmbus/pmbus_core.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 44535add3a4a1..91839979cf6c1 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -1018,9 +1018,9 @@ static int pmbus_add_attribute(struct pmbus_data *data, struct attribute *attr)
 {
 	if (data->num_attributes >= data->max_attributes - 1) {
 		int new_max_attrs = data->max_attributes + PMBUS_ATTR_ALLOC_SIZE;
-		void *new_attrs = krealloc(data->group.attrs,
-					   new_max_attrs * sizeof(void *),
-					   GFP_KERNEL);
+		void *new_attrs = devm_krealloc(data->dev, data->group.attrs,
+						new_max_attrs * sizeof(void *),
+						GFP_KERNEL);
 		if (!new_attrs)
 			return -ENOMEM;
 		data->group.attrs = new_attrs;
@@ -2534,7 +2534,7 @@ int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
 
 	ret = pmbus_find_attributes(client, data);
 	if (ret)
-		goto out_kfree;
+		return ret;
 
 	/*
 	 * If there are no attributes, something is wrong.
@@ -2542,35 +2542,27 @@ int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
 	 */
 	if (!data->num_attributes) {
 		dev_err(dev, "No attributes found\n");
-		ret = -ENODEV;
-		goto out_kfree;
+		return -ENODEV;
 	}
 
 	data->groups[0] = &data->group;
 	memcpy(data->groups + 1, info->groups, sizeof(void *) * groups_num);
-	data->hwmon_dev = hwmon_device_register_with_groups(dev, client->name,
-							    data, data->groups);
+	data->hwmon_dev = devm_hwmon_device_register_with_groups(dev,
+					client->name, data, data->groups);
 	if (IS_ERR(data->hwmon_dev)) {
-		ret = PTR_ERR(data->hwmon_dev);
 		dev_err(dev, "Failed to register hwmon device\n");
-		goto out_kfree;
+		return PTR_ERR(data->hwmon_dev);
 	}
 
 	ret = pmbus_regulator_register(data);
 	if (ret)
-		goto out_unregister;
+		return ret;
 
 	ret = pmbus_init_debugfs(client, data);
 	if (ret)
 		dev_warn(dev, "Failed to register debugfs\n");
 
 	return 0;
-
-out_unregister:
-	hwmon_device_unregister(data->hwmon_dev);
-out_kfree:
-	kfree(data->group.attrs);
-	return ret;
 }
 EXPORT_SYMBOL_GPL(pmbus_do_probe);
 
@@ -2580,8 +2572,6 @@ int pmbus_do_remove(struct i2c_client *client)
 
 	debugfs_remove_recursive(data->debugfs);
 
-	hwmon_device_unregister(data->hwmon_dev);
-	kfree(data->group.attrs);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pmbus_do_remove);
-- 
2.26.1

