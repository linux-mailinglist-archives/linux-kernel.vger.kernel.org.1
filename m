Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D912A3783
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 01:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgKCANH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 19:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgKCANG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 19:13:06 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F025C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 16:13:06 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id c20so12635030pfr.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 16:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ul60m8IIifIpsjtzly1RX3b0Mhagmr0FW1v0DBlxPWM=;
        b=jY5Q8JclUFiAoBChIhkGBbS90jE7o3/dAeA4p/e4qn6P8SsrmXG0w4skVppW/BQhvv
         khKSjL5cxTk2wXIFMFwT8yUv1FGUiFUx/Q+4ju+c0Lo+4AtlPvaABFgeW7ad3CMb6zue
         1jtGTjxHgxkCEG1rPtWPqErqxD9TbxvNGbA9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ul60m8IIifIpsjtzly1RX3b0Mhagmr0FW1v0DBlxPWM=;
        b=BUtPTyIYIJoPnz9H9Aq8y67Bv2lwQwMJxzanbPiG0luu1g0J0ZsTld+2PIGyvE/uTK
         4oOOxNQoPfBD/4r0L2J2JF+mhOV0WAx8enwKgyqy3iN1XyWLG6O9jOLeaJ3Vo3HUzQex
         Kwgwem2eOw7PP7klB+CBKsaaFWWlCACqOKFa+rGnfH0qJyzuGtOZ0x4z/XQTmZ9Gz/d4
         +BcdCtYnt8GRXV8LBQ5bak1U0z3t/LzNonDC99IRf0oARJVp0j4BTaLGiawbNKsa60HY
         gnCv4HHmhBuAndIpqJwOCOVP7RJ2H9MjmFZsGXfpWP1lMH+iU07bV9tWvkW+OEW1/qkW
         7eYg==
X-Gm-Message-State: AOAM533KumCyaeW+BLqWTlGWVIwIC4SwxiqWvSH1yuqMs8NMlPZnrv5j
        NhaSgMiH6RwlGWVXAwaLBphElw==
X-Google-Smtp-Source: ABdhPJxkQVlo9EYqQ/2jCNcyo/uISGLN7g69m9FLLkoR3y97vih5lpL8suUZi0POIuEfbRffv3skrw==
X-Received: by 2002:a63:4707:: with SMTP id u7mr14396862pga.358.1604362385897;
        Mon, 02 Nov 2020 16:13:05 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id v16sm13244295pgk.26.2020.11.02.16.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 16:13:05 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     jkosina@suse.cz, benjamin.tissoires@redhat.com,
        gregkh@linuxfoundation.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, hdegoede@redhat.com,
        swboyd@chromium.org, kai.heng.feng@canonical.com,
        robh+dt@kernel.org, andrea@borgia.bo.it,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] dt-bindings: HID: i2c-hid: Introduce bindings for the Goodix GT7375P
Date:   Mon,  2 Nov 2020 16:12:39 -0800
Message-Id: <20201102161210.v3.1.Ibb28033c81d87fcc13a6ba28c6ea7ac154d65f93@changeid>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds new bindings for the Goodix GT7375P touchscreen.  While this
touchscreen's communications are based on the generic "i2c-over-hid"
protocol, it needs special power sequencing and thus gets its own
compatible and bindings.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- Removed Benjamin as a maintainer.
- Fixed compatible in example.
- Updated description.

Changes in v2:
- ("dt-bindings: HID: i2c-hid: Introduce bindings for the Goodix GT7375P") new in v2.

 .../bindings/input/goodix,gt7375p.yaml        | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/goodix,gt7375p.yaml

diff --git a/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml b/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
new file mode 100644
index 000000000000..15a38516e594
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/goodix,gt7375p.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Goodix GT7375P touchscreen
+
+maintainers:
+  - Douglas Anderson <dianders@chromium.org>
+
+description:
+  Supports the Goodix GT7375P touchscreen.
+
+properties:
+  compatible:
+    items:
+      - const: goodix,gt7375p
+
+  reg:
+    enum:
+      - 0x5d
+      - 0x14
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    true
+
+  vdd-supply:
+    description: The 3.3V supply to the touchscreen.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - reset-gpios
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      ap_ts: touchscreen@5d {
+        compatible = "goodix,gt7375p";
+        reg = <0x5d>;
+
+        interrupt-parent = <&tlmm>;
+        interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
+
+        reset-gpios = <&tlmm 8 GPIO_ACTIVE_LOW>;
+        vdd-supply = <&pp3300_ts>;
+      };
+    };
-- 
2.29.1.341.ge80a0c044ae-goog

