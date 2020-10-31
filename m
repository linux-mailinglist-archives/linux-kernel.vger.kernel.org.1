Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B49B22A179D
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 14:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgJaNXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 09:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbgJaNXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 09:23:47 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710A7C0617A7;
        Sat, 31 Oct 2020 06:23:46 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id y17so8986572ilg.4;
        Sat, 31 Oct 2020 06:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2BAE0GAYrZ+h/fvEAymXxBYp5Q9nZ7l93StEnx8WCVo=;
        b=oa9arIuUwp7z5k7ieLHUvYeT4v99c95V2hyjeo1/RpOYoqIxQlTEvSANWoykAgkycy
         Ddc0lAo0ibwRjNWTWYDKiR+rr3tHbY4OIHvOYRzg/wDyerhySGjn7XE0P17ibFTLh2ZV
         yAAV59mbWVfA2yEfXeIk8fOhiyxgfpKFLJAsiAO5M1WVYDZE2Dbve+L0uZWYSNobryp+
         Tj1nsTxZaoLCTUkos5mXKuelEmV9HM3qe+eIFF5kHGCYBDPkWyJRo0RB+key0/NAd0J8
         4oUc4VJqCBNDxzDOiAzX4KE+kV7fWGCOD7tkS4x/wXJTBDKAQwd7PQnJ+CHHjznGOTDP
         tNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2BAE0GAYrZ+h/fvEAymXxBYp5Q9nZ7l93StEnx8WCVo=;
        b=NyirX2aOTxOcgAycaP/jfLHVs2BJxv1Auc6yn8qjLd8trRJrNHjqCkegnnMZ5N1pCu
         yG8S/HU57xWivOhWAglvmUmZUrAOnjrzxDIn9XTDu+rTadXgd1oUlgELTYiVikjA0x6y
         jxIR0LwlKOAEJCpsi5bJ3Veli2MP8ewgnvw4C35xB51+Wz57rQmoOqWjD0tTwwf3w5qY
         COmKfOH6HbGmPdVMV4b2NZGEonCNKoe6UJA7CBPYFHzzz8Kx5Pw3KGt3IpLdwHiqPgO0
         25fcYKb1Pg85AnkW+hWmFYDnffo1ie9fr5K0ZRCDqZ4GxL0AYPk17u9XBLKUOfJVi17J
         4z9Q==
X-Gm-Message-State: AOAM533muFwwXztzMiZTjFdX8siuHh9aDi9zhoPDztB26khYUxwrspC2
        tt7xrVoEi2MbgcUKgdwpy54=
X-Google-Smtp-Source: ABdhPJzW5iSfePtEwccZqMInS+95LJQakqNc+SNXXiM8q26rA57qqEQvBDKPTyTETC7AOD4MqQ3BAg==
X-Received: by 2002:a92:c6c3:: with SMTP id v3mr5250057ilm.28.1604150625742;
        Sat, 31 Oct 2020 06:23:45 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:c107:3b4f:7176:6aff])
        by smtp.gmail.com with ESMTPSA id y3sm6804655ilc.49.2020.10.31.06.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 06:23:44 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, marex@denx.de,
        Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 4/5] arm64: dts: imx8mn: Add support for micfil
Date:   Sat, 31 Oct 2020 08:23:27 -0500
Message-Id: <20201031132328.712525-5-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201031132328.712525-1-aford173@gmail.com>
References: <20201031132328.712525-1-aford173@gmail.com>
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
V2:  Rebase and use generic term audio-controller instead of micfil.
---
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index dab246e5abea..a83e87cac96d 100644
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

