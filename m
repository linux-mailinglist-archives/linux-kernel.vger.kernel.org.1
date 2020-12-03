Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8E52CDAD1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 17:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731258AbgLCQHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 11:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbgLCQHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 11:07:38 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3394C061A54;
        Thu,  3 Dec 2020 08:06:48 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id w4so1637578pgg.13;
        Thu, 03 Dec 2020 08:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ufY8PAE6/5PnBalLSAkkFIU9kLkjLoZMVRGTSeVEitk=;
        b=WI9RQlZAlARVycG20Bs7eowahragTEq3jOwXm0GE7N5OpNfweyeT2/joUbMFRvhWIi
         7vvHn1a2SQ5mO4xSBs8/u+vgw7SImKBw1HsGHvCKnFbgJQnYPUnuSsyTUV5fiHnPAW9F
         0eJHj8uphNXTHVdxboM0AkfkMpVURQddNyGKRI37HMNpP22c+7N22nxDkoOq9+QXQM+r
         EVEoC6oD9yT2ISEYnzJPKkZ20urnRaugggDswYlyBPbtVCBo1buupb20FHHGmUJ9xqyR
         HOvDJlWgk7F9eZeIcir0zMiJQcHmXq70vubAkzYzFMaKlPB/7nNyQXMLOPQFyxAbLEvc
         cqHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ufY8PAE6/5PnBalLSAkkFIU9kLkjLoZMVRGTSeVEitk=;
        b=my+TXTamFN6fALnsmLgx+fVoNBNbr0LQK4blPGy33XCrl1c3Ev7OTy8iZBwlcoy19S
         jKkSnZZMZL7pd2AHmLAbcvDub9jSlkCVt7cCNjCeqW0wEZqXtCOnzQDvCJT/nKmLMe9j
         8X0G6vaKBf8DoyihZRf1JcdtSpm2NQzpzc9HocP1MGcMPemgaHOQvp6hlwGmthxu5BA3
         G98jIkDmpb2S02/D/R0Sn3ZSuFGJPFhd0kFGkfCRpy2Uz6qJotvJJ78T2fp4U2iJ5utf
         4lhFmb3+MA/2yqtdgSiUNvL9dbRiY02mqj4uMs1ifLyCasIDmaw6S6/061rmVjbWibcR
         KfsA==
X-Gm-Message-State: AOAM531rzbsZFPZu1He6WgzPSE76ztiqSGUHGGj20pg9NVjoQku/A07j
        waSxayRKgSy9ONA5q34sI/UafXDssP7b7A==
X-Google-Smtp-Source: ABdhPJxI5rb09SN6xC8Rvcz8RG5807/SE+xJVRxxNlXfPx8oYo+qA/MdlCtpZ53IhYFAny4/wCwCRQ==
X-Received: by 2002:a63:1959:: with SMTP id 25mr3628743pgz.201.1607011608437;
        Thu, 03 Dec 2020 08:06:48 -0800 (PST)
Received: from localhost.localdomain (1-171-1-217.dynamic-ip.hinet.net. [1.171.1.217])
        by smtp.gmail.com with ESMTPSA id h6sm92503pgc.15.2020.12.03.08.06.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Dec 2020 08:06:47 -0800 (PST)
From:   cy_huang <u0084500@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org
Cc:     cy_huang@richtek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 3/4] regulator: rt4831: Adds DT binding document for Richtek RT4831 DSV regulator
Date:   Fri,  4 Dec 2020 00:06:34 +0800
Message-Id: <1607011595-13603-3-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607011595-13603-1-git-send-email-u0084500@gmail.com>
References: <1607011595-13603-1-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Adds DT binding document for Richtek RT4831 DSV regulator.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 .../regulator/richtek,rt4831-regulator.yaml        | 67 ++++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt4831-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt4831-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt4831-regulator.yaml
new file mode 100644
index 00000000..bc1e976
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/richtek,rt4831-regulator.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: GPL-2.0
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
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      rt4831@11 {
+        compatible = "richtek,rt4831";
+        reg = <0x11>;
+
+        regulators {
+          DSVLCM {
+            regulator-min-microvolt = <4000000>;
+            regulator-max-microvolt = <7150000>;
+            regulator-allow-bypass;
+          };
+          DSVP {
+            regulator-name = "rt4831-dsvp";
+            regulator-min-microvolt = <4000000>;
+            regulator-max-microvolt = <6500000>;
+            regulator-boot-on;
+          };
+          DSVN {
+            regulator-name = "rt4831-dsvn";
+            regulator-min-microvolt = <4000000>;
+            regulator-max-microvolt = <6500000>;
+            regulator-boot-on;
+          };
+        };
+      };
+    };
-- 
2.7.4

