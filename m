Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86EA3291DA9
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 21:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387534AbgJRTq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 15:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731757AbgJRTqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 15:46:51 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC76C0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 12:46:50 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id p13so8088776edi.7
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 12:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ldXak5SnxnljogjS5BR4bzLQ/cs7o2P5Z7xi0J4e2zs=;
        b=B4ezs0jnZXe0OoPEHTaO2JK643odWH4jcP7VGXoLrgJtEmJqs5BvZhLnBxMIWt+CT5
         1EWAqMem9TADkZ65DuSA50Wy/qjZA3RLPgSKDHv3+nOg9DVXsUnQ1DdgKr31mrz9Gxga
         xVrX6vtzxaOj/9PT6tYsrqUIwHom3lkoIel0j236GdPrfCjfwpPzIoFokkZgit0joRIj
         DnWuK4Arv4Jqv+aQ6olPyI7cLEKVnNDjdvcnTNjlj3K2ovuLtZdOewVvl/2i1+0J5Edm
         hqOXWZeM1BBlxpcUl2RpKARhqurr7BBshgHZjGNJ6TkyRK5C8R6HYgmJJJKV8XL23rdC
         R4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ldXak5SnxnljogjS5BR4bzLQ/cs7o2P5Z7xi0J4e2zs=;
        b=BCGk9jWgDQpN83N3J1qn0LC0sKFPJ4O2hAWaaJjEvzSDu8VdQva9u3paJrLUPbJpq9
         WOgFQWoHIgvSWhIo+WEkx8mHYBQIrRhNpEDvqECYHvIrsp1gNGkzb+qN7Lu3z0jF3mXm
         YxepSKNXVa7yE2bF91q/JKraj2z/VuI+isEzCWoNObTIehFOxkO4fwTzYYL7NWhYSY4M
         4UusB+h2QoCrMEa+dbY/f80AP3sNluRiwyt7D4jiwMnV4k7q7vEKX23MMptT4mfqi8hC
         Wrb2fHMeSof8RIxvvf0fZEPMxt2EN9vF14d+UgQHPzv299C67YsRkvEh9Lb+acLWj0to
         2z0Q==
X-Gm-Message-State: AOAM531PECrCZml65BjTUjJxz3oO3ntlFONmyGzWvVY+G+29BwF9bM/b
        kwuJt9i1UOwvZQIvJNtwHCfeT9Sk2/lbHg==
X-Google-Smtp-Source: ABdhPJwY6G8XBmaYMPV8hFHddmJ/OHEgz7gA3xdGXbTrVFj3gqbUp+8slxRYnn6QASjh7AGhTznBEQ==
X-Received: by 2002:aa7:c659:: with SMTP id z25mr14681221edr.219.1603050408832;
        Sun, 18 Oct 2020 12:46:48 -0700 (PDT)
Received: from localhost.localdomain (124.171.185.81.rev.sfr.net. [81.185.171.124])
        by smtp.gmail.com with ESMTPSA id c5sm8009574edx.58.2020.10.18.12.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2020 12:46:48 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        matthias.bgg@gmail.com, jic23@kernel.org
Cc:     chun-hung.wu@mediatek.com, alexandru.ardelean@analog.com,
        pmeerw@pmeerw.net, lars@metafoo.de,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH v3] iio: adc: mediatek: fix unset field
Date:   Sun, 18 Oct 2020 21:46:44 +0200
Message-Id: <20201018194644.3366846-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_comp field is used in a couple of places but it is never set. This
results in kernel oops when dereferencing a NULL pointer. Set the
`dev_comp` field correctly in the probe function.

Fixes: 6d97024dce23 ("iio: adc: mediatek: mt6577-auxadc, add mt6765 support")
Signed-off-by: Fabien Parent <fparent@baylibre.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
---

Changelog:
V2:
	* s/of_device_get_match_data/device_get_match_data
	* include mod_devicetable.h and property.h instead of of_*.h headers
V3:
	* Remove extra space between Fixes tag and Signed-off-by tag
	* Add missing Reviewed-by tag from Matthias Brugger

 drivers/iio/adc/mt6577_auxadc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
index ac415cb089cd..79c1dd68b909 100644
--- a/drivers/iio/adc/mt6577_auxadc.c
+++ b/drivers/iio/adc/mt6577_auxadc.c
@@ -9,9 +9,9 @@
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/iopoll.h>
 #include <linux/io.h>
 #include <linux/iio/iio.h>
@@ -276,6 +276,8 @@ static int mt6577_auxadc_probe(struct platform_device *pdev)
 		goto err_disable_clk;
 	}
 
+	adc_dev->dev_comp = device_get_match_data(&pdev->dev);
+
 	mutex_init(&adc_dev->lock);
 
 	mt6577_auxadc_mod_reg(adc_dev->reg_base + MT6577_AUXADC_MISC,
-- 
2.28.0

