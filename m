Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A3F2E0BBF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 15:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbgLVObH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 09:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727702AbgLVObF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 09:31:05 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B809C0611CE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 06:30:20 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id ce23so18482431ejb.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 06:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mamze14+WiY2yuDsLyQBfAVHfVo7/eHBt2nEYPH4G8k=;
        b=P+tLYH814vFy8X3uaUxmmBuEZST3sh4KNwNPw5cq4yyLVZ24CC85n59ejW6iTCaiYy
         DAHXafVb8AK3v3JrYtp9SLr7f8LRQj4BFdPs657AEdq5kIF32i3XyDtcdUcjx9sTY2s1
         glzGUXEZE+OokTrCg518sECumfn6VrTfmItt8zWXPrt2FmNBGOZuJXnG1LweMp/tD7qx
         Ohvro7beW6cCP3+hv3oAGfJt1NxRl8soFq+8IonNseE3bReMCls26YmY2F8LU5finuf9
         VP9anXsQR6qJCDf1QkUG72LwAz4PegUQpowX5/gvoSceZYfGvGTH9khseG3k+2sQXE4X
         hxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mamze14+WiY2yuDsLyQBfAVHfVo7/eHBt2nEYPH4G8k=;
        b=bhBR4uk2lNgrx8h3nDPUkGZreALFyeBZX3FYPFmAA9wpMtBGiVv2xOMNp2nERFFWrs
         +EM23FIhcxNI+D4VBVvuu7gHQVlZyF/3p5HJQYECv8HfkPj5H5w1/pkqX0ABf1vRFq7E
         Pzou2m5jA/BAUOcfswkV26AWWonh+I5auLrPlpsnV642/ke46QqaDBWWusQT+WwPXHpM
         8Mh6zJs4bf2tVn1JabhjnJpU+hSE22oIb18SPRIy45xd6hxqiBir8Tmxjyp1biBInHO/
         E4dyb2p9vOs46C8+DWy6XrevWS8fW8Z8DqP3S62KhlbaTR92yuaCA9DSDn/y53AICsuu
         EBZw==
X-Gm-Message-State: AOAM530vnJIo2snXA9kxS0E/rXSt+Aslr5YjYyU6va8+TdwoxSe1eGfa
        in4+HZ15mjAxOPVzDaHei+Iw8g==
X-Google-Smtp-Source: ABdhPJy1yQdgnSoNPEttYoUC5gC39TEY11L8aFkLEY4st3GwB0I7XW2JNrPkgay34R/PXDk+P2mHYg==
X-Received: by 2002:a17:906:350b:: with SMTP id r11mr20577385eja.143.1608647418876;
        Tue, 22 Dec 2020 06:30:18 -0800 (PST)
Received: from localhost.localdomain (dh207-99-167.xnet.hr. [88.207.99.167])
        by smtp.googlemail.com with ESMTPSA id z1sm8434896edm.89.2020.12.22.06.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 06:30:17 -0800 (PST)
From:   Robert Marko <robert.marko@sartura.hr>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>
Subject: [PATCH v3 1/3] dt-bindings: hwmon: Add TI TPS23861 bindings
Date:   Tue, 22 Dec 2020 15:30:10 +0100
Message-Id: <20201222143012.1618807-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document bindings for the Texas Instruments TPS23861 driver.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Cc: Luka Perkov <luka.perkov@sartura.hr>
---
 .../bindings/hwmon/ti,tps23861.yaml           | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml b/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
new file mode 100644
index 000000000000..a7a801f54398
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/hwmon/ti,tps23861.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI TPS23861 PoE PSE
+
+maintainers:
+  - Robert Marko <robert.marko@sartura.hr>
+
+description: |
+  The TPS23861 is a IEEE 802.3at Quad Port Power-over-Ethernet PSE Controller.
+
+  Datasheets:
+  https://www.ti.com/lit/gpn/tps23861
+
+
+properties:
+  compatible:
+    enum:
+      - ti,tps23861
+
+  reg:
+    maxItems: 1
+
+  shunt-resistor-micro-ohms:
+    description: |
+      The value of curent sense resistor in microohms.
+    items:
+      default: 255000
+      minimum: 250000
+      maximum: 255000
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          tps23861@30 {
+              compatible = "ti,tps23861";
+              reg = <0x30>;
+              shunt-resistor-micro-ohms = <255000>;
+          };
+    };
-- 
2.29.2

