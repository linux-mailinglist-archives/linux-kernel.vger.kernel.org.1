Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D06300115
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 12:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbhAVLAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 06:00:02 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:35714 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727645AbhAVKwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 05:52:20 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10MAlUiA011339;
        Fri, 22 Jan 2021 11:51:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=JulSSnbmn/ODg792hatyNg+R8GdjukARkpZyZAZHMmA=;
 b=B6fZnLNHyHiPS2qhGttFFZOwL2dl7HW1Z/LCQqfKTPXhOVI890xO1mA3YzBptU8JmZo0
 S00hePEppEVHNp6gFsFcKd7xJYmF1pL8FSA+zuSMMYJ//cuVA5kJI9ByR3xsc6kH4WdT
 avbgA87OmRK9CO9+kUXIT+6weakaCMVqde+sNdfOxR+leH2CbBF41JEERoEaisEEYz7h
 Hn+xmwWW6E2TI1IKUtgDcNcnk0LBcT13B4UVZIlYvooOFQY2/smtH/CriTbyKWlyU6Us
 AfCnannXTnM9xWD3aSRIyH13sO/viXGrZTG980/upaNXT9hmwyMg1uPHhYj86GV6AeZ/ KQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3668pe1e1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jan 2021 11:51:25 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C9132100038;
        Fri, 22 Jan 2021 11:51:24 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BB0F322DBCA;
        Fri, 22 Jan 2021 11:51:24 +0100 (CET)
Received: from localhost (10.75.127.49) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 22 Jan 2021 11:51:24
 +0100
From:   <gabriel.fernandez@foss.st.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Etienne Carriere <etienne.carriere@st.com>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 08/14] dt-bindings: reset: add IDs for SCMI reset domains on stm32mp15
Date:   Fri, 22 Jan 2021 11:50:55 +0100
Message-ID: <20210122105101.27374-9-gabriel.fernandez@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210122105101.27374-1-gabriel.fernandez@foss.st.com>
References: <20210122105101.27374-1-gabriel.fernandez@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-22_06:2021-01-21,2021-01-22 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>

stm32mp15 TZ secure firmware provides SCMI reset domains for
secure resources. This change defines the SCMI reset domain
identifiers used by SCMI agents and servers.

Stm32mp15 TZ secure firmware provides SCMI clocks for oscillators, some
PLL output and few secure aware interfaces. This change defines the
SCMI clock identifiers used by SCMI agents and servers.

Server SCMI0 exposes reset controllers for resources under RCC[TZEN]
configuration control.

Signed-off-by: Etienne Carriere <etienne.carriere@st.com>
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
---
 include/dt-bindings/reset/stm32mp1-resets.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/dt-bindings/reset/stm32mp1-resets.h b/include/dt-bindings/reset/stm32mp1-resets.h
index f0c3aaef67a0..bc71924faa54 100644
--- a/include/dt-bindings/reset/stm32mp1-resets.h
+++ b/include/dt-bindings/reset/stm32mp1-resets.h
@@ -105,4 +105,17 @@
 #define GPIOJ_R		19785
 #define GPIOK_R		19786
 
+/* SCMI reset domain identifiers */
+#define RST_SCMI0_SPI6		0
+#define RST_SCMI0_I2C4		1
+#define RST_SCMI0_I2C6		2
+#define RST_SCMI0_USART1	3
+#define RST_SCMI0_STGEN		4
+#define RST_SCMI0_GPIOZ		5
+#define RST_SCMI0_CRYP1		6
+#define RST_SCMI0_HASH1		7
+#define RST_SCMI0_RNG1		8
+#define RST_SCMI0_MDMA		9
+#define RST_SCMI0_MCU		10
+
 #endif /* _DT_BINDINGS_STM32MP1_RESET_H_ */
-- 
2.17.1

