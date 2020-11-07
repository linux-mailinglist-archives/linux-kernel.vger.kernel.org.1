Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 053ED2AA4DE
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 12:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgKGL6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 06:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728026AbgKGL6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 06:58:32 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25B5C0613D3;
        Sat,  7 Nov 2020 03:58:31 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id k1so3609989ilc.10;
        Sat, 07 Nov 2020 03:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xjiQRc4dZgVzVnqr6XKAtaGiVZ1gvizScIbzJui/+es=;
        b=aEql86p8CeEIEPOHUCzzL1D+6CacnMegJ81GBbPM/qV1GEcakmF+ai2ucMDLnxIeao
         u1qj1kexFdyzJMdqHCnzfCGraF9BfvPHVJJvgphoWeWyFhrXThWdyiJKxDn8LHwIEG7u
         fnKjrwEyMeqVKxLTh1pMUP+/XWR3fy8830HfmT8/JJ1XY9AHEpEijtPNYhBxw5a2LCI+
         EGZ3C7edtTqaFGOcSz54LijI1Z9vVE7NSWh2FO2KWq1xbqdYkZk/1E6vEFY3+HFRBi0D
         nWAPFfS4D2q7PZhCFps1vjx4mugbZ0bVqJE7scnN4uR1y+2yBRVejnNRXgWKa7YrFVRb
         MFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xjiQRc4dZgVzVnqr6XKAtaGiVZ1gvizScIbzJui/+es=;
        b=sDxaFk0btcOox04k4MrI4DwkoLaLl7FCsVmXbgZDk8H3Qd0kBydCHLgg5jWIMoZ9rP
         189nWhmROt3NUOwFpDi0Wex5NwXGFM80ylTKLyfbDI0xagL0Ao2K6xP3zfN+8nsIg5Jm
         EurSPJAVFa9CL4q3hDRwFBmpYsEu7o5Mj1J04/+BN7CnSnSVkZoblhta7AA3hEa9eyND
         CWOCEIlzSxIbeioNWDjc49CtFlxJN54GYYBUJ73qrX62e+OlnvQMlQqI6iMGqH7BVB0o
         eQz5fH40br5hZ5mAJKVluUpjzHTmCCHYab4sP/xxpc67AfYb2YM8iNvqRSVKxci4giyu
         jxJA==
X-Gm-Message-State: AOAM530TM+DHTJ31ba+LlV8ncR3IFEJgfCCkhi003SaqTNq93SZliQ1/
        jGaXZydUCM5qYIkGRPeHTOs=
X-Google-Smtp-Source: ABdhPJwp6O1YDvTgwJYpfITqWPzDw49xZVX3grMCXDY4GIu2Tp6IoaHnCs2i3sSk6ptIgp55LblEqA==
X-Received: by 2002:a05:6e02:cf:: with SMTP id r15mr4346498ilq.181.1604750310826;
        Sat, 07 Nov 2020 03:58:30 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:5d9e:32b:1062:f8cd])
        by smtp.gmail.com with ESMTPSA id n1sm2920671ile.86.2020.11.07.03.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 03:58:30 -0800 (PST)
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
Subject: [PATCH V4 5/5] arm64: dts: imx8mn: Add node for SPDIF
Date:   Sat,  7 Nov 2020 05:58:08 -0600
Message-Id: <20201107115809.1866131-5-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201107115809.1866131-1-aford173@gmail.com>
References: <20201107115809.1866131-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX8M Nano can support SPDIF which is compatible to the
IP used on the i.MX35.

Add the node.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V4:  No Change
V3:  No Change
V2:  No Change

 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 24 +++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index aa3f1eb391bd..ee1790230490 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -337,6 +337,30 @@ micfil: audio-controller@30080000 {
 					status = "disabled";
 				};
 
+				spdif1: spdif@30090000 {
+					compatible = "fsl,imx35-spdif";
+					reg = <0x30090000 0x10000>;
+					interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MN_CLK_AUDIO_AHB>, /* core */
+						 <&clk IMX8MN_CLK_24M>, /* rxtx0 */
+						 <&clk IMX8MN_CLK_SPDIF1>, /* rxtx1 */
+						 <&clk IMX8MN_CLK_DUMMY>, /* rxtx2 */
+						 <&clk IMX8MN_CLK_DUMMY>, /* rxtx3 */
+						 <&clk IMX8MN_CLK_DUMMY>, /* rxtx4 */
+						 <&clk IMX8MN_CLK_AUDIO_AHB>, /* rxtx5 */
+						 <&clk IMX8MN_CLK_DUMMY>, /* rxtx6 */
+						 <&clk IMX8MN_CLK_DUMMY>, /* rxtx7 */
+						 <&clk IMX8MN_CLK_DUMMY>; /* spba */
+					clock-names = "core", "rxtx0",
+						      "rxtx1", "rxtx2",
+						      "rxtx3", "rxtx4",
+						      "rxtx5", "rxtx6",
+						      "rxtx7", "spba";
+					dmas = <&sdma2 28 18 0>, <&sdma2 29 18 0>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
+
 				sai7: sai@300b0000 {
 					compatible = "fsl,imx8mm-sai", "fsl,imx8mq-sai";
 					reg = <0x300b0000 0x10000>;
-- 
2.25.1

