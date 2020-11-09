Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A086B2AC75E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 22:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730902AbgKIVhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 16:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730699AbgKIVhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 16:37:31 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A414C0613D4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 13:37:30 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id i26so8272014pgl.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 13:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IVG/pnqU/rZNPf8FUWkusV/y8FFNBFgXush0QW0Xq5w=;
        b=KmSITxLJGqcCJ45deGdKGXIPpYDMb6vveRBn1HOVY6jEMgcT+ifQdB3G0Nal6I+V47
         nSTUsnLUcQhMQAjWPDB5ap8OQYBYrtawZVjHw2D3ju1AoPvSRxJdOZ9mARnXlcbQxadC
         JD2D6wyu2ywUArSYM5EzsEt9IEcySkh9UqOds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IVG/pnqU/rZNPf8FUWkusV/y8FFNBFgXush0QW0Xq5w=;
        b=Bt4nrk168GoOzLlqKKgVz2s5OKHDPfgbsS3JWYLr9pgPN83ShHZtJk/iIwmCwGWUpt
         PLILExWTLPI/e0Lf60KpiHLDl5XVV9EqqorpWnSyeyhR2hWi25v2rHqxb7gh0WwWJshw
         4Z6X2gETprnNFMmRWfL1FQ7UwozIDwDRa+oQexzieZ0CuWgGWszC5KXFj1NiFEaU7Ay4
         rv7sWpQUsRBngFp+UwWNucPNwbMRHsnA+KsVQ7QjVOoVdKomFpHtMRW9PYXMLluX3xud
         9vJCDCc8fvhhX/5N784lnrHlXj4FyLmyrAc78a+aosq+9/NXn5LBY4BSK9ev45wnRJBo
         Sskg==
X-Gm-Message-State: AOAM532pe70raUePh9eUwLMee25zT6tbslDqFWugGLSciJnRxq+rJRcN
        S3oRx+yBQ8dkR7lsQ0p/JxLJcg==
X-Google-Smtp-Source: ABdhPJzzp3X12Puhdm2/cXoL8BUDk0MNJMipPzxDxixAaij3gk3beeDcDcKSGToa7LMwwY12Zd1gUw==
X-Received: by 2002:a63:134d:: with SMTP id 13mr14444377pgt.370.1604957849726;
        Mon, 09 Nov 2020 13:37:29 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id i10sm11895444pfd.60.2020.11.09.13.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 13:37:29 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     jkosina@suse.cz, benjamin.tissoires@redhat.com,
        gregkh@linuxfoundation.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     kai.heng.feng@canonical.com, hdegoede@redhat.com,
        robh+dt@kernel.org, linux-input@vger.kernel.org,
        swboyd@chromium.org, andrea@borgia.bo.it,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/4] dt-bindings: input: HID: i2c-hid: Introduce bindings for the Goodix GT7375P
Date:   Mon,  9 Nov 2020 13:36:35 -0800
Message-Id: <20201109133526.v5.3.Ibb28033c81d87fcc13a6ba28c6ea7ac154d65f93@changeid>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
In-Reply-To: <20201109213636.1267536-1-dianders@chromium.org>
References: <20201109213636.1267536-1-dianders@chromium.org>
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
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes in v5:
- Added mention of i2c-hid in the yaml itself as per Rob.
- Adjusted subject as per Rob.

Changes in v3:
- Fixed compatible in example.
- Removed Benjamin as a maintainer.
- Updated description.

Changes in v2:
- ("dt-bindings: HID: i2c-hid: Introduce bindings for the Goodix GT7375P") new in v2.

 .../bindings/input/goodix,gt7375p.yaml        | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/goodix,gt7375p.yaml

diff --git a/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml b/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
new file mode 100644
index 000000000000..fe1c5016f7f3
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/goodix,gt7375p.yaml
@@ -0,0 +1,65 @@
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
+  This touchscreen uses the i2c-hid protocol but has some non-standard
+  power sequencing required.
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
2.29.2.222.g5d2a92d10f8-goog

