Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712832E95BD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 14:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbhADNTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 08:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbhADNTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 08:19:07 -0500
Received: from yawp.biot.com (yawp.biot.com [IPv6:2a01:4f8:10a:8e::fce2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AD1C061793
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 05:18:26 -0800 (PST)
Received: from debian-spamd by yawp.biot.com with sa-checked (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1kwPke-00BbtW-Vx
        for linux-kernel@vger.kernel.org; Mon, 04 Jan 2021 14:18:25 +0100
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on yawp
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.4
Received: from [2a02:578:460c:1:ae1f:6bff:fed1:9ca8] (helo=sumner.biot.com)
        by yawp.biot.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1kwPkK-00Bbqj-VE; Mon, 04 Jan 2021 14:18:05 +0100
Received: from bert by sumner.biot.com with local (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1kwPkK-00CV2j-AB; Mon, 04 Jan 2021 14:18:04 +0100
From:   Bert Vermeulen <bert@biot.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Birger Koblitz <mail@birger-koblitz.de>,
        John Crispin <john@phrozen.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Bert Vermeulen <bert@biot.com>
Subject: [PATCH v2 1/2] dt-bindings: interrupt-controller: Add Realtek RTL838x/RTL839x support
Date:   Mon,  4 Jan 2021 14:17:54 +0100
Message-Id: <20210104131755.2979203-2-bert@biot.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210104131755.2979203-1-bert@biot.com>
References: <20210104131755.2979203-1-bert@biot.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bert Vermeulen <bert@biot.com>
---
 .../realtek,rtl-intc.yaml                     | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml
new file mode 100644
index 000000000000..e9b18a65cafb
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/realtek,rtl-intc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek RTL SoC interrupt controller devicetree bindings
+
+maintainers:
+  - Birger Koblitz <mail@birger-koblitz.de>
+  - Bert Vermeulen <bert@biot.com>
+  - John Crispin <john@phrozen.org>
+
+properties:
+  compatible:
+    const: realtek,rtl-intc
+
+  "#interrupt-cells":
+    const: 1
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#address-cells":
+    const: 0
+
+  interrupt-map:
+    maxItems: 24
+    description: Describes mapping from SoC interrupts to CPU interrupts
+
+required:
+  - compatible
+  - reg
+  - "#interrupt-cells"
+  - interrupt-controller
+  - "#address-cells"
+  - interrupt-map
+
+additionalProperties: false
+
+examples:
+  - |
+    intc: interrupt-controller@3000 {
+      compatible = "realtek,rtl-intc";
+      #interrupt-cells = <1>;
+      interrupt-controller;
+      reg = <0x3000 0x20>;
+      #address-cells = <0>;
+      interrupt-map =
+              <31 &cpuintc 2>,
+              <30 &cpuintc 1>;
+    }
-- 
2.25.1

