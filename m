Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D592E2675
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 12:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgLXLoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 06:44:14 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41482 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbgLXLoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 06:44:14 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BOBhLQa048694;
        Thu, 24 Dec 2020 05:43:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608810201;
        bh=uBuv+SA+RAdeWsnzltldKqL0qlFzkvQrF1N+8ccx8gk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=I6jlv3LZ56tG8A5SF+PGZAkywdcemQjOT8goLIABBZgy4hwbzgu4bR/eyaglKHpi6
         WPNhArtCFdimOdz6CnPxMi5dPEayqnWxft/v28ydTz1PzRYbHOIUsr5dQGKYAaErSw
         clygsuCuqRDFHdY/juheFJ+83THOagwKpi4GEx0U=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BOBhL2E000655
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Dec 2020 05:43:21 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 24
 Dec 2020 05:43:20 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 24 Dec 2020 05:43:20 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BOBgtwX026267;
        Thu, 24 Dec 2020 05:43:16 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Peter Rosin <peda@axentia.se>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 4/7] dt-bindings: ti-serdes-mux: Add defines for AM64 SoC
Date:   Thu, 24 Dec 2020 17:12:47 +0530
Message-ID: <20201224114250.1083-5-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201224114250.1083-1-kishon@ti.com>
References: <20201224114250.1083-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM64 has a single lane SERDES which can be configured to be used
with either PCIe or USB. Define the possilbe values for the SERDES
function in AM64 SoC here.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 include/dt-bindings/mux/ti-serdes.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/mux/ti-serdes.h b/include/dt-bindings/mux/ti-serdes.h
index 9047ec6bd3cf..68e0f76deed1 100644
--- a/include/dt-bindings/mux/ti-serdes.h
+++ b/include/dt-bindings/mux/ti-serdes.h
@@ -90,4 +90,8 @@
 #define J7200_SERDES0_LANE3_USB			0x2
 #define J7200_SERDES0_LANE3_IP4_UNUSED		0x3
 
+/* AM64 */
+#define AM64_SERDES0_LANE0_PCIE0		0x0
+#define AM64_SERDES0_LANE0_USB			0x1
+
 #endif /* _DT_BINDINGS_MUX_TI_SERDES */
-- 
2.17.1

