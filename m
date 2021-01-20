Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0330F2FCFC5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 13:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388534AbhATLoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 06:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbhATL3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 06:29:51 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E876C0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 03:22:18 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id t29so9191741pfg.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 03:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/G1XKKzyK0yZAshK+VzVtT1gmvcbma2qBK0WNAjoFJ0=;
        b=f9QxSmeFNcQFQsw7hS5QGeGaJxyqhXGEzo3QbjXqM2wj4ArTB1aEOtGsbeRw0Cfry7
         Z/DoOVbz6XFlRGziXkPIHVr5CDG77H52tQekRcbd3EoBJSieaNdq4sOUvO8lrRzd6C3A
         D3KVS+yS1pwtyYt8XtxYOSAZdhSj7wr23Llrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/G1XKKzyK0yZAshK+VzVtT1gmvcbma2qBK0WNAjoFJ0=;
        b=U3VESfYMp0LebxrgCGZ9qX0pJxUQ2v1LAXN4zV4DR+CS4LUtnCuXkxwKCE3qD7D00t
         wJrhgj8F3DEwZKo3DNIsF/ejef4guTMg7qP+0OxxA92gKZLNThqVpjCR77K4pysw7ZS/
         tpnPqHBa/XP5CG53BKYreRPTvU90jhsip9hx/OoVH7gySSuSQHiI/AbPvJjEaTL6Z0n2
         +oH3YuYn+tcm6HmwVnGII6UwOrQB/hcZMnxJyeCnWz9ie/ReN5Ar4MurhYlQF3cjVx4O
         gWClwyiuDnAgp/12AYv6FlPaUrsJUIqg6El5p2cH5W6gMpTV1mWWX7mpG7koAED7D0A4
         56NA==
X-Gm-Message-State: AOAM53229gw8oThSn4qxXFPQ9hLfZ3/bXKnsXjegTEHSguJRiF6sd6lB
        Uy+rzjqiE8bGfDvkIURGV3hGNg==
X-Google-Smtp-Source: ABdhPJwEhxynnzNsfdOIosnWD6hJRmKWPIAg2bWTvI3yFlUc2LWW0ORKLS7qvfBc2J2WLYigePeAKg==
X-Received: by 2002:a65:4083:: with SMTP id t3mr8967439pgp.150.1611141737943;
        Wed, 20 Jan 2021 03:22:17 -0800 (PST)
Received: from ub-XPS-13-9350.domain.name ([103.105.103.154])
        by smtp.gmail.com with ESMTPSA id gk2sm2248341pjb.6.2021.01.20.03.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 03:22:17 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 1/2] dt-bindings: display: bridge: Add documentation for SN65DSI84
Date:   Wed, 20 Jan 2021 16:51:57 +0530
Message-Id: <20210120112158.62109-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SN65DSI84 is a Single Channel DSI to Dual-link LVDS bridge from
Texas Instruments.

SN65DSI83, SN65DSI85 are variants of the same family of bridge
controllers.

Right now the bridge driver is supporting a single link, dual-link
support requires to initiate I2C Channel B registers, so dt-bindings
documented with single link LVDS.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../bindings/display/bridge/ti,sn65dsi84.yaml | 127 ++++++++++++++++++
 1 file changed, 127 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/ti,sn65dsi84.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi84.yaml b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi84.yaml
new file mode 100644
index 000000000000..891382a76c1a
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi84.yaml
@@ -0,0 +1,127 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/ti,sn65dsi84.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI SN65DSI84 MIPI DSI to LVDS bridge bindings
+
+maintainers:
+  - Jagan Teki <jagan@amarulasolutions.com>
+
+description: |
+  The SN65DSI84 DSI to FlatLink bridge features a single channel MIPI D-PHY receiver
+  front-end configuration with 4 lanes per channel operating at 1 Gbps per lanes.
+  The bridge decodes MIPI DSI 18bpp RGB666 and 240bpp RG888 packets and converts
+  the formatted video data stream to a FlatLink compatible LVDS output operating
+  at pixel clocks operating from 25 MHx to 154 MHz, offering a Dual-Link LVDS,
+  Single-Link LVDS interface with four data lanes per link.
+
+  https://www.ti.com/product/SN65DSI84
+
+properties:
+  compatible:
+    const: ti,sn65dsi84
+
+  reg:
+    maxItems: 1
+    description: i2c address of the bridge, 0x2c
+
+  enable-gpios:
+    maxItems: 1
+    description: GPIO specifier for bridge enable pin (active high).
+
+  ports:
+    type: object
+    description:
+      A node containing input and output port nodes with endpoint definitions
+      as documented in
+      Documentation/devicetree/bindings/media/video-interfaces.txt
+    properties:
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
+      port@0:
+        type: object
+        description: |
+          DSI Input. The remote endpoint phandle should be a
+          reference to a valid mipi_dsi_host device node.
+
+      port@1:
+        type: object
+        description: |
+          Video port for LVDS output (panel or connector).
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - reg
+  - enable-gpios
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+       #address-cells = <1>;
+       #size-cells = <0>;
+
+       ports {
+           #address-cells = <1>;
+           #size-cells = <0>;
+
+           port@0 {
+               reg = <0>;
+               dsi_in: endpoint {
+                   remote-endpoint = <&ltdc_ep0_out>;
+               };
+           };
+
+           port@1 {
+               reg = <1>;
+               dsi_out: endpoint {
+                   remote-endpoint = <&bridge_in>;
+                   data-lanes = <0 1>;
+               };
+           };
+       };
+    };
+
+    i2c6 {
+       #address-cells = <1>;
+       #size-cells = <0>;
+
+       bridge@2c {
+           compatible = "ti,sn65dsi84";
+           reg = <0x2c>;
+           enable-gpios = <&gpiof 15 GPIO_ACTIVE_HIGH>;
+
+           ports {
+               #address-cells = <1>;
+               #size-cells = <0>;
+
+               port@0 {
+                   reg = <0>;
+                   bridge_in: endpoint {
+                        remote-endpoint = <&dsi_out>;
+                   };
+               };
+
+               port@1 {
+                   reg = <1>;
+                   bridge_out: endpoint {
+                        remote-endpoint = <&panel_in_lvds>;
+                   };
+               };
+           };
+       };
+    };
-- 
2.25.1

