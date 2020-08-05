Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3280F23C3A5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 04:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgHECsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 22:48:18 -0400
Received: from inva021.nxp.com ([92.121.34.21]:39602 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727109AbgHECsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 22:48:16 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6B1C920139E;
        Wed,  5 Aug 2020 04:48:14 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BEE05201398;
        Wed,  5 Aug 2020 04:48:08 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id E3A2740302;
        Wed,  5 Aug 2020 04:48:01 +0200 (CEST)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, marex@denx.de,
        s.trumtrar@pengutronix.de, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 3/3] dt-bindings: crypto: Convert i.MX sahara to json-schema
Date:   Wed,  5 Aug 2020 10:43:30 +0800
Message-Id: <1596595410-26921-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596595410-26921-1-git-send-email-Anson.Huang@nxp.com>
References: <1596595410-26921-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the i.MX sahara binding to DT schema format using json-schema.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 .../devicetree/bindings/crypto/fsl-imx-sahara.txt  | 15 ----------
 .../devicetree/bindings/crypto/fsl-imx-sahara.yaml | 35 ++++++++++++++++++++++
 2 files changed, 35 insertions(+), 15 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/crypto/fsl-imx-sahara.txt
 create mode 100644 Documentation/devicetree/bindings/crypto/fsl-imx-sahara.yaml

diff --git a/Documentation/devicetree/bindings/crypto/fsl-imx-sahara.txt b/Documentation/devicetree/bindings/crypto/fsl-imx-sahara.txt
deleted file mode 100644
index db690b1..0000000
--- a/Documentation/devicetree/bindings/crypto/fsl-imx-sahara.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-Freescale SAHARA Cryptographic Accelerator included in some i.MX chips.
-Currently only i.MX27 and i.MX53 are supported.
-
-Required properties:
-- compatible : Should be "fsl,<soc>-sahara"
-- reg : Should contain SAHARA registers location and length
-- interrupts : Should contain SAHARA interrupt number
-
-Example:
-
-sah: crypto@10025000 {
-	compatible = "fsl,imx27-sahara";
-	reg = <	0x10025000 0x800>;
-	interrupts = <75>;
-};
diff --git a/Documentation/devicetree/bindings/crypto/fsl-imx-sahara.yaml b/Documentation/devicetree/bindings/crypto/fsl-imx-sahara.yaml
new file mode 100644
index 0000000..3cabc6b
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/fsl-imx-sahara.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/crypto/fsl-imx-sahara.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale SAHARA Cryptographic Accelerator included in some i.MX chips
+
+maintainers:
+  - Steffen Trumtrar <s.trumtrar@pengutronix.de>
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx27-sahara
+      - fsl,imx53-sahara
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+examples:
+  - |
+    crypto@10025000 {
+        compatible = "fsl,imx27-sahara";
+        reg = < 0x10025000 0x800>;
+        interrupts = <75>;
+    };
-- 
2.7.4

