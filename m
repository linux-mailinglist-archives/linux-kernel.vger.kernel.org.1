Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC5326951D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 20:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgINSmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 14:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgINSl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 14:41:58 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF0EC061788
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 11:41:58 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id w7so332537pfi.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 11:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=olcKWgb6ooi9Ty9EcmRaxmtzPxvqeZ6aV/XLm2hKVeM=;
        b=BAC+RbLdruZMEHX4dAFpJZ1BCwYAkAoGs7nFPcR+Obtj1OiEL8VRJqKeOUF/9TA7UO
         ND91uFF1Uw+ZFumLCyAY9ceION7Pz2nhuMWlkxVzeFY6cg9Bw1ZH56mYnYqL45WL8jpz
         m96kieoNlLC7GOyErIt3SScX6e80niz6HQXQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=olcKWgb6ooi9Ty9EcmRaxmtzPxvqeZ6aV/XLm2hKVeM=;
        b=eKXi9glMbvlMspXKxfKUV434tBrx4WuoFhuLUr6OVIsohed/3LSJLCAVkkANdwWppW
         vQOX7XSY2vpXPG9dl3s43VYk+rQWj1hrt/uzLcAGDauSP9dzUaPPzJEUvd8vUsBJ9gzy
         Dq2CXPH4zIFkZJWuTJ0cCCYIyefy6vEQfAmE+UG0e+eDR0p90rH6pC+tmu3wZJdGoq8f
         kCVaTD2vzVfV9u0kxfhCtyMELcxSC9vy4fpOBbK0CtXvuDsfpf2peqafZOhsXz7Lu1x8
         qWJrrrYLrJ0X9I/mLIMvrMYOEEOfHmQFXoMjyba5GwmGmEBucdPhM5xhOsfftqq+2mN6
         BMZw==
X-Gm-Message-State: AOAM530nDXAxQc+HEzmTfdHqIvbbjgWQI0+wJfKRvytXaXFg9ioZ+1ee
        gjhUQHTu/WXU8dWqt086RXIl3g==
X-Google-Smtp-Source: ABdhPJzdnekzhydVGrQOLgzl7NM/wiqfSpOONbDlXV8bvtYn5xyc1HJosD+o5yVKPw22BvNZ5TNrXA==
X-Received: by 2002:a65:6412:: with SMTP id a18mr12096545pgv.215.1600108917475;
        Mon, 14 Sep 2020 11:41:57 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id n128sm8931875pga.5.2020.09.14.11.41.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 11:41:56 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        linux-usb@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Peter Chen <peter.chen@nxp.com>, linux-kernel@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 1/2] dt-bindings: usb: Add binding for onboard USB hubs
Date:   Mon, 14 Sep 2020 11:27:48 -0700
Message-Id: <20200914112716.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Onboard USB hubs need to be powered and may require initiaization of
other resources (like GPIOs or clocks) to work properly. This adds
a device tree binding for these hubs.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 .../bindings/usb/onboard_usb_hub.yaml         | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml

diff --git a/Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml b/Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml
new file mode 100644
index 000000000000..f82d8f459eed
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/onboard_usb_hub.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Binding for onboard USB hubs
+
+maintainers:
+  - Matthias Kaehlcke <mka@chromium.org>
+
+allOf:
+  - $ref: /schemas/usb/onboard_usb_hub.yaml#
+
+properties:
+  compatible:
+    enum:
+      - onboard-usb-hub
+      - realtek,rts5411
+
+  power-off-in-suspend:
+    description:
+      The hub should be powered off during system suspend. When the
+      "wakeup-source" property is also provided the hub is only powered
+      off during suspend when no wakeup capable descendants are connected.
+    type: boolean
+
+  vdd-supply:
+    description:
+      phandle to the regulator that provides power to the hub.
+
+  wakeup-source:
+    description:
+      Wakeup capable USB devices connected to this hub can be used as
+      wakeup source.
+    type: boolean
+
+required:
+  - compatible
+  - vdd-supply
+
+examples:
+  - |
+    usb_hub: usb-hub {
+        compatible = "realtek,rts5411", "onboard-usb-hub";
+        vdd-supply = <&pp3300_hub>;
+        power-off-in-suspend;
+        wakeup-source;
+    };
+
+    &usb_1_dwc3 {
+	dr_mode = "host";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	/* 2.0 hub on port 1 */
+	hub@1 {
+		compatible = "usbbda,5411";
+		reg = <1>;
+		hub = <&usb_hub>;
+	};
+
+	/* 3.0 hub on port 2 */
+	hub@2 {
+		compatible = "usbbda,411";
+		reg = <2>;
+		hub = <&usb_hub>;
+	};
+
+...
-- 
2.28.0.618.gf4bc123cb7-goog

