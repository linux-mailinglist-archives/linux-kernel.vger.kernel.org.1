Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC6B2DF134
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 20:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgLSTM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 14:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbgLSTM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 14:12:28 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A168C0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 11:11:30 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id x16so8016786ejj.7
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 11:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mamze14+WiY2yuDsLyQBfAVHfVo7/eHBt2nEYPH4G8k=;
        b=2Ahdghb0OOvc1AqacmhlZBLWLqD8XbcxTImTHzL3iGXit5Q5jdN2lr/NQRBPmblvrQ
         7fGTjX2033LazIAbVuSFRfW9Vi5cfDE/QblO4lazXWeL39yG8tXfJ1V+0gKz360Ef5Tq
         RZQ5AU03CwlM4am2j/tAkJI1k5d8FhXlVE/lJ6Xr3L2i/UTny6vl1S9RPd3a0bz47gyM
         aI3/gckBmlxQW78tldjw0CBMVsl63WfLzQagKVS8pWAF6xNj2Th2z8eVBeZc+4Xkmc+v
         DKPfp2dBkD9hZR/nCwn1wyhK9SaMdy8Rzs/RAwRsDoFmg9+sqZuTdYrUKUuQtrRiWYyz
         DXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mamze14+WiY2yuDsLyQBfAVHfVo7/eHBt2nEYPH4G8k=;
        b=pekwpp2n0skX0nrGkAYEGBlBgHsNp8YoFwMGxS62MHZjJey4o1wUbPKwMVuJ0oT6nB
         4gERNQjGfl93fwCmOYxt7zbXZ57mN2xBcV6xgZrz0V/gMfLp379WiXrvXN3Ed+XUrJIv
         AxTC+6jJ6kiFZGsGO9RL7QYKcfOSSzvCZjQ9EMo9TsXf+x5gW14VkyK+E2+GJKBl6STF
         0FiJ5rprAiqwkgXLKI4hg8+b+Ck/69sKM8a4trC5KuFjiYYo54sGtxUHwNumKnIp+3Hw
         VPPAiPszstG/WYe4MQAH9KfFujIQMHRP0eyQPiduvUeuBntWDnn2XR3O3mqLZFg1DdgP
         sPAA==
X-Gm-Message-State: AOAM530/RUGZ+KPoBqhfQeTpnDb6ZZqQK/1c6HM71/NSPDApJyIOYxjf
        B2AFskVBekSq0SuQRnu5vLlQEg==
X-Google-Smtp-Source: ABdhPJz0qcm/+VzJYfGAJjU4D061HpbYham777R+yNcnQXOckELp4b8/ZW997jyMygKDmQPk4/qEWA==
X-Received: by 2002:a17:906:2707:: with SMTP id z7mr9574360ejc.418.1608405088829;
        Sat, 19 Dec 2020 11:11:28 -0800 (PST)
Received: from localhost.localdomain ([88.207.4.44])
        by smtp.googlemail.com with ESMTPSA id o10sm7081955eju.89.2020.12.19.11.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 11:11:28 -0800 (PST)
From:   Robert Marko <robert.marko@sartura.hr>
To:     jdelvare@suse.com, robh+dt@kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>
Subject: [PATCH v2 1/3] dt-bindings: hwmon: Add TI TPS23861 bindings
Date:   Sat, 19 Dec 2020 20:11:19 +0100
Message-Id: <20201219191121.85142-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document bindings for the Texas Instruments TPS23861 driver.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Cc: Luka Perkov <luka.perkov@sartura.hr>
---
 .../bindings/hwmon/ti,tps23861.yaml           | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml b/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
new file mode 100644
index 000000000000..a7a801f54398
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/hwmon/ti,tps23861.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI TPS23861 PoE PSE
+
+maintainers:
+  - Robert Marko <robert.marko@sartura.hr>
+
+description: |
+  The TPS23861 is a IEEE 802.3at Quad Port Power-over-Ethernet PSE Controller.
+
+  Datasheets:
+  https://www.ti.com/lit/gpn/tps23861
+
+
+properties:
+  compatible:
+    enum:
+      - ti,tps23861
+
+  reg:
+    maxItems: 1
+
+  shunt-resistor-micro-ohms:
+    description: |
+      The value of curent sense resistor in microohms.
+    items:
+      default: 255000
+      minimum: 250000
+      maximum: 255000
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          tps23861@30 {
+              compatible = "ti,tps23861";
+              reg = <0x30>;
+              shunt-resistor-micro-ohms = <255000>;
+          };
+    };
-- 
2.29.2

