Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10372E7692
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 07:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgL3GaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 01:30:08 -0500
Received: from mga02.intel.com ([134.134.136.20]:62430 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbgL3GaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 01:30:08 -0500
IronPort-SDR: +d9TB9gW/SXKEwJvEExeCIIPycEuDH702tyXK+OSoa7hEmUNOAMqghcTR3S0OhwOj9m+ocVi4p
 HFxZ9bOA7J+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9849"; a="163637643"
X-IronPort-AV: E=Sophos;i="5.78,460,1599548400"; 
   d="scan'208";a="163637643"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2020 22:29:27 -0800
IronPort-SDR: 41hX2GBKvAd2kTueRKZ8T8qF2sQTHw533KCDk5XyNhtU9+f7+5dWdDZIcFpVloG0z+NMvoBdbA
 n8ru8FDJSrjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,460,1599548400"; 
   d="scan'208";a="460372466"
Received: from ubuntu18.png.intel.com ([10.88.229.38])
  by fmsmga001.fm.intel.com with ESMTP; 29 Dec 2020 22:29:24 -0800
From:   vijayakannan.ayyathurai@intel.com
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        lakshmi.bai.raja.subramanian@intel.com, chen.yong.seow@intel.com,
        vijayakannan.ayyathurai@intel.com
Subject: [PATCH v2 1/2] dt-bindings: timer: Add bindings for Intel Keem Bay SoC timer
Date:   Wed, 30 Dec 2020 14:25:26 +0800
Message-Id: <907e6379ae5fc8f5decdb344485123425de7afc1.1609306622.git.vijayakannan.ayyathurai@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1609306622.git.vijayakannan.ayyathurai@intel.com>
References: <cover.1609306622.git.vijayakannan.ayyathurai@intel.com>
In-Reply-To: <cover.1609306622.git.vijayakannan.ayyathurai@intel.com>
References: <cover.1609306622.git.vijayakannan.ayyathurai@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>

Add Device Tree bindings for the Timer IP, which used as clocksource and
clockevent device in the Intel Keem Bay SoC.

Acked-by: Mark Gross <mgross@linux.intel.com>
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>
---
 .../bindings/timer/intel,keembay-timer.yaml   | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml b/Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
new file mode 100644
index 000000000000..197493336ac2
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/intel,keembay-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Intel Keem Bay SoC Timers
+
+maintainers:
+  - Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
+  - Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>
+
+description:
+  Intel Keem Bay SoC Timers block contains 8 32-bit general purpose timers,
+  a free running 64-bit counter, a random number generator and a watchdog
+  timer. Each gpt can generate an individual interrupt.
+
+properties:
+  compatible:
+    enum:
+      - intel,keembay-timer
+
+  reg:
+    maxItems: 3
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #define KEEM_BAY_A53_TIM
+
+    timer@20330010 {
+        compatible = "intel,keembay-timer";
+        reg = <0x20330010 0xc>,
+              <0x203300e8 0xc>,
+              <0x20331000 0xc>;
+        clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
+        interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+    };
-- 
2.17.1

