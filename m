Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2023301CFC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 16:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbhAXPK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 10:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbhAXPJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 10:09:28 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A52CC0613D6;
        Sun, 24 Jan 2021 07:08:48 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 190so8417183wmz.0;
        Sun, 24 Jan 2021 07:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ag6006OGpj/LnO01jq+OCQKPnWe8b0yCa7D0tLaFvmM=;
        b=bPwf4qkir49pVBSitB1Do8De4PPdvI6685ybt24v+l9t1TtNQfcEsur0Je7nsRbi0N
         ILXUQ3ulIGpUzLhgKy+WPEFxCwLT1b6v4C8+l1/VXFl0IqYsJdIHammgIPqadmYW9NtO
         HivSY1nzRSUp7N0BcM8VfZ8eg5dmexoVdKQKWJQmQlBpBIcivKzh42OS0QnUxrX/Vegs
         ey6kH0lP32cZNTosC0JaosIuX7CuaddjOd0C+Cf3cgx4Ve+2WkL9N0GyNMXGq0/Z4o7G
         Glr3CLkxnMFeexWx9pqZ0REXGXhnqQIPOWvLHzrzu2yFUYA2vnPuiX5MHNENvyXvPGI1
         ngCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ag6006OGpj/LnO01jq+OCQKPnWe8b0yCa7D0tLaFvmM=;
        b=UnD7KX2kBJ24AicfKnRfSc0ysRn6goFXHIDBwZkOnUVZYD7AGoSDWDtfTkIzjH7eZ3
         Gw5o+g+yZY4jjLtyTBqWYG/gAZnPmGPktohR36RwnuuHG/s2BcjBlznRuVH33NlhfCdg
         DuBmFVdtF7bUi9PXYsdMXCx+MMq7EKOKFn6ecY2BuQ/CkmJjT53R5yo+/QMEYkPZHmI8
         e3YD66sVZCWSLHvHo6tE+x+6htYkKYpDv9Kpno1Y809pVzmyvoIFA8QpgJwsAtEQPYZY
         DjH1HCno3MCJoQmRQf/gNKD7B2z28TyVywScFIR7c8/0jNk5ludyu+6xr/i6BEehADkM
         WrBQ==
X-Gm-Message-State: AOAM531VfdsWTai5rYd/7W+m0C/99jBgIix6vQER+fjPjNy5qKtn051B
        6gwJExPaOEB1TpfmgS+r13Y=
X-Google-Smtp-Source: ABdhPJzayFhOgFZntgiAOE/EY618MX5PY+t/LDNbQv/eVErJ+86mON1JNnZWa3lXxDa4I2nqJiaAeg==
X-Received: by 2002:a1c:2501:: with SMTP id l1mr12006281wml.41.1611500926916;
        Sun, 24 Jan 2021 07:08:46 -0800 (PST)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd2700e58e9e649f9020b2.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:e58e:9e64:9f90:20b2])
        by smtp.gmail.com with ESMTPSA id m18sm244608wrx.17.2021.01.24.07.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 07:08:46 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        a.hajda@samsung.com, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH 1/2] dt-bindings: display: bridge: Add documentation for LT8912
Date:   Sun, 24 Jan 2021 16:08:34 +0100
Message-Id: <20210124150835.1522899-3-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210124150835.1522899-1-adrien.grassein@gmail.com>
References: <20210124150835.1522899-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lontium LT8912 is a DSI to HDMI bridge.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 .../display/bridge/lontium,lt8912.yaml        | 92 +++++++++++++++++++
 MAINTAINERS                                   |  5 +
 2 files changed, 97 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/lontium,lt8912.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/lontium,lt8912.yaml b/Documentation/devicetree/bindings/display/bridge/lontium,lt8912.yaml
new file mode 100644
index 000000000000..ed1a6ddaab2f
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/lontium,lt8912.yaml
@@ -0,0 +1,92 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/lontium,lt8912.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Lontium LT8912 MIPI to HDMI Bridge
+
+maintainers:
+  - Adrien Grassein <adrien.grassein@gmail.com>
+
+description: |
+  The LT8912 is a bridge device which convert DSI to HDMI
+
+properties:
+  compatible:
+    enum:
+      - lontium,lt8912
+
+  reg:
+    maxItems: 1
+
+  ddc-i2c-bus:
+    maxItems: 1
+    description: i2c bus used to read EDID of the connected display.
+
+  dsi-lanes:
+    maxItems: 1
+    description: dsi lanes count interconnected with lt8912.
+
+  reset-gpios:
+    maxItems: 1
+    description: GPIO connected to active high RESET pin.
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          Primary MIPI port-1 for MIPI input
+
+    required:
+      - port@0
+
+required:
+  - compatible
+  - ddc-i2c-bus
+  - dsi-lanes
+  - reg
+  - reset-gpios
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c4 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      hdmi-bridge@48 {
+        compatible = "lontium,lt8912";
+        reg = <0x48>;
+        reset-gpios = <&max7323 0 GPIO_ACTIVE_LOW>;
+        dsi-lanes = <4>;
+        ddc-i2c-bus = <&ddc_i2c_bus>;
+
+        ports {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          port@0 {
+            reg = <0>;
+
+            hdmi_out_in: endpoint {
+              remote-endpoint = <&mipi_dsi_out>;
+            };
+          };
+        };
+      };
+    };
+
+    ddc_i2c_bus: i2c5 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 5aa18cbfb883..01e7e356bfac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10472,6 +10472,11 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git
 F:	drivers/hid/hid-lg-g15.c
 
+LONTIUM LT8912 MIPI TO HDMI BRIDGE
+M:	Adrien Grassein <adrien.grassein@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/bridge/lontium,lt8912.yaml
+
 LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
 M:	Sathya Prakash <sathya.prakash@broadcom.com>
 M:	Sreekanth Reddy <sreekanth.reddy@broadcom.com>
-- 
2.25.1

