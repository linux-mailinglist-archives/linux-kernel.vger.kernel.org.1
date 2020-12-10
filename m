Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88FE62D6B24
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 00:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394210AbgLJWbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 17:31:40 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54688 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405105AbgLJWXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 17:23:05 -0500
Received: by mail-wm1-f65.google.com with SMTP id d3so5982626wmb.4;
        Thu, 10 Dec 2020 14:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9IRxFWDzOz05IGkpdOd8TSSSTaf0BQyqI/wwoSsnvR0=;
        b=XkughVdmbzbKH8Dx2UPQauN3lfoRWQ90tMIlyKzwiYN6nzmELWP9Dr/EtPF1TAOFaf
         JHOQ7MAaZdWWFIWwVnq846lI/ATvPG7OXM0a47WbJgcazt47IJ6mTr/FtcQfJ03C0sAR
         ZRU9mMNuIZ9T5oHiRNK+Ch5ZEpFebFu3kpQ4Afr79Z5okhNXOEr/Om32U83JUB4Mfzsi
         ju9O1fw97KZ22P6SZZXvz4giqIT1Z56Xu0Nauat2oyBpcbi2v3eDlMAn2AlD6o/yw71Y
         CAQ8Qwsn7HQMArKYpRxBrKmxI08fSV0foznbCOdw7ggF+N+5I/q5/NjbqXEhZO+L9liz
         H3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9IRxFWDzOz05IGkpdOd8TSSSTaf0BQyqI/wwoSsnvR0=;
        b=UrI1MBzPolSD1wEoEyHN7ynUYVc0xBka+bAEBTZ2TlxbuWzEUNbhHcH/XkhxWSn2v/
         wipSlrZN+s8ktDMNjUZcpbl+eH5yYcnBZOaRby7jz+jqzsxb89bTvfFRmXgpMDHoFIMH
         Sa4lk+E6kSGOlR0r+XURtEjjd23vrPn55GHAt8v6R2lZrQAHDh932jVLFBAZqXacMh7w
         Ui16OuOFrbkMWdRdS+YZooJCfNocAD7e2ASp27uO+5vkDzIipSK12WF9t7zfaPdB1ePx
         RHCAvsHMcxs141vGKS2TKAPogE23PDtaP4EwvLVM0AYzaKPuYKS51AHYTxUbOhzIbHb8
         dUIg==
X-Gm-Message-State: AOAM530hQClI2J5TFCHhlY9sYCO7bYV4o83fTM4YQVolOTyhhP1pGtLa
        dkeSblJnwt286PBPurHnJAQ=
X-Google-Smtp-Source: ABdhPJxp97mPrM2c4Pv6wfyoGoGQjkRvjv9yvV0Mraw6wPGNRtMUVHYzdKoxvKwwfEc7UX2vGhF4pw==
X-Received: by 2002:a1c:17:: with SMTP id 23mr10228470wma.35.1607638633269;
        Thu, 10 Dec 2020 14:17:13 -0800 (PST)
Received: from adgra-XPS-15-9570.home (lfbn-idf1-1-1007-144.w86-238.abo.wanadoo.fr. [86.238.83.144])
        by smtp.gmail.com with ESMTPSA id z2sm12061764wml.23.2020.12.10.14.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 14:17:12 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        troy.kisky@boundarydevices.com, gary.bisson@boundarydevices.com,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: regulator: add pf8x00 PMIC
Date:   Thu, 10 Dec 2020 23:16:28 +0100
Message-Id: <20201210221629.17312-1-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201206002629.12872-1-adrien.grassein@gmail.com>
References: <20201206002629.12872-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a devicetree binding documentation for the pf8x00 regulator driver.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 .../regulator/nxp,pf8x00-regulator.yaml       | 232 ++++++++++++++++++
 MAINTAINERS                                   |   6 +
 2 files changed, 238 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
