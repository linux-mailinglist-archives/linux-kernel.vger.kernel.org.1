Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF063045DD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 19:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393898AbhAZSBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 13:01:07 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:5410 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390873AbhAZJFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 04:05:30 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10Q8v017012790;
        Tue, 26 Jan 2021 10:04:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=k6uscXkXABTNJTneIu2qnrDFpyKKioS22qyjfIif7ss=;
 b=N8iBKEpqEWEP022q+rZqm7+J3l/PVobuB9lozp4zODiZXjieCvuz4cwnLOLBUVP4aUHV
 cseTpUST7qMKSQCHfh16u3w51YlcNTG4sdsEA3ZNTwV3rQ4a4JvuiiyVOvbIjqDEGVie
 O943fbVyZlwmUMJUC/oGEydVBpwklPzjAdfH0zJpl8YHHVAz3Wc9DXtRZzDHr9ufsZOs
 8QeKMIjV3z+QFMzroFyD61R32+yaJAIOgLRkQ+HN/WOzAoQ3p0KhZBec6zo4Hw7KQ4Os
 AZnMG6PS9j8/FkH2rPZJByqDt9ff+7L60WNt/2uCaeYzde9YzhZ7QnI+hNDQVzOV2xU2 7w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3689tdr2kp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Jan 2021 10:04:39 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2332C100034;
        Tue, 26 Jan 2021 10:04:38 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 133412288C8;
        Tue, 26 Jan 2021 10:04:38 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 26 Jan 2021 10:04:37
 +0100
From:   <gabriel.fernandez@foss.st.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Etienne Carriere <etienne.carriere@st.com>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
        <marex@denx.de>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 07/14] dt-bindings: clock: add IDs for SCMI clocks on stm32mp15
Date:   Tue, 26 Jan 2021 10:01:13 +0100
Message-ID: <20210126090120.19900-8-gabriel.fernandez@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210126090120.19900-1-gabriel.fernandez@foss.st.com>
References: <20210126090120.19900-1-gabriel.fernandez@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-26_06:2021-01-25,2021-01-26 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>

stm32mp15 TZ secure firmware provides SCMI clocks for oscillators, some
PLL output and few secure aware interfaces.
This change defines the SCMI clock identifiers used by SCMI agents
and servers.
Server SCMI0 exposes clocks and reset controllers for resources under
RCC[TZEN] configuration control.
Server SCMI1 exposes clocks for resources under RCC[MCKPROT] control.

Signed-off-by: Etienne Carriere <etienne.carriere@st.com>
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
---
 include/dt-bindings/clock/stm32mp1-clks.h | 27 +++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/dt-bindings/clock/stm32mp1-clks.h b/include/dt-bindings/clock/stm32mp1-clks.h
index 4cdaf135829c..e02770b98e6c 100644
--- a/include/dt-bindings/clock/stm32mp1-clks.h
+++ b/include/dt-bindings/clock/stm32mp1-clks.h
@@ -248,4 +248,31 @@
 
 #define STM32MP1_LAST_CLK 232
 
+/* SCMI clock identifiers */
+#define CK_SCMI0_HSE		0
+#define CK_SCMI0_HSI		1
+#define CK_SCMI0_CSI		2
+#define CK_SCMI0_LSE		3
+#define CK_SCMI0_LSI		4
+#define CK_SCMI0_PLL2_Q		5
+#define CK_SCMI0_PLL2_R		6
+#define CK_SCMI0_MPU		7
+#define CK_SCMI0_AXI		8
+#define CK_SCMI0_BSEC		9
+#define CK_SCMI0_CRYP1		10
+#define CK_SCMI0_GPIOZ		11
+#define CK_SCMI0_HASH1		12
+#define CK_SCMI0_I2C4		13
+#define CK_SCMI0_I2C6		14
+#define CK_SCMI0_IWDG1		15
+#define CK_SCMI0_RNG1		16
+#define CK_SCMI0_RTC		17
+#define CK_SCMI0_RTCAPB		18
+#define CK_SCMI0_SPI6		19
+#define CK_SCMI0_USART1		20
+
+#define CK_SCMI1_PLL3_Q		0
+#define CK_SCMI1_PLL3_R		1
+#define CK_SCMI1_MCU		2
+
 #endif /* _DT_BINDINGS_STM32MP1_CLKS_H_ */
-- 
2.17.1

