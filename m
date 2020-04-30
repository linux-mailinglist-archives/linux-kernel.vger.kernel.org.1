Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99FC1C08E2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 23:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgD3VLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 17:11:35 -0400
Received: from foss.arm.com ([217.140.110.172]:33628 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbgD3VLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 17:11:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2AFCE31B;
        Thu, 30 Apr 2020 14:11:12 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.197.25])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 471AA3F68F;
        Thu, 30 Apr 2020 14:11:11 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v3 5/8] dt-bindings: arm: Convert Calxeda L2 cache controller to json-schema
Date:   Thu, 30 Apr 2020 22:10:51 +0100
Message-Id: <20200430211054.30466-6-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200430211054.30466-1-andre.przywara@arm.com>
References: <20200430211054.30466-1-andre.przywara@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the L2-ECC controller binding to DT schema format using
json-schema.
This is indented to be just used for error reporting.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../devicetree/bindings/arm/calxeda/l2ecc.txt | 15 -------
 .../bindings/arm/calxeda/l2ecc.yaml           | 42 +++++++++++++++++++
 2 files changed, 42 insertions(+), 15 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/calxeda/l2ecc.txt
 create mode 100644 Documentation/devicetree/bindings/arm/calxeda/l2ecc.yaml

diff --git a/Documentation/devicetree/bindings/arm/calxeda/l2ecc.txt b/Documentation/devicetree/bindings/arm/calxeda/l2ecc.txt
deleted file mode 100644
index 94e642a33db0..000000000000
--- a/Documentation/devicetree/bindings/arm/calxeda/l2ecc.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-Calxeda Highbank L2 cache ECC
-
-Properties:
-- compatible : Should be "calxeda,hb-sregs-l2-ecc"
-- reg : Address and size for ECC error interrupt clear registers.
-- interrupts : Should be single bit error interrupt, then double bit error
-	interrupt.
-
-Example:
-
-	sregs@fff3c200 {
-		compatible = "calxeda,hb-sregs-l2-ecc";
-		reg = <0xfff3c200 0x100>;
-		interrupts = <0 71 4  0 72 4>;
-	};
diff --git a/Documentation/devicetree/bindings/arm/calxeda/l2ecc.yaml b/Documentation/devicetree/bindings/arm/calxeda/l2ecc.yaml
new file mode 100644
index 000000000000..a9fe01238a88
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/calxeda/l2ecc.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/calxeda/l2ecc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Calxeda Highbank L2 cache ECC
+
+description: |
+  Binding for the Calxeda Highbank L2 cache controller ECC device.
+  This does not cover the actual L2 cache controller control registers,
+  but just the error reporting functionality.
+
+maintainers:
+  - Andre Przywara <andre.przywara@arm.com>
+
+properties:
+  compatible:
+    const: "calxeda,hb-sregs-l2-ecc"
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: single bit error interrupt
+      - description: double bit error interrupt
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    sregs@fff3c200 {
+        compatible = "calxeda,hb-sregs-l2-ecc";
+        reg = <0xfff3c200 0x100>;
+        interrupts = <0 71 4>, <0 72 4>;
+    };
-- 
2.17.1

