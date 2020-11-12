Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A90B2B025A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 10:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgKLJ52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 04:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgKLJ5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 04:57:21 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25D2C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 01:57:20 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id s13so4893533wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 01:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yQkw2l9WIpkjYhKP7Ul2HuGuzOBTh63oL9grzgjK3CQ=;
        b=bcdviuqNSoOpm26doGhfbZW/J0FexDO8vOQFu7IWvGhijr7A8u/sPf4yBz6G5YiI8/
         6aTv7L3ClS2xuaXAsY0DOqQoIazieic2n99F8+j9ilpSKk7v5cpwI8/fG7yqnKA24x4D
         DDWg32nUnf3syXxMho4jlWnvBvGVEIe++06+6/CgScMkH/UkslPVucVVyCGTeEKIEnMh
         r8i7rHwEqz7bdohi9sIpIPSmNNfKVyNw2gKygfM9pMQPSGQKAdYKihwFb0oaoynZBCul
         4Loctrxsw4UvrekgGLLjiUPjTR6R0Vr2mVddTXWJyZK0Q9Xrk5MBRUlDKr1nyBFVMXyt
         yhcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yQkw2l9WIpkjYhKP7Ul2HuGuzOBTh63oL9grzgjK3CQ=;
        b=jVxPwmmCjk37k1kLFM2Bn2BAozY6X60d1iWUlRMdMXR4TxvNmw9RmgGd9zTMWrf3AO
         4CVikp0L95A3RKKxdpiOqoSPL1zZMo412PaXwXlM3acQpgBFaiaXfXiArZmiLIepZ2RV
         vPwvKdC+QHbWFyLoXz3lZLQiZrhElvZhqiOUmIZ8VWSZ9CNvPRcP7eX3Y3RxZV0TxhtM
         iO/Jyek/0LL1dr1WSSv8lznrSnF5NSTX2YiTey/9OIx0yqY5jEndICDT7nojhfGIT6/U
         Ft6XGx5fe9IsucLk9F/826fZGx7853TBBnwfbKy3MBnw3dguH4vaZf70jnZO48wamZV2
         VnvA==
X-Gm-Message-State: AOAM530KlPcIdAtRtXvnAEuH3Mhc8lOwKjt7nIS62kafaed4BqbmbPpu
        KrBfvondK0c8m3+4Im2pCICp3A==
X-Google-Smtp-Source: ABdhPJxoLAGJ14e0h61QfThiqt5zvB6EWwk8u8Mxfn0uS/id1tAexeu96ZnmI6IHXqr8oGCebTjY5A==
X-Received: by 2002:a7b:c77a:: with SMTP id x26mr8804584wmk.63.1605175039365;
        Thu, 12 Nov 2020 01:57:19 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id n15sm6138792wrq.48.2020.11.12.01.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 01:57:18 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Beniamin Bia <beniamin.bia@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH 1/3] hwmon: adm1177: Fix kerneldoc attribute formatting
Date:   Thu, 12 Nov 2020 09:57:13 +0000
Message-Id: <20201112095715.1993117-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201112095715.1993117-1-lee.jones@linaro.org>
References: <20201112095715.1993117-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc expects attributes/parameters to be in '@*.: ' format.

Also fix repeated word "the the".

Fixes the following W=1 kernel build warning(s):

 drivers/hwmon/adm1177.c:40: warning: Function parameter or member 'client' not described in 'adm1177_state'
 drivers/hwmon/adm1177.c:40: warning: Function parameter or member 'reg' not described in 'adm1177_state'
 drivers/hwmon/adm1177.c:40: warning: Function parameter or member 'r_sense_uohm' not described in 'adm1177_state'
 drivers/hwmon/adm1177.c:40: warning: Function parameter or member 'alert_threshold_ua' not described in 'adm1177_state'
 drivers/hwmon/adm1177.c:40: warning: Function parameter or member 'vrange_high' not described in 'adm1177_state'

Cc: Beniamin Bia <beniamin.bia@analog.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/hwmon/adm1177.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/adm1177.c b/drivers/hwmon/adm1177.c
index 6e8bb661894b9..0c5dbc5e33b46 100644
--- a/drivers/hwmon/adm1177.c
+++ b/drivers/hwmon/adm1177.c
@@ -25,11 +25,11 @@
 
 /**
  * struct adm1177_state - driver instance specific data
- * @client		pointer to i2c client
- * @reg			regulator info for the the power supply of the device
- * @r_sense_uohm	current sense resistor value
- * @alert_threshold_ua	current limit for shutdown
- * @vrange_high		internal voltage divider
+ * @client:		pointer to i2c client
+ * @reg:		regulator info for the power supply of the device
+ * @r_sense_uohm:	current sense resistor value
+ * @alert_threshold_ua:	current limit for shutdown
+ * @vrange_high:	internal voltage divider
  */
 struct adm1177_state {
 	struct i2c_client	*client;
-- 
2.25.1

