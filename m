Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0C026FB71
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 13:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgIRL2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 07:28:22 -0400
Received: from smtp2.axis.com ([195.60.68.18]:1583 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbgIRL1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 07:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=2871; q=dns/txt; s=axis-central1;
  t=1600428460; x=1631964460;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nf9xyKjOJLYLLbRB2/HBWzS8DPHd3qUqka4CHMmC6qo=;
  b=YoYdWeeafpZNDZBdbEPlGCyw9DYkj1qmpiwAE3UOEH8LJ0hbne8wqL1+
   0qod3rbQdRqU0CSIUtNnOg/CrOsXkUejhs8oHUj91Wf1Ej8SNoF808zd/
   RxRxo3ZihFblkPZAyBFCI7a5eD5B7Euy4ksM8FXdECEhmktYDDWvBMF4/
   yPHfVcaTMQwCrdihPJfA9dveRXuAoI4Xu+txcakBfLovUyhR2SecSMJsa
   nXKBZyLQa39Oa9dZ5rzGlwfSeQyt00WDGx5dEdsE5MMZbHzDYx4a+vYyA
   Bt08YO5DJom2fMxV9mbh8dgCKL5toeMtx60RQL3iJ1PG/vQZZ1elyqpoQ
   A==;
IronPort-SDR: Wm68cUyutQ/yZufGg2RwvdgbyWG4H6Us9tO92e0nTRFhcL5G7fU2xmjltFz4EL6lutkaTb21Mx
 akPkFIUJ/kazqwkvHURjIqsrnL/0XAxDhDhahUzXf6ARYEw/DLK1faCn1aBQsvduNODlhk0/fv
 R2fTtMY4d4AYk2nymM6/apcdM3weTefCZm9YfEUuOQ0UB9cEcH0tR9wdyjLgBWi+5xb0tfkW3g
 2uMIDBAGbqx7i++lzvnX0nveQUcLUDaAWWiZZUxRH/AT8Y7oBRS2Nc+DNkbXUvs/FFnSOjGXHV
 9t4=
X-IronPort-AV: E=Sophos;i="5.77,274,1596492000"; 
   d="scan'208";a="12636759"
From:   Camel Guo <camel.guo@axis.com>
To:     <robh+dt@kernel.org>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <tiwai@suse.com>, <dmurphy@ti.com>
CC:     <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <kernel@axis.com>,
        Camel Guo <camelg@axis.com>
Subject: [PATCH v4 1/2] dt-bindings: tlv320adcx140: Add GPIO config and drive config
Date:   Fri, 18 Sep 2020 13:26:21 +0200
Message-ID: <20200918112622.17262-1-camel.guo@axis.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Camel Guo <camelg@axis.com>

Add properties for configuring the General Purpose Input Output (GPIO).
There are 2 settings for GPIO, configuration and the output drive type.

Signed-off-by: Camel Guo <camelg@axis.com>
Acked-by: Dan Murphy <dmurphy@ti.com>
---
 v4:
  - Rebase
 v3: 
  - Fix typo
  - Add Acked-By from Dan 

 .../bindings/sound/tlv320adcx140.yaml         | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml b/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
index e79f8d1891e4..798b366fe6d1 100644
--- a/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
+++ b/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
@@ -140,6 +140,49 @@ patternProperties:
        4d - Drive weak low and active high
        5d - Drive Hi-Z and active high
 
+  ti,gpio-config:
+    description: |
+       Defines the configuration and output drive for the General Purpose
+       Input and Output pin (GPIO1). Its value is a pair, the first value is for
+       the configuration type and the second value is for the output drive
+       type. The array is defined as <GPIO1_CFG GPIO1_DRV>
+
+       configuration for the GPIO pin can be one of the following:
+       0 - disabled
+       1 - GPIO1 is configured as a general-purpose output (GPO)
+       2 - (default) GPIO1 is configured as a device interrupt output (IRQ)
+       3 - GPIO1 is configured as a secondary ASI output (SDOUT2)
+       4 - GPIO1 is configured as a PDM clock output (PDMCLK)
+       8 - GPIO1 is configured as an input to control when MICBIAS turns on or
+           off (MICBIAS_EN)
+       9 - GPIO1 is configured as a general-purpose input (GPI)
+       10 - GPIO1 is configured as a master clock input (MCLK)
+       11 - GPIO1 is configured as an ASI input for daisy-chain (SDIN)
+       12 - GPIO1 is configured as a PDM data input for channel 1 and channel 2
+            (PDMDIN1)
+       13 - GPIO1 is configured as a PDM data input for channel 3 and channel 4
+            (PDMDIN2)
+       14 - GPIO1 is configured as a PDM data input for channel 5 and channel 6
+            (PDMDIN3)
+       15 - GPIO1 is configured as a PDM data input for channel 7 and channel 8
+            (PDMDIN4)
+
+       output drive type for the GPIO pin can be one of the following:
+       0 - Hi-Z output
+       1 - Drive active low and active high
+       2 - (default) Drive active low and weak high
+       3 - Drive active low and Hi-Z
+       4 - Drive weak low and active high
+       5 - Drive Hi-Z and active high
+
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32-array
+      - minItems: 2
+        maxItems: 2
+        items:
+          maximum: 15
+        default: [2, 2]
+
 required:
   - compatible
   - reg
@@ -156,6 +199,7 @@ examples:
         ti,mic-bias-source = <6>;
         ti,pdm-edge-select = <0 1 0 1>;
         ti,gpi-config = <4 5 6 7>;
+        ti,gpio-config = <10 2>;
         ti,gpo-config-1 = <0 0>;
         ti,gpo-config-2 = <0 0>;
         reset-gpios = <&gpio0 14 GPIO_ACTIVE_HIGH>;
-- 
2.20.1

