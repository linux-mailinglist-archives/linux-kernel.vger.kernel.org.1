Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74253298AA8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 11:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770938AbgJZKqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 06:46:37 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56486 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1770920AbgJZKqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 06:46:35 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 155701A044D;
        Mon, 26 Oct 2020 11:46:33 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id F17151A037D;
        Mon, 26 Oct 2020 11:46:27 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 65BED402B1;
        Mon, 26 Oct 2020 11:46:21 +0100 (CET)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ASoC: dt-bindings: fsl_aud2htx: Add binding doc for aud2htx module
Date:   Mon, 26 Oct 2020 18:40:54 +0800
Message-Id: <1603708855-2663-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AUD2HTX (Audio Subsystem TO HDMI TX Subsystem) is a new
IP module found on i.MX8MP.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 .../bindings/sound/fsl,aud2htx.yaml           | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,aud2htx.yaml

diff --git a/Documentation/devicetree/bindings/sound/fsl,aud2htx.yaml b/Documentation/devicetree/bindings/sound/fsl,aud2htx.yaml
new file mode 100644
index 000000000000..18548d0889a8
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl,aud2htx.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/fsl,aud2htx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP Audio Subsystem to HDMI RTX Subsystem Controller
+
+maintainers:
+  - Shengjiu Wang <shengjiu.wang@nxp.com>
+
+properties:
+  $nodename:
+    pattern: "^aud2htx@.*"
+
+  compatible:
+    const: fsl,imx8mp-aud2htx
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Peripheral clock
+
+  clock-names:
+    items:
+      - const: bus
+
+  dmas:
+    items:
+      - description: DMA controller phandle and request line for TX
+
+  dma-names:
+    items:
+      - const: tx
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - dmas
+  - dma-names
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/imx8mp-clock.h>
+
+    aud2htx: aud2htx@30cb0000 {
+             compatible = "fsl,imx8mp-aud2htx";
+             reg = <0x30cb0000 0x10000>;
+             interrupts = <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>;
+             clocks = <&audiomix_clk IMX8MP_CLK_AUDIOMIX_AUD2HTX_IPG>;
+             clock-names = "bus";
+             dmas = <&sdma2 26 2 0>;
+             dma-names = "tx";
+             power-domains = <&audiomix_pd>;
+    };
-- 
2.27.0

