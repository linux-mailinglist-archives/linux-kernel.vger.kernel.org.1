Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6762E6EBA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 08:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgL2HUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 02:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgL2HUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 02:20:48 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE86C061793;
        Mon, 28 Dec 2020 23:20:08 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id h10so6613540pfo.9;
        Mon, 28 Dec 2020 23:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kBEBtsW2irgq6PGYdUQwTOTY6n0Khj2SouVUPR5ajI0=;
        b=oacOvtUvxf7jxRJ/HEMrMmiOOr6gPzz9mzltJf8SLX+oPOsMBVirvWTn0V2WE2fVzB
         CIDhyg5PKVt+hiaHjnl0wJ+If4nLL/jZGwiO3+9a69aQP8fSPIhKNe2F+30jOVsl6RIG
         CenQTMBvgM7b+bjolrV7ZfWWTvi78yyuiat0Rt7XbFB3r7lzhbkSO5iivPcE+aiDkS3T
         HLPfBqtr5RXzKux+layJ7epR33BuQOHtpHcsY4Vlngk2pgbcZ3zSU2vdfqx8JTflQ2fu
         A4yeWablM2Vq9uSgLseNbbuS2jwo0MggA4ydGgHxMhlIBw2/HvCZh7klwse4b7JIBbG+
         t1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kBEBtsW2irgq6PGYdUQwTOTY6n0Khj2SouVUPR5ajI0=;
        b=Cxwdck/bX6633Scr6/Wj1gqpcNyOWdpo5t5F5lc0CEJR1zmpK6zpiSK753RimXYWoL
         CD8ifZvKwaPyeqqFWXqEJBqQ5JcKOsPA3UYYkfSlq9u+8+TrdeC1N8UPfLyOc92jXkD5
         vSEjvPuhNa5TP1THYeJOgFf82GFeitdzm7UhH2TTbk0O1Tl29ubm5nmnSUNW4dye8q5H
         v59sZgL9MGQe4nA56IEYB3H0yu3QLlQ04GTd4IWI4Bf6CDg7Bs3tPO3xG0Syg/FYqRIn
         IB8rPy53f6634aHIGFntWRzpmjrPt2hxCsOG18+VrLDKocOerh7GSj+H8VINMEUmKw9m
         8rXg==
X-Gm-Message-State: AOAM530mlX+74OQOX24R3JJDqaXonuMSY0+DVvwMBfaYbfNnky/5s66h
        G+M3iaIW0htCv6k+WrovjdJdEQZGsm4=
X-Google-Smtp-Source: ABdhPJwXaCBQh5JeWVe6+nZE7Wrt6Q3eygPmDknt2GMHLy0SPvbERa8SrgSpu65WMOK9c+qpjR2fgg==
X-Received: by 2002:a05:6a00:816:b029:198:30d:e020 with SMTP id m22-20020a056a000816b0290198030de020mr44670060pfk.52.1609226407364;
        Mon, 28 Dec 2020 23:20:07 -0800 (PST)
Received: from charles-System-Product-Name.dhcpserver.local (220-135-135-179.HINET-IP.hinet.net. [220.135.135.179])
        by smtp.googlemail.com with ESMTPSA id q70sm1838943pja.39.2020.12.28.23.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 23:20:06 -0800 (PST)
From:   Charles Hsu <hsu.yungteng@gmail.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org
Cc:     Charles Hsu <hsu.yungteng@gmail.com>
Subject: [PATCH] dt-bindings: (hwmon/pm6764tr) Add PM6764TR hwmon driver bindings
Date:   Tue, 29 Dec 2020 15:17:23 +0800
Message-Id: <20201229071723.2219360-1-hsu.yungteng@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document device tree bindings for STMicroelectronics PM6764tr Voltage
Regulator.

Signed-off-by: Charles Hsu <hsu.yungteng@gmail.com>
---
 .../bindings/hwmon/pmbus/st,pm6764tr.yaml     | 47 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  2 +
 2 files changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/pmbus/st,pm6764tr.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/pmbus/st,pm6764tr.yaml b/Documentation/devicetree/bindings/hwmon/pmbus/st,pm6764tr.yaml
new file mode 100644
index 000000000000..b4b0d5614d8d
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/pmbus/st,pm6764tr.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/hwmon/pmbus/st,pm6764tr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PM6764TR voltage regulator
+
+maintainers:
+  - Charles Hsu <hsu.yungteng@gmail.com>
+
+description: |
+  The PM6764/66 is a high performance digital controller designed to power
+  Intel’s VR12.5 processors (PM6766) and memories (PM6764): all required
+  parameters are programmable through a PMBus™ interface.
+  The device utilizes digital technology to implement all control and
+  power management functions to provide maximum flexibility and performance.
+  The NVM is embedded to store custom configurations.
+
+  https://www.st.com/resource/en/data_brief/pm6764.pdf
+
+properties:
+  compatible:
+    enum:
+      - st,pm6764tr
+
+  reg:
+    maxItems: 1
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
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pm6764tr@68 {
+            compatible = "st,pm6764tr";
+            reg = <0x68>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index bdc2dc318178..0a2dcd03220b 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -260,6 +260,8 @@ properties:
           - socionext,synquacer-tpm-mmio
             # i2c serial eeprom  (24cxx)
           - st,24c256
+            # STMicroelectronics Voltage Regulator
+          - st,pm6764tr
             # Ambient Light Sensor with SMBUS/Two Wire Serial Interface
           - taos,tsl2550
             # Temperature Monitoring and Fan Control
-- 
2.25.1