new file mode 100644
index 000000000000..98cb0d281bf1
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
@@ -0,0 +1,232 @@
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
+description:
+  pf8x00 are a 12-chanel regulator PMIC family. Regulators nodes should
+  be named to ldo<>, sw<> and vnss. The definition for each of these nodes
+  is defined using the standard binding for regulators at
+  Documentation/devicetree/bindings/regulator/regulator.txt.
+  Datasheet is available at https://www.nxp.com/docs/en/data-sheet/PF8100_PF8200.pdf
+
+properties:
+  compatible:
+    enum:
+      - nxp,pf8100
+      - nxp,pf8121a
+      - nxp,pf8200
+
+  reg:
+    maxItems: 1
+
+  regulators:
+    type: object
+    description:
+      list of regulators provided by this controller
+
+    patternProperties:
+      "^ldo[1-4]$":
+        type: object
+        $ref: regulator.yaml#
+        description:
+          Properties for single LDO regulator.
+
+        properties:
+          regulator-name:
+            pattern: "^ldo[1-4]$"
+            description:
+              should be ldo1", ..., "ldo4"
+
+          nxp,hw-en:
+            $ref: /schemas/types.yaml#definitions/flag
+            description:
+              Only available for ldo2. If present, use LDO2EN input pin
+              to enable or disable ldo2. (LDO2EN should be in HIGH state
+              to enable LDO2 if nxp,hw-en is specified).
+
+          nxp,vselect-en:
+            $ref: /schemas/types.yaml#definitions/flag
+            description:
+              Only available for ldo2. When specified, use the VSELECT
+              input pin of the chip to control the output voltage of the
+              ldo02 regulator. (3.3V if VSELECT is LOW, 1.8V if HIGH).
+
+        unevaluatedProperties: false
+
+      "^sw[1-7]$":
+        type: object
+        $ref: regulator.yaml#
+        description:
+          Properties for single SW regulator.
+
+        properties:
+          regulator-name:
+            pattern: "^sw[1-7]$"
+            description:
+              should be sw1", ..., "sw7"
+
+          nxp,ilim-microamp:
+            $ref: /schemas/types.yaml#definitions/uint32
+            minimum: 2100
+            maximum: 4500
+            default: 2100
+            enum: [ 2100, 2600, 3000, 4500 ]
+            description:
+              Defines the maximum current delivered by the regulator in microamp.
+
+          nxp,phase:
+            $ref: /schemas/types.yaml#definitions/uint32
+            minimum: 0
+            maximum: 315
+            default: 0
+            enum: [ 0, 45, 90, 135, 180, 225, 270, 315 ]
+            description:
+               This controls the phase shift of the switching frequency.
+
+          nxp,fast-slew:
+            $ref: /schemas/types.yaml#definitions/flag
+            description:
+              Enables the fast DVS ramp of the regulator.
+              Default is slow DVS ramp.
+
+          nxp,dual-phase:
+            $ref: /schemas/types.yaml#definitions/flag
+            description:
+              This allow regulators  sw1 and sw2, to work together to
+              deliver a maximum 5A current. Should be only specified
+              for sw1. If set, sw2 configuration will be totally ignored.
+
+          nxp,quad-phase:
+            $ref: /schemas/types.yaml#definitions/flag
+            description:
+              This allow regulators  sw1, sw2, sw3 and sw4 to work together
+              to deliver a maximum 10A current. Should be only specified for
+              sw1. If set, sw2, sw3 and sw4 configuration will be totally ignored.
+
+        unevaluatedProperties: false
+
+    properties:
+      vsnvs:
+        type: object
+        $ref: regulator.yaml#
+        description:
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
+      pmic@8 {
+        compatible = "nxp,pf8100";
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
+              nxp,ilim-microamp = <4500>;
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
+              nxp,fast-slew;
+            };
+
+            reg_sw4: sw4 {
+              regulator-always-on;
+              regulator-boot-on;
+              regulator-max-microvolt = <1800000>;
+              regulator-min-microvolt =  <400000>;
+              nxp,fast-slew;
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
index 52086876ce40..71b4476a7619 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13737,6 +13737,12 @@ S:	Maintained
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

