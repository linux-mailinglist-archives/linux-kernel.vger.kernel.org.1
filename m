Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64CB286E7A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 08:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbgJHGQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 02:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728594AbgJHGQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 02:16:09 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C65C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 23:16:09 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id x24so3031286pfi.18
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 23:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=qREnjimRvXvFv14cu2Mdee7FTQw1clOjNi7le952Vyw=;
        b=TcQlrlgY6FCgtg3cVzVVSia+tZL5ToTRLB3TQ3Z3BSmx0AeDXVkonOCCympIMCPA60
         xZITTW6+FY/82C6MVAyur+WQv+Sbaf8ErZqPHPOSwWgUCAmEbHXEjI3Ho5ys6ZChI5wH
         xGoWs3AxR3T88L6srkvgsIGoOSL+uogtov/fDRXaIpXvRfvLY5eBAuFc5VKoAfbRfa1t
         yRdG70DxamhpyzHuEnbnvdyMjO2l/gOXsDYplgHNLTAz0QqQcrd5PfEwxpYSNEV+vJEy
         05wZm6dV+XvcNdz/EMiSQLWeqdI8xc7IMsagkwv1zAXsWTRVRpBPPsU7irZl/XjQHeET
         cHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qREnjimRvXvFv14cu2Mdee7FTQw1clOjNi7le952Vyw=;
        b=sB2EMtyCvwKiP/+vwZ0hzChskQj8L26Y/5A4oV3b3pn13cU9y7W2BkpxkOcLOif4rK
         4mmifUMOueWUKDRJ/B6QKKnFXbGFOjD1kEE43RA4BD1Td6pFEabXeBNV3jZspG+Zy5jF
         shv0MLgxbGbkI2o+VKHUxzUOx+pHokvc4xYRoKKV3m2N3/cnbY4aJUweHWI8d+cBm8qu
         t26RcCfFuQ+dz3ASw5OVhsOboM5chXDdvLzevW1YnDnuSE0UpUpzAet6Pk6qw5gjHlZy
         +BGvwmoT3KuS24PsU1c/c2YyXziUPEZv5xfgBAmwzcP0Pu7IKid6aohNjbsKSiNi0ZyG
         Cavw==
X-Gm-Message-State: AOAM5331CKoHlmMovqwxSoPsR+tef0o03lbHb2nGS0RXms/Q70xGXikZ
        M/jfJsUAFANytdsj8e3EATp5N4Wg0gM=
X-Google-Smtp-Source: ABdhPJzvHDLGP+igoqH53dJ2k49U6QLMJba95bZHrAFiCqofD8WzzcI1hZpnEsj2C3HhyRTk/GQlHKJPkZ4=
Sender: "badhri via sendgmr" <badhri@badhri.mtv.corp.google.com>
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:1:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a17:90a:b896:: with SMTP id
 o22mr4704764pjr.130.1602137768574; Wed, 07 Oct 2020 23:16:08 -0700 (PDT)
Date:   Wed,  7 Oct 2020 23:15:44 -0700
In-Reply-To: <20201008061556.1402293-1-badhri@google.com>
Message-Id: <20201008061556.1402293-4-badhri@google.com>
Mime-Version: 1.0
References: <20201008061556.1402293-1-badhri@google.com>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: [PATCH v10 03/15] dt-bindings: usb: Maxim type-c controller device
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
        linux-usb@vger.kernel.org, Amelie Delaunay <amelie.delaunay@st.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree binding document for Maxim TCPCI based Type-C chip driver

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
---
 .../devicetree/bindings/usb/maxim,tcpci.yaml  | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/maxim,tcpci.yaml

diff --git a/Documentation/devicetree/bindings/usb/maxim,tcpci.yaml b/Documentation/devicetree/bindings/usb/maxim,tcpci.yaml
new file mode 100644
index 000000000000..12e0ece1b515
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/maxim,tcpci.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/usb/maxim,tcpci.yaml#"
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
+      - maxim,tcpci
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
+            compatible = "maxim,tcpc";
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
2.28.0.806.g8561365e88-goog

