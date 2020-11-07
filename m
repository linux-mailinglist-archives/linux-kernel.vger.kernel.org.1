Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9960F2AA4DB
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 12:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgKGL6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 06:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbgKGL63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 06:58:29 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E258C0613D2;
        Sat,  7 Nov 2020 03:58:28 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id a20so3593848ilk.13;
        Sat, 07 Nov 2020 03:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6q/+UA3/ES9qIvz2cc7bn+hbgGh/XaEahG2SGfUaAWM=;
        b=GdeEIth70T5fI3u2L468tYJdQLlNcPvHCRb2iUpenleuX0wep5L0mub0gNDIEVpvSN
         Ht420w5/QDSdG45xEnxLvKZZpJ5WOGsu/841gFVlKtgNPvVRJsrasJffZGQw0hgdjL2L
         oCALigvaMyO2zwiQULiepqOBO5de1uOUX4GoPYAyV7ldtriIws9K57AcjttfSajlHjbs
         gxJpYsSzf9M60lRTH9NOonODHXWQJ0eXprnLmSbPQByQmG38fvK5M/LbTnwwOzKUby8A
         6M02CoU4yH6Rdg/9F0f9ALh1mOm33ros8zdrqcOd6CATZ0essTyLM8HhwWa2PSxmzX0I
         jyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6q/+UA3/ES9qIvz2cc7bn+hbgGh/XaEahG2SGfUaAWM=;
        b=lF06i34ZP92ju+Zw/1F7xWw70s1ojPEvxyBzdAuJzneV9G8KPRmzxGrcDS7fZHGqAF
         4gGom+nnnv5Y79L4QFB0TSIy1z0DnWDwaZAfV6/3CCrIf7LV4o7oeVI5r+HfUX2ajeTj
         Ynem9lAnZ27ofGNGNVCC7vty9pZhHW/B9JKT6ASCK7eJrTeIciDTkj3ksmTk2XfR+6T4
         4ZgiN+Aduk9bC+vdL+qLmv9a8FivFTO7jHgTAIsbbtz4S0cg8A3R6FX3WDpbVt66VBfT
         ma8PXWDGHnfD/vvXi4ydc/IFn+Z9a8O+6bRapiXv0nmNngcoDxlJNHZZa3GMDA/Gp9rL
         Gefg==
X-Gm-Message-State: AOAM530sp7m12h48nuMUo0RML6z9HC7EeV2S0MQ6xhv132vX9kEliySm
        wKwqa+BXvfLiUNo77IkHeh2gYisUlCbXXg==
X-Google-Smtp-Source: ABdhPJyie9W74bpOjsiqPY9J/9iin31rvRjQY73cQi4EHo8S7wM+GoYU2bG3jEkuRr4zjE/Qdnor2w==
X-Received: by 2002:a92:ba14:: with SMTP id o20mr4488896ili.76.1604750307609;
        Sat, 07 Nov 2020 03:58:27 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:5d9e:32b:1062:f8cd])
        by smtp.gmail.com with ESMTPSA id n1sm2920671ile.86.2020.11.07.03.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 03:58:26 -0800 (PST)
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
Subject: [PATCH V4 3/5] arm64: dts: imx8mn: Add SAI nodes
Date:   Sat,  7 Nov 2020 05:58:06 -0600
Message-Id: <20201107115809.1866131-3-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201107115809.1866131-1-aford173@gmail.com>
References: <20201107115809.1866131-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX8M Nano has several SAI nodes available to it.
Enable them.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V4:  No Change
V3:  No Change
V2:  No Change

 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 72 +++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 61560c083300..6ea0d43a78a3 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -260,6 +260,78 @@ spba: bus@30000000 {
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

