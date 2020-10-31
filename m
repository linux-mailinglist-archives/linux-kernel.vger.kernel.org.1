Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821542A17A1
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 14:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgJaNYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 09:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbgJaNXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 09:23:47 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A34C0617A6;
        Sat, 31 Oct 2020 06:23:44 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id x7so8966662ili.5;
        Sat, 31 Oct 2020 06:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0IJOJwzEn87dTTb0y0lmBJfi48dZdafg1ypapanCRnE=;
        b=sr93MhilqpPvb26NbSm0VcKxkql+6Y0P9PBRibpeY4mS0Br63UgaPWlHzgXkgmvTsx
         m6CAuPjJLrTHCHCCZyf8JiR3TSfmx3LngUjx1cligR/5fB7KZly2V5fOsSALv69UzK6W
         Zgf6iQjPJmd0cr00FrhA8Ltm/OP2RjZM3CACC6LGuVPfAnGvV7uBH0U/cwE0HUof1uqV
         xIIUgsfhJiJLE9Te0pFzxmoUgLpQDLABJYN3W/YaHUY+qHAkjzGipUDeD1BUDIaoxuLj
         b4iv8Tf4Vj8CRO4XB8xPK4KwluuNPMGXLDqGALt3+p6V7T71Z59CU2XEkU4Bz/a9w7Xf
         s1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0IJOJwzEn87dTTb0y0lmBJfi48dZdafg1ypapanCRnE=;
        b=WXg07CF8OHUIuDtp5h+Y/HqSjBRN6WM2UX9hWl1Wox2kv+4cmWxJvd695HGRRXbH/y
         J8dQoIDM8VfWLPahQhrvkIcbmLgg720YDoEyIVIVfPsWdrAvyftA+cT1EXoa4Z7G5rXp
         eicTA44JHPyrlA3b4/x1Sp83+U0OgQrSTldwoiOezETcpWXjFnTwUEkD6xjxDrStZNQG
         lKda3VIpEp500eAR494fssQskj0YAeNnQwJYqA4VrFNLnQQbmpy24pG5gyHUDVeTxzOU
         KUq/2SA7Dy967sUrlb26dWxZoLjVwBrHUDCNfDQkmwC1psqc2ZZcecBtk4spmGXZMgOr
         HXrw==
X-Gm-Message-State: AOAM531aWZZCg1H6edzGEoDncH5W+SV6Hk9vLIeOR0mWvSIEvsitSu3N
        pxQ2zwv/RfKO5WSNc5WGmH4=
X-Google-Smtp-Source: ABdhPJyvQabai3UM/VfbWI7SNKSUADo8sbHIkoFifv+o8fUNV1S7QKXuHM+WnNGwdWwqwENs7VB05w==
X-Received: by 2002:a92:7a0c:: with SMTP id v12mr4566364ilc.37.1604150623842;
        Sat, 31 Oct 2020 06:23:43 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:c107:3b4f:7176:6aff])
        by smtp.gmail.com with ESMTPSA id y3sm6804655ilc.49.2020.10.31.06.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 06:23:43 -0700 (PDT)
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
Subject: [PATCH V2 3/5] arm64: dts: imx8mn: Add SAI nodes
Date:   Sat, 31 Oct 2020 08:23:26 -0500
Message-Id: <20201031132328.712525-4-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201031132328.712525-1-aford173@gmail.com>
References: <20201031132328.712525-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX8M Nano has several SAI nodes available to it.
Enable them.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 72 +++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index a2e1e92f2e84..dab246e5abea 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -260,6 +260,78 @@ spba-bus@30000000 {
 				reg = <0x30000000 0x100000>;
 				ranges;
 
+				sai2: sai@30020000 {
+					compatible = "fsl,imx8mm-sai", "fsl,imx8mq-sai";
+					reg = <0x30020000 0x10000>;
+					interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MN_CLK_SAI2_IPG>,
+						<&clk IMX8MN_CLK_DUMMY>,
+						<&clk IMX8MN_CLK_SAI2_ROOT>,
+						<&clk IMX8MN_CLK_DUMMY>, <&clk IMX8MN_CLK_DUMMY>;
+					clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+					dmas = <&sdma2 2 2 0>, <&sdma2 3 2 0>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
+
+				sai3: sai@30030000 {
+					compatible = "fsl,imx8mm-sai", "fsl,imx8mq-sai";
+					reg = <0x30030000 0x10000>;
+					interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MN_CLK_SAI3_IPG>,
+						 <&clk IMX8MN_CLK_DUMMY>,
+						 <&clk IMX8MN_CLK_SAI3_ROOT>,
+						 <&clk IMX8MN_CLK_DUMMY>, <&clk IMX8MN_CLK_DUMMY>;
+					clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+					dmas = <&sdma2 4 2 0>, <&sdma2 5 2 0>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
+
+				sai5: sai@30050000 {
+					compatible = "fsl,imx8mm-sai", "fsl,imx8mq-sai";
+					reg = <0x30050000 0x10000>;
+					interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MN_CLK_SAI5_IPG>,
+						 <&clk IMX8MN_CLK_DUMMY>,
+						 <&clk IMX8MN_CLK_SAI5_ROOT>,
+						 <&clk IMX8MN_CLK_DUMMY>, <&clk IMX8MN_CLK_DUMMY>;
+					clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+					dmas = <&sdma2 8 2 0>, <&sdma2 9 2 0>;
+					dma-names = "rx", "tx";
+					fsl,shared-interrupt;
+					fsl,dataline = <0 0xf 0xf>;
+					status = "disabled";
+				};
+
+				sai6: sai@30060000 {
+					compatible = "fsl,imx8mm-sai", "fsl,imx8mq-sai";
+					reg = <0x30060000  0x10000>;
+					interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MN_CLK_SAI6_IPG>,
+						 <&clk IMX8MN_CLK_DUMMY>,
+						 <&clk IMX8MN_CLK_SAI6_ROOT>,
+						 <&clk IMX8MN_CLK_DUMMY>, <&clk IMX8MN_CLK_DUMMY>;
+					clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+					dmas = <&sdma2 10 2 0>, <&sdma2 11 2 0>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
+
+				sai7: sai@300b0000 {
+					compatible = "fsl,imx8mm-sai", "fsl,imx8mq-sai";
+					reg = <0x300b0000 0x10000>;
+					interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MN_CLK_SAI7_IPG>,
+						 <&clk IMX8MN_CLK_DUMMY>,
+						 <&clk IMX8MN_CLK_SAI7_ROOT>,
+						 <&clk IMX8MN_CLK_DUMMY>, <&clk IMX8MN_CLK_DUMMY>;
+					clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+					dmas = <&sdma2 12 2 0>, <&sdma2 13 2 0>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
+
 				easrc: easrc@300c0000 {
 					compatible = "fsl,imx8mn-easrc";
 					reg = <0x300c0000 0x10000>;
-- 
2.25.1

