Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDB2293847
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 11:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405825AbgJTJh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 05:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730804AbgJTJgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 05:36:37 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66EFC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 02:36:37 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id z9so859946qvo.20
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 02:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=6b5Ynk+CtyDztlMBwmd53owM296q881JVhsYHyeZcdc=;
        b=Isl3BwNzkZ2zkWEEMcemaC7MTDkXo14g7Sebal1AfYUNnWWtPfzqpm2GWhYu6hZ1HL
         CHx/QzCRYqJnqCgI7J6FvHaIGiE/qybw5ViUAazV7Oy/J3defXdNwcf4kX9sV/WWaCRh
         YXQpU27UheV0Fe3wahPM2ytSeY0x0xCBLNkTfms5yIIHMAaMELmI6JsYdPSfjVPA66DG
         VdDBNlfZJm17CNSGTXZh3E2MhD5nT/9CLlYPZEfY9TRElTiXRaVbPw8Hahjhb+YCTesY
         III62jRU6xU41u4rT7tbunVvsrxLkcCC3crZLds/I9UnuiLgr8Psg+uf5JMniIpeLw7y
         KX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6b5Ynk+CtyDztlMBwmd53owM296q881JVhsYHyeZcdc=;
        b=hK8I17AfEdIlkF+0WWfi4liOXi04pCwUaUZcJ3fcVFW6eKruAXBX2aG9QE6AxMFHQJ
         FdCD3h+Kwj0BTQk6HtT+DxqqpvU3bQM+F+I1JFyzZi8P2XqXYhb9xrCuns7e0yK/wj6u
         YkrdgvUprCkgwLJR7JuZJBfBoRyLh/FrKy8V3hyaGcxd/Oqicy2DGPUtEeP0s5rCv238
         DEpVLXoQLKxHKQzx/xhJiiHIOahJTdyR+ylKplUY+LvFqP79dHkSrO1LOl7os5XUA0Be
         oRNx3UZGO+3gKjjzRPhN07n5nKi92wwSOCCGqsX7h2E/+FnWcmzeTtGP0jk2NrWOYef5
         E84A==
X-Gm-Message-State: AOAM5336w5oqTzHgrWrx0R+kWYZ/sKw/eGyWjHDyzOa+0d6562wbD3RG
        zFb5Axopq6yerAVAiiKAkp7RptF7g50=
X-Google-Smtp-Source: ABdhPJygmuYm45NEe6i6mDmuntpKNmzcLWNNaKbn0o1ptVNolIZ0+H0vHihBh5bqnXbC1HExF/ABGaF+PnU=
Sender: "badhri via sendgmr" <badhri@badhri.mtv.corp.google.com>
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:1:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:ad4:45a5:: with SMTP id y5mr2393530qvu.40.1603186596745;
 Tue, 20 Oct 2020 02:36:36 -0700 (PDT)
Date:   Tue, 20 Oct 2020 02:36:19 -0700
In-Reply-To: <20201020093627.256885-1-badhri@google.com>
Message-Id: <20201020093627.256885-3-badhri@google.com>
Mime-Version: 1.0
References: <20201020093627.256885-1-badhri@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH v11 02/10] dt-bindings: usb: Maxim type-c controller device
 tree binding document
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thierry Reding <treding@nvidia.com>,
        Prashant Malani <pmalani@chromium.org>,
        Badhri Jagan Sridharan <badhri@google.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree binding document for Maxim 33359 Type-C chip driver

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
Changes since v1:
- Changing patch version to v6 to fix version number confusion.

Changes since v6:
- Migrated to yaml format.

Changes since v7:
- Rebase on usb-next

Changes since v8:
- Fix errors from make dt_binding_check as suggested by
  Rob Herring.

Changes since v9:
- additionalProperties: false as suggested by Rob Herring.

Changes since v10:
- Added the chip number to the binding as suggested by Rob Herring.
- Renamed the filename as well.

---
 .../devicetree/bindings/usb/maxim,33359.yaml  | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/maxim,33359.yaml

diff --git a/Documentation/devicetree/bindings/usb/maxim,33359.yaml b/Documentation/devicetree/bindings/usb/maxim,33359.yaml
new file mode 100644
index 000000000000..b02e7b228cde
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/maxim,33359.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/usb/maxim,33359.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Maxim TCPCI Type-C PD controller DT bindings
+
+maintainers:
+  - Badhri Jagan Sridharan <badhri@google.com>
+
+description: Maxim TCPCI Type-C PD controller
+
+properties:
+  compatible:
+    enum:
+      - maxim,33359
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  connector:
+    type: object
+    $ref: ../connector/usb-connector.yaml#
+    description:
+      Properties for usb c connector.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - connector
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/usb/pd.h>
+    i2c0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        maxtcpc@25 {
+            compatible = "maxim,33359";
+            reg = <0x25>;
+            interrupt-parent = <&gpa8>;
+            interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
+
+            connector {
+                compatible = "usb-c-connector";
+                label = "USB-C";
+                data-role = "dual";
+                power-role = "dual";
+                try-power-role = "sink";
+                self-powered;
+                op-sink-microwatt = <2600000>;
+                new-source-frs-typec-current = <FRS_5V_1P5A>;
+                source-pdos = <PDO_FIXED(5000, 900,
+                                         PDO_FIXED_SUSPEND |
+                                         PDO_FIXED_USB_COMM |
+                                         PDO_FIXED_DATA_SWAP |
+                                         PDO_FIXED_DUAL_ROLE)>;
+                sink-pdos = <PDO_FIXED(5000, 3000,
+                                       PDO_FIXED_USB_COMM |
+                                       PDO_FIXED_DATA_SWAP |
+                                       PDO_FIXED_DUAL_ROLE)
+                                       PDO_FIXED(9000, 2000, 0)>;
+            };
+        };
+    };
+...
-- 
2.29.0.rc1.297.gfa9743e501-goog

