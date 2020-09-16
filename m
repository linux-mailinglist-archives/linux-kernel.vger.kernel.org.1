Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5979A26BEAA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 10:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgIPIAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 04:00:00 -0400
Received: from smtp1.axis.com ([195.60.68.17]:44530 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbgIPH7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 03:59:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=2854; q=dns/txt; s=axis-central1;
  t=1600243193; x=1631779193;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DwvnYeml1NZSY3bghbQPce2z0t9CsHFsugNSM39PW9I=;
  b=fLUof9C3iiarE2CceR84CumBsW1Kv/QYR1T2tpIAu5MtvZZqmDrHvHEK
   J8jFfRnKoekAjOXHEtlYZXiMZxWrHdyu0kgeZAP2HqZII3/FGhFliimbs
   38XTw9+PpcnXF4aq0ojrWQ95zB3F/+uxh2bkjBAZ7hSEElKkWsBmPYaa7
   vzhQ8RSD0d0LBOtgI+mgi1Up/18gZSkAEcWaWASfnSPfYJxcxaYI0FGYZ
   M9T0Pg53HxtoZIGm359E8CIqDqha++XbeV+pfYG5Zg/zfWDwvKHYSNrOo
   sgqP64sWwL/iIgC3PY91KWZIzoi4J6C9nVeMkN/bpGGzp3RF1++TqLx5g
   g==;
IronPort-SDR: oYhP3a+9occXN2PMZqrwGFo5xF4w8PXuORVMqOFcvcsCy/YtH23kCwNKccqqppkHgtCGWM9oKc
 tQhmmtfX06z1LND7ynH09RwHjRUCgzCxxvRgAJk+eUe1nHi5XvpFRE7i60N2tnjHlHfGS2SKhs
 FTHDiGmYvQWsi2wlOgFvBFspyWSYHtgcqdjIa504vkyDc3Pf1ISuD4JnjtEyy+TfD/FEtSrjEj
 qjsLlnYJJlHZJ2Qsd8dnYm1BnySI4n/T+T2frGwZr3/pvR+4TEbQWn5JriiEWkboeDqRV3SrXh
 fLs=
X-IronPort-AV: E=Sophos;i="5.76,432,1592863200"; 
   d="scan'208";a="12999944"
From:   Camel Guo <camel.guo@axis.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <tiwai@suse.com>,
        <dmurphy@ti.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Camel Guo <camelg@axis.com>
Subject: [PATCH v3 1/2] dt-bindings: tlv320adcx140: Add GPIO config and drive config
Date:   Wed, 16 Sep 2020 09:59:48 +0200
Message-ID: <20200916075949.28479-1-camel.guo@axis.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Camel Guo <camelg@axis.com>

Add properties for configuring the General Purpose Input Output (GPIO).
There are 2 settings for GPIO, configuration and the output drive type.

Signed-off-by: Camel Guo <camelg@axis.com>
Acked-by: Dan Murphy <dmurphy@ti.com>
---
 v3:
  - Fix typo
  - Add Acked-By from Dan

 .../bindings/sound/tlv320adcx140.yaml         | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml b/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
index f578f17f3e04..2f95ccde4dc3 100644
--- a/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
+++ b/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
@@ -134,6 +134,49 @@ patternProperties:
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
@@ -150,6 +193,7 @@ examples:
         ti,mic-bias-source = <6>;
         ti,pdm-edge-select = <0 1 0 1>;
         ti,gpi-config = <4 5 6 7>;
+        ti,gpio-config = <10 2>;
         ti,gpo-config-1 = <0 0>;
         ti,gpo-config-2 = <0 0>;
         reset-gpios = <&gpio0 14 GPIO_ACTIVE_HIGH>;
-- 
2.20.1

