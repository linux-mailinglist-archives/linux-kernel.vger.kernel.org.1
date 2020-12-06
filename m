Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D475B2CFFEF
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 01:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbgLFA1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 19:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgLFA1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 19:27:32 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80015C0613CF;
        Sat,  5 Dec 2020 16:26:46 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id k14so9032291wrn.1;
        Sat, 05 Dec 2020 16:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Opbjpb6gftj2lzGu/QRyxL0n/6feeVuBqr7gB5bZpf4=;
        b=DnzRf6opZ9kBS4ZRbbdGlx8oM0OKATFJPd8/w9dVGhvxBjBv0Bw2zImB430epe1RAF
         zXsYjZgu/1GozP6ifCftWuqFg0apzo0X4YYSBA5c28Q4roCWdSCQy04V3SW4lJ47fbrg
         CE/mPiIA4WiOU2YkhoBPVqM06RITTveG2mwtlFwt8nC4v+exBDbHG+wTXxD0a4mr3P5j
         R15C5NI+u4C6OpS/kTujA9NQ5sTHkIuHBQX+/tmMOMSOWNofzcwKBKyVWSk8cC8sPMAE
         VNHtEAEO7EM2U7/aEF9r8fEQ2Q94BOCo0ItJgr6YEGPZePLsZbdkRcUBsAwUUYKrM0fX
         oDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Opbjpb6gftj2lzGu/QRyxL0n/6feeVuBqr7gB5bZpf4=;
        b=LvqYVhJQsWfoMCPtx15sLgO06xZCv/cz8gVnpYIiL+bWdKhKbNPIP6XdLaAhjEYdM4
         Bz0c+uMB5KaJoikbSyzljboP4p/ZFQ0eVi1tlPd8DDVnR30RmahEHnrmRHNI28VeieSY
         47vfy2qDRqZV+8qnJE+8WoIP8VEiHiyD27/I+gkLZDALWO/e5qgJO65PniY57lH3gest
         tXjxu5NV9d0lf63zTSM0x2QxxRgIEZHcqPSuKeT5/XTU6BsW8MFPpZccaUBmfpVgopt+
         ASSCt8kgyCM72b87b09jQ0UktaCp8aBSmLyyVlKWUke3jtKpc0WR27OGOAXtRhDaxwzj
         Rx6A==
X-Gm-Message-State: AOAM532UxwpZMr5Kb1d4gTkdkMyQk6U8Og/hInawStqBzo3kj6fF0CcB
        2EhodkGA7kTT+Mx+o897VQ8=
X-Google-Smtp-Source: ABdhPJz8UV5v39vlHcKo3Tq/8wHDIt+vnmGdiD3Rxa0xDPNoB8896qPLm0k/ZdMMLuMHW69VnwvI+Q==
X-Received: by 2002:adf:f0d0:: with SMTP id x16mr2726025wro.162.1607214405190;
        Sat, 05 Dec 2020 16:26:45 -0800 (PST)
Received: from adgra-XPS-15-9570.home (lfbn-idf1-1-1007-144.w86-238.abo.wanadoo.fr. [86.238.83.144])
        by smtp.gmail.com with ESMTPSA id c2sm8978407wrv.41.2020.12.05.16.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 16:26:44 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        troy.kisky@boundarydevices.com, gary.bisson@boundarydevices.com,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH 1/2] dt-bindings: regulator: Add pf8x00 regulator
Date:   Sun,  6 Dec 2020 01:26:28 +0100
Message-Id: <20201206002629.12872-1-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings for the pf8x00 driver.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 .../regulator/nxp,pf8x00-regulator.yaml       | 223 ++++++++++++++++++
 MAINTAINERS                                   |   6 +
 2 files changed, 229 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
