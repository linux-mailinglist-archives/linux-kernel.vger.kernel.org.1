Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA212EBDF8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 13:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbhAFMzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 07:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbhAFMzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 07:55:16 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484EEC061364
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 04:54:05 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id m6so1660550pfm.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 04:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dcjq6ySHauExsv9V4q5630OQKP0ygTy3/BVfo42I6Bs=;
        b=ovfmRKYouCXn0IzBiLyVatNfL2wv89xZURd3oCdiX1D2wCa53ktoo9XsUvh2QHKjxH
         QYAOEXjt8B6YMnKg41frSkA3GjkO+Q88XK2fDTQbcZ812wmq+mdjhqmDUr2yC7Rbm1go
         RS/PtW/MOV79HjNEnm4rhNPGrL0Owg26kVXnCe/wYnLJJ+fvtsyi99KZq9hH+WWzl8xq
         en82RtJZcAyf8fQm+mUIH2SOmyX7WOQVZc47YlNudpH0UU7NzmT9JritaR20Sw2lUt0n
         OjEeRQHv/Ah8U6PVNBNBU/nnEoyT+e0HLbdi81M1e/PVNjsSq2LXnn0KKUbEaw+JPPTw
         M1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dcjq6ySHauExsv9V4q5630OQKP0ygTy3/BVfo42I6Bs=;
        b=Mxs+0xYDSdZWAENLfUdDXnh0q/Byb5g1NHmG1G2UtL85f/2r4DMn2gBqUclezrU4QI
         mJpBLSubMmTdgYuQIzdj9vFMY+DVUVP6syTGTCnP4JUBEXo0CwoxtslqCNSou7T0f4bl
         uAoMG4B7WieuWg8bn+2lUHwOIRZvJ5jA8N/IlbW19WwM/ngvZoKlKCX+kEMyv0VnSQBC
         +nXFbBLp4uWJUKJOoFNfm7XF82B4czjXExIaKz2cIckqsiPtZNdSK/g7KpNVcYvIfS7s
         +fJ3zAy8SzBfmSOJPyPtFFcnBkw6fxa4el7icj1y8s5nzu+qE3zqwAfCrXks58Q7OYIr
         h9YQ==
X-Gm-Message-State: AOAM5300TXnU0YG4D9YmsLhChU/t/CaJryPGOia3UkDBExGCSPgu2RXS
        A1rgZZb77+DdSKlnnZKKGlyf
X-Google-Smtp-Source: ABdhPJx5ZWCJw0kYB5dk0UaP4J4XL4qJvsMVaEFDqCtYCo8TyrlDc6Z1ylI8SGHbWHU46bexhK80hA==
X-Received: by 2002:a63:77c1:: with SMTP id s184mr4309628pgc.376.1609937644789;
        Wed, 06 Jan 2021 04:54:04 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6102:e7a2:51f0:bf72:bf80:ec88])
        by smtp.gmail.com with ESMTPSA id n128sm2918182pga.55.2021.01.06.04.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 04:54:04 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 06/18] ARM: dts: qcom: sdx55: Enable ARM SMMU
Date:   Wed,  6 Jan 2021 18:23:10 +0530
Message-Id: <20210106125322.61840-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210106125322.61840-1-manivannan.sadhasivam@linaro.org>
References: <20210106125322.61840-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

Add a node for the ARM SMMU found in the SDX55.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index 8b71f476e5b1..d78e1123b422 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -170,6 +170,30 @@ tlmm: pinctrl@f100000 {
 			#interrupt-cells = <2>;
 		};
 
+		apps_smmu: iommu@15000000 {
+			compatible = "qcom,sdx55-smmu-500", "arm,mmu-500";
+			reg = <0x15000000 0x20000>;
+			#iommu-cells = <2>;
+			#global-interrupts = <1>;
+			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		intc: interrupt-controller@17800000 {
 			compatible = "qcom,msm-qgic2";
 			interrupt-controller;
-- 
2.25.1

