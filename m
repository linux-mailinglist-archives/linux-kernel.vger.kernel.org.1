Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF432D8675
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 13:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438865AbgLLMiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Dec 2020 07:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbgLLMiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 07:38:04 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F16C0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 12 Dec 2020 04:37:24 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 23so18338616lfg.10
        for <linux-kernel@vger.kernel.org>; Sat, 12 Dec 2020 04:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WLAwp3y+tFT1YsQfzRXA65Quly0sNlnvQc7MORshoDc=;
        b=wLDIoZh9xvvAIudM3jCde94tcJA4ozhrnT+kTMafIK5goFijF9/SjjVugg+xtVGkAm
         dWkakl+WXFvJjx00ViyQPRuFJ4XWbk6yeg6Jz0mO+DBdZ2OROCskewG1QqlfKJdEL+Ov
         kC9csLAYr3aeF/5a19uynaIaDq7jiKEOTJpLMovToNrfuGnZszD24NTMJe585RQmYYfK
         as0SvsY4/A6f4jm61zFOk8OOqpcWh+62rzBTw+f4j8CPRtZHj/KKQLPlUxYR7dz7r5yR
         8pPQ9T4hXkmfdJVvazSPSTsYcbmFfHFsOeWK706kRQPKLwiwxSGo5dyMaFTr1zuyEEmc
         KieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WLAwp3y+tFT1YsQfzRXA65Quly0sNlnvQc7MORshoDc=;
        b=qu+GR1SEzae03ek7g6SoFR68Wfrfth301kuprk4BaK3gd5Hgeb/KDjoeuM8ytVwoVF
         xdX9FQZYZuOvRpg8gpwpGazwoTKN1olyvYWNhfaVTXQ+2jN5fwojV/37ZXOwzXmBhsLe
         oczkjp7Vyfb6huJjWhA1cgGGEzUIC5wVQdCkWlg7RnVehgT2eJ+kavFokoQoB24mtp+d
         pWe8yL1bUodlkEb8zhEWhQCZbWeaE42oULJXRJVvntjCIK2/d4GIA76FQX/I1QZ4xo/w
         aBwYpVYzmJVLjJPts3xkF69KscT/1ysh5JcwH0yNV3v7TTZbpHesRczpHwwoh2VankDO
         PC1w==
X-Gm-Message-State: AOAM530d26czdi3ngO0BsQcSsqRhiduwZqNoPbtgPcIKtComBwVIt2Vw
        CvxSp2Fx/Qyw9HktuObpDC3phw==
X-Google-Smtp-Source: ABdhPJw1j9dStyGKmFQ6sbcbiK0mYMgnmTaJQ7WiQf/77aj97MOq1X2Lh2/QMvy6Wh8xSre4r5tmag==
X-Received: by 2002:a2e:b5d6:: with SMTP id g22mr6577940ljn.488.1607776642183;
        Sat, 12 Dec 2020 04:37:22 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id b3sm1209011lfs.168.2020.12.12.04.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Dec 2020 04:37:21 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v2] mfd: db8500-prcmu: Add devicetree bindings
Date:   Sat, 12 Dec 2020 13:37:18 +0100
Message-Id: <20201212123718.2768502-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver was merged in the early days of device tree
on Arm in 2012 and somehow we failed to provide bindings
for it. Fix it up with some YAML bindings.

Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Make the main PRCMU node name more generic instead of
  hammering it down to a specific address.
---
 .../bindings/mfd/stericsson,db8500-prcmu.yaml | 282 ++++++++++++++++++
 1 file changed, 282 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/stericsson,db8500-prcmu.yaml

