Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF672AA4D9
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 12:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgKGL63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 06:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgKGL60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 06:58:26 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6543C0613CF;
        Sat,  7 Nov 2020 03:58:26 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id n129so4528122iod.5;
        Sat, 07 Nov 2020 03:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O70bHm0na7N+R6ZrEDBYfrsG/JlIHa6hFDJz5Nqlhro=;
        b=KCYwk2/M2tRs7qRUzGRbnvHL0A1ZDIDY+OhRZf+3ru6OyHDv4wzGvQWMcIQAW+KUXp
         O4ZJcRMSDskXugAO9XyBh7TikOnq/1UXrEdI+TcEim1zBM2XA/A6Z3PdYxMoWWPhco0V
         MSs7Y2whsbBWXuuyYg71j6Q3cf9y+F00Bf1VYnyqg5Cr5+SaxFQXopswtERvXH5144SH
         NudAFBVUCpoAL0VPSrfQZiJyygFuqxgbdXdiUelNOUCOSgSh8y/Abwgzxrb0zSPy5HbF
         lxKq11kCbueDBzyX9T8hzt4Q22Hyj7BR23udJnvQWpQsyW+A8CpvsJQhE/2Z/0KVipvi
         gNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O70bHm0na7N+R6ZrEDBYfrsG/JlIHa6hFDJz5Nqlhro=;
        b=fgkmSDAEeRan2pk+L2yfVteOyi2isnZAKKC018/BLdUHQDY0uRTSDNvTki4s3Uszof
         4h8BwURsuIKfgR4c2XSdJbdeWpvsfsSCnP2y0SDynbrB0BfK0gVbjxcy5CoFStJ3fie1
         7T8BkB2ItRqAs8XO7toFpTzkbZPeRB9bJrk3SJ0a9e9+7EgtNbMEYP+ffYfFjLp0alnF
         Pi55wLJNo45sZr4S0t5izKO2aSqA21Ja7iSiSifqtkM0ODmOaP5RMPB+hx8wOY28pRL8
         24nx742Gus85tYDKKdE6Xxqq2uYNrIcVAXaIarv4wAskVfzxhM1aNJGh6C0Sl60pmn37
         MZ5g==
X-Gm-Message-State: AOAM532bM5GAtPB2NyD1P5YCK+/QW4OaC9O1DsXNdumd0lvJcS23Bj0x
        jeDcynOz7rwm/iCumzxIy3E=
X-Google-Smtp-Source: ABdhPJx7n9VNpMJ4n0HbrNXF8EXyBcvEWBHsG2akmaBz0Da5SbbOPVEjvFE2fU95jSvoTOZGGAUGLA==
X-Received: by 2002:a5d:9ada:: with SMTP id x26mr4618669ion.132.1604750305935;
        Sat, 07 Nov 2020 03:58:25 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:5d9e:32b:1062:f8cd])
        by smtp.gmail.com with ESMTPSA id n1sm2920671ile.86.2020.11.07.03.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 03:58:25 -0800 (PST)
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
Subject: [PATCH V4 2/5] arm64: dts: imx8mn: Enable Asynchronous Sample Rate Converter
Date:   Sat,  7 Nov 2020 05:58:05 -0600
Message-Id: <20201107115809.1866131-2-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201107115809.1866131-1-aford173@gmail.com>
References: <20201107115809.1866131-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver exists for the Enhanced Asynchronous Sample Rate Converter
(EASRC) Controller, but there isn't a device tree entry for it.

On the vendor kernel, they put this on a spba-bus for SDMA support.

Add the node for the spba-bus with the easrc node inside.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V4:  No change
V3:  Change spba-bus@30000000 to spba: bus@30000000
V2:  Make the DT node more in-line with the dt binding and remove
     vendor customizations that are not applicable.
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 28 +++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index a06d2a6268e6..61560c083300 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -253,6 +253,34 @@ aips1: bus@30000000 {
 			#size-cells = <1>;
 			ranges;
 
+			spba: bus@30000000 {
+				compatible = "fsl,spba-bus", "simple-bus";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0x30000000 0x100000>;
+				ranges;
+
+				easrc: easrc@300c0000 {
+					compatible = "fsl,imx8mn-easrc";
+					reg = <0x300c0000 0x10000>;
+					interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MN_CLK_ASRC_ROOT>;
+					clock-names = "mem";
+					dmas = <&sdma2 16 23 0> , <&sdma2 17 23 0>,
+					       <&sdma2 18 23 0> , <&sdma2 19 23 0>,
+					       <&sdma2 20 23 0> , <&sdma2 21 23 0>,
+					       <&sdma2 22 23 0> , <&sdma2 23 23 0>;
+					dma-names = "ctx0_rx", "ctx0_tx",
+						    "ctx1_rx", "ctx1_tx",
+						    "ctx2_rx", "ctx2_tx",
+						    "ctx3_rx", "ctx3_tx";
+					firmware-name = "imx/easrc/easrc-imx8mn.bin";
+					fsl,asrc-rate  = <8000>;
+					fsl,asrc-format = <2>;
+					status = "disabled";
+				};
+			};
+
 			gpio1: gpio@30200000 {
 				compatible = "fsl,imx8mn-gpio", "fsl,imx35-gpio";
 				reg = <0x30200000 0x10000>;
-- 
2.25.1

