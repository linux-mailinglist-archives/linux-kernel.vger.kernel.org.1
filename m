Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9A62FF8BB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 00:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbhAUXYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 18:24:23 -0500
Received: from alln-iport-1.cisco.com ([173.37.142.88]:43963 "EHLO
        alln-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbhAUXXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 18:23:08 -0500
X-Greylist: delayed 562 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Jan 2021 18:23:04 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=49027; q=dns/txt;
  s=iport; t=1611271384; x=1612480984;
  h=from:to:cc:subject:date:message-id;
  bh=2gyQU3y1WAEYMhzZ0pieh5eVFa8PqYM+GfX0hNXhHlI=;
  b=KQwvyR/1gUlCKuc/kc+yIFB3wJlNp66HUKQrIN40Rkl4jd2r6LA+LHYD
   ztp+xGK7EuS7Fn8sm0BTiEQFGgWCYurox0henRQok06YGoHbbeQ+L9vDK
   0YL8zhmYA5otVbPpEeFa1nlCb4m/Bm0SZCCFDY5LdqkrIJ5yUC+QpkwqQ
   U=;
X-IPAS-Result: =?us-ascii?q?A0DwAQBaCApgmJtdJa1KGIZQATIvlhaaW4FoCwEBAQ8vB?=
 =?us-ascii?q?AEBgVWBdn+BeQIlOBMCAwEBAQMCAwEBAQEFAQEBAgEGBBQBAQEBAQEBAYZCh?=
 =?us-ascii?q?hQBXkZ4E4MmgwexPYIoiR2BQxSBJIhVhQsbgUE/gRABg1eDeQgVD4YSBIFVc?=
 =?us-ascii?q?AZUNAETXj9KdJsEgXWaXX2DAYEcmj0PIqJvshyDe4FtIYFZMxoIGxWDJFAZD?=
 =?us-ascii?q?Y47jlAgAzA3AgYKAQEDCYlOgkUBAQ?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.79,365,1602547200"; 
   d="scan'208";a="632408376"
Received: from rcdn-core-4.cisco.com ([173.37.93.155])
  by alln-iport-1.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 21 Jan 2021 23:12:38 +0000
Received: from zorba.cisco.com ([10.24.5.176])
        by rcdn-core-4.cisco.com (8.15.2/8.15.2) with ESMTP id 10LNCbRL024470;
        Thu, 21 Jan 2021 23:12:38 GMT
From:   Daniel Walker <danielwa@cisco.com>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Daniel Walker <dwalker@fifo99.com>, xe-linux-external@cisco.com,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: boot: dts: add new dts for hellcat & petra
Date:   Thu, 21 Jan 2021 15:12:35 -0800
Message-Id: <20210121231237.30664-1-danielwa@cisco.com>
X-Mailer: git-send-email 2.17.1
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.24.5.176, [10.24.5.176]
X-Outbound-Node: rcdn-core-4.cisco.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Petra and Hellcat dts file. These platforms are based on
the Xilinx Zynqmp platform.

Signed-off-by: Daniel Walker <dwalker@fifo99.com>
Cc: xe-linux-external@cisco.com
---
 arch/arm64/boot/dts/xilinx/Makefile           |   2 +
 .../boot/dts/xilinx/zynqmp-petra-hellcat.dts  | 856 ++++++++++++++++++
 arch/arm64/boot/dts/xilinx/zynqmp-petra.dts   | 847 +++++++++++++++++
 3 files changed, 1705 insertions(+)
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-petra-hellcat.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-petra.dts

diff --git a/arch/arm64/boot/dts/xilinx/Makefile b/arch/arm64/boot/dts/xilinx/Makefile
index 60f5443f3ef4..d9eacb3c60e5 100644
--- a/arch/arm64/boot/dts/xilinx/Makefile
+++ b/arch/arm64/boot/dts/xilinx/Makefile
@@ -15,3 +15,5 @@ dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu102-rev1.0.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu104-revA.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu106-revA.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu111-revA.dtb
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-petra.dts
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-petra-hellcat.dts
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-petra-hellcat.dts b/arch/arm64/boot/dts/xilinx/zynqmp-petra-hellcat.dts
new file mode 100644
index 000000000000..87e23c1cac65
--- /dev/null
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-petra-hellcat.dts
@@ -0,0 +1,856 @@
+/*
+ * dts file for Cisco Petra-Hellcat Switching IOT platform
+ *
+ * (C) Copyright 2016-2018, Cisco Systems, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ */
+
+/dts-v1/;
+
+#include "zynqmp.dtsi"
+#include "zynqmp-clk-ccf.dtsi"
+
+/*
+ ********************* PL *********************
+ */
+
+/ {
+    reserved-memory {
+        #address-cells = <0x2>;
+        #size-cells = <0x2>;
+        ranges;
+
+        rproc@3ed00000 {
+            no-map;
+            reg = <0x0 0x3ed00000 0x0 0x1000000>;
+        };
+        zynqmp_sha_reserved: buffer@0 {
+            compatible = "shared-dma-pool";
+            no-map;
+            reg = <0x0 0x78000000 0x0 0x00020000>;
+        };
+    }; 
+
+    sha384 {
+        compatible = "xlnx,zynqmp-keccak-384";
+        memory-region = <&zynqmp_sha_reserved>;
+    };
+
+	amba_pl: amba_pl@0 {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		compatible = "simple-bus";
+		ranges ;
+		design_1_i_axi_iic_BP: i2c@80104000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+            clocks = <0x3 0x47>;
+			compatible = "xlnx,xps-iic-2.00.a";
+			interrupt-parent = <&gic>;
+			interrupts = <0 93 4>;
+			reg = <0x0 0x80104000 0x0 0x1000>;
+		};
+		design_1_i_axi_iic_KM_PLT: i2c@80106000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+            clocks = <0x3 0x47>;
+			compatible = "xlnx,xps-iic-2.00.a";
+			interrupt-parent = <&gic>;
+			interrupts = <0 107 4>;
+			reg = <0x0 0x80106000 0x0 0x1000>;
+		};
+		design_1_i_axi_iic_LC1: i2c@80100000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+            clocks = <0x3 0x47>;
+			compatible = "xlnx,xps-iic-2.00.a";
+			interrupt-parent = <&gic>;
+			interrupts = <0 89 4>;
+			reg = <0x0 0x80100000 0x0 0x1000>;
+		};
+		design_1_i_axi_iic_LC2: i2c@80101000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+            clocks = <0x3 0x47>;
+			compatible = "xlnx,xps-iic-2.00.a";
+			interrupt-parent = <&gic>;
+			interrupts = <0 90 4>;
+			reg = <0x0 0x80101000 0x0 0x1000>;
+		};
+		design_1_i_axi_iic_LC3: i2c@80102000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+            clocks = <0x3 0x47>;
+			compatible = "xlnx,xps-iic-2.00.a";
+			interrupt-parent = <&gic>;
+			interrupts = <0 91 4>;
+			reg = <0x0 0x80102000 0x0 0x1000>;
+		};
+		design_1_i_axi_iic_PS: i2c@80103000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+            clocks = <0x3 0x47>;
+			compatible = "xlnx,xps-iic-2.00.a";
+			interrupt-parent = <&gic>;
+			interrupts = <0 92 4>;
+			reg = <0x0 0x80103000 0x0 0x1000>;
+		};
+		design_1_i_axi_iic_SUP: i2c@80105000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+            clocks = <0x3 0x47>;
+			compatible = "xlnx,xps-iic-2.00.a";
+			interrupt-parent = <&gic>;
+			interrupts = <0 94 4>;
+			reg = <0x0 0x80105000 0x0 0x1000>;
+		};
+		design_1_i_axi_quad_spi_LED: axi_quad_spi@80108000 {
+			bits-per-word = <8>;
+			compatible = "xlnx,xps-spi-2.00.a";
+			fifo-size = <16>;
+			interrupt-parent = <&gic>;
+			interrupts = <0 106 1>;
+			num-cs = <0x3>;
+			reg = <0x0 0x80108000 0x0 0x1000>;
+			xlnx,num-ss-bits = <0x3>;
+			xlnx,spi-mode = <0>;
+            clock-names = "axi_clk", "axi4_clk", "spi_clk";
+            clocks = <0x3 0x47 0x3 0x47 0x3 0x47>;
+		};
+		design_1_i_axi_quad_spi_lc3: axi_quad_spi@80107000 {
+			bits-per-word = <8>;
+			compatible = "xlnx,xps-spi-2.00.a";
+			fifo-size = <16>;
+			interrupt-parent = <&gic>;
+			interrupts = <0 95 1>;
+			num-cs = <0x1>;
+			reg = <0x0 0x80107000 0x0 0x1000>;
+			xlnx,num-ss-bits = <0x1>;
+			xlnx,spi-mode = <0>;
+            clock-names = "axi_clk", "axi4_clk", "spi_clk";
+            clocks = <0x3 0x47 0x3 0x47 0x3 0x48>;
+		};
+		design_1_i_mqueue_tm_ip_0: mqueue_tm_ip@80200000 {
+			compatible = "xlnx,mqueue-tm-ip-1.0";
+			interrupt-parent = <&gic>;
+			interrupts = <0 108 4 0 109 4 0 110 4 0 111 4>;
+			reg = <0x0 0x80200000 0x0 0x10000 0x80280000 0x10000 0x80300000 0x100000>;
+			xlnx,dma-data-axi-addr-width = <0x20>;
+			xlnx,dma-data-axi-data-width = <0x20>;
+			xlnx,dma-desc-axi-addr-width = <0x20>;
+			xlnx,dma-desc-axi-data-width = <0x20>;
+			xlnx,has-sgmii = <0x0>;
+			xlnx,mcam-axi-addr-width = <0x14>;
+			xlnx,mcam-axi-data-width = <0x20>;
+			xlnx,mdma-axi-addr-width = <0x10>;
+			xlnx,mdma-axi-data-width = <0x20>;
+			xlnx,mqtm-axi-addr-width = <0x10>;
+			xlnx,mqtm-axi-data-width = <0x20>;
+			xlnx,pktreq-width = <0xe>;
+			xlnx,queues = <0x40>;
+		};
+		design_1_i_system_management_wiz_0: system_management_wiz@8010a000 {
+			compatible = "xlnx,system-management-wiz-1.3";
+			reg = <0x0 0x8010a000 0x0 0x1000>;
+			xlnx,alarm-limit-r0 = <0xb794>;
+			xlnx,alarm-limit-r1 = <0x4e81>;
+			xlnx,alarm-limit-r10 = <0x5555>;
+			xlnx,alarm-limit-r11 = <0x5111>;
+			xlnx,alarm-limit-r12 = <0x9999>;
+			xlnx,alarm-limit-r13 = <0x91eb>;
+			xlnx,alarm-limit-r14 = <0x6aaa>;
+			xlnx,alarm-limit-r15 = <0x6666>;
+			xlnx,alarm-limit-r2 = <0xa147>;
+			xlnx,alarm-limit-r3 = <0xcba3>;
+			xlnx,alarm-limit-r4 = <0xab03>;
+			xlnx,alarm-limit-r5 = <0x4963>;
+			xlnx,alarm-limit-r6 = <0x9555>;
+			xlnx,alarm-limit-r7 = <0xb00a>;
+			xlnx,alarm-limit-r8 = <0x4e81>;
+			xlnx,alarm-limit-r9 = <0x4963>;
+			xlnx,alarm-limit-slave0-ssit-usl1 = <0x98bf>;
+			xlnx,alarm-limit-slave0-ssit-usl2 = <0x4bf2>;
+			xlnx,alarm-limit-slave0-ssit-usl3 = <0x98bf>;
+			xlnx,alarm-limit-slave0-ssit-usl4 = <0x98bf>;
+			xlnx,alarm-limit-slave0-ssit-usu1 = <0x9a74>;
+			xlnx,alarm-limit-slave0-ssit-usu2 = <0x4da6>;
+			xlnx,alarm-limit-slave0-ssit-usu3 = <0x9a74>;
+			xlnx,alarm-limit-slave0-ssit-usu4 = <0x9a74>;
+			xlnx,alarm-limit-slave1-ssit-usl1 = <0x98bf>;
+			xlnx,alarm-limit-slave1-ssit-usl2 = <0x4bf2>;
+			xlnx,alarm-limit-slave1-ssit-usl3 = <0x98bf>;
+			xlnx,alarm-limit-slave1-ssit-usl4 = <0x98bf>;
+			xlnx,alarm-limit-slave1-ssit-usu1 = <0x9a74>;
+			xlnx,alarm-limit-slave1-ssit-usu2 = <0x4da6>;
+			xlnx,alarm-limit-slave1-ssit-usu3 = <0x9a74>;
+			xlnx,alarm-limit-slave1-ssit-usu4 = <0x9a74>;
+			xlnx,alarm-limit-slave2-ssit-usl1 = <0x98bf>;
+			xlnx,alarm-limit-slave2-ssit-usl2 = <0x4bf2>;
+			xlnx,alarm-limit-slave2-ssit-usl3 = <0x98bf>;
+			xlnx,alarm-limit-slave2-ssit-usl4 = <0x98bf>;
+			xlnx,alarm-limit-slave2-ssit-usu1 = <0x9a74>;
+			xlnx,alarm-limit-slave2-ssit-usu2 = <0x4da6>;
+			xlnx,alarm-limit-slave2-ssit-usu3 = <0x9a74>;
+			xlnx,alarm-limit-slave2-ssit-usu4 = <0x9a74>;
+			xlnx,alarm-limit-usl1 = <0xd47a>;
+			xlnx,alarm-limit-usl2 = <0x4bf2>;
+			xlnx,alarm-limit-usl3 = <0x98bf>;
+			xlnx,alarm-limit-usl4 = <0x98bf>;
+			xlnx,alarm-limit-usu1 = <0xd62f>;
+			xlnx,alarm-limit-usu2 = <0x4da6>;
+			xlnx,alarm-limit-usu3 = <0x9a74>;
+			xlnx,alarm-limit-usu4 = <0x9a74>;
+			xlnx,average-en-slave0-ssit-vuser0 = <0x0>;
+			xlnx,average-en-slave0-ssit-vuser1 = <0x0>;
+			xlnx,average-en-slave0-ssit-vuser2 = <0x0>;
+			xlnx,average-en-slave0-ssit-vuser3 = <0x0>;
+			xlnx,average-en-slave1-ssit-vuser0 = <0x0>;
+			xlnx,average-en-slave1-ssit-vuser1 = <0x0>;
+			xlnx,average-en-slave1-ssit-vuser2 = <0x0>;
+			xlnx,average-en-slave1-ssit-vuser3 = <0x0>;
+			xlnx,average-en-slave2-ssit-vuser0 = <0x0>;
+			xlnx,average-en-slave2-ssit-vuser1 = <0x0>;
+			xlnx,average-en-slave2-ssit-vuser2 = <0x0>;
+			xlnx,average-en-slave2-ssit-vuser3 = <0x0>;
+			xlnx,average-en-vuser0 = <0x0>;
+			xlnx,average-en-vuser1 = <0x0>;
+			xlnx,average-en-vuser2 = <0x0>;
+			xlnx,average-en-vuser3 = <0x0>;
+			xlnx,avg-slave0-ssit-vuser = <0x0>;
+			xlnx,avg-slave1-ssit-vuser = <0x0>;
+			xlnx,avg-slave2-ssit-vuser = <0x0>;
+			xlnx,avg-vuser = <0x0>;
+			xlnx,channel-cnt = <0xb>;
+			xlnx,common-n-source = "Null";
+			xlnx,configuration-r0 = <0x0>;
+			xlnx,configuration-r1 = <0x2190>;
+			xlnx,configuration-r2 = <0x1400>;
+			xlnx,configuration-r3 = <0xf>;
+			xlnx,configuration-r4 = <0x0>;
+			xlnx,configuration-r4-1 = <0xc>;
+			xlnx,configuration-r4-2 = <0xd>;
+			xlnx,configuration-r4-3 = <0xe>;
+			xlnx,configuration-r4-4 = <0x8>;
+			xlnx,configuration-slave0-ssit-r3 = <0xf>;
+			xlnx,configuration-slave0-ssit-r4-1 = <0xc>;
+			xlnx,configuration-slave0-ssit-r4-2 = <0xd>;
+			xlnx,configuration-slave0-ssit-r4-3 = <0xe>;
+			xlnx,configuration-slave0-ssit-r4-4 = <0x8>;
+			xlnx,configuration-slave1-ssit-r3 = <0xf>;
+			xlnx,configuration-slave1-ssit-r4-1 = <0xc>;
+			xlnx,configuration-slave1-ssit-r4-2 = <0xd>;
+			xlnx,configuration-slave1-ssit-r4-3 = <0xe>;
+			xlnx,configuration-slave1-ssit-r4-4 = <0x8>;
+			xlnx,configuration-slave2-ssit-r3 = <0xf>;
+			xlnx,configuration-slave2-ssit-r4-1 = <0xc>;
+			xlnx,configuration-slave2-ssit-r4-2 = <0xd>;
+			xlnx,configuration-slave2-ssit-r4-3 = <0xe>;
+			xlnx,configuration-slave2-ssit-r4-4 = <0x8>;
+			xlnx,dclk-frequency = <0x64>;
+			xlnx,dual-seq = <0x0>;
+			xlnx,dual-sequence-r0 = <0x0>;
+			xlnx,dual-sequence-r1 = <0x0>;
+			xlnx,dual-sequence-r2 = <0x0>;
+			xlnx,dual0-register = <0x0>;
+			xlnx,dual1-register = <0x0>;
+			xlnx,dual2-register = <0x0>;
+			xlnx,dual3-register = <0x0>;
+			xlnx,enable-adc-data-out-master = <0x0>;
+			xlnx,enable-adc-data-out-slave0 = <0x0>;
+			xlnx,enable-adc-data-out-slave1 = <0x0>;
+			xlnx,enable-adc-data-out-slave2 = <0x0>;
+			xlnx,enable-dual-sequence-mode = <0x0>;
+			xlnx,enable-slave0 = <0x0>;
+			xlnx,enable-slave1 = <0x0>;
+			xlnx,enable-slave2 = <0x0>;
+			xlnx,external-mux-channel = "VP_VN";
+			xlnx,external-muxaddr-enable = <0x0>;
+			xlnx,fifo-depth = <0x7>;
+			xlnx,has-axi = <0x1>;
+			xlnx,has-axi4stream = <0x0>;
+			xlnx,has-busy = <0x1>;
+			xlnx,has-channel = <0x1>;
+			xlnx,has-convst = <0x0>;
+			xlnx,has-convstclk = <0x0>;
+			xlnx,has-dclk = <0x1>;
+			xlnx,has-drp = <0x0>;
+			xlnx,has-eoc = <0x1>;
+			xlnx,has-eos = <0x1>;
+			xlnx,has-external-mux = <0x0>;
+			xlnx,has-i2c = <0x0>;
+			xlnx,has-i2c-slave = <0x0>;
+			xlnx,has-jtagbusy = <0x0>;
+			xlnx,has-jtaglocked = <0x0>;
+			xlnx,has-jtagmodified = <0x0>;
+			xlnx,has-ot-alarm = <0x1>;
+			xlnx,has-pmbus = <0x0>;
+			xlnx,has-pmc = <0x0>;
+			xlnx,has-pmc-master = <0x0>;
+			xlnx,has-reset = <0x0>;
+			xlnx,has-slave0-ssit-temp-ch = <0x1>;
+			xlnx,has-slave0-ssit-vuser0 = <0x0>;
+			xlnx,has-slave0-ssit-vuser1 = <0x0>;
+			xlnx,has-slave0-ssit-vuser2 = <0x0>;
+			xlnx,has-slave0-ssit-vuser3 = <0x0>;
+			xlnx,has-slave1-ssit-temp-ch = <0x1>;
+			xlnx,has-slave1-ssit-vuser0 = <0x0>;
+			xlnx,has-slave1-ssit-vuser1 = <0x0>;
+			xlnx,has-slave1-ssit-vuser2 = <0x0>;
+			xlnx,has-slave1-ssit-vuser3 = <0x0>;
+			xlnx,has-slave2-ssit-temp-ch = <0x1>;
+			xlnx,has-slave2-ssit-vuser0 = <0x0>;
+			xlnx,has-slave2-ssit-vuser1 = <0x0>;
+			xlnx,has-slave2-ssit-vuser2 = <0x0>;
+			xlnx,has-slave2-ssit-vuser3 = <0x0>;
+			xlnx,has-temp-bus = <0x0>;
+			xlnx,has-user-supply0-alarm = <0x0>;
+			xlnx,has-user-supply0-slave0-ssit-alarm = <0x0>;
+			xlnx,has-user-supply0-slave1-ssit-alarm = <0x0>;
+			xlnx,has-user-supply0-slave2-ssit-alarm = <0x0>;
+			xlnx,has-user-supply1-alarm = <0x0>;
+			xlnx,has-user-supply1-slave0-ssit-alarm = <0x0>;
+			xlnx,has-user-supply1-slave1-ssit-alarm = <0x0>;
+			xlnx,has-user-supply1-slave2-ssit-alarm = <0x0>;
+			xlnx,has-user-supply2-alarm = <0x0>;
+			xlnx,has-user-supply2-slave0-ssit-alarm = <0x0>;
+			xlnx,has-user-supply2-slave1-ssit-alarm = <0x0>;
+			xlnx,has-user-supply2-slave2-ssit-alarm = <0x0>;
+			xlnx,has-user-supply3-alarm = <0x0>;
+			xlnx,has-user-supply3-slave0-ssit-alarm = <0x0>;
+			xlnx,has-user-supply3-slave1-ssit-alarm = <0x0>;
+			xlnx,has-user-supply3-slave2-ssit-alarm = <0x0>;
+			xlnx,has-user-temp-alarm = <0x1>;
+			xlnx,has-vbram-alarm = <0x0>;
+			xlnx,has-vccaux-alarm = <0x1>;
+			xlnx,has-vccddro-alarm = <0x0>;
+			xlnx,has-vccint-alarm = <0x1>;
+			xlnx,has-vccpaux-alarm = <0x0>;
+			xlnx,has-vccpint-alarm = <0x0>;
+			xlnx,has-vccpsaux-alarm = <0x0>;
+			xlnx,has-vccpsintfp-alarm = <0x0>;
+			xlnx,has-vccpsintlp-alarm = <0x0>;
+			xlnx,has-vn = <0x1>;
+			xlnx,has-vp = <0x1>;
+			xlnx,has-vuser0 = <0x0>;
+			xlnx,has-vuser1 = <0x0>;
+			xlnx,has-vuser2 = <0x0>;
+			xlnx,has-vuser3 = <0x0>;
+			xlnx,i2c-clk-period = "2500.000";
+			xlnx,i2c-sclk-loc = "K9";
+			xlnx,i2c-sda-loc = "H9";
+			xlnx,i2c-slave-address = <0x20>;
+			xlnx,i2c-slave0-address = <0x20>;
+			xlnx,i2c-slave1-address = <0x20>;
+			xlnx,i2c-slave2-address = <0x20>;
+			xlnx,include-intr = <0x1>;
+			xlnx,is-diablo = <0x1>;
+			xlnx,is-ssit-slave0 = <0x0>;
+			xlnx,is-ssit-slave0-analog-bank = <0x0>;
+			xlnx,is-ssit-slave1 = <0x0>;
+			xlnx,is-ssit-slave1-analog-bank = <0x0>;
+			xlnx,is-ssit-slave2 = <0x0>;
+			xlnx,is-ssit-slave2-analog-bank = <0x0>;
+			xlnx,sampling-rate = "192307.6923076923";
+			xlnx,sequence-r0 = <0x4701>;
+			xlnx,sequence-r1 = <0x3f>;
+			xlnx,sequence-r2 = <0x0>;
+			xlnx,sequence-r3 = <0x0>;
+			xlnx,sequence-r4 = <0x0>;
+			xlnx,sequence-r5 = <0x0>;
+			xlnx,sequence-r6 = <0x0>;
+			xlnx,sequence-r7 = <0x0>;
+			xlnx,sequence-r8 = <0x0>;
+			xlnx,sequence-slave0-ssit-r0 = <0x100>;
+			xlnx,sequence-slave0-ssit-r8 = <0x0>;
+			xlnx,sequence-slave1-ssit-r0 = <0x100>;
+			xlnx,sequence-slave1-ssit-r8 = <0x0>;
+			xlnx,sequence-slave2-ssit-r0 = <0x100>;
+			xlnx,sequence-slave2-ssit-r8 = <0x0>;
+			xlnx,sim-device = "ZYNQ_ULTRASCALE";
+			xlnx,sim-file-name = "design";
+			xlnx,sim-file-rel-path = "./";
+			xlnx,sim-file-sel = "Default";
+			xlnx,user-supply0-bank = <0x2c>;
+			xlnx,user-supply0-slave0-ssit-bank = <0x2c>;
+			xlnx,user-supply0-slave0-ssit-source = "VCCO";
+			xlnx,user-supply0-slave1-ssit-bank = <0x2c>;
+			xlnx,user-supply0-slave1-ssit-source = "VCCO";
+			xlnx,user-supply0-slave2-ssit-bank = <0x2c>;
+			xlnx,user-supply0-slave2-ssit-source = "VCCO";
+			xlnx,user-supply0-source = "VCCO";
+			xlnx,user-supply1-bank = <0x2c>;
+			xlnx,user-supply1-slave0-ssit-bank = <0x2c>;
+			xlnx,user-supply1-slave0-ssit-source = "VCCINT";
+			xlnx,user-supply1-slave1-ssit-bank = <0x2c>;
+			xlnx,user-supply1-slave1-ssit-source = "VCCINT";
+			xlnx,user-supply1-slave2-ssit-bank = <0x2c>;
+			xlnx,user-supply1-slave2-ssit-source = "VCCINT";
+			xlnx,user-supply1-source = "VCCINT";
+			xlnx,user-supply2-bank = <0x2c>;
+			xlnx,user-supply2-slave0-ssit-bank = <0x2c>;
+			xlnx,user-supply2-slave0-ssit-source = "VCCAUX";
+			xlnx,user-supply2-slave1-ssit-bank = <0x2c>;
+			xlnx,user-supply2-slave1-ssit-source = "VCCAUX";
+			xlnx,user-supply2-slave2-ssit-bank = <0x2c>;
+			xlnx,user-supply2-slave2-ssit-source = "VCCAUX";
+			xlnx,user-supply2-source = "VCCAUX";
+			xlnx,user-supply3-bank = <0x41>;
+			xlnx,user-supply3-slave0-ssit-bank = <0x41>;
+			xlnx,user-supply3-slave0-ssit-source = "VCCO";
+			xlnx,user-supply3-slave1-ssit-bank = <0x41>;
+			xlnx,user-supply3-slave1-ssit-source = "VCCO";
+			xlnx,user-supply3-slave2-ssit-bank = <0x41>;
+			xlnx,user-supply3-slave2-ssit-source = "VCCO";
+			xlnx,user-supply3-source = "VCCO";
+			xlnx,vaux0 = <0x1>;
+			xlnx,vaux1 = <0x1>;
+			xlnx,vaux10 = <0x0>;
+			xlnx,vaux11 = <0x0>;
+			xlnx,vaux12 = <0x0>;
+			xlnx,vaux13 = <0x0>;
+			xlnx,vaux14 = <0x0>;
+			xlnx,vaux15 = <0x0>;
+			xlnx,vaux2 = <0x1>;
+			xlnx,vaux3 = <0x1>;
+			xlnx,vaux4 = <0x1>;
+			xlnx,vaux5 = <0x1>;
+			xlnx,vaux6 = <0x0>;
+			xlnx,vaux7 = <0x0>;
+			xlnx,vaux8 = <0x0>;
+			xlnx,vaux9 = <0x0>;
+			xlnx,vauxn0-loc = "AF2";
+			xlnx,vauxn1-loc = "AH3";
+			xlnx,vauxn10-loc = "AC2";
+			xlnx,vauxn11-loc = "AB3";
+			xlnx,vauxn12-loc = "AH7";
+			xlnx,vauxn13-loc = "AH9";
+			xlnx,vauxn14-loc = "AC7";
+			xlnx,vauxn15-loc = "AC8";
+			xlnx,vauxn2-loc = "AC1";
+			xlnx,vauxn3-loc = "AD1";
+			xlnx,vauxn4-loc = "AG5";
+			xlnx,vauxn5-loc = "AG8";
+			xlnx,vauxn6-loc = "AC6";
+			xlnx,vauxn7-loc = "AE7";
+			xlnx,vauxn8-loc = "AF3";
+			xlnx,vauxn9-loc = "AH4";
+			xlnx,vauxp0-loc = "AE2";
+			xlnx,vauxp1-loc = "AG3";
+			xlnx,vauxp10-loc = "AB2";
+			xlnx,vauxp11-loc = "AB4";
+			xlnx,vauxp12-loc = "AH8";
+			xlnx,vauxp13-loc = "AG9";
+			xlnx,vauxp14-loc = "AB7";
+			xlnx,vauxp15-loc = "AB8";
+			xlnx,vauxp2-loc = "AB1";
+			xlnx,vauxp3-loc = "AD2";
+			xlnx,vauxp4-loc = "AG6";
+			xlnx,vauxp5-loc = "AF8";
+			xlnx,vauxp6-loc = "AB6";
+			xlnx,vauxp7-loc = "AD7";
+			xlnx,vauxp8-loc = "AE3";
+			xlnx,vauxp9-loc = "AG4";
+			xlnx,vpvn = <0x0>;
+		};
+		psu_ctrl_ipi: PERIPHERAL@ff380000 {
+			compatible = "xlnx,PERIPHERAL-1.0";
+			reg = <0x0 0xff380000 0x0 0x80000>;
+		};
+		psu_message_buffers: PERIPHERAL@ff990000 {
+			compatible = "xlnx,PERIPHERAL-1.0";
+			reg = <0x0 0xff990000 0x0 0x10000>;
+		};
+		misc_clk_0: misc_clk_0 {
+			#clock-cells = <0>;
+			clock-frequency = <125000000>;
+			compatible = "fixed-clock";
+		};
+		tm_dma {
+			compatible = "xlnx,tm-drv";
+			reg = <0x0 0x80200000 0x0 0x4000 0x0 0x80280000 0x0 0x4000>;
+			interrupt-parent = <0x4>;
+			interrupts = <0x0 0x6c 0x4>;
+		};
+		tm_veth {
+			compatible = "xlnx,tm-veth";
+			reg = <0x0 0x80200000 0x0 0x4000 0x0 0x80280000 0x0 0x4000>;
+			interrupt-parent = <0x4>;
+			interrupts = <0x0 0x6d 0x4>;
+		};
+	};
+};
+
+/*
+ ********************* PCW / SYS *********************
+ */
+
+&lpd_dma_chan1 {
+	status = "okay";
+};
+
+&lpd_dma_chan2 {
+	status = "okay";
+};
+
+&lpd_dma_chan3 {
+	status = "okay";
+};
+
+&lpd_dma_chan4 {
+	status = "okay";
+};
+
+&lpd_dma_chan5 {
+	status = "okay";
+};
+
+&lpd_dma_chan6 {
+	status = "okay";
+};
+
+&lpd_dma_chan7 {
+	status = "okay";
+};
+
+&lpd_dma_chan8 {
+	status = "okay";
+};
+
+&fpd_dma_chan1 {
+	status = "okay";
+};
+
+&fpd_dma_chan2 {
+	status = "okay";
+};
+
+&fpd_dma_chan3 {
+	status = "okay";
+};
+
+&fpd_dma_chan4 {
+	status = "okay";
+};
+
+&fpd_dma_chan5 {
+	status = "okay";
+};
+
+&fpd_dma_chan6 {
+	status = "okay";
+};
+
+&fpd_dma_chan7 {
+	status = "okay";
+};
+
+&fpd_dma_chan8 {
+	status = "okay";
+};
+
+&gpio {
+	emio-gpio-width = <32>;
+	gpio-mask-high = <0x0>;
+	gpio-mask-low = <0x5600>;
+	status = "okay";
+};
+
+&pcie {
+	status = "okay";
+	xlnx,pcie-mode = "Root Port";
+};
+
+&spi0 {
+	is-decoded-cs = <0>;
+	num-cs = <0x1>;
+	status = "okay";
+};
+
+&spi1 {
+	is-decoded-cs = <0>;
+	num-cs = <0x1>;
+	status = "okay";
+};
+
+&pss_ref_clk {
+	clock-frequency = <50000000>;
+};
+
+&rtc {
+	status= "disabled";
+};
+
+&watchdog0 {
+	status = "okay";
+	/delete-property/ reset-on-timeout;
+};
+
+&sdhci0 {
+	clock-frequency = <200000000>;
+	status = "okay";
+	xlnx,mio_bank = <0x0>;
+};
+
+&sdhci1 {
+	clock-frequency = <200000000>;
+	status = "okay";
+	xlnx,mio_bank = <0x1>;
+};
+
+&uart0 {
+	device_type = "serial";
+	port-number = <0>;
+	status = "okay";
+};
+
+&uart1 {
+	device_type = "serial";
+	port-number = <1>;
+	status = "disabled";
+};
+
+&usb0 {
+	status = "okay";
+	xlnx,usb-reset = <0x2faf080>;
+	clock-names = "bus_clk";
+	clocks = <0x3 0x20>;
+
+};
+
+&gem0 {
+	phy-mode = "gmii";
+	status = "okay";
+	xlnx,ptp-enet-clock = <0x0>;
+};
+
+&gem1 {
+	is-internal-pcspma ;
+	phy-mode = "sgmii";
+	status = "okay";
+	xlnx,ptp-enet-clock = <0x0>;
+};
+
+&gem2 {
+	phy-mode = "gmii";
+	status = "okay";
+	xlnx,ptp-enet-clock = <0x0>;
+};
+
+&gem3 {
+	phy-mode = "gmii";
+	status = "okay";
+	xlnx,ptp-enet-clock = <0x0>;
+	local-mac-address = [00 0a 35 00 22 01];
+};
+
+&sata {
+
+};
+
+/* 
+&gpu {
+	status = "disabled";
+};
+
+&pinctrl0 {
+	status = "okay";
+};
+
+&serdes {
+	status = "okay";
+};
+
+&ams_ps {
+	status = "okay";
+};
+
+&ams_pl {
+	status = "okay";
+};
+
+&dwc3_0 {
+	status = "okay";
+	snps,dis_u2_susphy_quirk;
+	dr_mode = "host";
+        snps,usb3_lpm_capable;
+        phy-names = "usb3-phy";
+        phys = <&lane2 0x4 0x0 0x2 0x5f5e100>;
+
+};
+
+&xilinx_ams {
+	status = "okay";
+};
+
+&qspi {
+	is-dual = <0>;
+	num-cs = <0x1>;
+	spi-rx-bus-width = <4>;
+	spi-tx-bus-width = <4>;
+	status = "disabled";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	flash0: flash@0 {
+		compatible = "n25q512a", "micron,m25p80";
+		reg = <0x0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <108000000>;
+		partition@0x00000000 {
+			label = "boot";
+			reg = <0x00000000 0x00100000>;
+		};
+		partition@0x00100000 {
+			label = "bootenv";
+			reg = <0x00100000 0x00040000>;
+		};
+		partition@0x00140000 {
+			label = "kernel";
+			reg = <0x00140000 0x01600000>;
+		};
+	};
+};
+*/
+&design_1_i_axi_iic_SUP {
+	lm75@48 {
+		compatible = "lm75";
+		reg = <0x48>;
+	};
+	ds1337@68 {
+		compatible = "dallas,ds1337";
+		reg = <0x68>;
+	};
+};
+
+
+&i2c0 {
+	clock-frequency = <400000>;
+	status = "okay";
+	gpio1@74 {
+		compatible = "i2c-pca9539";
+		reg = <0x74>;
+	};
+};
+
+&i2c1 {
+	clock-frequency = <400000>;
+	status = "okay";
+	gpio2@74 {
+		compatible = "i2c-pca9539";
+		reg = <0x74>;
+	};
+	gpio3@20 {
+		compatible = "i2c-pca8575";
+		reg = <0x20>;
+	};
+};
+
+&design_1_i_axi_quad_spi_LED {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	device@0 {
+		compatible = "cisco,spi-petra";
+		reg = <0x0>;
+		spi-max-frequency = <0x2faf08>;
+	};
+	device@1 {
+		compatible = "cisco,spi-petra";
+		reg = <0x1>;
+		spi-max-frequency = <0x2faf08>;
+	};
+};
+
+&amba {
+    shm@0 {
+        compatible = "shm_uio";
+        reg = <0x0 0x3ed80000 0x0 0x800000>;
+    };
+
+    ipi@ff340000 {
+        compatible = "ipi_uio";
+        reg = <0x0 0xff340000 0x0 0x1000>;
+        interrupt-parent = <0x2>;
+        interrupts = <0x0 0x1d 0x4>;
+    };
+};
+
+&spi0 {
+    status = "okay";
+    num-cs = <1>;
+    spidev@0 {
+	compatible = "cisco,spi-petra";
+        reg = <0>;
+        spi-max-frequency = <25000000>;
+    };
+};
+
+&spi1 {
+    status = "okay";
+    spidev@1 {
+	compatible = "cisco,spi-petra";
+        reg = <0x0>;
+        spi-max-frequency = <0xf4240>;
+    };
+};
+
+&design_1_i_axi_quad_spi_lc3 {
+    status = "okay";
+    device@0 {
+      compatible = "cisco,spi-petra";
+      reg = <0>;  //Chip select 0
+      spi-max-frequency = <3125000>;
+    };
+};
+
+&gem0 {
+    status = "disabled";
+};
+
+&gem1 {
+    status = "disabled";
+};
+
+&gem2 {
+    status = "disabled";
+};
+
+&gem3 {
+    status = "disabled";
+};
+
+
+/ {
+	chosen {
+		bootargs = "earlycon console=ttyPS0,9600n8 clk_ignore_unused cpuidle.off=1";
+		stdout-path = "serial0:9600n8";
+	};
+	aliases {
+		ethernet0 = &gem0;
+		ethernet1 = &gem1;
+		ethernet2 = &gem2;
+		ethernet3 = &gem3;
+		serial0 = &uart0;
+		spi0 = &design_1_i_axi_quad_spi_LED;
+		spi1 = &design_1_i_axi_quad_spi_lc3;
+		//spi2 = &qspi;
+		spi3 = &spi0;
+		spi4 = &spi1;
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &design_1_i_axi_iic_LC1;
+		i2c3 = &design_1_i_axi_iic_LC2;
+		i2c4 = &design_1_i_axi_iic_LC3;
+		i2c5 = &design_1_i_axi_iic_PS;
+		i2c6 = &design_1_i_axi_iic_BP;
+		i2c7 = &design_1_i_axi_iic_SUP;
+		i2c8 = &design_1_i_axi_iic_KM_PLT;
+	};
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x80000000>, <0x8 0x0 0x0 0x80000000>;
+	};
+};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-petra.dts b/arch/arm64/boot/dts/xilinx/zynqmp-petra.dts
new file mode 100644
index 000000000000..594335740bf9
--- /dev/null
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-petra.dts
@@ -0,0 +1,847 @@
+/*
+ * dts file for Cisco Petra Switching IOT platform
+ *
+ * (C) Copyright 2016-2018, Cisco Systems, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ */
+
+/dts-v1/;
+
+#include "zynqmp.dtsi"
+#include "zynqmp-clk-ccf.dtsi"
+
+/*
+ ********************* PL *********************
+ */
+
+/ {
+    reserved-memory {
+        #address-cells = <0x2>;
+        #size-cells = <0x2>;
+        ranges;
+
+        rproc@3ed00000 {
+            no-map;
+            reg = <0x0 0x3ed00000 0x0 0x1000000>;
+        };
+        zynqmp_sha_reserved: buffer@0 {
+            compatible = "shared-dma-pool";
+            no-map;
+            reg = <0x0 0x78000000 0x0 0x00020000>;
+        };
+    };
+
+    sha384 {
+        compatible = "xlnx,zynqmp-keccak-384";
+        memory-region = <&zynqmp_sha_reserved>;
+    };
+
+	amba_pl: amba_pl@0 {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		compatible = "simple-bus";
+		ranges ;
+		design_1_i_axi_iic_BP: i2c@80104000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+            clocks = <0x3 0x47>;
+			compatible = "xlnx,xps-iic-2.00.a";
+			interrupt-parent = <&gic>;
+			interrupts = <0 93 4>;
+			reg = <0x0 0x80104000 0x0 0x1000>;
+		};
+		design_1_i_axi_iic_KM_PLT: i2c@80106000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+            clocks = <0x3 0x47>;
+			compatible = "xlnx,xps-iic-2.00.a";
+			interrupt-parent = <&gic>;
+			interrupts = <0 107 4>;
+			reg = <0x0 0x80106000 0x0 0x1000>;
+		};
+		design_1_i_axi_iic_LC1: i2c@80100000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+            clocks = <0x3 0x47>;
+			compatible = "xlnx,xps-iic-2.00.a";
+			interrupt-parent = <&gic>;
+			interrupts = <0 89 4>;
+			reg = <0x0 0x80100000 0x0 0x1000>;
+		};
+		design_1_i_axi_iic_LC2: i2c@80101000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+            clocks = <0x3 0x47>;
+			compatible = "xlnx,xps-iic-2.00.a";
+			interrupt-parent = <&gic>;
+			interrupts = <0 90 4>;
+			reg = <0x0 0x80101000 0x0 0x1000>;
+		};
+		design_1_i_axi_iic_LC3: i2c@80102000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+            clocks = <0x3 0x47>;
+			compatible = "xlnx,xps-iic-2.00.a";
+			interrupt-parent = <&gic>;
+			interrupts = <0 91 4>;
+			reg = <0x0 0x80102000 0x0 0x1000>;
+		};
+		design_1_i_axi_iic_PS: i2c@80103000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+	        clocks = <0x3 0x47>;
+			compatible = "xlnx,xps-iic-2.00.a";
+			interrupt-parent = <&gic>;
+			interrupts = <0 92 4>;
+			reg = <0x0 0x80103000 0x0 0x1000>;
+		};
+		design_1_i_axi_iic_SUP: i2c@80105000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+	        clocks = <0x3 0x47>;
+			compatible = "xlnx,xps-iic-2.00.a";
+			interrupt-parent = <&gic>;
+			interrupts = <0 94 4>;
+			reg = <0x0 0x80105000 0x0 0x1000>;
+		};
+		design_1_i_axi_quad_spi_LED: axi_quad_spi@80108000 {
+			bits-per-word = <8>;
+			compatible = "xlnx,xps-spi-2.00.a";
+			fifo-size = <16>;
+			interrupt-parent = <&gic>;
+			interrupts = <0 106 1>;
+			num-cs = <0x3>;
+			reg = <0x0 0x80108000 0x0 0x1000>;
+			xlnx,num-ss-bits = <0x3>;
+			xlnx,spi-mode = <0>;
+            clock-names = "axi_clk", "axi4_clk", "spi_clk";
+            clocks = <0x3 0x47 0x3 0x47 0x3 0x47>;
+            device@0 {
+                compatible = "cisco,spi-petra";
+                status = "disabled";
+                reg = <0x0>;
+                spi-max-frequency = <0x2faf08>;
+            };
+		};
+		design_1_i_axi_quad_spi_lc3: axi_quad_spi@80107000 {
+			bits-per-word = <8>;
+			compatible = "xlnx,xps-spi-2.00.a";
+			fifo-size = <16>;
+			interrupt-parent = <&gic>;
+			interrupts = <0 95 1>;
+			num-cs = <0x1>;
+			reg = <0x0 0x80107000 0x0 0x1000>;
+			xlnx,num-ss-bits = <0x1>;
+			xlnx,spi-mode = <0>;
+            clock-names = "axi_clk", "axi4_clk", "spi_clk";
+            clocks = <0x3 0x47 0x3 0x47 0x3 0x48>;
+		};
+		design_1_i_mqueue_tm_ip_0: mqueue_tm_ip@80200000 {
+			compatible = "xlnx,mqueue-tm-ip-1.0";
+			interrupt-parent = <&gic>;
+			interrupts = <0 108 4 0 109 4 0 110 4 0 111 4>;
+			reg = <0x0 0x80200000 0x0 0x10000 0x80280000 0x10000 0x80300000 0x100000>;
+			xlnx,dma-data-axi-addr-width = <0x20>;
+			xlnx,dma-data-axi-data-width = <0x20>;
+			xlnx,dma-desc-axi-addr-width = <0x20>;
+			xlnx,dma-desc-axi-data-width = <0x20>;
+			xlnx,has-sgmii = <0x0>;
+			xlnx,mcam-axi-addr-width = <0x14>;
+			xlnx,mcam-axi-data-width = <0x20>;
+			xlnx,mdma-axi-addr-width = <0x10>;
+			xlnx,mdma-axi-data-width = <0x20>;
+			xlnx,mqtm-axi-addr-width = <0x10>;
+			xlnx,mqtm-axi-data-width = <0x20>;
+			xlnx,pktreq-width = <0xe>;
+			xlnx,queues = <0x40>;
+		};
+		design_1_i_system_management_wiz_0: system_management_wiz@8010a000 {
+			compatible = "xlnx,system-management-wiz-1.3";
+			reg = <0x0 0x8010a000 0x0 0x1000>;
+			xlnx,alarm-limit-r0 = <0xb794>;
+			xlnx,alarm-limit-r1 = <0x4e81>;
+			xlnx,alarm-limit-r10 = <0x5555>;
+			xlnx,alarm-limit-r11 = <0x5111>;
+			xlnx,alarm-limit-r12 = <0x9999>;
+			xlnx,alarm-limit-r13 = <0x91eb>;
+			xlnx,alarm-limit-r14 = <0x6aaa>;
+			xlnx,alarm-limit-r15 = <0x6666>;
+			xlnx,alarm-limit-r2 = <0xa147>;
+			xlnx,alarm-limit-r3 = <0xcba3>;
+			xlnx,alarm-limit-r4 = <0xab03>;
+			xlnx,alarm-limit-r5 = <0x4963>;
+			xlnx,alarm-limit-r6 = <0x9555>;
+			xlnx,alarm-limit-r7 = <0xb00a>;
+			xlnx,alarm-limit-r8 = <0x4e81>;
+			xlnx,alarm-limit-r9 = <0x4963>;
+			xlnx,alarm-limit-slave0-ssit-usl1 = <0x98bf>;
+			xlnx,alarm-limit-slave0-ssit-usl2 = <0x4bf2>;
+			xlnx,alarm-limit-slave0-ssit-usl3 = <0x98bf>;
+			xlnx,alarm-limit-slave0-ssit-usl4 = <0x98bf>;
+			xlnx,alarm-limit-slave0-ssit-usu1 = <0x9a74>;
+			xlnx,alarm-limit-slave0-ssit-usu2 = <0x4da6>;
+			xlnx,alarm-limit-slave0-ssit-usu3 = <0x9a74>;
+			xlnx,alarm-limit-slave0-ssit-usu4 = <0x9a74>;
+			xlnx,alarm-limit-slave1-ssit-usl1 = <0x98bf>;
+			xlnx,alarm-limit-slave1-ssit-usl2 = <0x4bf2>;
+			xlnx,alarm-limit-slave1-ssit-usl3 = <0x98bf>;
+			xlnx,alarm-limit-slave1-ssit-usl4 = <0x98bf>;
+			xlnx,alarm-limit-slave1-ssit-usu1 = <0x9a74>;
+			xlnx,alarm-limit-slave1-ssit-usu2 = <0x4da6>;
+			xlnx,alarm-limit-slave1-ssit-usu3 = <0x9a74>;
+			xlnx,alarm-limit-slave1-ssit-usu4 = <0x9a74>;
+			xlnx,alarm-limit-slave2-ssit-usl1 = <0x98bf>;
+			xlnx,alarm-limit-slave2-ssit-usl2 = <0x4bf2>;
+			xlnx,alarm-limit-slave2-ssit-usl3 = <0x98bf>;
+			xlnx,alarm-limit-slave2-ssit-usl4 = <0x98bf>;
+			xlnx,alarm-limit-slave2-ssit-usu1 = <0x9a74>;
+			xlnx,alarm-limit-slave2-ssit-usu2 = <0x4da6>;
+			xlnx,alarm-limit-slave2-ssit-usu3 = <0x9a74>;
+			xlnx,alarm-limit-slave2-ssit-usu4 = <0x9a74>;
+			xlnx,alarm-limit-usl1 = <0xd47a>;
+			xlnx,alarm-limit-usl2 = <0x4bf2>;
+			xlnx,alarm-limit-usl3 = <0x98bf>;
+			xlnx,alarm-limit-usl4 = <0x98bf>;
+			xlnx,alarm-limit-usu1 = <0xd62f>;
+			xlnx,alarm-limit-usu2 = <0x4da6>;
+			xlnx,alarm-limit-usu3 = <0x9a74>;
+			xlnx,alarm-limit-usu4 = <0x9a74>;
+			xlnx,average-en-slave0-ssit-vuser0 = <0x0>;
+			xlnx,average-en-slave0-ssit-vuser1 = <0x0>;
+			xlnx,average-en-slave0-ssit-vuser2 = <0x0>;
+			xlnx,average-en-slave0-ssit-vuser3 = <0x0>;
+			xlnx,average-en-slave1-ssit-vuser0 = <0x0>;
+			xlnx,average-en-slave1-ssit-vuser1 = <0x0>;
+			xlnx,average-en-slave1-ssit-vuser2 = <0x0>;
+			xlnx,average-en-slave1-ssit-vuser3 = <0x0>;
+			xlnx,average-en-slave2-ssit-vuser0 = <0x0>;
+			xlnx,average-en-slave2-ssit-vuser1 = <0x0>;
+			xlnx,average-en-slave2-ssit-vuser2 = <0x0>;
+			xlnx,average-en-slave2-ssit-vuser3 = <0x0>;
+			xlnx,average-en-vuser0 = <0x0>;
+			xlnx,average-en-vuser1 = <0x0>;
+			xlnx,average-en-vuser2 = <0x0>;
+			xlnx,average-en-vuser3 = <0x0>;
+			xlnx,avg-slave0-ssit-vuser = <0x0>;
+			xlnx,avg-slave1-ssit-vuser = <0x0>;
+			xlnx,avg-slave2-ssit-vuser = <0x0>;
+			xlnx,avg-vuser = <0x0>;
+			xlnx,channel-cnt = <0xb>;
+			xlnx,common-n-source = "Null";
+			xlnx,configuration-r0 = <0x0>;
+			xlnx,configuration-r1 = <0x2190>;
+			xlnx,configuration-r2 = <0x1400>;
+			xlnx,configuration-r3 = <0xf>;
+			xlnx,configuration-r4 = <0x0>;
+			xlnx,configuration-r4-1 = <0xc>;
+			xlnx,configuration-r4-2 = <0xd>;
+			xlnx,configuration-r4-3 = <0xe>;
+			xlnx,configuration-r4-4 = <0x8>;
+			xlnx,configuration-slave0-ssit-r3 = <0xf>;
+			xlnx,configuration-slave0-ssit-r4-1 = <0xc>;
+			xlnx,configuration-slave0-ssit-r4-2 = <0xd>;
+			xlnx,configuration-slave0-ssit-r4-3 = <0xe>;
+			xlnx,configuration-slave0-ssit-r4-4 = <0x8>;
+			xlnx,configuration-slave1-ssit-r3 = <0xf>;
+			xlnx,configuration-slave1-ssit-r4-1 = <0xc>;
+			xlnx,configuration-slave1-ssit-r4-2 = <0xd>;
+			xlnx,configuration-slave1-ssit-r4-3 = <0xe>;
+			xlnx,configuration-slave1-ssit-r4-4 = <0x8>;
+			xlnx,configuration-slave2-ssit-r3 = <0xf>;
+			xlnx,configuration-slave2-ssit-r4-1 = <0xc>;
+			xlnx,configuration-slave2-ssit-r4-2 = <0xd>;
+			xlnx,configuration-slave2-ssit-r4-3 = <0xe>;
+			xlnx,configuration-slave2-ssit-r4-4 = <0x8>;
+			xlnx,dclk-frequency = <0x64>;
+			xlnx,dual-seq = <0x0>;
+			xlnx,dual-sequence-r0 = <0x0>;
+			xlnx,dual-sequence-r1 = <0x0>;
+			xlnx,dual-sequence-r2 = <0x0>;
+			xlnx,dual0-register = <0x0>;
+			xlnx,dual1-register = <0x0>;
+			xlnx,dual2-register = <0x0>;
+			xlnx,dual3-register = <0x0>;
+			xlnx,enable-adc-data-out-master = <0x0>;
+			xlnx,enable-adc-data-out-slave0 = <0x0>;
+			xlnx,enable-adc-data-out-slave1 = <0x0>;
+			xlnx,enable-adc-data-out-slave2 = <0x0>;
+			xlnx,enable-dual-sequence-mode = <0x0>;
+			xlnx,enable-slave0 = <0x0>;
+			xlnx,enable-slave1 = <0x0>;
+			xlnx,enable-slave2 = <0x0>;
+			xlnx,external-mux-channel = "VP_VN";
+			xlnx,external-muxaddr-enable = <0x0>;
+			xlnx,fifo-depth = <0x7>;
+			xlnx,has-axi = <0x1>;
+			xlnx,has-axi4stream = <0x0>;
+			xlnx,has-busy = <0x1>;
+			xlnx,has-channel = <0x1>;
+			xlnx,has-convst = <0x0>;
+			xlnx,has-convstclk = <0x0>;
+			xlnx,has-dclk = <0x1>;
+			xlnx,has-drp = <0x0>;
+			xlnx,has-eoc = <0x1>;
+			xlnx,has-eos = <0x1>;
+			xlnx,has-external-mux = <0x0>;
+			xlnx,has-i2c = <0x0>;
+			xlnx,has-i2c-slave = <0x0>;
+			xlnx,has-jtagbusy = <0x0>;
+			xlnx,has-jtaglocked = <0x0>;
+			xlnx,has-jtagmodified = <0x0>;
+			xlnx,has-ot-alarm = <0x1>;
+			xlnx,has-pmbus = <0x0>;
+			xlnx,has-pmc = <0x0>;
+			xlnx,has-pmc-master = <0x0>;
+			xlnx,has-reset = <0x0>;
+			xlnx,has-slave0-ssit-temp-ch = <0x1>;
+			xlnx,has-slave0-ssit-vuser0 = <0x0>;
+			xlnx,has-slave0-ssit-vuser1 = <0x0>;
+			xlnx,has-slave0-ssit-vuser2 = <0x0>;
+			xlnx,has-slave0-ssit-vuser3 = <0x0>;
+			xlnx,has-slave1-ssit-temp-ch = <0x1>;
+			xlnx,has-slave1-ssit-vuser0 = <0x0>;
+			xlnx,has-slave1-ssit-vuser1 = <0x0>;
+			xlnx,has-slave1-ssit-vuser2 = <0x0>;
+			xlnx,has-slave1-ssit-vuser3 = <0x0>;
+			xlnx,has-slave2-ssit-temp-ch = <0x1>;
+			xlnx,has-slave2-ssit-vuser0 = <0x0>;
+			xlnx,has-slave2-ssit-vuser1 = <0x0>;
+			xlnx,has-slave2-ssit-vuser2 = <0x0>;
+			xlnx,has-slave2-ssit-vuser3 = <0x0>;
+			xlnx,has-temp-bus = <0x0>;
+			xlnx,has-user-supply0-alarm = <0x0>;
+			xlnx,has-user-supply0-slave0-ssit-alarm = <0x0>;
+			xlnx,has-user-supply0-slave1-ssit-alarm = <0x0>;
+			xlnx,has-user-supply0-slave2-ssit-alarm = <0x0>;
+			xlnx,has-user-supply1-alarm = <0x0>;
+			xlnx,has-user-supply1-slave0-ssit-alarm = <0x0>;
+			xlnx,has-user-supply1-slave1-ssit-alarm = <0x0>;
+			xlnx,has-user-supply1-slave2-ssit-alarm = <0x0>;
+			xlnx,has-user-supply2-alarm = <0x0>;
+			xlnx,has-user-supply2-slave0-ssit-alarm = <0x0>;
+			xlnx,has-user-supply2-slave1-ssit-alarm = <0x0>;
+			xlnx,has-user-supply2-slave2-ssit-alarm = <0x0>;
+			xlnx,has-user-supply3-alarm = <0x0>;
+			xlnx,has-user-supply3-slave0-ssit-alarm = <0x0>;
+			xlnx,has-user-supply3-slave1-ssit-alarm = <0x0>;
+			xlnx,has-user-supply3-slave2-ssit-alarm = <0x0>;
+			xlnx,has-user-temp-alarm = <0x1>;
+			xlnx,has-vbram-alarm = <0x0>;
+			xlnx,has-vccaux-alarm = <0x1>;
+			xlnx,has-vccddro-alarm = <0x0>;
+			xlnx,has-vccint-alarm = <0x1>;
+			xlnx,has-vccpaux-alarm = <0x0>;
+			xlnx,has-vccpint-alarm = <0x0>;
+			xlnx,has-vccpsaux-alarm = <0x0>;
+			xlnx,has-vccpsintfp-alarm = <0x0>;
+			xlnx,has-vccpsintlp-alarm = <0x0>;
+			xlnx,has-vn = <0x1>;
+			xlnx,has-vp = <0x1>;
+			xlnx,has-vuser0 = <0x0>;
+			xlnx,has-vuser1 = <0x0>;
+			xlnx,has-vuser2 = <0x0>;
+			xlnx,has-vuser3 = <0x0>;
+			xlnx,i2c-clk-period = "2500.000";
+			xlnx,i2c-sclk-loc = "K9";
+			xlnx,i2c-sda-loc = "H9";
+			xlnx,i2c-slave-address = <0x20>;
+			xlnx,i2c-slave0-address = <0x20>;
+			xlnx,i2c-slave1-address = <0x20>;
+			xlnx,i2c-slave2-address = <0x20>;
+			xlnx,include-intr = <0x1>;
+			xlnx,is-diablo = <0x1>;
+			xlnx,is-ssit-slave0 = <0x0>;
+			xlnx,is-ssit-slave0-analog-bank = <0x0>;
+			xlnx,is-ssit-slave1 = <0x0>;
+			xlnx,is-ssit-slave1-analog-bank = <0x0>;
+			xlnx,is-ssit-slave2 = <0x0>;
+			xlnx,is-ssit-slave2-analog-bank = <0x0>;
+			xlnx,sampling-rate = "192307.6923076923";
+			xlnx,sequence-r0 = <0x4701>;
+			xlnx,sequence-r1 = <0x3f>;
+			xlnx,sequence-r2 = <0x0>;
+			xlnx,sequence-r3 = <0x0>;
+			xlnx,sequence-r4 = <0x0>;
+			xlnx,sequence-r5 = <0x0>;
+			xlnx,sequence-r6 = <0x0>;
+			xlnx,sequence-r7 = <0x0>;
+			xlnx,sequence-r8 = <0x0>;
+			xlnx,sequence-slave0-ssit-r0 = <0x100>;
+			xlnx,sequence-slave0-ssit-r8 = <0x0>;
+			xlnx,sequence-slave1-ssit-r0 = <0x100>;
+			xlnx,sequence-slave1-ssit-r8 = <0x0>;
+			xlnx,sequence-slave2-ssit-r0 = <0x100>;
+			xlnx,sequence-slave2-ssit-r8 = <0x0>;
+			xlnx,sim-device = "ZYNQ_ULTRASCALE";
+			xlnx,sim-file-name = "design";
+			xlnx,sim-file-rel-path = "./";
+			xlnx,sim-file-sel = "Default";
+			xlnx,user-supply0-bank = <0x2c>;
+			xlnx,user-supply0-slave0-ssit-bank = <0x2c>;
+			xlnx,user-supply0-slave0-ssit-source = "VCCO";
+			xlnx,user-supply0-slave1-ssit-bank = <0x2c>;
+			xlnx,user-supply0-slave1-ssit-source = "VCCO";
+			xlnx,user-supply0-slave2-ssit-bank = <0x2c>;
+			xlnx,user-supply0-slave2-ssit-source = "VCCO";
+			xlnx,user-supply0-source = "VCCO";
+			xlnx,user-supply1-bank = <0x2c>;
+			xlnx,user-supply1-slave0-ssit-bank = <0x2c>;
+			xlnx,user-supply1-slave0-ssit-source = "VCCINT";
+			xlnx,user-supply1-slave1-ssit-bank = <0x2c>;
+			xlnx,user-supply1-slave1-ssit-source = "VCCINT";
+			xlnx,user-supply1-slave2-ssit-bank = <0x2c>;
+			xlnx,user-supply1-slave2-ssit-source = "VCCINT";
+			xlnx,user-supply1-source = "VCCINT";
+			xlnx,user-supply2-bank = <0x2c>;
+			xlnx,user-supply2-slave0-ssit-bank = <0x2c>;
+			xlnx,user-supply2-slave0-ssit-source = "VCCAUX";
+			xlnx,user-supply2-slave1-ssit-bank = <0x2c>;
+			xlnx,user-supply2-slave1-ssit-source = "VCCAUX";
+			xlnx,user-supply2-slave2-ssit-bank = <0x2c>;
+			xlnx,user-supply2-slave2-ssit-source = "VCCAUX";
+			xlnx,user-supply2-source = "VCCAUX";
+			xlnx,user-supply3-bank = <0x41>;
+			xlnx,user-supply3-slave0-ssit-bank = <0x41>;
+			xlnx,user-supply3-slave0-ssit-source = "VCCO";
+			xlnx,user-supply3-slave1-ssit-bank = <0x41>;
+			xlnx,user-supply3-slave1-ssit-source = "VCCO";
+			xlnx,user-supply3-slave2-ssit-bank = <0x41>;
+			xlnx,user-supply3-slave2-ssit-source = "VCCO";
+			xlnx,user-supply3-source = "VCCO";
+			xlnx,vaux0 = <0x1>;
+			xlnx,vaux1 = <0x1>;
+			xlnx,vaux10 = <0x0>;
+			xlnx,vaux11 = <0x0>;
+			xlnx,vaux12 = <0x0>;
+			xlnx,vaux13 = <0x0>;
+			xlnx,vaux14 = <0x0>;
+			xlnx,vaux15 = <0x0>;
+			xlnx,vaux2 = <0x1>;
+			xlnx,vaux3 = <0x1>;
+			xlnx,vaux4 = <0x1>;
+			xlnx,vaux5 = <0x1>;
+			xlnx,vaux6 = <0x0>;
+			xlnx,vaux7 = <0x0>;
+			xlnx,vaux8 = <0x0>;
+			xlnx,vaux9 = <0x0>;
+			xlnx,vauxn0-loc = "AF2";
+			xlnx,vauxn1-loc = "AH3";
+			xlnx,vauxn10-loc = "AC2";
+			xlnx,vauxn11-loc = "AB3";
+			xlnx,vauxn12-loc = "AH7";
+			xlnx,vauxn13-loc = "AH9";
+			xlnx,vauxn14-loc = "AC7";
+			xlnx,vauxn15-loc = "AC8";
+			xlnx,vauxn2-loc = "AC1";
+			xlnx,vauxn3-loc = "AD1";
+			xlnx,vauxn4-loc = "AG5";
+			xlnx,vauxn5-loc = "AG8";
+			xlnx,vauxn6-loc = "AC6";
+			xlnx,vauxn7-loc = "AE7";
+			xlnx,vauxn8-loc = "AF3";
+			xlnx,vauxn9-loc = "AH4";
+			xlnx,vauxp0-loc = "AE2";
+			xlnx,vauxp1-loc = "AG3";
+			xlnx,vauxp10-loc = "AB2";
+			xlnx,vauxp11-loc = "AB4";
+			xlnx,vauxp12-loc = "AH8";
+			xlnx,vauxp13-loc = "AG9";
+			xlnx,vauxp14-loc = "AB7";
+			xlnx,vauxp15-loc = "AB8";
+			xlnx,vauxp2-loc = "AB1";
+			xlnx,vauxp3-loc = "AD2";
+			xlnx,vauxp4-loc = "AG6";
+			xlnx,vauxp5-loc = "AF8";
+			xlnx,vauxp6-loc = "AB6";
+			xlnx,vauxp7-loc = "AD7";
+			xlnx,vauxp8-loc = "AE3";
+			xlnx,vauxp9-loc = "AG4";
+			xlnx,vpvn = <0x0>;
+		};
+		psu_ctrl_ipi: PERIPHERAL@ff380000 {
+			compatible = "xlnx,PERIPHERAL-1.0";
+			reg = <0x0 0xff380000 0x0 0x80000>;
+		};
+		psu_message_buffers: PERIPHERAL@ff990000 {
+			compatible = "xlnx,PERIPHERAL-1.0";
+			reg = <0x0 0xff990000 0x0 0x10000>;
+		};
+		misc_clk_0: misc_clk_0 {
+			#clock-cells = <0>;
+			clock-frequency = <125000000>;
+			compatible = "fixed-clock";
+		};
+		tm_dma {
+			compatible = "xlnx,tm-drv";
+			reg = <0x0 0x80200000 0x0 0x4000 0x0 0x80280000 0x0 0x4000>;
+			interrupt-parent = <0x4>;
+			interrupts = <0x0 0x6c 0x4>;
+		};
+		tm_veth {
+			compatible = "xlnx,tm-veth";
+			reg = <0x0 0x80200000 0x0 0x4000 0x0 0x80280000 0x0 0x4000>;
+			interrupt-parent = <0x4>;
+			interrupts = <0x0 0x6d 0x4>;
+		};
+	};
+};
+
+/*
+ ********************* PCW / SYS *********************
+ */
+
+&lpd_dma_chan1 {
+	status = "okay";
+};
+
+&lpd_dma_chan2 {
+	status = "okay";
+};
+
+&lpd_dma_chan3 {
+	status = "okay";
+};
+
+&lpd_dma_chan4 {
+	status = "okay";
+};
+
+&lpd_dma_chan5 {
+	status = "okay";
+};
+
+&lpd_dma_chan6 {
+	status = "okay";
+};
+
+&lpd_dma_chan7 {
+	status = "okay";
+};
+
+&lpd_dma_chan8 {
+	status = "okay";
+};
+
+&fpd_dma_chan1 {
+	status = "okay";
+};
+
+&fpd_dma_chan2 {
+	status = "okay";
+};
+
+&fpd_dma_chan3 {
+	status = "okay";
+};
+
+&fpd_dma_chan4 {
+	status = "okay";
+};
+
+&fpd_dma_chan5 {
+	status = "okay";
+};
+
+&fpd_dma_chan6 {
+	status = "okay";
+};
+
+&fpd_dma_chan7 {
+	status = "okay";
+};
+
+&fpd_dma_chan8 {
+	status = "okay";
+};
+
+&gpio {
+	emio-gpio-width = <32>;
+	gpio-mask-high = <0x0>;
+	gpio-mask-low = <0x5600>;
+	status = "okay";
+};
+
+&pcie {
+	status = "okay";
+	xlnx,pcie-mode = "Root Port";
+};
+
+&spi0 {
+	is-decoded-cs = <0>;
+	num-cs = <0x1>;
+	status = "okay";
+};
+
+&spi1 {
+	is-decoded-cs = <0>;
+	num-cs = <0x1>;
+	status = "okay";
+};
+
+&pss_ref_clk {
+	clock-frequency = <50000000>;
+};
+
+&rtc {
+	status= "disabled";
+};
+
+&watchdog0 {
+	status = "okay";
+	/delete-property/ reset-on-timeout;
+};
+
+&sdhci0 {
+	clock-frequency = <200000000>;
+	status = "okay";
+	xlnx,mio_bank = <0x0>;
+};
+
+&sdhci1 {
+	clock-frequency = <200000000>;
+	status = "okay";
+	xlnx,mio_bank = <0x1>;
+};
+
+&uart0 {
+	device_type = "serial";
+	port-number = <0>;
+	status = "okay";
+};
+
+&uart1 {
+	device_type = "serial";
+	port-number = <1>;
+	status = "disabled";
+};
+
+&usb0 {
+	status = "okay";
+	xlnx,usb-reset = <0x2faf080>;
+	clock-names = "bus_clk";
+	clocks = <0x3 0x20>;
+
+};
+
+&gem0 {
+	phy-mode = "gmii";
+	status = "okay";
+	xlnx,ptp-enet-clock = <0x0>;
+};
+
+&gem1 {
+	is-internal-pcspma ;
+	phy-mode = "sgmii";
+	status = "okay";
+	xlnx,ptp-enet-clock = <0x0>;
+};
+
+&gem2 {
+	phy-mode = "gmii";
+	status = "okay";
+	xlnx,ptp-enet-clock = <0x0>;
+};
+
+&gem3 {
+	phy-mode = "gmii";
+	status = "okay";
+	xlnx,ptp-enet-clock = <0x0>;
+	local-mac-address = [00 0a 35 00 22 01];
+};
+
+&sata {
+
+};
+
+/* These nodes have not been upstreamed by Xilinx yet.
+&gpu {
+	status = "disabled";
+};
+
+&pinctrl0 {
+	status = "okay";
+};
+
+&serdes {
+	status = "okay";
+};
+
+&ams_ps {
+	status = "okay";
+};
+
+&ams_pl {
+	status = "okay";
+};
+
+&dwc3_0 {
+	status = "okay";
+	snps,dis_u2_susphy_quirk;
+	dr_mode = "host";
+        snps,usb3_lpm_capable;
+        phy-names = "usb3-phy";
+        phys = <&lane2 0x4 0x0 0x2 0x5f5e100>;
+
+};
+
+&xilinx_ams {
+	status = "okay";
+};
+
+&qspi {
+	is-dual = <0>;
+	num-cs = <0x1>;
+	spi-rx-bus-width = <4>;
+	spi-tx-bus-width = <4>;
+	status = "disabled";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	flash0: flash@0 {
+		compatible = "n25q512a", "micron,m25p80";
+		reg = <0x0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <108000000>;
+		partition@0x00000000 {
+			label = "boot";
+			reg = <0x00000000 0x00100000>;
+		};
+		partition@0x00100000 {
+			label = "bootenv";
+			reg = <0x00100000 0x00040000>;
+		};
+		partition@0x00140000 {
+			label = "kernel";
+			reg = <0x00140000 0x01600000>;
+		};
+	};
+};
+*/
+
+&design_1_i_axi_iic_SUP {
+	lm75@48 {
+		compatible = "lm75";
+		reg = <0x48>;
+	};
+	ds1337@68 {
+		compatible = "dallas,ds1337";
+		reg = <0x68>;
+	};
+};
+
+
+&i2c0 {
+	clock-frequency = <400000>;
+	status = "okay";
+	gpio1@74 {
+		compatible = "i2c-pca9539";
+		reg = <0x74>;
+	};
+};
+
+&i2c1 {
+	clock-frequency = <400000>;
+	status = "okay";
+	gpio2@74 {
+		compatible = "i2c-pca9539";
+		reg = <0x74>;
+	};
+	gpio3@20 {
+		compatible = "i2c-pca8575";
+		reg = <0x20>;
+	};
+};
+
+&amba {
+    shm@0 {
+         compatible = "shm_uio";
+         reg = <0x0 0x3ed80000 0x0 0x800000>;
+    };
+
+    ipi@ff340000 {
+         compatible = "ipi_uio";
+         reg = <0x0 0xff340000 0x0 0x1000>;
+         interrupt-parent = <0x2>;
+         interrupts = <0x0 0x1d 0x4>;
+    };
+};
+
+&spi0 {
+    status = "okay";
+    num-cs = <1>;
+    spidev@0 {
+        compatible = "cisco,spi-petra";
+        reg = <0>;
+        spi-max-frequency = <25000000>;
+    };
+};
+
+&spi1 {
+    status = "okay";
+    spidev@1 {
+        compatible = "cisco,spi-petra";
+        reg = <0x0>;
+        spi-max-frequency = <0xf4240>;
+    };
+};
+
+&design_1_i_axi_quad_spi_lc3 {
+    status = "okay";
+    device@0 {
+      compatible = "cisco,spi-petra";
+      reg = <0>;  //Chip select 0
+      spi-max-frequency = <3125000>;
+    };
+};
+
+&gem0 {
+    status = "disabled";
+};
+
+&gem1 {
+    status = "disabled";
+};
+
+&gem2 {
+    status = "disabled";
+};
+
+&gem3 {
+    status = "disabled";
+};
+
+/ {
+	chosen {
+		bootargs = "earlycon console=ttyPS0,9600n8 clk_ignore_unused cpuidle.off=1";
+		stdout-path = "serial0:9600n8";
+	};
+	aliases {
+		ethernet0 = &gem0;
+		ethernet1 = &gem1;
+		ethernet2 = &gem2;
+		ethernet3 = &gem3;
+		serial0 = &uart0;
+		spi0 = &design_1_i_axi_quad_spi_LED;
+		spi1 = &design_1_i_axi_quad_spi_lc3;
+		// spi2 = &qspi;
+		spi3 = &spi0;
+		spi4 = &spi1;
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &design_1_i_axi_iic_LC1;
+		i2c3 = &design_1_i_axi_iic_LC2;
+		i2c4 = &design_1_i_axi_iic_LC3;
+		i2c5 = &design_1_i_axi_iic_PS;
+		i2c6 = &design_1_i_axi_iic_BP;
+		i2c7 = &design_1_i_axi_iic_SUP;
+		i2c8 = &design_1_i_axi_iic_KM_PLT;
+	};
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x80000000>, <0x8 0x0 0x0 0x80000000>;
+	};
+};
-- 
2.17.1

