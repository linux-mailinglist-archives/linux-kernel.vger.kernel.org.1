Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2381126FBB3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 13:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgIRLkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 07:40:32 -0400
Received: from smtp2.axis.com ([195.60.68.18]:42506 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbgIRLkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 07:40:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=2871; q=dns/txt; s=axis-central1;
  t=1600429230; x=1631965230;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nf9xyKjOJLYLLbRB2/HBWzS8DPHd3qUqka4CHMmC6qo=;
  b=Wt6XPdfycJ7vMjy8x1/G2X8fi9ZyreP2xIWDwteh580/eTo2qVQ3YYO4
   pxx3oCKYaj0aM4berUo0LPtjhzEhR/spuXBWemALl22dHepHKnbyuOliX
   IWubtbUUXU1Fw4LHzMYYJrzeBzn5FpYT9f/UhlMola90fvdSYuv3sAFRo
   1d6oEMFbUa+Lhr0zAd2FF+iVrbmAsun+Lvjk4gsCKinjnSbbRM+xQfZRx
   baK0MfJJQ2JitTK1C2Dgg9cFAk0FcjBH9n7d3/Vmy62Lxq2O7gTuTJOxP
   eNDYFD0ErC/OaIOlmUp4Va0IOiSMc7GgOl3eQdWvTEjbC+rIPW3d3RvZQ
   g==;
IronPort-SDR: MeyJ+ipT9q80W1KxznfMpqfE4aU7/yQs4lPs05Y8+BohAR/d1+bypJN+EFkzhVi983AtROHYn3
 ym2J9g1K7jb7RiyEiWv2AFz6CT2cr7UMwvuqFW2nI7POTFlt7WidD+GBobSLbfUM+QnFfrtQBT
 Lbp7AD5Y2+iu9873B8TEGalLKd4h5EMo0qLDNkn4HDHF3PPVh3G4VUWbvWbOJD8BTsgFqckxQ7
 sGWCqfgQqZ1zMVP/O9fms0Z2auo9axhc73YzkDFHi8pNqIvtgnJUXO/4iDAQc9lWZPNKIavsF2
 Pmo=
X-IronPort-AV: E=Sophos;i="5.77,274,1596492000"; 
   d="scan'208";a="12637619"
From:   Camel Guo <camel.guo@axis.com>
To:     <robh+dt@kernel.org>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <tiwai@suse.com>, <dmurphy@ti.com>
CC:     <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <kernel@axis.com>,
        Camel Guo <camelg@axis.com>
Subject: [PATCH v5 1/2] dt-bindings: tlv320adcx140: Add GPIO config and drive config
Date:   Fri, 18 Sep 2020 13:40:24 +0200
Message-ID: <20200918114025.18205-1-camel.guo@axis.com>
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

