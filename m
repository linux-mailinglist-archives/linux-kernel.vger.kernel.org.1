Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E27D29E7A7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 10:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgJ2JqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 05:46:03 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:62026 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726607AbgJ2Jp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 05:45:59 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09T9jXpK005056;
        Thu, 29 Oct 2020 05:45:46 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 34ce462q0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Oct 2020 05:45:45 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 09T9ji32023819
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 29 Oct 2020 05:45:44 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 29 Oct
 2020 05:45:43 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 29 Oct 2020 05:45:43 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 09T9jcAM008861;
        Thu, 29 Oct 2020 05:45:42 -0400
From:   <alexandru.tachici@analog.com>
To:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <linux@roeck-us.net>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH 3/3] dt-binding: hwmon: Add documentation for ltc2992
Date:   Thu, 29 Oct 2020 11:49:11 +0200
Message-ID: <20201029094911.79173-4-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201029094911.79173-1-alexandru.tachici@analog.com>
References: <20201029094911.79173-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-29_03:2020-10-29,2020-10-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 spamscore=0 malwarescore=0 impostorscore=0 adultscore=0 mlxlogscore=999
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010290070
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandru Tachici <alexandru.tachici@analog.com>

Add documentation for ltc2992.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 .../bindings/hwmon/adi,ltc2992.yaml           | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adi,ltc2992.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/adi,ltc2992.yaml b/Documentation/devicetree/bindings/hwmon/adi,ltc2992.yaml
new file mode 100644
index 000000000000..1b603026ed2d
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/adi,ltc2992.yaml
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/adi,ltc2992.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Linear Technology 2992 Power Monitor
+
+maintainers:
+  - Alexandru Tachici <alexandru.tachici@analog.com>
+
+description: |
+  Linear Technology 2992 Dual Wide Range Power Monitor
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ltc2992.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ltc2992
+
+  reg:
+    maxItems: 1
+
+  avcc-supply: true
+
+patternProperties:
+  "^channel@([0-1])$":
+    type: object
+    description: |
+      Represents the two supplies to be monitored.
+
+    properties:
+      reg:
+        description: |
+          The channel number. LTC2992 can monitor two supplies.
+        items:
+         minimum: 0
+         maximum: 1
+
+      shunt-resistor-micro-ohms:
+        description:
+          The value of curent sense resistor in microohms.
+  required:
+    - reg
+
+  additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c1 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ltc2992@6F {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                compatible = "adi,ltc2992";
+                reg = <0x6F>;
+
+                channel@0 {
+                        reg = <0x0>;
+                        shunt-resistor-micro-ohms = <10000>;
+                };
+
+                channel@1 {
+                        reg = <0x1>;
+                        shunt-resistor-micro-ohms = <10000>;
+                };
+        };
+    };
+...
-- 
2.20.1

