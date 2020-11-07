Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 999E92AA4DF
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 12:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgKGL6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 06:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728007AbgKGL6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 06:58:31 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4B4C0613CF;
        Sat,  7 Nov 2020 03:58:29 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id t8so34881iov.8;
        Sat, 07 Nov 2020 03:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8TYaQhPWhE2R8SN/6kXesrx9+2H5np1CaC8Ta2eDNVk=;
        b=rj4ovlkHkI6QKRVvdjhEe570EgQctiw8Z5Owy1UDBhh162gk3fu2FYDMm0XMTf/whB
         C6/zqqCZtUiaTua7ASzVjciwMuPzD1InB3arceiwhvnc2u+hE5V91rOyK5l2TLXCZEdR
         uqYV5QLaSCkX+jwr3PAQpxJQ9eMFkHSjX3J3hbfHqMoqJpjQ50DKnwz+3Uh5/gTrkinY
         B/PttwMl4+OA945+1/1OfrAF3fa9tFeybGO75sOXwq9zWMqn8/FoseDaTmBMikyEfCo/
         IbxNcy5+viPdNJ2dCXsud/FgslYE3088bHBLCHNs65S8KtitQ15epyhTsIKADm7rzs6p
         7K0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8TYaQhPWhE2R8SN/6kXesrx9+2H5np1CaC8Ta2eDNVk=;
        b=hvQ43nUCE3Y7Vj1NBcAO1f84yaQgg0o2gZvHUyK9ZuRvuFRD42DDyOeGUXkfWB6hMW
         ByGY9nQs8ZUFGwztur/JSe/vfR2EpK1kwHpP5TZbioXZhU4uTWhO/Ohy5H1WDUghR8wA
         gKd6RfpGMixNLuEtJdLeDtDKWZx3lWA0kiF+9/qAaqj4Z1TVaAGpzlgN3Zu+idu9u2Xe
         Bmneezwf4PvWjOrKRItnIlNIuUQoukUWflJSD64pfPOUT1ewISNkMr/HJxU+0F2aywBC
         hk66qI41Onh1xfIiZ4xZrDHl8sb+PnuorJWcidlGXUXeHtvYmaQgRFKy/olc3gb+hckK
         9DgQ==
X-Gm-Message-State: AOAM530UXzkkBRhwYWofkw535UiEE74hZUhnMMxKhqPe9au/CMwyEafj
        kvDYFpu21RYfMJ6v40rD+u0=
X-Google-Smtp-Source: ABdhPJyY5Tbb3OWFmVsJp53JHxUlFvlR1sTIUcsrK+I9NWsmLE+FonU4MONfgm+V3KLAZD9WKOCTmA==
X-Received: by 2002:a6b:7a02:: with SMTP id h2mr4658314iom.171.1604750309145;
        Sat, 07 Nov 2020 03:58:29 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:5d9e:32b:1062:f8cd])
        by smtp.gmail.com with ESMTPSA id n1sm2920671ile.86.2020.11.07.03.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 03:58:28 -0800 (PST)
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
Subject: [PATCH V4 4/5] arm64: dts: imx8mn: Add support for micfil
Date:   Sat,  7 Nov 2020 05:58:07 -0600
Message-Id: <20201107115809.1866131-4-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201107115809.1866131-1-aford173@gmail.com>
References: <20201107115809.1866131-1-aford173@gmail.com>
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
V4:  No Change
V3:  No Change
V2:  Change micfil@30080000 to audio-controller@30080000

 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

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

