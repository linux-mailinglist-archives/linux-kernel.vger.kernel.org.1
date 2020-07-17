Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C9C2240E2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 18:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgGQQ4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 12:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbgGQQ4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 12:56:03 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8376C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 09:56:02 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f2so11872180wrp.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 09:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lIupI+tKAOz6AMhKMQ/MUZEWjIHVvy3yhlR142kJJzQ=;
        b=C7HneBkEgxiePq6cP+uc0msARkXKZ68uMEWX9XvHJk51XE/BiAVtq27WtsiRaWpZOl
         blIPdgePFo/nZeZ1gGvbiyp6TXMBSerIKtneJiwHtDGhX3/19NJd9qNmpRmEAOcUInjE
         Joe3OOs7tX+fan+SF++O2aDxnMg6VJQNfwqM/hTuZ4VIQcR8NDL0ukAmnVHHLyhL6cjA
         BiPU9T/6ho43X4D/ukf7LCo72Ha6TdYmz7wne2DouxCak7hk442qzdOgHuEiGgKAx4Of
         JA16zWN7T2bMrYEvs/D+rqAHHbROXFn23jNHTHTADeK4nBcwhUjM5TBGRGvGVLOWMKZU
         mKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lIupI+tKAOz6AMhKMQ/MUZEWjIHVvy3yhlR142kJJzQ=;
        b=Vp9yydnRM0Nr2fHpicFbcH/VmqsjluUFypiADHnBVqYlvNjIH7BRZmNMt6+ix3gGIY
         yplK56x6fUa5Wc0Hf42OtDr2cuDSsWSU8wHfnOF5Ex+4kBD005vEGx9KtRknvkyOiG0c
         yM6AjKCVInck8MHaJVcD8igZfBWVgAVZDJuV2pU7SRjNsucXFgUoLdJMDDNkmO5K5+O6
         1ECieqYKLQ2VFfUkJ8R9+XFmZpEzU/z/4xRKk3Jh6vNGof72dATOshN+14u6NEXxwBwR
         S0ydAMuRo5ckZklHrNeBf0qgslv5AlMLkDI3j9nZtoE54SlkALNHjngQURyllOF73Zcv
         ci9g==
X-Gm-Message-State: AOAM531aZsxjlfThEWXT222NtU+NMIM9NJ9H8E3reVYDbBKPdplEJhzu
        b5ypUcw2AjCOfejJlON1qkCyCw==
X-Google-Smtp-Source: ABdhPJzK3GbkD2rzZrYM3yoqQYRKGWTe1avEC7a2sRHmTBdmjWCN1HXe7dJK1gVWJjCwVAE7KRFK0Q==
X-Received: by 2002:a5d:69c5:: with SMTP id s5mr11229093wrw.197.1595004961514;
        Fri, 17 Jul 2020 09:56:01 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id k4sm14941516wrp.86.2020.07.17.09.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 09:56:01 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        J Keerthy <j-keerthy@ti.com>,
        Mikko Ylinen <mikko.k.ylinen@nokia.com>,
        Amit Kucheria <amit.kucheria@canonical.com>
Subject: [PATCH 03/30] iio: adc: twl4030-madc: Fix misnamed struct attribute
Date:   Fri, 17 Jul 2020 17:55:11 +0100
Message-Id: <20200717165538.3275050-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717165538.3275050-1-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/iio/adc/twl4030-madc.c:170: warning: Function parameter or member 'usb3v1' not described in 'twl4030_madc_data'

Cc: J Keerthy <j-keerthy@ti.com>
Cc: Mikko Ylinen <mikko.k.ylinen@nokia.com>
Cc: Amit Kucheria <amit.kucheria@canonical.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/adc/twl4030-madc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-madc.c
index 826d8295e9b3c..882a678b44690 100644
--- a/drivers/iio/adc/twl4030-madc.c
+++ b/drivers/iio/adc/twl4030-madc.c
@@ -153,7 +153,7 @@ enum sample_type {
  * struct twl4030_madc_data - a container for madc info
  * @dev:		Pointer to device structure for madc
  * @lock:		Mutex protecting this data structure
- * @regulator:		Pointer to bias regulator for madc
+ * @usb3v1:		Pointer to bias regulator for madc
  * @requests:		Array of request struct corresponding to SW1, SW2 and RT
  * @use_second_irq:	IRQ selection (main or co-processor)
  * @imr:		Interrupt mask register of MADC
@@ -161,7 +161,7 @@ enum sample_type {
  */
 struct twl4030_madc_data {
 	struct device *dev;
-	struct mutex lock;	/* mutex protecting this data structure */
+	struct mutex lock;
 	struct regulator *usb3v1;
 	struct twl4030_madc_request requests[TWL4030_MADC_NUM_METHODS];
 	bool use_second_irq;
-- 
2.25.1

