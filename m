Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8754A292BE1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 18:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730758AbgJSQuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 12:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730570AbgJSQux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 12:50:53 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F868C0613D0;
        Mon, 19 Oct 2020 09:50:52 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id w17so839684ilg.8;
        Mon, 19 Oct 2020 09:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8d32TFjCm8T9gZCPnebFvwGLHjSMEjTUaQmQ3dkvl1Y=;
        b=Lb2Ub6YokGOdQwTwxjIWS0FtqXMPsJlCI6pP/Hot0TXLYlXOzqJ4sCLUTTtCPU42X3
         PA1nUFk0zricYze0sOYzDEB+dtGpLFdOs6/LpxFTiQgrw667LqW+ZNBKVnvEhSxBNldH
         7iwjYUImUP9iaAFu3FKuGikx7lJ1Fa+8+Tf9LHfseecahglA6JNI5+IZ8I/f36TRHLvF
         Aeq8qBTEAgV3NTzk5pWNiZKnqvy74dTNzMuavWuUs+QHnCYA8++yzujsUGBIVZvtmyQB
         uJh8mHl0dVIft5Zgufhk54jxTm9K8dIPTgpR6yPc7dyz2UyU1KTs0tRJVsMtaSRF06me
         C9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8d32TFjCm8T9gZCPnebFvwGLHjSMEjTUaQmQ3dkvl1Y=;
        b=VqvgcANYJsX+IJBxoytTSnQykLb8XtZnu2AT3+9nTjEjwQVh1rVMv0EA2SwgKUTvhg
         yKR2MNo6bAMRZdksNSLDVX8GWtzhYh6lB/Y4Tbss4DLImZgDlCiY6gbIUvHany1j38UJ
         4L13j2hlpVT2j3EaB3lTJG489awTuTQ1TQ2tIV9UMVfRBMGnoNypPGQSs6RkKFLSTDhu
         VhDGL7fIKPsieihYtPbbwd45jhhZdREsJy4jD3U58PlfUa73MWpVmzyzrC7byjOMpFGh
         3iAXtd1+T3siayqPgWYFSWjc3a3w7jo0onHmK2REwWOibnT/+tQvsZkeBKh2hZSPub2L
         RCyA==
X-Gm-Message-State: AOAM5301f9mdTIVNnD7nxsJJqBp5ObNptgQl++jFI7sl16q6cY0guWm6
        nuYlj9fSDtUrz6YaihW7aU8=
X-Google-Smtp-Source: ABdhPJyjrVOdG7BldGVEaSXe66H8kVzZgKsI4WBxPCkKxdb4AqvOVqIv65jfuynX/SDfJ/lolzQCGQ==
X-Received: by 2002:a05:6e02:931:: with SMTP id o17mr726616ilt.273.1603126251669;
        Mon, 19 Oct 2020 09:50:51 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:75c9:416d:1d67:486f])
        by smtp.gmail.com with ESMTPSA id p17sm212839ilh.34.2020.10.19.09.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 09:50:51 -0700 (PDT)
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
Subject: [PATCH V2 2/3] arm64: dts: imx8mm: Add node for SPDIF
Date:   Mon, 19 Oct 2020 11:50:37 -0500
Message-Id: <20201019165038.274164-2-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201019165038.274164-1-aford173@gmail.com>
References: <20201019165038.274164-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX8M Mini can support SPDIF which is compatible to the
IP used on the i.MX35.  Add the node.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2:  Fix some typos

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index fad1f9cdb241..7cc2899db12e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -358,6 +358,30 @@ micfil: audio-controller@30080000 {
 				status = "disabled";
 			};
 
+			spdif1: spdif@30090000 {
+				compatible = "fsl,imx35-spdif";
+				reg = <0x30090000 0x10000>;
+				interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MM_CLK_AUDIO_AHB>, /* core */
+					 <&clk IMX8MM_CLK_24M>, /* rxtx0 */
+					 <&clk IMX8MM_CLK_SPDIF1>, /* rxtx1 */
+					 <&clk IMX8MM_CLK_DUMMY>, /* rxtx2 */
+					 <&clk IMX8MM_CLK_DUMMY>, /* rxtx3 */
+					 <&clk IMX8MM_CLK_DUMMY>, /* rxtx4 */
+					 <&clk IMX8MM_CLK_AUDIO_AHB>, /* rxtx5 */
+					 <&clk IMX8MM_CLK_DUMMY>, /* rxtx6 */
+					 <&clk IMX8MM_CLK_DUMMY>, /* rxtx7 */
+					 <&clk IMX8MM_CLK_DUMMY>; /* spba */
+				clock-names = "core", "rxtx0",
+					      "rxtx1", "rxtx2",
+					      "rxtx3", "rxtx4",
+					      "rxtx5", "rxtx6",
+					      "rxtx7", "spba";
+				dmas = <&sdma2 28 18 0>, <&sdma2 29 18 0>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+
 			gpio1: gpio@30200000 {
 				compatible = "fsl,imx8mm-gpio", "fsl,imx35-gpio";
 				reg = <0x30200000 0x10000>;
-- 
2.25.1

