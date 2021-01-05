Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 301402EA7EB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 10:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbhAEJsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 04:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728543AbhAEJsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 04:48:21 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF078C0617A7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 01:47:04 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id r4so16069561pls.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 01:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iO5icBTtHtBZIDqzVqO0jX3ryjCGhCk+9IrH4cJEnWk=;
        b=KtecjC8I6JFDZcjyQDzsyn8sevbZsrMt1Mq4ZgX15WgRio8COCucMu0VAoaoBMzGaK
         /KleL00sLZiWZYWIl/QDP+tPX0jtvJnGw4tYoD2Ti4yeBzRmjpKV2Fpm1wSJ0pG8e4SS
         7LUPRKduafsvoF7Q/MpUx8CT8PwKuu1hCVXFZME1QQkNBzmciUWe02RgXldGq3NBlK2R
         AUeKFKvZvHiYMUF42xQvDUkSfkYlP/T1PcvB11tqlkv/w1w5ko4/Mz0/j3c+1bI3YFVP
         E4V5wT7FwePi+3a5ZbkpbDOgRtFGcdUtJfEkwa+B8E6AC3ILQH/DMryKPBuAPjbaOKcR
         VmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iO5icBTtHtBZIDqzVqO0jX3ryjCGhCk+9IrH4cJEnWk=;
        b=sraLh45Nq9M21Cnl9S7xAJ/mZAQPYcIBBa8mtreSHwT/8tnXlk7iTlUYg+6RL1AO9W
         LvOEvjpNCNA++tDk7ogifSqJk6pnmqYatH1/8+MMA9VWJFfK2fQjuG7BJYe03JLx3j0F
         Ja0g5jDiedVQHdp1h7yCcsDGPHmy6+k738Fm0H+2PZ2GY/DVzzYzIi9iNM2tHVz5ax6S
         FaroTw1Wc+a+l5btKrEq9axc22qlkHSdXNMt7V1htmFrP10oCnv6ClWoZq6tz5AcqB/9
         2D1A9IVm7Mf0R5kqLj90wI7wIhS+GQBSXOXZFlDCEdUzEIv+IRTMbLjSZcMoYpFOL6YD
         DGzg==
X-Gm-Message-State: AOAM531GgagDq9egtO6ZT8kkJg0/xzr25sDQ+n00NQDPvatDUgzqitLA
        4hHVONh6vt9UdwhBP1/lRNke
X-Google-Smtp-Source: ABdhPJwhE0IEPYTpundup54Ph13PlfZ87V7fgku09QlGcCJ8Yk2jlL7EvHZW/ONjlWnsmzB4X30f1A==
X-Received: by 2002:a17:902:6a87:b029:da:e253:dd6a with SMTP id n7-20020a1709026a87b02900dae253dd6amr75008610plk.81.1609840024320;
        Tue, 05 Jan 2021 01:47:04 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.191])
        by smtp.gmail.com with ESMTPSA id f64sm60073921pfb.146.2021.01.05.01.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 01:47:03 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/18] ARM: dts: qcom: sdx55: Enable ARM SMMU
Date:   Tue,  5 Jan 2021 15:16:24 +0530
Message-Id: <20210105094636.10301-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210105094636.10301-1-manivannan.sadhasivam@linaro.org>
References: <20210105094636.10301-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

Add a node for the ARM SMMU found in the SDX55.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index 3f8e98bfc020..927f43a7414c 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -185,6 +185,30 @@ tlmm: pinctrl@f100000 {
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

