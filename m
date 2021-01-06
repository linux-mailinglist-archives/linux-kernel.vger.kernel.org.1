Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81C702EBE0C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 13:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbhAFM4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 07:56:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbhAFMzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 07:55:42 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F07AC06136A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 04:54:17 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id v19so2145064pgj.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 04:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UgCTOZP+iS7Zpfo/UYMAHF9VQ2ZJFjb723cKr3RX7Qg=;
        b=IK70e9NPRwV1gMZ/EU7occBXqZpRyUhyDuGkW9/mVy9xRT97IL8mcm5Mp//snREkHF
         +3GNX51QIwzU9hxWEBp2dMqsOyllsDYBeVfc5ik56T92OB+bcJ48Zz7T05lr9w+XBeHz
         8QvxqIzH+u6V0BjDIktM8124iJR1J0+rMMlH8r+6eEpSyQ9OGBd1Jl7ZisQ1SXcJSJ1f
         85ZCm5UbQ5jKs5B0oHTDfZsqyGSsZ950NEks/wRqWhlJvlx/N1QWtFOy17lVDYkenHPB
         k2V7wacuIaYX4XuDJgScPuMwi4DFvMJLR2aaTWsvxFJWk5kaLjA6H3DytD9mZCFGbA6t
         lySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UgCTOZP+iS7Zpfo/UYMAHF9VQ2ZJFjb723cKr3RX7Qg=;
        b=s1yuyHpKiqBhmt9eZGPDUWpG1IN8wNreO8WWt8lnR+f71MMqimgs0zBRP3dwcZwAC2
         dW1Pkp/lufOmIdzfBqixQaXf84XN5/5nye6LyJvn6a+mNOH43ldFqL+B2VCZG5mU4D6A
         3omg9Oi19hZQww4SZNy674aLFpUd2aEOTBQfawJqsiskosZE1M6x4Ec/2sa9Xb+dBM80
         KlJ4fUOt4abP3ls3vWFGXKAo4q0PDQ5/Vh2E3i5YBj0GHk80hQ0JN5UrvxI4vQA7h4cH
         Jj9H9IjZ6x0CSjYTZVqpv1yR9tuX0vPh8ti5BOHAgBdhObZC0pw7reiXOqMlrdoVnOo7
         LUig==
X-Gm-Message-State: AOAM532GGVbwmm5kCIwFV1ohWMco3jS9UiO+1KPDrl342ETCMDTydbQh
        lohFwciuFmRfmTcVV13NT10hRZcodddp
X-Google-Smtp-Source: ABdhPJzoOIOZrSRTRNRWtwHlbXCPcZou+nUjpIvVzVg0TjhQi5r+9UQDEp5sBG3GlX2AL6FdhJ+xbw==
X-Received: by 2002:a63:1865:: with SMTP id 37mr4435531pgy.206.1609937656963;
        Wed, 06 Jan 2021 04:54:16 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6102:e7a2:51f0:bf72:bf80:ec88])
        by smtp.gmail.com with ESMTPSA id n128sm2918182pga.55.2021.01.06.04.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 04:54:16 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v3 09/18] ARM: dts: qcom: sdx55: Add QPIC BAM support
Date:   Wed,  6 Jan 2021 18:23:13 +0530
Message-Id: <20210106125322.61840-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210106125322.61840-1-manivannan.sadhasivam@linaro.org>
References: <20210106125322.61840-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add qpic_bam node to support QPIC BAM DMA controller on SDX55 platform.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm/boot/dts/qcom-sdx55.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index 5c091787c458..fde3a9da68e7 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -139,6 +139,18 @@ blsp1_uart3: serial@831000 {
 			status = "disabled";
 		};
 
+		qpic_bam: dma-controller@1b04000 {
+			compatible = "qcom,bam-v1.7.0";
+			reg = <0x01b04000 0x1c000>;
+			interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rpmhcc RPMH_QPIC_CLK>;
+			clock-names = "bam_clk";
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+			qcom,controlled-remotely;
+			status = "disabled";
+		};
+
 		tcsr_mutex: hwlock@1f40000 {
 			compatible = "qcom,tcsr-mutex";
 			reg = <0x01f40000 0x40000>;
-- 
2.25.1

