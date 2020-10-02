Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C631528175D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 18:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388082AbgJBQDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 12:03:20 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:31352 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733260AbgJBQDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 12:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1601654600; x=1633190600;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WnJFaAsuf8XICIieeva6yD00uy3IL/eDLKGXHIhOzJI=;
  b=nGKuyOj5f8Ihi8+tHU/XWy42I2y0MU76JRKUqW51u9P9JpCoOEVe4UzL
   U5TxdHc1STIVmAL8uQAVj9EtbBqHR8VsQxRO7a1wdUWSm4btkqXHfvIHi
   0KkUuaewAsVfNPhRdhJ2ngb16Hl2EGP1jrsezXZOtgezAP/RT28p496YO
   HVTvM1PpeFX6ERDNXsj6i4lViKccZnt9vJ+IWzoEv0A6xzFtlujywWp76
   L2xCe145xuvU+0ZGIcxoA3O2HzTLagrxhqRGLnylLDHj5iHg4QmCJv09E
   uz8MkDQWwTqDbEfKt7sfYe/oyyIjQeH4wNciLglcyIj5oTPy6F3kKA0Jz
   Q==;
IronPort-SDR: Kb3tl5lnhIbvL2vAiAxCiB62r6vNSlu9RZgOmsbUp1v4/cWt1yFdAj2bglNRwEZc18iqqeSLjj
 KjxWxYyXLwnAVJGlJ04bJASA2RC2fOnYW0YZqoDRV3HlQShfUzdxaY0g2Y7ObxItlbgmPmJpkh
 rL/12guPSVqrvlZzNpvu1NY6iLGnoSYojDit0vHPNInqhq6IVsbtLvHuYGu3M/mYiHH2FlT9we
 fGKPbsEo3m/V/q8cyOHQ1skH48K8D2R9bdVhL6iO8mbZzNK/9HvHKFXLC4XG8Opn6UWlPVw5XT
 6Yo=
X-IronPort-AV: E=Sophos;i="5.77,328,1596524400"; 
   d="scan'208";a="93228967"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Oct 2020 09:03:19 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 2 Oct 2020 09:03:19 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 2 Oct 2020 09:02:41 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <perex@perex.cz>, <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        "Codrin Ciubotariu" <codrin.ciubotariu@microchip.com>
Subject: [PATCH 1/2] dt-bindings: sound: add DT bindings for Microchip S/PDIF RX Controller
Date:   Fri, 2 Oct 2020 19:03:04 +0300
Message-ID: <20201002160305.815523-2-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201002160305.815523-1-codrin.ciubotariu@microchip.com>
References: <20201002160305.815523-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds DT bindings for the new Microchip S/PDIF RX Controller
embedded inside sama7g5 SoCs.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 .../bindings/sound/mchp,spdifrx.yaml          | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mchp,spdifrx.yaml

diff --git a/Documentation/devicetree/bindings/sound/mchp,spdifrx.yaml b/Documentation/devicetree/bindings/sound/mchp,spdifrx.yaml
new file mode 100644
index 000000000000..7d8bd4e14434
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mchp,spdifrx.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/mchp,spdifrx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip S/PDIF Rx Controller Device Tree Bindings
+
+maintainers:
+  - Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
+
+description:
+        The Microchip Sony/Philips Digital Interface Receiver is a
+        serial port compliant with the IEC-60958 standard.
+
+properties:
+  "#sound-dai-cells":
+    const: 0
+
+  compatible:
+    const: microchip,sama7g5-spdifrx
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Peripheral Bus Clock
+      - description: Generic Clock
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: gclk
+
+  dmas:
+    description: RX DMA Channel
+    maxItems: 1
+
+  dma-names:
+    const: rx
+
+required:
+  - "#sound-dai-cells"
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - dmas
+  - dma-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/at91.h>
+    #include <dt-bindings/dma/at91.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    spdifrx: spdifrx@e1614000 {
+        #sound-dai-cells = <0>;
+        compatible = "microchip,sama7g5-spdifrx";
+        reg = <0xe1614000 0x4000>;
+        interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+        dmas = <&dma0 AT91_XDMAC_DT_PERID(49)>;
+        dma-names = "rx";
+        clocks = <&pmc PMC_TYPE_PERIPHERAL 84>, <&pmc PMC_TYPE_GCK 84>;
+        clock-names = "pclk", "gclk";
+    };
-- 
2.25.1

