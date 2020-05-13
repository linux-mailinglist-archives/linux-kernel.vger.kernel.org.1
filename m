Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5971D1607
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 15:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388127AbgEMNlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 09:41:52 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:46432 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgEMNlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:41:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589377310; x=1620913310;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qlFyZReVo2pHOVk2iDuspF2CVGNtSezC+5qbLU9vpWA=;
  b=K13d63UmH//ZG/kFwYbMKQ80Y0GuFIXdquLFowkJNAUO2DRIfu6FoNDn
   2BM0bYZDnq3CstM0LwTon3mu788KRSpUKiNvEwK373+Bjo3r2OckQmTsk
   iRYtpPVxHGyh3bf/ck3OF73OOEjhZq1QwKyWWLnh9Vy8n15XIKmG52Dyd
   z1XhFnXEpUsiWLqkvE3o+3ipEfszUhpc+Upet1+0ggEVN7cEqwIHvlD0v
   xbTn3zneC8jJfLbTIVlCElX0Zdud8vXytSOULUK+N0bR7PiSqMIZ4LqVN
   /5d5fP/6QaV3l9bD5EHyV+k9QQqboiCEZ2zOPZVKKlEHV4tKhJg2EwNMG
   Q==;
IronPort-SDR: 3n7GItFr3OrwIchwpxNLWuuQkrXHfun+GhFttMmeaLVJMnOp9ZBHwobBZCyag9KxKTqnTiaiFS
 M0gd+bu2OZ5ln49vNO8xvQqP3xKN2++LVxFjwqq1JkiRPZOSL2gHjhU5+vlQbWT1XRy+Vz5nF4
 9N8LfTNwynF3unssGanacMGljwKV+F6t6eM045FIaFselBxXGR+VdUDuF88JBFiXSO2U9w3mw8
 4YT0Vqy+GGcknlv8ZIHBXeZXAsfWYrMUGJkJHipIU1/ya8X4I9JUrjBhEPJzAveapCDwfdSNjt
 Tro=
X-IronPort-AV: E=Sophos;i="5.73,387,1583218800"; 
   d="scan'208";a="79444211"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 May 2020 06:41:50 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 May 2020 06:41:52 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Wed, 13 May 2020 06:41:50 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Guenter Roeck <linux@roeck-us.net>, SoC Team <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Jean Delvare <jdelvare@suse.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/3] dt-bindings: hwmon: Add Sparx5 temperature sensor
Date:   Wed, 13 May 2020 15:41:38 +0200
Message-ID: <20200513134140.25357-2-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513134140.25357-1-lars.povlsen@microchip.com>
References: <20200513134140.25357-1-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This add the DT binding specification for the Sparx5 temperature
sensor.

Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 .../bindings/hwmon/microchip,sparx5-temp.yaml | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/microchip,sparx5-temp.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/microchip,sparx5-temp.yaml b/Documentation/devicetree/bindings/hwmon/microchip,sparx5-temp.yaml
new file mode 100644
index 0000000000000..0df4813fd7b24
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/microchip,sparx5-temp.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/microchip,sparx5-temp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip Sparx5 Temperature Monitor
+
+maintainers:
+  - Lars Povlsen <lars.povlsen@microchip.com>
+
+description: |
+  Microchip Sparx5 embedded temperature monitor
+
+properties:
+  compatible:
+    enum:
+      - microchip,sparx5-temp
+
+  reg:
+    maxItems: 1
+
+  '#thermal-sensor-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    tmon0: tmon@610508110 {
+        compatible = "microchip,sparx5-temp";
+        reg = <0x10508110 0xc>;
+        #thermal-sensor-cells = <0>;
+    };
+
--
2.26.2
