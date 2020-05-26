Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A491AAEB3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 18:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410436AbgDOQr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 12:47:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:47178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1416219AbgDOQq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 12:46:56 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C2D121556;
        Wed, 15 Apr 2020 16:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586969215;
        bh=3LgAEXzg3hin+aaY948zanpI6w0MQHNo1PfMx6VlC7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LWysdhMx1OPkv8LstjduIfPlHM+DFSeHnCLWTj/SUfEBpgoihDLdbt4O0FGOSYpJ5
         XEkj9pta4WAMpTNwXD2qmUtbTS3xpeU6fBsF2FiI+E1hpH731QWfbQ8gbVvR/NQCeL
         7mstKQEnzAHBGQAVzQqHuzRjbpyQOxCj+DGM1iTg=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     linux-clk@vger.kernel.org
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com
Subject: [PATCHv7 4/5] dt-bindings: documentation: add clock bindings information for Agilex
Date:   Wed, 15 Apr 2020 11:46:41 -0500
Message-Id: <20200415164642.29382-5-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200415164642.29382-1-dinguyen@kernel.org>
References: <20200415164642.29382-1-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the Agilex clock bindings, and add the clock header file. The
clock header is an enumeration of all the different clocks on the Agilex
platform.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v7: Fix license to be "(GPL-2.0-only OR BSD-2-Clause)"
v6: fix build error by adding descriptions for clocks and reg in
    properties
v5: update license to GPL-2.0-only
    Add additionalProperties
    Add clock input for clkmgr
v4: really fix build error(comment formatting was wrong)
v3: address comments from Stephen Boyd
    fix build error(tab removed in line 37)
    renamed to intel,agilex.yaml
v2: convert original document to YAML
---
 .../bindings/clock/intel,agilex.yaml          | 46 ++++++++++++
 include/dt-bindings/clock/agilex-clock.h      | 70 +++++++++++++++++++
 2 files changed, 116 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/intel,agilex.yaml
 create mode 100644 include/dt-bindings/clock/agilex-clock.h

diff --git a/Documentation/devicetree/bindings/clock/intel,agilex.yaml b/Documentation/devicetree/bindings/clock/intel,agilex.yaml
new file mode 100644
index 000000000000..cf5a9eb803e6
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/intel,agilex.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/intel,agilex.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Intel SoCFPGA Agilex platform clock controller binding
+
+maintainers:
+  - Dinh Nguyen <dinguyen@kernel.org>
+
+description:
+  The Intel Agilex Clock controller is an integrated clock controller, which
+  generates and supplies to all modules.
+
+properties:
+  compatible:
+    const: intel,agilex-clkmgr
+
+  '#clock-cells':
+    const: 1
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  # Clock controller node:
+  - |
+    clkmgr: clock-controller@ffd10000 {
+      compatible = "intel,agilex-clkmgr";
+      reg = <0xffd10000 0x1000>;
+      clocks = <&osc1>;
+      #clock-cells = <1>;
+    };
+...
diff --git a/include/dt-bindings/clock/agilex-clock.h b/include/dt-bindings/clock/agilex-clock.h
new file mode 100644
index 000000000000..f19cf8ccbdd2
--- /dev/null
+++ b/include/dt-bindings/clock/agilex-clock.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019, Intel Corporation
+ */
+
+#ifndef __AGILEX_CLOCK_H
+#define __AGILEX_CLOCK_H
+
+/* fixed rate clocks */
+#define AGILEX_OSC1			0
+#define AGILEX_CB_INTOSC_HS_DIV2_CLK	1
+#define AGILEX_CB_INTOSC_LS_CLK		2
+#define AGILEX_L4_SYS_FREE_CLK		3
+#define AGILEX_F2S_FREE_CLK		4
+
+/* PLL clocks */
+#define AGILEX_MAIN_PLL_CLK		5
+#define AGILEX_MAIN_PLL_C0_CLK		6
+#define AGILEX_MAIN_PLL_C1_CLK		7
+#define AGILEX_MAIN_PLL_C2_CLK		8
+#define AGILEX_MAIN_PLL_C3_CLK		9
+#define AGILEX_PERIPH_PLL_CLK		10
+#define AGILEX_PERIPH_PLL_C0_CLK	11
+#define AGILEX_PERIPH_PLL_C1_CLK	12
+#define AGILEX_PERIPH_PLL_C2_CLK	13
+#define AGILEX_PERIPH_PLL_C3_CLK	14
+#define AGILEX_MPU_FREE_CLK		15
+#define AGILEX_MPU_CCU_CLK		16
+#define AGILEX_BOOT_CLK			17
+
+/* fixed factor clocks */
+#define AGILEX_L3_MAIN_FREE_CLK		18
+#define AGILEX_NOC_FREE_CLK		19
+#define AGILEX_S2F_USR0_CLK		20
+#define AGILEX_NOC_CLK			21
+#define AGILEX_EMAC_A_FREE_CLK		22
+#define AGILEX_EMAC_B_FREE_CLK		23
+#define AGILEX_EMAC_PTP_FREE_CLK	24
+#define AGILEX_GPIO_DB_FREE_CLK		25
+#define AGILEX_SDMMC_FREE_CLK		26
+#define AGILEX_S2F_USER0_FREE_CLK	27
+#define AGILEX_S2F_USER1_FREE_CLK	28
+#define AGILEX_PSI_REF_FREE_CLK		29
+
+/* Gate clocks */
+#define AGILEX_MPU_CLK			30
+#define AGILEX_MPU_L2RAM_CLK		31
+#define AGILEX_MPU_PERIPH_CLK		32
+#define AGILEX_L4_MAIN_CLK		33
+#define AGILEX_L4_MP_CLK		34
+#define AGILEX_L4_SP_CLK		35
+#define AGILEX_CS_AT_CLK		36
+#define AGILEX_CS_TRACE_CLK		37
+#define AGILEX_CS_PDBG_CLK		38
+#define AGILEX_CS_TIMER_CLK		39
+#define AGILEX_S2F_USER0_CLK		40
+#define AGILEX_EMAC0_CLK		41
+#define AGILEX_EMAC1_CLK		43
+#define AGILEX_EMAC2_CLK		44
+#define AGILEX_EMAC_PTP_CLK		45
+#define AGILEX_GPIO_DB_CLK		46
+#define AGILEX_NAND_CLK			47
+#define AGILEX_PSI_REF_CLK		48
+#define AGILEX_S2F_USER1_CLK		49
+#define AGILEX_SDMMC_CLK		50
+#define AGILEX_SPI_M_CLK		51
+#define AGILEX_USB_CLK			52
+#define AGILEX_NUM_CLKS			53
+
+#endif	/* __AGILEX_CLOCK_H */
-- 
2.25.1

