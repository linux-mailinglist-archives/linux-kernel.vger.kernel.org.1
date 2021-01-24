Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53E33301E8F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 20:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbhAXTvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 14:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbhAXTvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 14:51:48 -0500
X-Greylist: delayed 697 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 24 Jan 2021 11:50:51 PST
Received: from srv1.deutnet.info (srv1.deutnet.info [IPv6:2a01:4f8:c2c:6846::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA35CC0613ED;
        Sun, 24 Jan 2021 11:50:51 -0800 (PST)
Received: from [2a01:cb14:a98:4900:be5f:f4ff:fe8b:2fc1] (helo=sonata)
        by srv1.deutnet.info with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <agriveaux@deutnet.info>)
        id 1l3lE2-0006mI-O6; Sun, 24 Jan 2021 20:39:06 +0100
Received: from agriveaux by sonata with local (Exim 4.92)
        (envelope-from <agriveaux@localhost.localdomain>)
        id 1l3lE1-0005Zx-VU; Sun, 24 Jan 2021 20:39:05 +0100
From:   Alexandre GRIVEAUX <agriveaux@deutnet.info>
To:     robh+dt@kernel.org, mripard@kernel.org, wens@csie.org,
        jernej.skrabec@siol.net
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Alexandre GRIVEAUX <agriveaux@deutnet.info>
Subject: [PATCH v2] ARM: dts: sun5i: Add dts for inet86v_rev2
Date:   Sun, 24 Jan 2021 20:39:03 +0100
Message-Id: <20210124193903.21401-1-agriveaux@deutnet.info>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Inet 86V Rev 2 support, based upon Inet 86VS.

The Inet 86V use SL1536 touchpanel controller, the Inet 86VS a GSL1680,
which make them both incompatible.

Missing things:
- Accelerometer (MXC6225X)
- Touchpanel (Sitronix SL1536)
- Nand (29F32G08CBACA)
- Camera (HCWY0308)

Signed-off-by: Alexandre GRIVEAUX <agriveaux@deutnet.info>
---
 arch/arm/boot/dts/sun5i-a13-inet-86v-rev2.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun5i-a13-inet-86v-rev2.dts

diff --git a/arch/arm/boot/dts/sun5i-a13-inet-86v-rev2.dts b/arch/arm/boot/dts/sun5i-a13-inet-86v-rev2.dts
new file mode 100644
index 000000000000..581083e932d8
--- /dev/null
+++ b/arch/arm/boot/dts/sun5i-a13-inet-86v-rev2.dts
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2021 Alexandre Griveaux <agriveaux@deutnet.info>
+ *
+ * Minimal dts file for the iNet 86V
+ */
+
+/dts-v1/;
+
+#include "sun5i-a13.dtsi"
+#include "sun5i-reference-design-tablet.dtsi"
+
+/ {
+	model = "iNET 86V Rev 02";
+	compatible = "inet,86v-rev2", "allwinner,sun5i-a13";
+
+};
-- 
2.20.1

