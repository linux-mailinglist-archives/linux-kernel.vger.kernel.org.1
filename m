Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1F91F356E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 09:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgFIHtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 03:49:09 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:19367 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgFIHtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 03:49:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1591688947; x=1623224947;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z9fxhQY3z4ehjLCF3109NrNvK62lTfFTjodG2LyrA/M=;
  b=Zw7gR6yc9IM3FBGzB+jGHFY/DqFb108rA/toHTVZvV8YRcNMheeBbg81
   hvjapV83HX0RddGKlJknpdLDylI7Zt7fIVPEw09kRY/yqAmOxsVXZpIyr
   4dS+nPRoK/+S+spUSEfkEr1AWQ5TPPoGg8ZY3McfMAo6lQjmd4z66lneL
   F2dOn05tXG4/V+yWe3taJ0kgZBbEIwRfGImAWTMsuuWO8FjKrlpjwuJ4D
   1Ywpq9lvtNCEzuugsQnnDk9q6E3WE+lFqyY+zwWG5uEAwePuLzVQLW8jC
   OdaZHz8IAgY6CoDEIPrnmlOMHQRJklEM1SQDoNWkHQtvzLDTe28VMryxr
   w==;
IronPort-SDR: TpvI0lSXmxb1sJfVs+cknweLXfAeBY11r03cwlBbUzm2OmL6NKuCWYbAxk5p32STuoT4DuO+Uk
 i21lDVrdXXdqWM8KQ8jw7My8fchB8Tbda4OPlIJk/BLHx/qyjN4+VJcMYcDzkIi7rEuLQZQqL3
 u6JEnr+zgelXlloQ0u/EAtr0/UcLHKu8fagNvwabOX8FOdJ87cI2dK/a6L0smKCSTZnTIH1mIi
 0zplBDVzwFZ5nlJygP+A+Jpo5WZ979uss4aHAtu9Gko/3aOgTsVi2Ri58w43sMDnyCTJB5vwK9
 36o=
X-IronPort-AV: E=Sophos;i="5.73,490,1583218800"; 
   d="scan'208";a="75943736"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jun 2020 00:49:06 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Tue, 9 Jun 2020 00:49:06 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Tue, 9 Jun 2020 00:49:03 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Jean Delvare <jdelvare@suse.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 1/3] dt-bindings: hwmon: Add Sparx5 temperature sensor
Date:   Tue, 9 Jun 2020 09:48:59 +0200
Message-ID: <20200609074859.9385-1-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609072828.9088-1-lars.povlsen@microchip.com>
References: <20200609072828.9088-1-lars.povlsen@microchip.com>
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
2.27.0
