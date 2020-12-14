Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFAE2DA3E0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 00:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441275AbgLNXAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 18:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439879AbgLNW7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 17:59:54 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB6FC061793;
        Mon, 14 Dec 2020 14:59:14 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id c5so14388460wrp.6;
        Mon, 14 Dec 2020 14:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r2EEnarBMK93aha93o9lkDpvjBpyl+l7cfZdEGQoNzA=;
        b=l0WqDqa7NmEuOYcJKpEkhsjOTVSskvraOSvYgNuOpxiTadEAFK9zUXBVWbe8ci9KXK
         bzTvfajpRYr+ZMMZvn2D7jK9fps+8mfx0dRWiXkFHYF6hXD8ncJS5HG+Y/1KEB1gXx8O
         nUAUMdHlEypjLh8bObFbWMW42Wx4qqXcw6COm8d+agWREZ4qlcanpJUTnAELyyOKAPaH
         8ozKB4/MBiyTxWZIxQIe5WUJf7ALLQwV3pC2wqedB5L12HM/jSts2kzSA9w84rYPRb7Z
         Iv96Y+Ue/1Wi/zzI/2JAkjNj7adpuACRmiyzT9XoTRwCMyuVk2IdKOpOvlaGIjq0LDwo
         VgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r2EEnarBMK93aha93o9lkDpvjBpyl+l7cfZdEGQoNzA=;
        b=UMOLcendCgQqV0d3mLqUMbXINrk4foAZGlC5qRIEY0ss3qFrM4BSA7rZe71eG3/QIY
         0IVTdfTCqdi/lkELewONKXbyta77Dytqr6dkfihP13Jgb0t9yy1R4+r+1wE4Brc6fVy+
         cB33lA6GYxZxd4ULlvS0GElNce0z9fKZaralka/z0Q78tIxcHdVRcwJgmYKsw+t/8Ye5
         JoncSe4/884S17iI6L9MqRNxTPNoiaryyj08MjxZUhXW5uIK463xT3zII1h3sDPcf1RY
         kM+rOr6GDVo2BvTjrkkya3QmrmJCH/nYG+ApVgsm+1g5NFutj5EonJ0QZ1fKzYC00b3l
         hQog==
X-Gm-Message-State: AOAM530+j2LHG26q8xfmfLOONro2DDh/lBUJai/WQ3srHu734gDeD6dg
        trJpi4LFyi1DU+l3Rz9bVac=
X-Google-Smtp-Source: ABdhPJzclejgDG1Qsb8O527G/kDVFVZsVFu6GO6KfjD+6bG1BAad7BFrS9QK/88wn28Ex6eLnNW+oA==
X-Received: by 2002:a5d:69cf:: with SMTP id s15mr31096013wrw.372.1607986753109;
        Mon, 14 Dec 2020 14:59:13 -0800 (PST)
Received: from adgra-XPS-15-9570.home (lfbn-idf1-1-1007-144.w86-238.abo.wanadoo.fr. [86.238.83.144])
        by smtp.gmail.com with ESMTPSA id k11sm33091857wmj.42.2020.12.14.14.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 14:59:12 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        troy.kisky@boundarydevices.com, gary.bisson@boundarydevices.com,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v3 1/2] dt-bindings: regulator: add pf8x00 PMIC
Date:   Mon, 14 Dec 2020 23:58:50 +0100
Message-Id: <20201214225851.23342-2-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201214225851.23342-1-adrien.grassein@gmail.com>
References: <20201214225851.23342-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a devicetree binding documentation for the pf8x00 regulator driver.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 .../regulator/nxp,pf8x00-regulator.yaml       | 220 ++++++++++++++++++
 MAINTAINERS                                   |   6 +
 2 files changed, 226 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
new file mode 100644
index 000000000000..a17ab3b22913
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
@@ -0,0 +1,220 @@
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
+          nxp,phase:
+            $ref: /schemas/types.yaml#definitions/uint32
+            minimum: 0
+            maximum: 315
+            enum: [ 0, 45, 90, 135, 180, 225, 270, 315 ]
+            description:
+               This controls the phase shift of the switching frequency.
+               Default value is the one written in the OTP configuration.
+
+          nxp,fast-slew:
+            $ref: /schemas/types.yaml#definitions/flag
+            description:
+              Enables the fast DVS ramp of the regulator.
+              Default is slow DVS ramp.
+              Not available for sw7 regulator.
+              Default value is the one written in the OTP configuration.
+
+          nxp,dual-phase:
+            $ref: /schemas/types.yaml#definitions/flag
+            description:
+              This allow regulators  sw1 and sw2, sw3 and sw4, sw5 and sw6,
+              to work together to deliver a maximum 5A current.
+              Should be only specified for sw1, sw3 and sw5.
+              If set, sw2, sw4 and sw6 configuration will be totally ignored.
+              This is not a configuration property. It's only used to control
+              the consistency of the OTP confguration.
+
+          nxp,quad-phase:
+            $ref: /schemas/types.yaml#definitions/flag
+            description:
+              This allow regulators  sw1, sw2, sw3 and sw4 to work together
+              to deliver a maximum 10A current. Should be only specified for
+              sw1. If set, sw2, sw3 and sw4 configuration will be totally ignored.
+              This is not a configuration property. It's only used to control
+              the consistency of the OTP confguration.
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
+              regulator-always-on;
+              regulator-boot-on;
+              regulator-max-microvolt = <1800000>;
+              regulator-min-microvolt = <400000>;
+              regulator-max-microamp  = <4500000>;
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
index fb75813e23d4..878e6f25aab7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13804,6 +13804,12 @@ S:	Maintained
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

