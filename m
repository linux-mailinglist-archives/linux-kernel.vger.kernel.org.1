Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B62A218F33
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 19:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgGHRu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 13:50:58 -0400
Received: from mga05.intel.com ([192.55.52.43]:31336 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbgGHRu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:50:57 -0400
IronPort-SDR: pOr1ab1oPu2rxiI7OswnYmBHVCtM4Gq34Td1fJzWo9PU0WrZp0Wo3d0dDV1yjG8anrS/fhzsEU
 KnukIHzFYYjA==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="232753567"
X-IronPort-AV: E=Sophos;i="5.75,328,1589266800"; 
   d="scan'208";a="232753567"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 10:50:57 -0700
IronPort-SDR: hQqu/5M6q4nS/e14LAVyoT9Jl2/HL/XMHI5+al7gkntaeU8cIWSarqjxPsXnj+BSFkjrLKHFf5
 ZfxZ72M8rZjA==
X-IronPort-AV: E=Sophos;i="5.75,328,1589266800"; 
   d="scan'208";a="457591975"
Received: from sgyanama-mobl1.gar.corp.intel.com (HELO dalessan-mobl1.ir.intel.com) ([10.252.5.67])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 10:50:53 -0700
From:   Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
To:     linux-arm-kernel@lists.infradead.org, SoC Team <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     devicetree@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>,
        Paul Murphy <paul.j.murphy@intel.com>,
        Will Deacon <will@kernel.org>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>
Subject: [PATCH v2 4/5] arm64: dts: keembay: Add device tree for Keem Bay SoC
Date:   Wed,  8 Jul 2020 18:50:19 +0100
Message-Id: <20200708175020.194436-5-daniele.alessandrelli@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200708175020.194436-1-daniele.alessandrelli@linux.intel.com>
References: <20200708175020.194436-1-daniele.alessandrelli@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>

Add initial device tree for Intel Movidius SoC code-named Keem Bay.

This initial DT includes nodes for Cortex-A53 cores, UARTs, GIC, PSCI,
and PMU.

Reviewed-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
---
 MAINTAINERS                                |   1 +
 arch/arm64/boot/dts/intel/keembay-soc.dtsi | 125 +++++++++++++++++++++
 2 files changed, 126 insertions(+)
 create mode 100644 arch/arm64/boot/dts/intel/keembay-soc.dtsi

diff --git a/MAINTAINERS b/MAINTAINERS
index ceb833fa04dd..53d2f8d0976a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1959,6 +1959,7 @@ M:	Paul J. Murphy <paul.j.murphy@intel.com>
 M:	Daniele Alessandrelli <daniele.alessandrelli@intel.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/keembay.yaml
+F:	arch/arm64/boot/dts/intel/keembay-soc.dtsi
 F:	include/dt-bindings/clock/keembay-clocks.h
 F:	include/dt-bindings/power/keembay-power.h
 
diff --git a/arch/arm64/boot/dts/intel/keembay-soc.dtsi b/arch/arm64/boot/dts/intel/keembay-soc.dtsi
new file mode 100644
index 000000000000..4aaf543f3ad1
--- /dev/null
+++ b/arch/arm64/boot/dts/intel/keembay-soc.dtsi
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020, Intel Corporation.
+ *
+ * Device tree describing Keem Bay SoC.
+ */
+
+#include <dt-bindings/clock/keembay-clocks.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/power/keembay-power.h>
+
+/ {
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			reg = <0x0>;
+			enable-method = "psci";
+		};
+
+		cpu@1 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			reg = <0x1>;
+			enable-method = "psci";
+		};
+
+		cpu@2 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			reg = <0x2>;
+			enable-method = "psci";
+		};
+
+		cpu@3 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			reg = <0x3>;
+			enable-method = "psci";
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	gic: interrupt-controller@20500000 {
+		compatible = "arm,gic-v3";
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		reg = <0x0 0x20500000 0x0 0x20000>,	/* GICD */
+		      <0x0 0x20580000 0x0 0x80000>;	/* GICR */
+		/* VGIC maintenance interrupt */
+		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		/* Secure, non-secure, virtual, and hypervisor */
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <GIC_PPI 0x7 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		uart0: serial@20150000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x20150000 0x0 0x100>;
+			interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+			clock-frequency = <24000000>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart1: serial@20160000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x20160000 0x0 0x100>;
+			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
+			clock-frequency = <24000000>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart2: serial@20170000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x20170000 0x0 0x100>;
+			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
+			clock-frequency = <24000000>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart3: serial@20180000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x20180000 0x0 0x100>;
+			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+			clock-frequency = <24000000>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+	};
+};
-- 
2.26.2

