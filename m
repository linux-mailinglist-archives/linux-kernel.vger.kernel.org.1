Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADB22834B1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 13:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbgJELNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 07:13:33 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:44678 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725843AbgJELNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 07:13:32 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 095BAEpB029464;
        Mon, 5 Oct 2020 07:13:11 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 33xk56c3uv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Oct 2020 07:13:10 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 095BD9xA051994
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 5 Oct 2020 07:13:09 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 5 Oct 2020 07:12:55 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 5 Oct 2020 07:12:55 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 5 Oct 2020 07:12:55 -0400
Received: from btogorean-pc.ad.analog.com ([10.48.65.113])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 095BCi8U002619;
        Mon, 5 Oct 2020 07:13:06 -0400
From:   Bogdan Togorean <bogdan.togorean@analog.com>
To:     <dri-devel@lists.freedesktop.org>
CC:     Bogdan Togorean <bogdan.togorean@analog.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] drm: dt-bindings: adi: axi-hdmi-tx: Add DT bindings for axi-hdmi-tx
Date:   Mon, 5 Oct 2020 17:12:09 +0300
Message-ID: <20201005141226.180655-2-bogdan.togorean@analog.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005141226.180655-1-bogdan.togorean@analog.com>
References: <20201005141226.180655-1-bogdan.togorean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-05_06:2020-10-02,2020-10-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 suspectscore=1
 malwarescore=0 impostorscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010050084
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML device tree bindings for Analog Devices Inc. AXI HDMI TX
IP core DRM driver.

Signed-off-by: Bogdan Togorean <bogdan.togorean@analog.com>
---
 .../bindings/gpu/adi,axi-hdmi-tx.yaml         | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpu/adi,axi-hdmi-tx.yaml

diff --git a/Documentation/devicetree/bindings/gpu/adi,axi-hdmi-tx.yaml b/Documentation/devicetree/bindings/gpu/adi,axi-hdmi-tx.yaml
new file mode 100644
index 000000000000..ab7e71d14d1d
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpu/adi,axi-hdmi-tx.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpu/adi,axi-hdmi-tx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AXI HDMI TX HDL core
+
+maintainers:
+  - Bogdan Togorean <bogdan.togorean@analog.com>
+
+description: |
+  The AXI HDMI HDL driver is the driver for the HDL graphics core which
+  is used on various FPGA designs. It's mostly used to interface with
+  the ADV7511 driver on some Zynq boards (e.g. ZC702 & ZedBoard).
+
+properties:
+  compatible:
+    const: adi,axi-hdmi-tx-1.00.a
+
+  reg:
+    maxItems: 1
+
+  dmas:
+    items:
+      - description: phandle to AXIS DMA controller
+    maxItems: 1
+
+  dma-names:
+    items:
+      - const: video
+
+  clocks:
+    maxItems: 1
+    description: phandle to the pixel clock
+
+  adi,is-rgb:
+    type: boolean
+    description: control color space conversion
+
+  port:
+    type: object
+    description: |
+      Port as described in Documentation/devicetree/bindings/graph.txt.
+      Remote output connection to ADV7511 driver
+
+required:
+  - compatible
+  - reg
+  - dmas
+  - dma-names
+  - clocks
+  - port
+
+examples:
+  - |
+    axi_hdmi_tx: axi_hdmi@70e00000 {
+            compatible = "adi,axi-hdmi-tx-1.00.a";
+            reg = <0x70e00000 0x10000>;
+            dmas = <&hdmi_dma 0>;
+            dma-names = "video";
+            clocks = <&hdmi_clock>;
+
+            port {
+                    axi_hdmi_out: endpoint {
+                            remote-endpoint = <&zynq_hdmi_in>;
+                    };
+            };
+    };
+...
-- 
2.28.0

