Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC322EAABB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 13:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730143AbhAEM1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 07:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730130AbhAEM1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 07:27:40 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52953C061795
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 04:27:00 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id lj6so1589466pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 04:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DxgWqwKwqFym7GE4OKnS1/iwRMLr+x+z7Qj6uMJA0Lc=;
        b=YkEiw1xNxnan6Av8Gy6XOzI4ceb0QksuFADkgTccA4gs7I7FrQJTluFqNYsQpbt4+r
         ALqREvrgIrBzkr6etyVJ/rA9XIPeDQ8dJecQ8YPtJShsjssEYGRpj3b/pcLEnXZo3fQv
         V/8S56MTBeyAft3vgzIyVB5c8lVidWpg5GJdVIXZRZVDYJ96+pMgLieNeHhfbgFUuEnj
         fKGRXFLHfqgevtKlW+XLDkdp9WGb8BLOBsh7+Z/wW510Lxzegyzk0fFfYpziSQg/hsLl
         Bn8ODvrhOVUTnaUmLhF+NAUSQrp+/3TgceR1VlM0Eok8RCG2Pjqy5Fra6ulw1xv+Wa0Q
         fMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DxgWqwKwqFym7GE4OKnS1/iwRMLr+x+z7Qj6uMJA0Lc=;
        b=aNJ/rz2BAvrp8GhsAqKX7Xt4zmz+vqBF4lKd0Ap+oe33fn30SasfzoJ7EDy2SF1apZ
         /62JyvPO+gOo5oIZjfwES6HRKczDHKDhfu9oCwbdYbKOZ37TO6LoXxCo0FnOsyK3WJu1
         fXG0p59z5Oi7H19frd814MYV8PVf+mH9J0lkRUeRjnWTVJKYlNp9x4Y/4SfXPHWBw/k7
         lq+WBJUE9REo07ddw9tQ4iS0yT54pUYlQYacc8KA/8IbpJDEcEYsispy+Bo68oenWI8d
         x49wP6H3NOiqMypf4su7tZX/AINy8g90uhTT8lSzWe1ceoIVhf36lzi0fIVPXdvCqaKl
         NI+g==
X-Gm-Message-State: AOAM532ur3kzH0rykwg5Lme+Lvlaa3L4XuJHkz+piGY8NJRQcDiGAY4j
        8Sb0E2W2Ss57Kw565LqCG3vf
X-Google-Smtp-Source: ABdhPJy2ec5b3ccwTavvmXOiWFzdcc3FN+errCF1OIyp3UH43VEj38qbiAjCD4d49DSw5Ee8V9X63w==
X-Received: by 2002:a17:90b:80d:: with SMTP id bk13mr3819963pjb.41.1609849619921;
        Tue, 05 Jan 2021 04:26:59 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.191])
        by smtp.gmail.com with ESMTPSA id t22sm64745402pgm.18.2021.01.05.04.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 04:26:59 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 01/18] ARM: dts: qcom: sdx55: Add pincontrol node
Date:   Tue,  5 Jan 2021 17:56:32 +0530
Message-Id: <20210105122649.13581-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210105122649.13581-1-manivannan.sadhasivam@linaro.org>
References: <20210105122649.13581-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vinod Koul <vkoul@kernel.org>

This adds pincontrol node to SDX55 dts.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index ca7d4e4f5d11..08b4a40338fa 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -96,6 +96,16 @@ pdc: interrupt-controller@b210000 {
 			interrupt-controller;
 		};
 
+		tlmm: pinctrl@f100000 {
+			compatible = "qcom,sdx55-pinctrl";
+			reg = <0xf100000 0x300000>;
+			interrupts = <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
 		intc: interrupt-controller@17800000 {
 			compatible = "qcom,msm-qgic2";
 			interrupt-controller;
-- 
2.25.1

