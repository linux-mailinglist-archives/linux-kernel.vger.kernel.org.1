Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEBF12D2ECE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 16:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730221AbgLHPzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 10:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729558AbgLHPzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 10:55:49 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AA1C061793;
        Tue,  8 Dec 2020 07:55:03 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id q3so12544179pgr.3;
        Tue, 08 Dec 2020 07:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rbYvHKBR+xXvOtcdc2hP7bGS0T77EGGlk2cdIpTFQnU=;
        b=lt5epzuJ1/ewWVilm9yTPUwh+gDhZH2NHMpBZDAVvlVj0HP33bim34q9nrT3IzPZYc
         g2BPNhv6C7VOnizpOUhPHfJmM7ei1Lb7h5QX3katZxeEN9sWma/KVBoZCAH0/688RwFm
         OhZvSkVeFwOVEjWSBHve8aBUoZh1yLDMuv7bGIyJ6cvB/EV81TkZyN2hak49AT4JNgrF
         V8o5p46iGFM8IyamaxAytkvxHui+vER2qu2R0YoArvRVFYmRq1bROObIiV/gM+EUr2Sm
         p0zsfwUPhHwtYmRFr4M3RZvXtZ6dBWXYYUSEKM6jW7JQ5ItVDfYM3wVT5dJj1A1Q3Ccc
         mydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rbYvHKBR+xXvOtcdc2hP7bGS0T77EGGlk2cdIpTFQnU=;
        b=mamUTyIKcW9eF6NNrRB+h+HUj880WQtdWtjtoxaDzW/XGs6yRlV1x4CsNroQhyHTz2
         BvWxc0JmPIh/ZAnLExQvkEKrKmI/dJcwWRxGMgUmTTcol1MTTyVe1MVN/VFmKLp1suSE
         Q6fQ2NJN2lrFJJl5ycFtF3jr5eBDIn9DhNnvJuAI5tRoWE5yftRmS1X816vcpqO3njiU
         2gacwJccm3nuT/rGrXzZcdZhFR+W+lwQqoQfVAaTR81mKUtv2UBVMfyglZbZXhxINIMq
         q1wqgGqSLzQfBZvFcSHQf9WgC0uPv5IJA29PkVxzmZMNOGyBxRfT+IFqNpbQBcmFoEuk
         np8w==
X-Gm-Message-State: AOAM533h3NtEFLhaNc1W0vQnJt+/0HancVfk2EnPQHqn51zFoVDPQUGI
        f5G/fgz73UbI8rD+xUWOd5k=
X-Google-Smtp-Source: ABdhPJwlRV8esP8MFYOKQb4zPQSn0lTQuBjOnIVg+V21OZlwUd+mDUxm48c5T6qpU2dHy2rMUCKxhg==
X-Received: by 2002:a17:90a:bb83:: with SMTP id v3mr4873439pjr.28.1607442902950;
        Tue, 08 Dec 2020 07:55:02 -0800 (PST)
Received: from localhost.localdomain (1-171-4-151.dynamic-ip.hinet.net. [1.171.4.151])
        by smtp.gmail.com with ESMTPSA id a17sm6700725pgw.80.2020.12.08.07.55.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Dec 2020 07:55:02 -0800 (PST)
From:   cy_huang <u0084500@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org
Cc:     cy_huang@richtek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 3/4] regulator: rt4831: Adds DT binding document for Richtek RT4831 DSV regulator
Date:   Tue,  8 Dec 2020 23:54:45 +0800
Message-Id: <1607442886-13046-3-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607442886-13046-1-git-send-email-u0084500@gmail.com>
References: <1607442886-13046-1-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Adds DT binding document for Richtek RT4831 DSV regulator.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
since v3
- Add dual license tag in regulator binding document.
- Left regulator dt-binding example only.
---
 .../regulator/richtek,rt4831-regulator.yaml        | 57 ++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt4831-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt4831-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt4831-regulator.yaml
new file mode 100644
index 00000000..c6741f2
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/richtek,rt4831-regulator.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/richtek,rt4831-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RT4831 Display Bias Voltage Regulator
+
+maintainers:
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description: |
+  RT4831 is a multifunctional device that can provide power to the LCD display
+  and LCD backlight.
+
+  For Display Bias Voltage DSVP and DSVN, the output range is about 4V to 6.5V.
+  It is sufficient to meet the current LCD power requirement.
+
+  DSVLCM is a boost regulator in IC internal as DSVP and DSVN input power.
+  Its voltage should be configured above 0.15V to 0.2V gap larger than the
+  voltage needed for DSVP and DSVN. Too much voltage gap could improve the
+  voltage drop from the heavy loading scenario. But it also make the power
+  efficiency worse. It's a trade-off.
+
+  Datasheet is available at
+  https://www.richtek.com/assets/product_file/RT4831A/DS4831A-05.pdf
+
+patternProperties:
+  "^DSV(LCM|P|N)$":
+    type: object
+    $ref: regulator.yaml#
+    description:
+      Properties for single Display Bias Voltage regulator.
+
+additionalProperties: false
+
+examples:
+  - |
+    regulators {
+      DSVLCM {
+        regulator-min-microvolt = <4000000>;
+        regulator-max-microvolt = <7150000>;
+        regulator-allow-bypass;
+      };
+      DSVP {
+        regulator-name = "rt4831-dsvp";
+        regulator-min-microvolt = <4000000>;
+        regulator-max-microvolt = <6500000>;
+        regulator-boot-on;
+      };
+      DSVN {
+        regulator-name = "rt4831-dsvn";
+        regulator-min-microvolt = <4000000>;
+        regulator-max-microvolt = <6500000>;
+        regulator-boot-on;
+      };
+    };
-- 
2.7.4

