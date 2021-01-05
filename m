Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B3D2EA7F3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 10:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbhAEJsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 04:48:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728630AbhAEJsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 04:48:21 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE9DC0617B1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 01:47:14 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id x12so16070073plr.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 01:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=krR0mmg8e2WHKAWsbc9kCR1LNZ0LFktieOVnJDiTgLs=;
        b=Vdu21QJA3Iy2/nZZZOeEVMKiQz4yFRKfYNrXjhrfLO963YEjIeFU+IEF+zwk5jedo9
         y3tF8gnQjXmIiXxt+ykQ1wsN8Yigg651AyoeLXBsudLqcXBrnC5c0h0KKiCTmjXKF3Fg
         jO3TTQ/FReVwcYhcOex5OmXacYETTI6RjgTSwMMzrW5zDBiUgNAm9H50MfHnPFYTvRu8
         aJ6wgg7ChDbBTMz8mPnDHmQLRAySBAEVsyXIKhWy0FxxkNDSESRXIdPS8nKSVOrJ0e0o
         sPhTNyf3eWAG7Lxnbo3y9dcJwLbWMRjNnPP9/GNDoIFhkJAOO/2MFr79P3pC1gsSjbSj
         2gvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=krR0mmg8e2WHKAWsbc9kCR1LNZ0LFktieOVnJDiTgLs=;
        b=JmTO4Mxn8aaebEQcRF51RgzcnFyL7mTwYp6HGPrdKHffHz17nXrQQc5gQKxs7DhI58
         i7gwHp40nOc1PpuzkPOTQOyAS/g7KXUOAQUD3AkeGbjp8pk59e3nia30opKZ379avhB6
         gFbEqhxE7AfDv5Lz0apYWcaQsRvWghPITnsYMViC6LCa5lu9j/7fepKjhnY6LUAHHRwJ
         TMDeF43RItBnPixoYZnLJjHuoM16mRK5HC0QovxAzDFE2gxrLqDLeGkFq2hQefhNLtYp
         GLnosphMcKtSK9se3lfwQXA6KbO6KOejhLCnyLqu3saGG82Y29xlXdmJVVA7zvzDa5JM
         9Hgw==
X-Gm-Message-State: AOAM532r9xxRmGmgHyxNWwXvheWIVnwgblwZ/fEy9c6kgd5d9IPPdC3B
        Wqx714UUWgk0msMPN4iQXiE6
X-Google-Smtp-Source: ABdhPJzilSIgGKfMzHm6OkFOFEHydpliOTxyesLprTKuYSDlpJUbZEw+fNiOUqFysjFkGpPxAUHHcg==
X-Received: by 2002:a17:903:2307:b029:dc:8e14:a92d with SMTP id d7-20020a1709032307b02900dc8e14a92dmr11760378plh.57.1609840033603;
        Tue, 05 Jan 2021 01:47:13 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.191])
        by smtp.gmail.com with ESMTPSA id f64sm60073921pfb.146.2021.01.05.01.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 01:47:13 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 09/18] ARM: dts: qcom: sdx55: Add QPIC BAM support
Date:   Tue,  5 Jan 2021 15:16:27 +0530
Message-Id: <20210105094636.10301-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210105094636.10301-1-manivannan.sadhasivam@linaro.org>
References: <20210105094636.10301-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add qpic_bam node to support QPIC BAM DMA controller on SDX55 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index 622a63b0058f..1b9b990ad0a2 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -166,6 +166,18 @@ sdhc_1: sdhci@8804000 {
 			status = "disabled";
 		};
 
+		qpic_bam: dma@1b04000 {
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
 		tcsr_mutex_block: syscon@1f40000 {
 			compatible = "syscon";
 			reg = <0x1f40000 0x20000>;
-- 
2.25.1

