Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3232A2A9257
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgKFJTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:19:51 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:58115 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726010AbgKFJTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:19:31 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A6984US008664;
        Fri, 6 Nov 2020 10:19:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=6qq/quNVzbBGlASaodU021u7lBejVGsfqPJlwc9JOcI=;
 b=euEg+Yvyqqg6lWYfcWv2ryupYlJKtPQJHMMQseV9aFHFzWfUM+w2Jv7ja2CJSRx5bGZD
 1WmIe2EYxow+rpxqgpiG5LpQXkHn9D3WOFZ9YPmOfH1Zbvno64GopgfN8Zp0cKE0q46r
 qoplgLjC307ShZcj/udeaJCOg4yDzp/ddKOkjw83266NLE67vfezhsIOUZ87Q+Sd6UBl
 u4SdJLXl9yORNjLHM3nvxmtWLUUXmSbInCm11CiyjMPU1EFpidexO/Xd1+JwkN/ez0fT
 cYWXTaD+VsYcix/aVmErslH9cKLV1hz2Po684dCImxr2S/MP5W55zVuhky7MqJGW/F0L 3w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34gyw1uws6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Nov 2020 10:19:10 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E0A6C100034;
        Fri,  6 Nov 2020 10:19:09 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D1D92233E9D;
        Fri,  6 Nov 2020 10:19:09 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Nov 2020 10:19:09
 +0100
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Russell King <linux@armlinux.org.uk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Jun Li <lijun.kernel@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH v4 2/5] dt-bindings: usb: Add DT bindings for STUSB160x Type-C controller
Date:   Fri, 6 Nov 2020 10:18:51 +0100
Message-ID: <20201106091854.14958-3-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201106091854.14958-1-amelie.delaunay@st.com>
References: <20201106091854.14958-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-06_03:2020-11-05,2020-11-06 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for the STMicroelectronics STUSB160x Type-C port
controller.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 .../devicetree/bindings/usb/st,stusb160x.yaml | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/st,stusb160x.yaml

diff --git a/Documentation/devicetree/bindings/usb/st,stusb160x.yaml b/Documentation/devicetree/bindings/usb/st,stusb160x.yaml
new file mode 100644
index 000000000000..882450571db6
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/st,stusb160x.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/usb/st,stusb160x.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: STMicroelectronics STUSB160x Type-C controller bindings
+
+maintainers:
+  - Amelie Delaunay <amelie.delaunay@st.com>
+
+properties:
+  compatible:
+    enum:
+      - st,stusb1600
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply:
+    description: main power supply (4.1V-22V)
+
+  vsys-supply:
+    description: low power supply (3.0V-5.5V)
+
+  vconn-supply:
+    description: power supply (2.7V-5.5V) used to supply VConn on CC pin in
+      source or dual power role
+
+  connector:
+    type: object
+
+    allOf:
+      - $ref: ../connector/usb-connector.yaml
+
+    properties:
+      compatible:
+        const: usb-c-connector
+
+      power-role: true
+
+      typec-power-opmode: true
+
+    required:
+      - compatible
+
+required:
+  - compatible
+  - reg
+  - connector
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c4 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        typec: stusb1600@28 {
+            compatible = "st,stusb1600";
+            reg = <0x28>;
+            vdd-supply = <&vbus_drd>;
+            vsys-supply = <&vdd_usb>;
+            interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-parent = <&gpioi>;
+
+            typec_con: connector {
+                compatible = "usb-c-connector";
+                label = "USB-C";
+                power-role = "dual";
+                data-role = "dual";
+                typec-power-opmode = "default";
+
+                port {
+                    typec_con_ep: endpoint {
+                        remote-endpoint = <&usbotg_hs_ep>;
+                    };
+                };
+            };
+        };
+    };
+...
-- 
2.17.1

