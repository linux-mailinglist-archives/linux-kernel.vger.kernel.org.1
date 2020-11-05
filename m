Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE012A875C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 20:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732320AbgKETfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 14:35:36 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:51693 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKETf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 14:35:28 -0500
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 0629623E55;
        Thu,  5 Nov 2020 20:35:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1604604924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eo+fPBfPzk/qMCRWMSDzjxSvOrHTFJ/sZimjalXzeRw=;
        b=j+rtgJWGm/jt67NwLZCmWqhjqFiPqzQ6yzxElteyt0p89CEJz+nn8DxhI7NBcdbK6GqH0W
        QdLDiN0AlTrAeO/uOhdYn2+OkaU3xTbATtis9BupxwgVwCdOmpcfeVn+0d7uro7VU8RGQn
        n9ABZOaj842J71fkNZqAye5m5qOTFE0=
From:   Michael Walle <michael@walle.cc>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 5/5] arm64: dts: lx2160a: fix FlexSPI clock
Date:   Thu,  5 Nov 2020 20:35:12 +0100
Message-Id: <20201105193512.22388-6-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201105193512.22388-1-michael@walle.cc>
References: <20201105193512.22388-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have a proper driver for the FlexSPI interface use it. This
will fix SCK frequency switching on Layerscape SoCs.

This was only compile time tested.

Signed-off-by: Michael Walle <michael@walle.cc>
---
Changes since v1:
 - none

 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index 83072da6f6c6..6e375e80bd35 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -659,9 +659,20 @@
 		};
 
 		dcfg: syscon@1e00000 {
-			compatible = "fsl,lx2160a-dcfg", "syscon";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,lx2160a-dcfg", "syscon", "simple-mfd";
 			reg = <0x0 0x1e00000 0x0 0x10000>;
+			ranges = <0x0 0x0 0x1e00000 0x10000>;
 			little-endian;
+
+			fspi_clk: clock-controller@900 {
+				compatible = "fsl,lx2160a-flexspi-clk";
+				reg = <0x900 0x4>;
+				#clock-cells = <0>;
+				clocks = <&clockgen 4 0>;
+				clock-output-names = "fspi_clk";
+			};
 		};
 
 		tmu: tmu@1f80000 {
@@ -776,7 +787,7 @@
 			      <0x0 0x20000000 0x0 0x10000000>;
 			reg-names = "fspi_base", "fspi_mmap";
 			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+			clocks = <&clockgen 4 3>, <&fspi_clk>;
 			clock-names = "fspi_en", "fspi";
 			status = "disabled";
 		};
-- 
2.20.1

