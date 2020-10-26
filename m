Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A8B29870E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 07:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770630AbgJZGoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 02:44:23 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:39644 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1770621AbgJZGoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 02:44:22 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09Q6PP1n001258;
        Mon, 26 Oct 2020 02:43:57 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 34ce45pmu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Oct 2020 02:43:57 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 09Q6huxL007330
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 26 Oct 2020 02:43:56 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 26 Oct
 2020 02:43:55 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 26 Oct 2020 02:43:55 -0400
Received: from btogorean-pc.ad.analog.com ([10.48.65.113])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 09Q6geJQ003008;
        Mon, 26 Oct 2020 02:43:52 -0400
From:   Bogdan Togorean <bogdan.togorean@analog.com>
To:     <dri-devel@lists.freedesktop.org>
CC:     <sam@ravnborg.org>, Bogdan Togorean <bogdan.togorean@analog.com>,
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
Subject: [PATCH v2 2/2] drm: dt-bindings: adi: axi-hdmi-tx: Add DT bindings for axi-hdmi-tx
Date:   Mon, 26 Oct 2020 08:41:06 +0200
Message-ID: <20201026064122.2831-2-bogdan.togorean@analog.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201026064122.2831-1-bogdan.togorean@analog.com>
References: <20201026064122.2831-1-bogdan.togorean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-26_04:2020-10-26,2020-10-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1 phishscore=0
 spamscore=0 malwarescore=0 impostorscore=0 adultscore=0 mlxlogscore=999
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010260045
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML device tree bindings for Analog Devices Inc. AXI HDMI TX
IP core DRM driver.

Signed-off-by: Bogdan Togorean <bogdan.togorean@analog.com>
---
 .../bindings/display/adi/adi,axi-hdmi-tx.yaml | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/adi/adi,axi-hdmi-tx.yaml

diff --git a/Documentation/devicetree/bindings/display/adi/adi,axi-hdmi-tx.yaml b/Documentation/devicetree/bindings/display/adi/adi,axi-hdmi-tx.yaml
new file mode 100644
index 000000000000..12a0ed9b187e
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/adi/adi,axi-hdmi-tx.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/adi/adi,axi-hdmi-tx.yaml#
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
+    description: enable color space conversion
+
+  port:
+    type: object
+    description: |
+      Port as described in Documentation/devicetree/bindings/graph.txt.
+      Remote output connection to bridge driver
+
+required:
+  - compatible
+  - reg
+  - dmas
+  - dma-names
+  - clocks
+  - port
+
+additionalProperties: false
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

