Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC4801D7BFD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 16:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgERO5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 10:57:33 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56358 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728115AbgERO5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 10:57:30 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DF4281A0B13;
        Mon, 18 May 2020 16:57:28 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6D0791A097E;
        Mon, 18 May 2020 16:57:23 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 138D6402B3;
        Mon, 18 May 2020 22:57:17 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, ping.bai@nxp.com, aisheng.dong@nxp.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 3/3] dt-bindings: timer: Convert i.MX SYSCTR to json-schema
Date:   Mon, 18 May 2020 22:47:40 +0800
Message-Id: <1589813260-20036-4-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589813260-20036-1-git-send-email-Anson.Huang@nxp.com>
References: <1589813260-20036-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the i.MX SYSCTR binding to DT schema format using json-schema.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 .../devicetree/bindings/timer/nxp,sysctr-timer.txt | 25 ----------
 .../bindings/timer/nxp,sysctr-timer.yaml           | 54 ++++++++++++++++++++++
 2 files changed, 54 insertions(+), 25 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/nxp,sysctr-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.txt b/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.txt
deleted file mode 100644
index d576599..0000000
--- a/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-NXP System Counter Module(sys_ctr)
-
-The system counter(sys_ctr) is a programmable system counter which provides
-a shared time base to Cortex A15, A7, A53, A73, etc. it is intended for use in
-applications where the counter is always powered and support multiple,
-unrelated clocks. The compare frame inside can be used for timer purpose.
-
-Required properties:
-
-- compatible :      should be "nxp,sysctr-timer"
-- reg :             Specifies the base physical address and size of the comapre
-                    frame and the counter control, read & compare.
-- interrupts :      should be the first compare frames' interrupt
-- clocks : 	    Specifies the counter clock.
-- clock-names: 	    Specifies the clock's name of this module
-
-Example:
-
-	system_counter: timer@306a0000 {
-		compatible = "nxp,sysctr-timer";
-		reg = <0x306a0000 0x20000>;/* system-counter-rd & compare */
-		clocks = <&clk_8m>;
-		clock-names = "per";
-		interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
-	};
diff --git a/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml b/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml
new file mode 100644
index 0000000..830211c
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/nxp,sysctr-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP System Counter Module(sys_ctr)
+
+maintainers:
+  - Bai Ping <ping.bai@nxp.com>
+
+description: |
+  The system counter(sys_ctr) is a programmable system counter
+  which provides a shared time base to Cortex A15, A7, A53, A73,
+  etc. it is intended for use in applications where the counter
+  is always powered and support multiple, unrelated clocks. The
+  compare frame inside can be used for timer purpose.
+
+properties:
+  compatible:
+    const: nxp,sysctr-timer
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: per
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    timer@306a0000 {
+        compatible = "nxp,sysctr-timer";
+        reg = <0x306a0000 0x20000>;
+        clocks = <&clk_8m>;
+        clock-names = "per";
+        interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+     };
-- 
2.7.4