new file mode 100644
index 000000000000..f4e4f545c5a3
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
@@ -0,0 +1,223 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/nxp,pf8x00-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP PF8x00 Power Management Integrated Circuit regulators
+
+maintainers:
+  - Adrien Grassein <adrien.grassein@gmail.com>
+
+description: |
+  pf8x00 are a 12-chanel regulator PMIC family. Regulators nodes should
+  be named to ldo<>, sw<> and vnss. The definition for each of these nodes
+  is defined using the standard binding for regulators at
+  Documentation/devicetree/bindings/regulator/regulator.txt.
+  Datasheet is available at https://www.nxp.com/docs/en/data-sheet/PF8100_PF8200.pdf
+
+properties:
+  compatible:
+    enum:
+      - nxp,pf8x00
+
+  reg:
+    maxItems: 1
+
+  regulators:
+    type: object
+    description: |
+      list of regulators provided by this controller
+
+    patternProperties:
+      "^ldo[1-4]$":
+        type: object
+        $ref: regulator.yaml#
+        description: |
+          Properties for single LDO regulator.
+
+        properties:
+          regulator-name:
+            pattern: "^ldo[1-4]$"
+            description: |
+              should be ldo1", ..., "ldo4"
+
+          nxp,hw-en:
+            $ref: /schemas/types.yaml#definitions/flag
+            description: |
+              Only available for ldo2. Used to enable or disable ld02.
+
+          nxp,vselect-en:
+            $ref: /schemas/types.yaml#definitions/flag
+            description: |
+              Only available for ldo2. When specified, use the VSELECT pin
+              of the chip to control the output voltage of the ldo02 regulator.
+
+        unevaluatedProperties: false
+
+      "^sw[1-7]$":
+        type: object
+        $ref: regulator.yaml#
+        description: |
+          Properties for single SW regulator.
+
+        properties:
+          regulator-name:
+            pattern: "^sw[1-7]$"
+            description: |
+              should be sw1", ..., "sw7"
+
+          nxp,ilim-ma:
+            $ref: /schemas/types.yaml#definitions/uint32
+            minimum: 2100
+            maximum: 4500
+            default: 2100
+            enum: [ 2100, 2600, 3000, 4500 ]
+            description: |
+              Defines the maximum current delivered by the regulator (in mA).
+
+          nxp,phase:
+            $ref: /schemas/types.yaml#definitions/uint32
+            minimum: 0
+            maximum: 315
+            default: 0
+            enum: [ 0, 45, 90, 135, 180, 225, 270, 315 ]
+            description: |
+               This controls the phase shift of the switching frequency.
+
+          nxp,fsl,fast-slew:
+            $ref: /schemas/types.yaml#definitions/flag
+            description: |
+              Controls the DVS ramp of the regulator.
+
+          nxp,quad-phase:
+            $ref: /schemas/types.yaml#definitions/flag
+            description: |
+              This allow regulators  sw1 and sw2, or sw3 and sw4 or sw4 and sw5
+              to work together to deliver a maximum 10A current.
+
+          nxp,dual-phase:
+            $ref: /schemas/types.yaml#definitions/flag
+            description: |
+              This allow regulators  sw1, sw2, sw3 and sw4 to work together
+              to deliver a maximum 5A current.
+
+        unevaluatedProperties: false
+
+      "^vsnvs$":
+        type: object
+        $ref: regulator.yaml#
+        description: |
+          Properties for vsnvs regulator.
+
+        unevaluatedProperties: false
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - regulators
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      pmic: pf8100@8 {
+        compatible = "nxp,pf8x00";
+        reg = <0x08>;
+
+        regulators {
+            reg_ldo1: ldo1 {
+              regulator-always-on;
+              regulator-boot-on;
+              regulator-max-microvolt = <5000000>;
+              regulator-min-microvolt = <1500000>;
+            };
+
+            reg_ldo2: ldo2 {
+              regulator-always-on;
+              regulator-boot-on;
+              regulator-max-microvolt = <5000000>;
+              regulator-min-microvolt = <1500000>;
+            };
+
+            reg_ldo3: ldo3 {
+              regulator-always-on;
+              regulator-boot-on;
+              regulator-max-microvolt = <5000000>;
+              regulator-min-microvolt = <1500000>;
+            };
+
+            reg_ldo4: ldo4 {
+              regulator-always-on;
+              regulator-boot-on;
+              regulator-max-microvolt = <5000000>;
+              regulator-min-microvolt = <1500000>;
+            };
+
+            reg_sw1: sw1 {
+              nxp,phase = <0>;
+              nxp,ilim-ma = <4500>;
+              regulator-always-on;
+              regulator-boot-on;
+              regulator-max-microvolt = <1800000>;
+              regulator-min-microvolt =  <400000>;
+            };
+
+            reg_sw2: sw2 {
+              regulator-always-on;
+              regulator-boot-on;
+              regulator-max-microvolt = <1800000>;
+              regulator-min-microvolt =  <400000>;
+            };
+
+            reg_sw3: sw3 {
+              regulator-always-on;
+              regulator-boot-on;
+              regulator-max-microvolt = <1800000>;
+              regulator-min-microvolt =  <400000>;
+              nxp,fast-slew = <1>;
+            };
+
+            reg_sw4: sw4 {
+              regulator-always-on;
+              regulator-boot-on;
+              regulator-max-microvolt = <1800000>;
+              regulator-min-microvolt =  <400000>;
+              nxp,fast-slew = <1>;
+            };
+
+            reg_sw5: sw5 {
+              regulator-always-on;
+              regulator-boot-on;
+              regulator-max-microvolt = <1800000>;
+              regulator-min-microvolt =  <400000>;
+            };
+
+           reg_sw6: sw6 {
+             regulator-always-on;
+             regulator-boot-on;
+             regulator-max-microvolt = <1800000>;
+             regulator-min-microvolt =  <400000>;
+           };
+
+           reg_sw7: sw7 {
+             regulator-always-on;
+             regulator-boot-on;
+             regulator-max-microvolt = <4100000>;
+             regulator-min-microvolt = <1000000>;
+           };
+
+          reg_vsnvs: vsnvs {
+            regulator-always-on;
+            regulator-boot-on;
+            regulator-max-microvolt = <3300000>;
+            regulator-min-microvolt = <1800000>;
+          };
+        };
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index ebe4829cdd4d..4e266f1e9a2f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13730,6 +13730,12 @@ S:	Maintained
 F:	include/linux/personality.h
 F:	include/uapi/linux/personality.h
 
+PF8x00 PMIC REGULATORS DRIVERS
+M:	Adrien Grassein <adrien.grassein@gmail.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
+
 PHOENIX RC FLIGHT CONTROLLER ADAPTER
 M:	Marcus Folkesson <marcus.folkesson@gmail.com>
 L:	linux-input@vger.kernel.org
-- 
2.20.1

