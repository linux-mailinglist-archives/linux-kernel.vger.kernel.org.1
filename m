Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047DA2EBDF1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 13:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbhAFMzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 07:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbhAFMzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 07:55:04 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E688C06135E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 04:53:56 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id r4so1487807pls.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 04:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4f6Doc0dS1yZ2IXHgqMpKz/2VTxor/Phil/0B11oX0Y=;
        b=IPnRw5+xkAOsx/g01cDapsdINozu5g4jMhVdyzsKZct4elXMJIYLpIX4cjIJ4xws4v
         ho4dhjtKaFsbmjjmPShlAfPBIOcF3/5kC7BkuME62WXLd72wjl0B5cg2/UoFmw/vtGdz
         CLdRjiMoAuEUyWzNkejG1XO6uLUFLEPFxVP96zXaBrvmQrW01gAX8T6puoj+ItYDCPgv
         ddNRjCe5wjr92/I52OA2E9Km2NFqH35ua3RM40KZKIbqVIs/krpd1/NHrQXrC26pPzzM
         UQQSAqMZDrf+KOVZRtYnppJhTWBKS8e0uGiR7HotghvPb14Jo2CjFHzLbqZeu2qSzY6e
         UkUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4f6Doc0dS1yZ2IXHgqMpKz/2VTxor/Phil/0B11oX0Y=;
        b=CxDC6KC75JeZGJLbJpttucgyh54DWDQ38j3TTDCaBp0lCI+HuLoHIUDvZeYEsGPs4y
         nsmpHn9kt56K+6p/CN9mzYuhbErsrHrdGzC2LmRz/9g3cjHbif1KKxVkblDYGE4HcTHT
         8KjnPT8IAYrkUXOJ+JzgGYs7dLZpvOVMBApfRArpBOR2wZHYXVxHeKVWzR+eh5KJyZgM
         y6KQc4T9opB8FXda0/h3nYbRR7/f078ZLWfBXbvOa6UkzlnSBtgfdgX5CV8AIHlWhTaX
         uNkFvARrbqp0yS9e+24Suw94yHlVY4+9GtBfcr7TZrNtNSj+qkY4e9mNWJZPzvEicYDm
         OjJw==
X-Gm-Message-State: AOAM533XUutrXW/Gsej9z/KGTfyZQ+bQjjtX7ENchaY3KMW9aerxalSx
        EzMQ/gX+RFKzQx61bjCjnurS
X-Google-Smtp-Source: ABdhPJyA4ZkYo24CYbsSb6qaA4OoCqoFwuBn5LIFRriPQvm2Tlg780GJPG2TcOPUZVhtQy1EAoKXvA==
X-Received: by 2002:a17:90a:8c87:: with SMTP id b7mr4289488pjo.158.1609937635598;
        Wed, 06 Jan 2021 04:53:55 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6102:e7a2:51f0:bf72:bf80:ec88])
        by smtp.gmail.com with ESMTPSA id n128sm2918182pga.55.2021.01.06.04.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 04:53:55 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 04/18] ARM: dts: qcom: sdx55: Add support for SDHCI controller
Date:   Wed,  6 Jan 2021 18:23:08 +0530
Message-Id: <20210106125322.61840-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210106125322.61840-1-manivannan.sadhasivam@linaro.org>
References: <20210106125322.61840-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree support for SDHCI controller found in Qualcomm SDX55
platform. The SDHCI controller is based on the MSM SDHCI v5 IP.
Hence, the support is added by reusing the existing sdhci driver with
"qcom,sdhci-msm-v5" as the fallback.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index 194936064884..8b71f476e5b1 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -139,6 +139,18 @@ blsp1_uart3: serial@831000 {
 			status = "disabled";
 		};
 
+		sdhc_1: sdhci@8804000 {
+			compatible = "qcom,sdx55-sdhci", "qcom,sdhci-msm-v5";
+			reg = <0x08804000 0x1000>;
+			interrupts = <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
+				 <&gcc GCC_SDCC1_APPS_CLK>;
+			clock-names = "iface", "core";
+			status = "disabled";
+		};
+
 		pdc: interrupt-controller@b210000 {
 			compatible = "qcom,sdx55-pdc", "qcom,pdc";
 			reg = <0x0b210000 0x30000>;
-- 
2.25.1

