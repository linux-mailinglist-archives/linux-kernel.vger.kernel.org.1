Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A4E2D02F9
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 11:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgLFKug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 05:50:36 -0500
Received: from inva020.nxp.com ([92.121.34.13]:51496 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgLFKug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 05:50:36 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BDF251A087E;
        Sun,  6 Dec 2020 11:49:48 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A3EE91A0AAF;
        Sun,  6 Dec 2020 11:49:43 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 26057402D0;
        Sun,  6 Dec 2020 11:49:37 +0100 (CET)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 1/2] ASoC: dt-bindings: imx-hdmi: Add binding doc for hdmi machine driver
Date:   Sun,  6 Dec 2020 18:41:58 +0800
Message-Id: <1607251319-5821-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Imx-hdmi is a new added machine driver for supporting hdmi devices
on i.MX platforms. There is HDMI IP or external HDMI modules connect
with SAI or AUD2HTX interface.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
changes in v2:
- none

 .../bindings/sound/imx-audio-hdmi.yaml        | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/imx-audio-hdmi.yaml

diff --git a/Documentation/devicetree/bindings/sound/imx-audio-hdmi.yaml b/Documentation/devicetree/bindings/sound/imx-audio-hdmi.yaml
new file mode 100644
index 000000000000..d5474f83ac2c
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/imx-audio-hdmi.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/imx-audio-hdmi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX audio complex with HDMI
+
+maintainers:
+  - Shengjiu Wang <shengjiu.wang@nxp.com>
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx-audio-hdmi
+      - fsl,imx-audio-sii902x
+
+  model:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: User specified audio sound card name
+
+  audio-cpu:
+    description: The phandle of an CPU DAI controller
+
+  hdmi-out:
+    description: |
+      This is a boolean property. If present, the transmitting function
+      of HDMI will be enabled, indicating there's a physical HDMI out
+      connector or jack on the board or it's connecting to some other IP
+      block, such as an HDMI encoder or display-controller.
+
+  hdmi-in:
+    description: |
+      This is a boolean property. If present, the receiving function of
+      HDMI will be enabled, indicating there is a physical HDMI in
+      connector/jack on the board.
+
+required:
+  - compatible
+  - model
+  - audio-cpu
+
+additionalProperties: false
+
+examples:
+  - |
+    sound-hdmi {
+        compatible = "fsl,imx-audio-hdmi";
+        model = "audio-hdmi";
+        audio-cpu = <&aud2htx>;
+        hdmi-out;
+    };
-- 
2.27.0

