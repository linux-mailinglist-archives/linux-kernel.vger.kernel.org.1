Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79EC22A210A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 20:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbgKATVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 14:21:06 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:38581 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbgKATVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 14:21:04 -0500
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id D74B822FB3;
        Sun,  1 Nov 2020 20:21:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1604258462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jrGrdZA03H0jf+vzvyuLno2m8KTDqXS0+2bMtxKpIDg=;
        b=JNiU5i5zQ4WDyscO4fhPrG3gKTlRr8lq85YY7d+4wrTB19tzz2YfZWmlM8Hl43pY5Jx+SN
        cA54BpiiTYY6t/R9ugpfXC6f5sxgfLj5Z+zXPyXva3Ik0DADd7zDftJnkLHlAS7SvbgTrN
        pjJhA2EO7UEY9QBSH40jHzwVu/6E5Yc=
From:   Michael Walle <michael@walle.cc>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 3/4] arm64: dts: ls1028a: fix FlexSPI clock
Date:   Sun,  1 Nov 2020 20:20:52 +0100
Message-Id: <20201101192053.18644-3-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201101192053.18644-1-michael@walle.cc>
References: <20201101192053.18644-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have a proper driver for the FlexSPI interface use it. This
will fix SCK frequency switching on Layerscape SoCs.

This was tested on the Kontron sl28 board.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index f223396b8266..ee88bf60f9a9 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -197,9 +197,20 @@
 		};
 
 		dcfg: syscon@1e00000 {
-			compatible = "fsl,ls1028a-dcfg", "syscon";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,ls1028a-dcfg", "syscon", "simple-mfd";
 			reg = <0x0 0x1e00000 0x0 0x10000>;
+			ranges = <0x0 0x0 0x1e00000 0x10000>;
 			little-endian;
+
+			fspi_clk: clock-controller@900 {
+				compatible = "fsl,ls1028a-flexspi-clk";
+				reg = <0x900 0x4>;
+				#clock-cells = <0>;
+				clocks = <&clockgen 4 0>;
+				clock-output-names = "fspi_clk";
+			};
 		};
 
 		rst: syscon@1e60000 {
@@ -309,7 +320,7 @@
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

