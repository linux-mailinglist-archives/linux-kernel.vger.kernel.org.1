Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F822CC852
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 21:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgLBUtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 15:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbgLBUtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:49:12 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7787C0613D6;
        Wed,  2 Dec 2020 12:48:31 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id f18so5370321ljg.9;
        Wed, 02 Dec 2020 12:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bQ41yXPCzyc4rNgsjGF9t3P1AEjo8KqwyR3/fv/WAlQ=;
        b=BlbAgyO/yVvZ38qWux4QCFfKoF/jE9OvnC2MXzEiKP5YO6Vu2KcH9D1XNfN8/i+96S
         tQQtYpPYypsLdZwaPi8hhZSrJBnY0tUcZ96S44stctGV/3llJk2UgA+yTUsXOhwCZ3NY
         Fa7qA6Wdy9VgpiGzld7et7QOImWg+8PPbM+TCK3KcP6thHjBTMAzVn4kdVWzAn4a6C9z
         zF++phOKlxdgb4zUZkwLRbnVbPrpcSyoA9Sjs8vpjL2R+zlQPNgTWnSSFmp0ygYdsPmW
         /tHFzPRWkU9KV+SX/XAF/laDifDuika0voNa5bKwcKPpwcAabDZZyjJb2nCYBTDhuiRV
         it6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bQ41yXPCzyc4rNgsjGF9t3P1AEjo8KqwyR3/fv/WAlQ=;
        b=gIvcMAOYmrnjYfHXsbjVij1kqXSEQJFJnfUrBFPWn04T6kv5o6TE4uNj+tMW67FOEI
         hBnZAvkW0Tlv9GMIlHGWBi7ykqby4dkulwI6B8Fkx9+x03ORlql9D2ly54K4t7vJWzBP
         4RpGsfQm3jaUbwZzIqwZLDameYbrqA28g3j4JNaftLA5TqWmCYmcv6VUIBQcZcW+HTtg
         ovTvanZgx8gDBhGNb1M4mknNwgtxzP5u8wjltRvnYxaRUsWPX5R2Zb8qDStQOjavH5Xd
         CQtpgZdlcQAtXLB+fw605pmwr3Tq6RwY1Uf9tzDwuA9AUfFURtxR6RdcoxkR8ViSWwQr
         nTVw==
X-Gm-Message-State: AOAM533lEhs9RJomiKe01B6DBDmhexgBs5qiGui36xRcmH5110JtrDir
        H6LCFo3HwHiqptSU6GXatgo=
X-Google-Smtp-Source: ABdhPJxfpxsYYpJU9I1mejOZBG8lo/GDvNwn9rq4pahZX3siTxwIyzOV2VK7uqT3rKHZFm90KRoORg==
X-Received: by 2002:a2e:9707:: with SMTP id r7mr1918941lji.265.1606942110406;
        Wed, 02 Dec 2020 12:48:30 -0800 (PST)
Received: from elitebook.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id r66sm801503lff.265.2020.12.02.12.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 12:48:29 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Simon Arlott <simon@octiron.net>,
        =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>, Al Cooper <alcooperx@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 1/2] dt-bindings: phy: Add binding for BCM4908 USB PHYs
Date:   Wed,  2 Dec 2020 21:46:48 +0100
Message-Id: <20201202204649.25314-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

BCM4908 SoCs have USB 2.0 PHY and USB 3.0 PHY attached to the MDIO bus.
Those bindings allow describing them.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../bindings/phy/bcm4908-usb-phy.yaml         | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/bcm4908-usb-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/bcm4908-usb-phy.yaml b/Documentation/devicetree/bindings/phy/bcm4908-usb-phy.yaml
new file mode 100644
index 000000000000..2bf5dcb58c1e
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/bcm4908-usb-phy.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/bcm4908-usb-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM4908 USB PHYs
+
+description: >
+  This binding describes USB PHYs used in BCM4908 family SoCs.
+
+maintainers:
+  - Rafał Miłecki <rafal@milecki.pl>
+
+properties:
+  compatible:
+    enum:
+      - brcm,bcm4908-usb2-phy
+      - brcm,bcm4908-usb3-phy
+
+  reg:
+    items:
+      - description: PHY MDIO address
+
+  "#phy-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        phy@0 {
+            compatible = "brcm,bcm4908-usb2-phy";
+            reg = <0x0>;
+            #phy-cells = <0>;
+        };
+
+        phy@1 {
+            compatible = "brcm,bcm4908-usb3-phy";
+            reg = <0x1>;
+            #phy-cells = <0>;
+        };
+    };
-- 
2.26.2

