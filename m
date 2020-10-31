Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5386E2A179A
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 14:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbgJaNXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 09:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbgJaNXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 09:23:42 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4208C0617A6;
        Sat, 31 Oct 2020 06:23:42 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id k21so10374412ioa.9;
        Sat, 31 Oct 2020 06:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=toCsgKHXXGOccKYJW6IP37jFy59BRBDt3wwcfKsZjOE=;
        b=f1Q6UTpxX8KEPfHmdBn+qmnO2QAUFOrIAfCqJsLINcdWJ707tHqBs4NF3O5LH8lm4w
         Y0jMEwZaiMxw5eSiVzj0QuaN5X4f+6sXZ48v4rIRXhID95jWnJXj9V1rGfCY0wkbVzZU
         VqGCdRKCSMpCljzKbAng/Qb621gP6M61tph2UDsKExTVhRsuNrlm2HJOealwPhfZzJpd
         QsETcoHOmj+lecv8tfZ5NLEjyjpOqIEwCtFrObcTfSpSMACBsDTd8bMrhlm0GsPrPejs
         JF7LPg/J5MiZn0BpN5g5eurANH5vfBUNGHxCjt1oz9fvEMH6RWDNOcmxJ0d2/f1IZF79
         xOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=toCsgKHXXGOccKYJW6IP37jFy59BRBDt3wwcfKsZjOE=;
        b=Leb9uYIi7x0imN3Y95d4ed6TclyVyQvKG1+vMVWQnDg7JZZUiN2xEQd8qy6PNucAnT
         QAqAUOHV7L9grDnud9wSyujg+eI8gaDKOB3tIyR1kUlzwgr48YVbtox45ujvujN+WviF
         TpKX4+wYoIbHKrWpVJX9Y0bAIeR/vFji95wrMQkV54C1jeHU7OSjvO1i7WgOA0qZUX0l
         a/3/S1b8Vhotprv6rvj8ZobUtEmcmdK0bu5z9vy66CG42F7oHanWZTAXwMf0a+DuszF2
         YfDFFO3beNIXwyONwkxS8iBpRCnot5Poz2Zmdd4FLR0+1k9abzuw2UKzJ6waW/W0c7LN
         nzeg==
X-Gm-Message-State: AOAM531apZw63W0dWIbT6CbQVg1eTC8qSMtB6zYJGKxC2R8LyOq4cqaq
        XZT2HJzWP0xIur6E3nGzSMw=
X-Google-Smtp-Source: ABdhPJzgnmbC49A0oLvG+DjIAZf9e8HuZ25fup4BrF2xb3SPXZs53N1pTDDwbT/KjDUNCruVJjnXkg==
X-Received: by 2002:a05:6638:a11:: with SMTP id 17mr5710637jan.59.1604150620680;
        Sat, 31 Oct 2020 06:23:40 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:c107:3b4f:7176:6aff])
        by smtp.gmail.com with ESMTPSA id y3sm6804655ilc.49.2020.10.31.06.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 06:23:39 -0700 (PDT)
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
Subject: [PATCH V2 1/5] arm64: dts: imx8mn: Enable Asynchronous Sample Rate Converter
Date:   Sat, 31 Oct 2020 08:23:24 -0500
Message-Id: <20201031132328.712525-2-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201031132328.712525-1-aford173@gmail.com>
References: <20201031132328.712525-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver exists for the Enhanced Asynchronous Sample Rate Converter
(EASRC) Controller, but there isn't a device tree entry for it.

On the vendor kernel, they put this on a spba-bus for SDMA support.

Add the the node for the spba-bus with the easrc node inside.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2:  Make the DT node more in-line with the dt binding and remove
vendor customizations that are not applicable.
---
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 28 +++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index d5cb8abb13e8..a2e1e92f2e84 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -253,6 +253,34 @@ aips1: bus@30000000 {
 			#size-cells = <1>;
 			ranges;
 
+			spba-bus@30000000 {
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

