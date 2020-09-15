Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895BE26A43B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 13:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgIOLgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 07:36:12 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:43432 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbgIOLWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 07:22:50 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08FBKjGH013435;
        Tue, 15 Sep 2020 06:20:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600168845;
        bh=HB6Ek5pzLz8fCLHNM5RI59gb394ysYTfKY+ZodmGEYk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=NjEq9dOtiiNZC2rwCtkYSrFW72bqENq+eG2NT2sJqQhJ92mdkO4oadZfwn33KD5Fm
         BPERA85F1BjNGDURbGFiy15yeQTq/+MXgQhwo+Pn+YWpVCvrkjWnXREsilKIYHHF+0
         RIpPMmMJwmLm1wPEHVdbY56aMTSJyigAuWKQi0rM=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08FBKj1h120680;
        Tue, 15 Sep 2020 06:20:45 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 15
 Sep 2020 06:20:45 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 15 Sep 2020 06:20:45 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08FBKdmA013285;
        Tue, 15 Sep 2020 06:20:42 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <t-kristo@ti.com>, <nm@ti.com>
CC:     <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <nsekhar@ti.com>,
        <kishon@ti.com>, Roger Quadros <rogerq@ti.com>,
        Peter Rosin <peda@axentia.se>
Subject: [PATCH v3 1/6] dt-bindings: mux-j7200-wiz: Add lane function defines
Date:   Tue, 15 Sep 2020 14:20:33 +0300
Message-ID: <20200915112038.30219-2-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200915112038.30219-1-rogerq@ti.com>
References: <20200915112038.30219-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each SERDES lane mux can select upto 4 different IPs.
There are 4 lanes in each J7200 SERDES. Define all
the possible functions in this file.

Cc: Peter Rosin <peda@axentia.se>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 include/dt-bindings/mux/mux-j7200-wiz.h | 29 +++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 include/dt-bindings/mux/mux-j7200-wiz.h

diff --git a/include/dt-bindings/mux/mux-j7200-wiz.h b/include/dt-bindings/mux/mux-j7200-wiz.h
new file mode 100644
index 000000000000..b091b1185a36
--- /dev/null
+++ b/include/dt-bindings/mux/mux-j7200-wiz.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header provides constants for J7200 WIZ.
+ */
+
+#ifndef _DT_BINDINGS_J7200_WIZ
+#define _DT_BINDINGS_J7200_WIZ
+
+#define SERDES0_LANE0_QSGMII_LANE3	0x0
+#define SERDES0_LANE0_PCIE1_LANE0	0x1
+#define SERDES0_LANE0_IP3_UNUSED	0x2
+#define SERDES0_LANE0_IP4_UNUSED	0x3
+
+#define SERDES0_LANE1_QSGMII_LANE4	0x0
+#define SERDES0_LANE1_PCIE1_LANE1	0x1
+#define SERDES0_LANE1_IP3_UNUSED	0x2
+#define SERDES0_LANE1_IP4_UNUSED	0x3
+
+#define SERDES0_LANE2_QSGMII_LANE1	0x0
+#define SERDES0_LANE2_PCIE1_LANE2	0x1
+#define SERDES0_LANE2_IP3_UNUSED	0x2
+#define SERDES0_LANE2_IP4_UNUSED	0x3
+
+#define SERDES0_LANE3_QSGMII_LANE2	0x0
+#define SERDES0_LANE3_PCIE1_LANE3	0x1
+#define SERDES0_LANE3_USB		0x2
+#define SERDES0_LANE3_IP4_UNUSED	0x3
+
+#endif /* _DT_BINDINGS_J7200_WIZ */
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

