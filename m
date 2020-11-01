Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC592A1B88
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 01:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgKAAoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 20:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgKAAoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 20:44:05 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A5FC0617A6
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 17:44:04 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id v6so12675205lfa.13
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 17:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q0/ioZzVMPStzlXDuEMERl3kgw45PqKAtbxb4+Rn9Zs=;
        b=Ch3f+cBNjkqeed25ynj+IjwEJ8XuJ0RvIuUYYJb8plBWy4ynKdI3NbBBGNQIouH4BR
         IcVSfDU4QTAgTCHgejwILrH5aKJrfGxNhp/WwmDljnu/aLXH/8eO71M8T2zTfK9pyZmP
         vNzIMK7O3QpJClSE62pc7o4tio1oC25eJKY45d2CXgzscLb5IaWoZ4XFtONe2sUzXZkf
         8i5zyYBl0gEwRPi6GCL+1cfmZZVwDnZeRzT+BWZWoCDikghrlaal1niWYQYpVhzak0vh
         tdabzADgQcpwz5RzAu/IvH1hpnfZuetqmFrftbN0h2Q0XZWZqWbGxPGVmTmxqJIgBcVr
         JS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q0/ioZzVMPStzlXDuEMERl3kgw45PqKAtbxb4+Rn9Zs=;
        b=FNC8ykrKAK7Q3wxaYWHOGVkxHTBHzTkfjdkLRYACVy4B+cpcP9N7nVi+JVV73mnScZ
         cIjunj6qgCYD5E76moJy4p1WKDArXsSFi4/kbDvyUciN5z7ny4q9wk6tgrLtcCZhZQhy
         77Ww0pLugGa8N2/Ri4k65IQx8JiOqpRHhaA505UZ0H7em+yMB0TzS3SmERRBAKfc2QCv
         GkotqmAWt4uixaF9iSCU+q+WwfFvOQHfISGBgM0bnF0c5bjqblRu5usMS0gWBcHRYW5N
         xnm8vQSfPbmipHj5ArrOI86JHz1DWn/Cb5QQEIx7NJbb2GuROwM+b3mwvRErwZyjzKBp
         YUcw==
X-Gm-Message-State: AOAM530AVLIMfXibZMPZMN/IyndQ79HYv8fLVY5lzpie2i9r0OSmw1sR
        dVUetmUDL03hU6SN4NHty3yCXA==
X-Google-Smtp-Source: ABdhPJx54vKDZoT1w/hwqn0yF2RmV6gbbuLyOWpQYe6zxTB0Jzh2OM0T/22gY+VgG9P/D0tjWLPBUg==
X-Received: by 2002:a19:e04e:: with SMTP id g14mr3138022lfj.590.1604191443206;
        Sat, 31 Oct 2020 17:44:03 -0700 (PDT)
Received: from localhost.bredbandsbolaget (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id n5sm1178637lfh.164.2020.10.31.17.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 17:44:02 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH 1/2] extcon: fsa9480: Rewrite bindings in YAML and extend
Date:   Sun,  1 Nov 2020 01:43:56 +0100
Message-Id: <20201101004357.1076876-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This rewrites the FSA9480 DT bindings using YAML and
extends them with the compatible TI TSU6111.

I chose to name the file fcs,fsa880 since this is the
first switch, later versions are improvements.

Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../bindings/extcon/extcon-fsa9480.txt        | 21 --------
 .../bindings/extcon/fcs,fsa880.yaml           | 52 +++++++++++++++++++
 2 files changed, 52 insertions(+), 21 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/extcon/extcon-fsa9480.txt
 create mode 100644 Documentation/devicetree/bindings/extcon/fcs,fsa880.yaml

diff --git a/Documentation/devicetree/bindings/extcon/extcon-fsa9480.txt b/Documentation/devicetree/bindings/extcon/extcon-fsa9480.txt
deleted file mode 100644
index 624bd76f468e..000000000000
--- a/Documentation/devicetree/bindings/extcon/extcon-fsa9480.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-FAIRCHILD SEMICONDUCTOR FSA9480 MICROUSB SWITCH
-
-The FSA9480 is a USB port accessory detector and switch. The FSA9480 is fully
-controlled using I2C and enables USB data, stereo and mono audio, video,
-microphone, and UART data to use a common connector port.
-
-Required properties:
- - compatible : Must be one of
-   "fcs,fsa9480"
-   "fcs,fsa880"
- - reg : Specifies i2c slave address. Must be 0x25.
- - interrupts : Should contain one entry specifying interrupt signal of
-   interrupt parent to which interrupt pin of the chip is connected.
-
- Example:
-	musb@25 {
-		compatible = "fcs,fsa9480";
-		reg = <0x25>;
-		interrupt-parent = <&gph2>;
-		interrupts = <7 0>;
-	};
diff --git a/Documentation/devicetree/bindings/extcon/fcs,fsa880.yaml b/Documentation/devicetree/bindings/extcon/fcs,fsa880.yaml
new file mode 100644
index 000000000000..ef6a246a1337
--- /dev/null
+++ b/Documentation/devicetree/bindings/extcon/fcs,fsa880.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/extcon/fcs,fsa880.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Fairchild Semiconductor FSA880, FSA9480 and compatibles
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+description:
+  The FSA880 and FSA9480 are USB port accessory detectors and switches.
+  The switch is fully controlled using I2C and enables USB data, stereo
+  and mono audio, video, microphone, and UART data to use a common
+  connector port. Compatible switches exist from other manufacturers.
+
+properties:
+  compatible:
+    enum:
+      - fcs,fsa880
+      - fcs,fsa9480
+      - ti,tsu6111
+
+  reg:
+    maxItems: 1
+    description: The I2C address for an FSA880 compatible device is
+      usually 0x25.
+
+  interrupts:
+    maxItems: 1
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
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        usb-switch@25 {
+            compatible = "fcs,fsa880";
+            reg = <0x25>;
+            interrupt-parent = <&gpio>;
+            interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
+        };
+    };
-- 
2.26.2

