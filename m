Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2302A179F
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 14:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbgJaNX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 09:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbgJaNXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 09:23:48 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230CDC0617A6;
        Sat, 31 Oct 2020 06:23:48 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id k21so10374572ioa.9;
        Sat, 31 Oct 2020 06:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=msN0U03I8r/VEdYzFEECbj7ezoLKGV1SY0EQdI9V/9s=;
        b=XfovuHEbVw9rdwHWbUXEgsGrfW7emnC26FqUnNzGKHeqMozbLtSUeMaRAWMb9I7znT
         KiXcgGyMSanwM+giE61XPjrHAnFNtqTDWEfkT+AZPDVuthEjVDmOGg7QjUT+MN+wreDL
         kluS/U87gSpQ+HJDLKleIRs2Sy0pM6B3+qMVb+6DcDd97sH0HudADqH1zHEfsk+0wu0j
         OlRtHbfKrg69LLuWBr/jMGbXkPmabME8Z7pUxzn204nkmipg4Hvf+5sloQMo/LsN+rQX
         xeZdkkEl2u3uYh7/Ln3SlX4YQJ/Sbrx19jaqPa22nMQKkg2iWClrmk1sVzUsmYu0dJpe
         q1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=msN0U03I8r/VEdYzFEECbj7ezoLKGV1SY0EQdI9V/9s=;
        b=ZPPfUrZm+GpiUOQ5UsNtXx4gPW5V5lCw1RHpOM3/e71AchozOVLKNxPr/+n5PD9cWk
         U2vgxJec/aCQ7RZFTya/gDGw2F7+AsmF1kzQyGogo5yw/itkDTj5kXh4mRCbtw8LfPp+
         G9+kZggiIFb7mu9PYOaqB9mO9sH6Rdv7jSuYbI/EFZ0lwx4q7XJlT6xZjTJDRqQvpvuu
         /8VbIEsJlla6Vz09DYgH7GkHPpR2lUXW8gjMtV2RCXmBFzmx82ycSe63FuyBoBWJDtyX
         8LnfwM4+svc7ec0Dvt/lA/V9bJSa3zCMzsYHjE5Ro+sFTvdJsfN2ETxFnCfwDMumpRv2
         I60Q==
X-Gm-Message-State: AOAM530wrlH0yoFcbUdGkOMUUHjwapFQKyAMWPPB6AcnXSthsT/kRfY5
        IgPasD71A8vBpL79mfZJLV4=
X-Google-Smtp-Source: ABdhPJyqntj7LB0rxKgOVDtq/sY2jmtv306TBhU6sjB5BIsIzZioyM9xiuAC+1wSmGpwDds8FuiSNg==
X-Received: by 2002:a6b:1546:: with SMTP id 67mr5198736iov.182.1604150627428;
        Sat, 31 Oct 2020 06:23:47 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:c107:3b4f:7176:6aff])
        by smtp.gmail.com with ESMTPSA id y3sm6804655ilc.49.2020.10.31.06.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 06:23:46 -0700 (PDT)
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
Subject: [PATCH V2 5/5] arm64: dts: imx8mn: Add node for SPDIF
Date:   Sat, 31 Oct 2020 08:23:28 -0500
Message-Id: <20201031132328.712525-6-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201031132328.712525-1-aford173@gmail.com>
References: <20201031132328.712525-1-aford173@gmail.com>
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
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 24 +++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index a83e87cac96d..e508db232bcf 100644
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

