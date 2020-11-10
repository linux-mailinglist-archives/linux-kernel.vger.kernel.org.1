Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 179E22ACFAE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 07:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730050AbgKJG3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 01:29:45 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:41286 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726307AbgKJG3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 01:29:45 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.137492|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0231434-0.00763199-0.969225;FP=4947591482161697186|1|1|17|0|-1|-1|-1;HT=ay29a033018047211;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.Iuo67q-_1604989774;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.Iuo67q-_1604989774)
          by smtp.aliyun-inc.com(10.147.41.137);
          Tue, 10 Nov 2020 14:29:41 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     tiny.windzz@gmail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yangtao Li <frank@allwinnertech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [RESEND PATCH 06/19] arm64: allwinner: a100: Add device node for DMA controller
Date:   Tue, 10 Nov 2020 14:29:32 +0800
Message-Id: <1b15266045edbcfff2fc3791c88a5390d7bb3185.1604988979.git.frank@allwinnertech.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1604988979.git.frank@allwinnertech.com>
References: <cover.1604988979.git.frank@allwinnertech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <frank@allwinnertech.com>

The A100 SoC has a DMA controller that supports 8 DMA channels
to and from various peripherals.

Add a device node for it.

Signed-off-by: Yangtao Li <frank@allwinnertech.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
index cc321c04f121..c34ed8045363 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
@@ -101,6 +101,18 @@ ccu: clock@3001000 {
 			#reset-cells = <1>;
 		};
 
+		dma: dma-controller@3002000 {
+			compatible = "allwinner,sun50i-a100-dma";
+			reg = <0x03002000 0x1000>;
+			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_DMA>, <&ccu CLK_MBUS_DMA>;
+			clock-names = "bus", "mbus";
+			dma-channels = <8>;
+			dma-requests = <51>;
+			resets = <&ccu RST_BUS_DMA>;
+			#dma-cells = <1>;
+		};
+
 		gic: interrupt-controller@3021000 {
 			compatible = "arm,gic-400";
 			reg = <0x03021000 0x1000>, <0x03022000 0x2000>,
-- 
2.28.0

