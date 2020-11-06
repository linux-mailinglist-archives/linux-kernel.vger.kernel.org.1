Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2602A9519
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 12:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgKFLQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 06:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbgKFLP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 06:15:58 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9BCC0613CF;
        Fri,  6 Nov 2020 03:15:58 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id k21so1052636ioa.9;
        Fri, 06 Nov 2020 03:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oL4hgtXKD4lqF85ucRr8aT2P9eazH1/qy4PK+2hHh90=;
        b=LvxHoIPAqm4x1qSqlaEAezNBdmcuMdzLMfGOIY7dBRyIPN8G4j9Bpcyt1vIu2fX2qh
         Fb0Uri9pS0hxog22U1xUWQilVeILHKKIqX1SwE48ahArfVPMF67eX6gqsbB0/KK0RqAa
         z13+oMjm4AtJ8i/+JICtH3hhP7yIrDao8sDXr2J3AXYUtKai4/xb1MDQKhkLuFl/15Qh
         Z2BllZmQVINtZeZxkO9e4GWz1ePqTqHcl9E+33lTUBIqRycFfiNhOWoYMuWCGFzTDrW7
         hYgwRiTYxyobg7IXrhBZeNOE2P25yADWQps0FQoLbRFQBRhFvKHlvqToazwtXSsH9L+C
         n1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oL4hgtXKD4lqF85ucRr8aT2P9eazH1/qy4PK+2hHh90=;
        b=oaUPgpo4t90XaNfs3Vn4vQvnK18RBNgmRmN/vg8AIFtVGvMgftWRvjM8C/BL7sOJ2+
         0+f7Wi/zc/RcUTOGjaaIrkjcl0nuIMRr52oswgJTEJ2KIy4WkmWzteg8v6hdOxDJqOQY
         H63sueXhU7sU7uE0PxJVlxUz3Qc6nddipe1M2JLX0R5CFtDNPmD25mA8ruTCY8Bu3F+h
         VX9g2yz3YOV7D8Tr2XSiTOjhykTbaRMl7Eif61RQxaUi/G6B1DIiYXyXGrdHBNNk35hF
         oAVMRLqA8OR577YF5BVGpwTK+NeKIkbe1bq8TDma4CiW5jVZSvAvHbh2g1QDvsYi4it8
         dEiw==
X-Gm-Message-State: AOAM53364c7t0hocLbWNcWsMryMxlL0QOX39g/1oJyPx6VlZjU3RBB4/
        ZJzu4/XKImsiOfG01dAp3H4=
X-Google-Smtp-Source: ABdhPJyALzSW1IAdUmrky5MbNqm5GA1wV+xTS18uejlbn4aSmKwcThmkIw3V1ppZ45sx1vqXgvXhZg==
X-Received: by 2002:a5e:9244:: with SMTP id z4mr1028896iop.53.1604661357568;
        Fri, 06 Nov 2020 03:15:57 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:8492:7d60:7e29:2784])
        by smtp.gmail.com with ESMTPSA id x5sm854597ilc.15.2020.11.06.03.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 03:15:57 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 4/5] arm64: dts: imx8mn: Add support for micfil
Date:   Fri,  6 Nov 2020 05:15:42 -0600
Message-Id: <20201106111543.1806809-4-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106111543.1806809-1-aford173@gmail.com>
References: <20201106111543.1806809-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX8M Nano has supports the MICFIL digital interface.
It's a 16-bit audio signal from a PDM microphone bitstream.
The driver is already in the kernel, but the node is missing.

Add the micfil node.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V3:  No Change
V2:  Change micfil@30080000 to audio-controller@30080000

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 6ea0d43a78a3..aa3f1eb391bd 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -318,6 +318,25 @@ sai6: sai@30060000 {
 					status = "disabled";
 				};
 
+				micfil: audio-controller@30080000 {
+					compatible = "fsl,imx8mm-micfil";
+					reg = <0x30080000 0x10000>;
+					interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+						     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+						     <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
+						     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MN_CLK_PDM_IPG>,
+						 <&clk IMX8MN_CLK_PDM_ROOT>,
+						 <&clk IMX8MN_AUDIO_PLL1_OUT>,
+						 <&clk IMX8MN_AUDIO_PLL2_OUT>,
+						 <&clk IMX8MN_CLK_EXT3>;
+					clock-names = "ipg_clk", "ipg_clk_app",
+						      "pll8k", "pll11k", "clkext3";
+					dmas = <&sdma2 24 25 0x80000000>;
+					dma-names = "rx";
+					status = "disabled";
+				};
+
 				sai7: sai@300b0000 {
 					compatible = "fsl,imx8mm-sai", "fsl,imx8mq-sai";
 					reg = <0x300b0000 0x10000>;
-- 
2.25.1