diff --git a/Documentation/devicetree/bindings/mfd/stericsson,db8500-prcmu.yaml b/Documentation/devicetree/bindings/mfd/stericsson,db8500-prcmu.yaml
new file mode 100644
index 000000000000..cf8e2cc25f9d
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/stericsson,db8500-prcmu.yaml
@@ -0,0 +1,282 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/stericsson,db8500-prcmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ST-Ericsson DB8500 PRCMU - Power Reset and Control Management Unit
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+description:
+  The DB8500 Power Reset and Control Management Unit is an XP70 8-bit
+  microprocessor that is embedded in the always-on power domain of the
+  DB8500 SoCs to manage the low power states, powering up and down parts
+  of the silicon, and controlling reset of different IP blocks.
+
+properties:
+  $nodename:
+    pattern: '^prcmu(@.*|-[0-9a-f])*$'
+
+  compatible:
+    description: The device is compatible both to the device-specific
+      compatible "stericsson,db8500-prcmu" and "syscon". The latter
+      compatible is needed for the device to be exposed as a system
+      controller so that arbitrary registers can be access by
+      different operating system components.
+    items:
+      - const: stericsson,db8500-prcmu
+      - const: syscon
+
+  reg:
+    items:
+      - description: Main PRCMU register area
+      - description: PRCMU TCPM register area
+      - description: PRCMU TCDM register area
+
+  reg-names:
+    items:
+      - const: prcmu
+      - const: prcmu-tcpm
+      - const: prcmu-tcdm
+
+  interrupts:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+  ranges: true
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+
+  db8500-prcmu-regulators:
+    description: Node describing the DB8500 regulators. These are mainly
+      power rails inside the silicon but some of those are also routed
+      out to external pins.
+    type: object
+
+    properties:
+      compatible:
+        const: stericsson,db8500-prcmu-regulator
+
+      db8500_vape:
+        description: The voltage for the application processor, the
+          main voltage domain for the chip.
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      db8500_varm:
+        description: The voltage for the ARM Cortex A-9 CPU.
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      db8500_vmodem:
+        description: The voltage for the modem subsystem.
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      db8500_vpll:
+        description: The voltage for the phase locked loop clocks.
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      db8500_vsmps1:
+        description: Also known as VIO12, is a step-down voltage regulator
+          for 1.2V I/O. SMPS means System Management Power Source.
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      db8500_vsmps2:
+        description: Also known as VIO18, is a step-down voltage regulator
+          for 1.8V I/O. SMPS means System Management Power Source.
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      db8500_vsmps3:
+        description: This is a step-down voltage regulator
+          for 0.87 thru 1.875V I/O. SMPS means System Management Power Source.
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      db8500_vrf1:
+        description: RF transciever voltage regulator.
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      db8500_sva_mmdsp:
+        description: Smart Video Accelerator (SVA) multimedia DSP (MMDSP)
+          voltage regulator. This is the voltage for the accelerator DSP
+          for video encoding and decoding.
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      db8500_sva_mmdsp_ret:
+        description: Smart Video Accelerator (SVA) multimedia DSP (MMDSP)
+          voltage regulator for retention mode.
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      db8500_sva_pipe:
+        description: Smart Video Accelerator (SVA) multimedia DSP (MMDSP)
+          voltage regulator for the data pipe.
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      db8500_sia_mmdsp:
+        description: Smart Image Accelerator (SIA) multimedia DSP (MMDSP)
+          voltage regulator. This is the voltage for the accelerator DSP
+          for image encoding and decoding.
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      db8500_sia_mmdsp_ret:
+        description: Smart Image Accelerator (SIA) multimedia DSP (MMDSP)
+          voltage regulator for retention mode.
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      db8500_sia_pipe:
+        description: Smart Image Accelerator (SIA) multimedia DSP (MMDSP)
+          voltage regulator for the data pipe.
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      db8500_sga:
+        description: Smart Graphics Accelerator (SGA) voltage regulator.
+          This is in effect controlling the power to the MALI400 3D
+          accelerator block.
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      db8500_b2r2_mcde:
+        description: Blit Blend Rotate and Rescale (B2R2), and Multi-Channel
+          Display Engine (MCDE) voltage regulator. These are two graphics
+          blocks.
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      db8500_esram12:
+        description: Embedded Static RAM (ESRAM) 1 and 2 voltage regulator.
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      db8500_esram12_ret:
+        description: Embedded Static RAM (ESRAM) 1 and 2 voltage regulator for
+          retention mode.
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      db8500_esram34:
+        description: Embedded Static RAM (ESRAM) 3 and 4 voltage regulator.
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+      db8500_esram34_ret:
+        description: Embedded Static RAM (ESRAM) 3 and 4 voltage regulator for
+          retention mode.
+        type: object
+        $ref: ../regulator/regulator.yaml#
+
+    required:
+      - compatible
+      - db8500_vape
+      - db8500_varm
+      - db8500_vmodem
+      - db8500_vpll
+      - db8500_vsmps1
+      - db8500_vsmps2
+      - db8500_vsmps3
+      - db8500_vrf1
+      - db8500_sva_mmdsp
+      - db8500_sva_mmdsp_ret
+      - db8500_sva_pipe
+      - db8500_sia_mmdsp
+      - db8500_sia_mmdsp_ret
+      - db8500_sia_pipe
+      - db8500_sga
+      - db8500_b2r2_mcde
+      - db8500_esram12
+      - db8500_esram12_ret
+      - db8500_esram34
+      - db8500_esram34_ret
+
+    additionalProperties: false
+
+  thermal@801573c0:
+    description: Node describing the DB8500 thermal control functions.
+      This binds to an operating system driver that monitors the
+      temperature of the SoC.
+    type: object
+
+    properties:
+      compatible:
+        const: stericsson,db8500-thermal
+
+      reg:
+        maxItems: 1
+
+      interrupts:
+        items:
+          - description: Hotmon low interrupt (falling temperature)
+          - description: Hotmon high interrupt (rising temperature)
+
+      interrupt-names:
+        items:
+          - const: IRQ_HOTMON_LOW
+          - const: IRQ_HOTMON_HIGH
+
+      '#thermal-sensor-cells':
+        const: 0
+
+    additionalProperties: false
+
+  prcmu-timer-4@80157450:
+    description: Node describing the externally visible timer 4 in the
+      PRCMU block. This timer is interesting to the operating system
+      since even thought it has a very low resolution (32768 Hz) it is
+      always on, and thus provides a consistent monotonic timeline for
+      the system.
+    type: object
+
+    properties:
+      compatible:
+        const: stericsson,db8500-prcmu-timer-4
+
+      reg:
+        maxItems: 1
+
+    additionalProperties: false
+
+patternProperties:
+  "^ab850[05]$":
+    description: Node describing the Analog Baseband 8500 mixed-signals
+      ASIC AB8500 and subcomponents. The AB8500 is accessed through the
+      PRCMU and hence it appears here. This component has a separate
+      set of devicetree bindings. The AB8505 is a newer version of the
+      same ASIC.
+    type: object
+
+required:
+  - compatible
+  - reg
+  - '#address-cells'
+  - '#size-cells'
+  - ranges
+  - interrupt-controller
+  - '#interrupt-cells'
+  - db8500-prcmu-regulators
+  - thermal@801573c0
+  - prcmu-timer-4@80157450
+
+dependencies:
+  interrupt-controller: [ interrupts ]
+
+additionalProperties: false
-- 
2.26.2

