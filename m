Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78DF12EAAC8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 13:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbhAEM2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 07:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730174AbhAEM2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 07:28:21 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9497C0617A2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 04:27:10 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id g3so16294338plp.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 04:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C3M1yGDo9sOujbh6Y3dKya3WVnGla1Jyt0Z8LN2HYb8=;
        b=lWgXQbyeAH+r0IxZoUcMpGxTqfmKINUBLurrnT5lDJuzGrqn+HUQw4bR0oIYnu3ARW
         bU++L4PLGLVP1/DEyx8M1mUFNnX9Qq1uvEZY3DFOtWf1n9zgzZEJiQ1NBJo7GcT5SN3t
         dIHMPT6qaZ9PmbGZoRzcTsY6LB2APLLkHj+C3tDqjU3hKzjlTH3+6tHc8aeZPyxR+vlN
         wQPlw2jBQrR5qfOJ/Ex1esZHxanlm0RNDKdgV6wNML2e5ajwG9gT4WaFl/isZ2aWOXVR
         j6y3piF7vIZgf/JgTt9e/2SMs675tBOWtcUip9HUQ/Ta+oqY2/ELKm0dbpvWITHzbLNO
         Oo6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C3M1yGDo9sOujbh6Y3dKya3WVnGla1Jyt0Z8LN2HYb8=;
        b=BxWqZgI2H94kKXhDjEUU/p+YHK9HcZxuqzw4BODyiDlK4H7nQgPtCCPcNvciga0hhD
         C9OLC9H2x9eRcOSs+kNu/xKEoBzKgtZinI4Ee9Puzf/vtKSwbIFdmyH4bLOMzFkGTS2Y
         QFBWeIwfM7H2KTfCKJRNdp74xwXQVmV0LjmeNHqNzFOuy2MEYHGOdwE8T5T8WFKwJOYt
         TNyLwcg6+wIJKUx48An6yvIA21ShGG/Ikh9ICFCWE9ZWbq5DfeiFO33i2e78p0TYhEYm
         RTdd1T/7u46b9O+BfrvuW+wCx+CvYt/I1ZfAdtOgEovq5H18j+nKk3qGFL7IAwthgViH
         pGvQ==
X-Gm-Message-State: AOAM530yiedfUi6cOhHMrfm1Lalq+B3grrF/EV2HmMY7lQYpanfp9sMa
        i6SUBidknWgYyRc/mhZr64t9
X-Google-Smtp-Source: ABdhPJyl0xfDD7ostLazfnoFDV8J/lLR+j/jvHs5YOuY3Ze8MnPvwcjv6/jNlkHsnJ1O4UzFVTEBaQ==
X-Received: by 2002:a17:903:22cb:b029:dc:8ac6:98ab with SMTP id y11-20020a17090322cbb02900dc8ac698abmr16157763plg.67.1609849630430;
        Tue, 05 Jan 2021 04:27:10 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.191])
        by smtp.gmail.com with ESMTPSA id t22sm64745402pgm.18.2021.01.05.04.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 04:27:09 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 04/18] ARM: dts: qcom: sdx55: Add support for SDHCI controller
Date:   Tue,  5 Jan 2021 17:56:35 +0530
Message-Id: <20210105122649.13581-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210105122649.13581-1-manivannan.sadhasivam@linaro.org>
References: <20210105122649.13581-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree support for SDHCI controller found in Qualcomm SDX55 SoC.
The SDHCI controller used in this SoC is based on the MSM SDHCI v5 IP.
Hence, the support is added by reusing the existing sdhci driver with
"qcom,sdhci-msm-v5" as the fallback.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index eeb6bf392f93..3f8e98bfc020 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -154,6 +154,18 @@ blsp1_uart3: serial@831000 {
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

