Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD6251F20E3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 22:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgFHUop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 16:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbgFHUo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 16:44:27 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70A9C08C5CB
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 13:44:16 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id er17so9047093qvb.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 13:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GeS57nqw38MaaFBYUxKJYofMdDxv41hdDhrvNhyT71U=;
        b=izdEU63JBRBlTIYJi2dlajVxsC8GIc4Ja/EpX8IoEH9m3Yn7PzeiCBuziBJZcx7QTH
         eivbQrpXFzyiiTg2BOzbVMqeIqULBRWtbCi2XF63rprhzLG8fC1njxBHqij2l+CFNQ7b
         KQrcLbl2n+GQTAtCjAr0JSThSCzSBvqRVda8jbeh6/7SlCmdGkxeIoegb/trCvXaXV0u
         /yCRDWK0omQYvulLWHYXOrBD8c6OWcsydoLf9GPU3vc16Jick4vv1eLmeI0Ayrw+XKKC
         +WFK8YNB4rWVq5uPOXneIjJOb3ysYiOCA5nlkV9Vw3SucwkKjU6lcSAen7GhoROgV/jC
         +S2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GeS57nqw38MaaFBYUxKJYofMdDxv41hdDhrvNhyT71U=;
        b=W/dW19dSOhnCMmqk6O8g+aFuDpxXyLeMcjCUpMCz2wdTwQddMXEARa7MNVIJcWQSdM
         Kmy2Jr0l4tA0bC/ZJZ96cF6Dg6wZ121504Blmx74biPIRROXzOJPnjkS9BqVz2XVkEqF
         4t4dnm778CxML/yDHj0LYfEgvUCvnHvwCm+BEAtUwI2RWvi0Fo28/J3gcukM/Jyocenj
         MzYdz3BPleyXpPun66BgzTGiDizzD0LbDzAkCs0OBM95qClW2aUsVo3B9u0pAiyzMecz
         nHbuBAuIGYSPlXiJtPtNocwHjeFw02Ioa/FELa+L2NCV1KB8i+kv26SnmS1eBFBLELsc
         wIgA==
X-Gm-Message-State: AOAM532Iy/qVWvXCD198qrlqm0EvzyDjWANLpA3JmkyhCE3q2w4M861K
        xAYXaxLnPA6rnJ4lbTLzGvRpAQ==
X-Google-Smtp-Source: ABdhPJzp1kY0Eq7ZnTPcv/fOpYkKQkoZv/tdIOc8Qlnkptw4yJZWeRurqIVGk4BRqBQE3LECzd3F8w==
X-Received: by 2002:a05:6214:aaf:: with SMTP id ew15mr576826qvb.110.1591649055572;
        Mon, 08 Jun 2020 13:44:15 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id y16sm8895565qty.1.2020.06.08.13.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 13:44:15 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     alsa-devel@alsa-project.org
Cc:     Vinod Koul <vkoul@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org (open list),
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT)
Subject: [PATCH 4/5] soundwire: qcom: avoid dependency on CONFIG_SLIMBUS
Date:   Mon,  8 Jun 2020 16:43:45 -0400
Message-Id: <20200608204347.19685-5-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200608204347.19685-1-jonathan@marek.ca>
References: <20200608204347.19685-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver may be used without slimbus, so don't depend on slimbus.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/soundwire/Kconfig | 1 -
 drivers/soundwire/qcom.c  | 5 +++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
index fa2b4ab92ed9..d121cf739090 100644
--- a/drivers/soundwire/Kconfig
+++ b/drivers/soundwire/Kconfig
@@ -33,7 +33,6 @@ config SOUNDWIRE_INTEL
 
 config SOUNDWIRE_QCOM
 	tristate "Qualcomm SoundWire Master driver"
-	depends on SLIMBUS
 	depends on SND_SOC
 	help
 	  SoundWire Qualcomm Master driver.
diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 14334442615f..ac81c64768ea 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -769,13 +769,18 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 	if (!ctrl)
 		return -ENOMEM;
 
+#ifdef CONFIG_SLIMBUS
 	if (dev->parent->bus == &slimbus_bus) {
+#else
+	if (false) {
+#endif
 		ctrl->reg_read = qcom_swrm_ahb_reg_read;
 		ctrl->reg_write = qcom_swrm_ahb_reg_write;
 		ctrl->regmap = dev_get_regmap(dev->parent, NULL);
 		if (!ctrl->regmap)
 			return -EINVAL;
 	} else {
+
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
 		ctrl->reg_read = qcom_swrm_cpu_reg_read;
-- 
2.26.1

