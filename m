Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4FE292D10
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 19:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbgJSRpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 13:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgJSRpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 13:45:41 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25BFC0613CE;
        Mon, 19 Oct 2020 10:45:40 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id w17so1052147ilg.8;
        Mon, 19 Oct 2020 10:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hbVnvFCXiFAdM1wS6lcel3oCxoSxmJXPtYWbPeLnY7c=;
        b=R0KG1F7aP2zFaXQozruYk6oaXKjVYRV2O3soCHaLRyNQnTr5+cKuQjLZAXDvsiIskq
         GfpXkUFUdEIF50qzr0E+gVo5nOu/YQPnEqoqdXPtJZ0/yZLW8SVrb4J+z2hAk6Ys43tf
         CtMQa65ffwzRN7H2kZwDxpZUzM49NHtfEhwb41JIStHlLNyZG9+lTBobpAnEah17ZWO9
         UgcLXdVzcuIYXFp7Ocdhrzi7v/UdXV91ns+PqaP83UGp2mkTpWm0hwUhuVCxVRMBOozi
         TI6nKhtLCj2rTrS+MojdNB4RFzwv//XUWhCm0DHHiT7VLxac8x88HPrpVBQMn4QKGl8C
         McGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hbVnvFCXiFAdM1wS6lcel3oCxoSxmJXPtYWbPeLnY7c=;
        b=me3s8NF06Mdh9dfR+zEelHTiweiPfyfiXJvhrEGEa/ZLqlTWQ+KrtcoG/8M6o0vCYo
         pWOKje1IkzMH3PBxDwshFW2Eh4pnIHnFk5O+rcHowIgBlBbr2/FNvQYTYXsQSIvL/cEy
         xxtN3iL6q7Aeo0x/k9by9bRA0ljpp63l+W91ZUJXwS6pRrdh21aQLrgHh8otbkM/FY9t
         OOV4JHmYZOQZ5EthGY78bTaELfFk1/5A0r/vTP+WyORylPW9KLi3CEzMBljjsOkMueCl
         fdPbSYr9rUwPSZnbY9gqQZBzD608J57mJCxxlTgyqC4x2d+eohFf9yzc6fZDZgBtxoW6
         bT3A==
X-Gm-Message-State: AOAM5322v9l3iOfCOC6o+NFqgxBInfaTUK8hiYs5DJ1B0xq9uwmnMD+O
        nUMn/1pBN9jqOOHa4zbjuNU=
X-Google-Smtp-Source: ABdhPJzxlo0oUNoGvoygPtlvcmUdeBAaNnOprDdlDEWiKbQXaZ44horSXUzuHDodc0cSOde6rQKiow==
X-Received: by 2002:a05:6e02:528:: with SMTP id h8mr1020038ils.84.1603129540170;
        Mon, 19 Oct 2020 10:45:40 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:75c9:416d:1d67:486f])
        by smtp.gmail.com with ESMTPSA id 128sm406261iow.50.2020.10.19.10.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 10:45:39 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] arm64: dts: imx8mn: Add SAI nodes
Date:   Mon, 19 Oct 2020 12:45:26 -0500
Message-Id: <20201019174529.289499-3-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201019174529.289499-1-aford173@gmail.com>
References: <20201019174529.289499-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX8M Nano has several SAI nodes available to it.
Enable them.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 7d34281332e1..9e2c0b6a7e32 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -253,6 +253,83 @@ spba-bus@30000000 {
 				reg = <0x30000000 0x100000>;
 				ranges;
 
+				sai2: sai@30020000 {
+					compatible = "fsl,imx8mq-sai",
+						     "fsl,imx6sx-sai";
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
+					compatible = "fsl,imx8mq-sai",
+						     "fsl,imx6sx-sai";
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
+					compatible = "fsl,imx8mq-sai",
+						     "fsl,imx6sx-sai";
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
+					compatible = "fsl,imx8mq-sai",
+						     "fsl,imx6sx-sai";
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
+					compatible = "fsl,imx8mq-sai",
+						     "fsl,imx6sx-sai";
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
 				easrc: easrc@300C0000 {
 					compatible = "fsl,imx8mn-easrc";
 					reg = <0x300C0000 0x10000>;
-- 
2.25.1

