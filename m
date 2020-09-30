Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F096B27E861
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 14:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbgI3MUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 08:20:47 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40358 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbgI3MUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 08:20:44 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08UCKcw7096039;
        Wed, 30 Sep 2020 07:20:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601468438;
        bh=SwwadW+HjZlVs3CRFD9ulpOZslq4ShS+RCbFScps8S4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=K1pUMZUN4JkLn2KL0FztPxaOe4n4kwrZzapsRG73jntbNAYKAqgzi2J0EzgpNLnnD
         iJCX3UNBMtXAHpbxBA/9bpckYHw9xndFhuVlvx1fiVE4aWYt4s+tvCdgv9JFA8QLQC
         lxkDiaAqEEzeO67f5krwjkQDZ9GzmFHqmecfBpKg=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08UCKcfc107614
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Sep 2020 07:20:38 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 07:20:38 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 30 Sep 2020 07:20:38 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08UCKXr3049132;
        Wed, 30 Sep 2020 07:20:36 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <nm@ti.com>
CC:     <t-kristo@ti.com>, <nsekhar@ti.com>, <kishon@ti.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>,
        Peter Rosin <peda@axentia.se>
Subject: [PATCH v5 1/6] dt-bindings: ti-serdes-mux: Add defines for J7200 SoC
Date:   Wed, 30 Sep 2020 15:20:27 +0300
Message-ID: <20200930122032.23481-2-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200930122032.23481-1-rogerq@ti.com>
References: <20200930122032.23481-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 4 lanes in each J7200 SERDES. Each SERDES lane mux can
select upto 4 different IPs. Define all the possible functions.

Cc: Peter Rosin <peda@axentia.se>
Signed-off-by: Roger Quadros <rogerq@ti.com>
Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Peter Rosin <peda@axentia.se>
---
 include/dt-bindings/mux/ti-serdes.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/dt-bindings/mux/ti-serdes.h b/include/dt-bindings/mux/ti-serdes.h
index 146d0685a925..9047ec6bd3cf 100644
--- a/include/dt-bindings/mux/ti-serdes.h
+++ b/include/dt-bindings/mux/ti-serdes.h
@@ -68,4 +68,26 @@
 #define J721E_SERDES4_LANE3_QSGMII_LANE8	0x2
 #define J721E_SERDES4_LANE3_IP4_UNUSED		0x3
 
+/* J7200 */
+
+#define J7200_SERDES0_LANE0_QSGMII_LANE3	0x0
+#define J7200_SERDES0_LANE0_PCIE1_LANE0		0x1
+#define J7200_SERDES0_LANE0_IP3_UNUSED		0x2
+#define J7200_SERDES0_LANE0_IP4_UNUSED		0x3
+
+#define J7200_SERDES0_LANE1_QSGMII_LANE4	0x0
+#define J7200_SERDES0_LANE1_PCIE1_LANE1		0x1
+#define J7200_SERDES0_LANE1_IP3_UNUSED		0x2
+#define J7200_SERDES0_LANE1_IP4_UNUSED		0x3
+
+#define J7200_SERDES0_LANE2_QSGMII_LANE1	0x0
+#define J7200_SERDES0_LANE2_PCIE1_LANE2		0x1
+#define J7200_SERDES0_LANE2_IP3_UNUSED		0x2
+#define J7200_SERDES0_LANE2_IP4_UNUSED		0x3
+
+#define J7200_SERDES0_LANE3_QSGMII_LANE2	0x0
+#define J7200_SERDES0_LANE3_PCIE1_LANE3		0x1
+#define J7200_SERDES0_LANE3_USB			0x2
+#define J7200_SERDES0_LANE3_IP4_UNUSED		0x3
+
 #endif /* _DT_BINDINGS_MUX_TI_SERDES */
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

