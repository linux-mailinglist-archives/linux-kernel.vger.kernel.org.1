Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEBE27AD1A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 13:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgI1Lo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 07:44:59 -0400
Received: from foss.arm.com ([217.140.110.172]:50010 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbgI1Loz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 07:44:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEA14113E;
        Mon, 28 Sep 2020 04:44:54 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 59EF43F6CF;
        Mon, 28 Sep 2020 04:44:53 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        ALKML <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh@kernel.org>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 1/4] dt-bindings: mailbox : arm,mhu: Convert to Json-schema
Date:   Mon, 28 Sep 2020 12:44:42 +0100
Message-Id: <20200928114445.19689-2-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200928114445.19689-1-sudeep.holla@arm.com>
References: <20200928114445.19689-1-sudeep.holla@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viresh Kumar <viresh.kumar@linaro.org>

Convert the DT binding over to Json-schema.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 .../devicetree/bindings/mailbox/arm,mhu.yaml  | 87 +++++++++++++++++++
 .../devicetree/bindings/mailbox/arm-mhu.txt   | 43 ---------
 2 files changed, 87 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
 delete mode 100644 Documentation/devicetree/bindings/mailbox/arm-mhu.txt

diff --git a/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml b/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
new file mode 100644
index 000000000000..2c8df7979c22
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/arm,mhu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM MHU Mailbox Controller
+
+maintainers:
+  - Jassi Brar <jaswinder.singh@linaro.org>
+
+description: |
+  The ARM's Message-Handling-Unit (MHU) is a mailbox controller that has 3
+  independent channels/links to communicate with remote processor(s).  MHU links
+  are hardwired on a platform. A link raises interrupt for any received data.
+  However, there is no specified way of knowing if the sent data has been read
+  by the remote. This driver assumes the sender polls STAT register and the
+  remote clears it after having read the data.  The last channel is specified to
+  be a 'Secure' resource, hence can't be used by Linux running NS.
+
+# We need a select here so we don't match all nodes with 'arm,primecell'
+select:
+  properties:
+    compatible:
+      contains:
+        const: arm,mhu
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - const: arm,mhu
+      - const: arm,primecell
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: low-priority non-secure
+      - description: high-priority non-secure
+      - description: Secure
+    maxItems: 3
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: apb_pclk
+
+  '#mbox-cells':
+    description: Index of the channel.
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - '#mbox-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        mhuA: mailbox@2b1f0000 {
+            #mbox-cells = <1>;
+            compatible = "arm,mhu", "arm,primecell";
+            reg = <0 0x2b1f0000 0 0x1000>;
+            interrupts = <0 36 4>, /* LP-NonSecure */
+                         <0 35 4>, /* HP-NonSecure */
+                         <0 37 4>; /* Secure */
+            clocks = <&clock 0 2 1>;
+            clock-names = "apb_pclk";
+        };
+
+        mhu_client_scb: scb@2e000000 {
+            compatible = "fujitsu,mb86s70-scb-1.0";
+            reg = <0 0x2e000000 0 0x4000>;
+            mboxes = <&mhuA 1>; /* HP-NonSecure */
+        };
+    };
diff --git a/Documentation/devicetree/bindings/mailbox/arm-mhu.txt b/Documentation/devicetree/bindings/mailbox/arm-mhu.txt
deleted file mode 100644
index 4971f03f0b33..000000000000
--- a/Documentation/devicetree/bindings/mailbox/arm-mhu.txt
+++ /dev/null
@@ -1,43 +0,0 @@
-ARM MHU Mailbox Driver
-======================
-
-The ARM's Message-Handling-Unit (MHU) is a mailbox controller that has
-3 independent channels/links to communicate with remote processor(s).
- MHU links are hardwired on a platform. A link raises interrupt for any
-received data. However, there is no specified way of knowing if the sent
-data has been read by the remote. This driver assumes the sender polls
-STAT register and the remote clears it after having read the data.
-The last channel is specified to be a 'Secure' resource, hence can't be
-used by Linux running NS.
-
-Mailbox Device Node:
-====================
-
-Required properties:
---------------------
-- compatible:		Shall be "arm,mhu" & "arm,primecell"
-- reg:			Contains the mailbox register address range (base
-			address and length)
-- #mbox-cells		Shall be 1 - the index of the channel needed.
-- interrupts:		Contains the interrupt information corresponding to
-			each of the 3 links of MHU.
-
-Example:
---------
-
-	mhu: mailbox@2b1f0000 {
-		#mbox-cells = <1>;
-		compatible = "arm,mhu", "arm,primecell";
-		reg = <0 0x2b1f0000 0x1000>;
-		interrupts = <0 36 4>, /* LP-NonSecure */
-			     <0 35 4>, /* HP-NonSecure */
-			     <0 37 4>; /* Secure */
-		clocks = <&clock 0 2 1>;
-		clock-names = "apb_pclk";
-	};
-
-	mhu_client: scb@2e000000 {
-		compatible = "fujitsu,mb86s70-scb-1.0";
-		reg = <0 0x2e000000 0x4000>;
-		mboxes = <&mhu 1>; /* HP-NonSecure */
-	};
-- 
2.17.1

