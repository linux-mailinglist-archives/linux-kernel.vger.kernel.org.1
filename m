Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B17CC29E445
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbgJ2Hf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbgJ2HY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:24:58 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF18CC05BD1B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 23:31:46 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id q8so1652599ybk.18
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 23:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=red9HlHLr0z6n5FLosfx26Eg7reAfUvRpziqA15ulqU=;
        b=hYmdvmdDS16Gjgv0H5F9XCMu0rc0O1990tkU0CWBSlxaZopO0acG4t3lsntbRTqG3F
         vEldA98kKc7pIyGzQSsO2Gg3tbk079oL7rnmJk/KPFUi32LY2WHkzvaLnGKB+2Gk4rMe
         3iZCsfNgpPANWTGuOPak0hDAc5+LHu0cV+80/3v0/GtlZnU1X1HMxe8P+t7jT932iU27
         TMLOS9R1Y7DwxqcwHg3dODDeOJvUabslgOMTyTMKZGYwa0wwSur2yMP4aSY1iz99r5J+
         J5kTud96cvz1wJtZf5DlOz6XRB9/N9g1QdTnA4/kkbTwAnW1bm7HF4fuia6g3XpFOT+x
         O0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=red9HlHLr0z6n5FLosfx26Eg7reAfUvRpziqA15ulqU=;
        b=iGOeiADK03YLh50jPw94hKpVEStbd1UodcFYQk6POSca7zFloG9PFwxFU/pE5dAwji
         kZI9BTBdw2BeLPsIJjKHjIJ7VrlFlf0josoPFODu+EVCyHiteEeWEWDuQ36IcerGioxF
         GoMtBLWqK8J9Pbde2D9gHi2l7kh9QoSHfSFU2S9xlNyHl20cxiBRc0wskbXzt77Syr6M
         Q/fEOrmdOysnt7K8DlhKD58n6Hz3voojdBJeDDh7EOakm/g932HwH4kqbMlUeczejdlW
         MJABbURu3JB6WSeLaMXXDwPhSbWIRAiac52Y85XBy6EOX/hE58OeqpssGKz4jHVDeSxt
         bWGQ==
X-Gm-Message-State: AOAM532qJjaIo85IZ/70sF4hDWZyYq3U5h4pMJqN57IhtQQWL+T14yVo
        jmHta0d3Cbu6B9xBLpKdp1kjmJZMfcI=
X-Google-Smtp-Source: ABdhPJx9B5u4THeH7RGSi23I4CNHa9buz01P1kDJOiSo5UGLBnHM78cdaXrwi5PUSGuQ1ORilgcyFmBTR1o=
Sender: "badhri via sendgmr" <badhri@badhri.mtv.corp.google.com>
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a25:ae97:: with SMTP id b23mr4231414ybj.26.1603953105875;
 Wed, 28 Oct 2020 23:31:45 -0700 (PDT)
Date:   Wed, 28 Oct 2020 23:31:29 -0700
In-Reply-To: <20201029063138.1429760-1-badhri@google.com>
Message-Id: <20201029063138.1429760-2-badhri@google.com>
Mime-Version: 1.0
References: <20201029063138.1429760-1-badhri@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v12 01/10] dt-bindings: usb: Maxim type-c controller device
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
        Badhri Jagan Sridharan <badhri@google.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree binding document for Maxim 33359 Type-C chip driver

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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

Changes since v11:
Addressed comments from Rob Herring to rename from maxim,33359
to maxim,max33359
---
 .../bindings/usb/maxim,max33359.yaml          | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/maxim,max33359.yaml

diff --git a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
new file mode 100644
index 000000000000..93a19eda610b
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/usb/maxim,max33359.yaml#"
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
+      - maxim,max33359
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
+            compatible = "maxim,max33359";
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
2.29.1.341.ge80a0c044ae-goog

