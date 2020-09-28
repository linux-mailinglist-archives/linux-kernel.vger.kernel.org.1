Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220A427AD19
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 13:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgI1Lo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 07:44:58 -0400
Received: from foss.arm.com ([217.140.110.172]:50024 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726625AbgI1Lo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 07:44:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A387231B;
        Mon, 28 Sep 2020 04:44:56 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1F0D23F6CF;
        Mon, 28 Sep 2020 04:44:55 -0700 (PDT)
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
Subject: [PATCH 2/4] dt-bindings: mailbox: add doorbell support to ARM MHU
Date:   Mon, 28 Sep 2020 12:44:43 +0100
Message-Id: <20200928114445.19689-3-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200928114445.19689-1-sudeep.holla@arm.com>
References: <20200928114445.19689-1-sudeep.holla@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARM MHU's reference manual states following:

"The MHU drives the signal using a 32-bit register, with all 32 bits
logically ORed together. The MHU provides a set of registers to enable
software to set, clear, and check the status of each of the bits of this
register independently.  The use of 32 bits for each interrupt line
enables software to provide more information about the source of the
interrupt. For example, each bit of the register can be associated with
a type of event that can contribute to raising the interrupt."

This patch thus extends the MHU controller's DT binding to add support
for doorbell mode.

Though the same MHU hardware controller is used in the two modes, A new
compatible string is added here to represent the combination of the MHU
hardware and the firmware sitting on the other side (which expects each
bit to represent a different signal now).

Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Co-developed-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 .../devicetree/bindings/mailbox/arm,mhu.yaml  | 60 +++++++++++++++++--
 1 file changed, 54 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml b/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
index 2c8df7979c22..d43791a2dde7 100644
--- a/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
+++ b/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
@@ -18,20 +18,40 @@ description: |
   remote clears it after having read the data.  The last channel is specified to
   be a 'Secure' resource, hence can't be used by Linux running NS.
 
+  The MHU hardware also allows operations in doorbell mode. The MHU drives the
+  interrupt signal using a 32-bit register, with all 32-bits logically ORed
+  together. It provides a set of registers to enable software to set, clear and
+  check the status of each of the bits of this register independently. The use
+  of 32 bits per interrupt line enables software to provide more information
+  about the source of the interrupt. For example, each bit of the register can
+  be associated with a type of event that can contribute to raising the
+  interrupt. Each of the 32-bits can be used as "doorbell" to alert the remote
+  processor.
+
 # We need a select here so we don't match all nodes with 'arm,primecell'
 select:
   properties:
     compatible:
       contains:
-        const: arm,mhu
+        enum:
+          - arm,mhu
+          - arm,mhu-doorbell
   required:
     - compatible
 
 properties:
   compatible:
-    items:
-      - const: arm,mhu
-      - const: arm,primecell
+    oneOf:
+      - description: Data transfer mode
+        items:
+          - const: arm,mhu
+          - const: arm,primecell
+
+      - description: Doorbell mode
+        items:
+          - const: arm,mhu-doorbell
+          - const: arm,primecell
+
 
   reg:
     maxItems: 1
@@ -51,8 +71,11 @@ description: |
       - const: apb_pclk
 
   '#mbox-cells':
-    description: Index of the channel.
-    const: 1
+    description: |
+      Set to 1 in data transfer mode and represents index of the channel.
+      Set to 2 in doorbell mode and represents index of the channel and doorbell
+      number.
+    enum: [ 1, 2 ]
 
 required:
   - compatible
@@ -63,6 +86,7 @@ description: |
 additionalProperties: false
 
 examples:
+  # Data transfer mode.
   - |
     soc {
         #address-cells = <2>;
@@ -85,3 +109,27 @@ additionalProperties: false
             mboxes = <&mhuA 1>; /* HP-NonSecure */
         };
     };
+
+  # Doorbell mode.
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        mhuB: mailbox@2b2f0000 {
+            #mbox-cells = <2>;
+            compatible = "arm,mhu-doorbell", "arm,primecell";
+            reg = <0 0x2b2f0000 0 0x1000>;
+            interrupts = <0 36 4>, /* LP-NonSecure */
+                         <0 35 4>, /* HP-NonSecure */
+                         <0 37 4>; /* Secure */
+            clocks = <&clock 0 2 1>;
+            clock-names = "apb_pclk";
+        };
+
+        mhu_client_scpi: scpi@2f000000 {
+            compatible = "arm,scpi";
+            reg = <0 0x2f000000 0 0x200>;
+            mboxes = <&mhuB 1 4>; /* HP-NonSecure, 5th doorbell */
+        };
+    };
-- 
2.17.1

