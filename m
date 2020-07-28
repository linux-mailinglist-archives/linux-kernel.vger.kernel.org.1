Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF989230EE5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 18:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731265AbgG1QJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 12:09:30 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:59516 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731137AbgG1QJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 12:09:30 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06SG8dA1088165;
        Tue, 28 Jul 2020 11:08:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595952519;
        bh=jH/FfVEnikUTSnMw2PAY6KDVMFYv6J1+LWUGiztMq0U=;
        h=From:To:CC:Subject:Date;
        b=pCBjWdRaFi4WpowH2bq5c1Mr663qG5o4KvQ6J7j5jhNx+SoP1dOFlVwKa8TtJTxwZ
         nIENgCtzibsL+bx7gEJteOdA5KPKuh8q/MBP7ngwBcIHQ9BhgCMzd5AyW+W04TGy1e
         ME6rBc3xpRddcKxsD4TK0oJPHfwwJgQvaDDQYTJU=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06SG8dxK014086
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Jul 2020 11:08:39 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 28
 Jul 2020 11:08:39 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 28 Jul 2020 11:08:39 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06SG8dWm080108;
        Tue, 28 Jul 2020 11:08:39 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 1/2] dt-bindings: tlv320adcx140: Add GPO config and drive config
Date:   Tue, 28 Jul 2020 11:08:32 -0500
Message-ID: <20200728160833.24130-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add properties for configuring the General Purpose Outputs (GPO). The
GPOs. There are 2 settings for each GPO, configuration and the output drive
type.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 .../bindings/sound/tlv320adcx140.yaml         | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml b/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
index 2e6ac5d2ee96..0950eb69f2b2 100644
--- a/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
+++ b/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
@@ -108,6 +108,32 @@ properties:
       maximum: 7
     default: [0, 0, 0, 0]
 
+patternProperties:
+ '^ti,gpo-config-[1-4]$':
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+       Defines the configuration and output driver for the general purpose
+       output pins (GPO).  These values are pairs, the first value is for the
+       configuration type and the second value is for the output drive type.
+       The array is defined as <GPO_CFG GPO_DRV>
+
+       GPO output configuration can be one of the following:
+
+       0 - (default) disabled
+       1 - GPOX is configured as a general-purpose output (GPO)
+       2 - GPOX is configured as a device interrupt output (IRQ)
+       3 - GPOX is configured as a secondary ASI output (SDOUT2)
+       4 - GPOX is configured as a PDM clock output (PDMCLK)
+
+       GPO output drive configuration for the GPO pins can be one of the following:
+
+       0d - (default) Hi-Z output
+       1d - Drive active low and active high
+       2d - Drive active low and weak high
+       3d - Drive active low and Hi-Z
+       4d - Drive weak low and active high
+       5d - Drive Hi-Z and active high
+
 required:
   - compatible
   - reg
@@ -124,6 +150,8 @@ examples:
         ti,mic-bias-source = <6>;
         ti,pdm-edge-select = <0 1 0 1>;
         ti,gpi-config = <4 5 6 7>;
+        ti,gpo-config-1 = <0 0>;
+        ti,gpo-config-2 = <0 0>;
         reset-gpios = <&gpio0 14 GPIO_ACTIVE_HIGH>;
       };
     };
-- 
2.28.0

