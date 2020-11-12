Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17402B0712
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 14:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbgKLN4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 08:56:00 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7221 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728210AbgKLNz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 08:55:59 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CX35q5tX8zkZnk;
        Thu, 12 Nov 2020 21:55:43 +0800 (CST)
Received: from huawei.com (10.151.151.249) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Thu, 12 Nov 2020
 21:55:55 +0800
From:   Dongjiu Geng <gengdongjiu@huawei.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: Document the hi3559a clock bindings
Date:   Thu, 12 Nov 2020 22:20:28 +0000
Message-ID: <20201112222029.19701-1-gengdongjiu@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.151.151.249]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings documentation for hi3559a SoC clock.

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
 .../bindings/clock/hi3559av100-clock.txt      | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/hi3559av100-clock.txt

diff --git a/Documentation/devicetree/bindings/clock/hi3559av100-clock.txt b/Documentation/devicetree/bindings/clock/hi3559av100-clock.txt
new file mode 100644
index 000000000000..0fb4ccc72cfe
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/hi3559av100-clock.txt
@@ -0,0 +1,40 @@
+* Hisilicon Hi3559A Clock Controller
+
+The Hi3559A clock controller generates and supplies clock to various
+controllers within the Hi3559A SoC.
+
+Required Properties:
+
+- compatible: the compatible should be one of the following strings to
+	indicate the clock controller functionality.
+
+	- "hisilicon,hi3559av100-clock"
+
+- reg: physical base address of the controller and length of memory mapped
+  region.
+
+- #clock-cells: should be 1.
+
+Each clock is assigned an identifier and client nodes use this identifier
+to specify the clock which they consume.
+
+All these identifier could be found in <dt-bindings/clock/hi3559av100-clock.h>.
+
+Examples:
+
+	clock: clock0 {
+		compatible = "hisilicon,hi3559av100-clock", "syscon";
+		#clock-cells = <1>;
+		#reset-cells = <2>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x0 0x12010000 0x0 0x10000>;
+	};
+
+	uart0: uart@12100000 {
+		compatible = "arm,pl011", "arm,primecell";
+		reg = <0x12100000 0x1000>;
+		interrupts = <0 6 4>;
+		clocks = <&clock HI3559AV100_UART0_CLK>;
+		clock-names = "apb_pclk";
+	};
-- 
2.17.1

