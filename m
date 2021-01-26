Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45520303B8A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392420AbhAZLYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:24:24 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:41644 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390874AbhAZJFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 04:05:30 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10Q8tfZk000604;
        Tue, 26 Jan 2021 10:04:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=JulSSnbmn/ODg792hatyNg+R8GdjukARkpZyZAZHMmA=;
 b=Wykc02L3WaxELF5pkUp8Q7eHeNGJdCEIJt5Mc/cUEbEAU/jYOodPuiV37IQRdV2I8QwY
 GI/e3GvufmEksKL6mtjh2HyezTqB6pe1a5m5JA1SGnlT++Q/EiMuQ5AEzr+iQJ7zW3F/
 C5KxfZ308C5ctYVgIkAJScVIaL8/il3AWB87jZi2JgLlOb8hfN3r3ggPHRP3GMNAmDcv
 3Z3abQjrJLpnZ72cGGnZHHGwYN3QgIPnw1P3inbLOgCZMkCiiMsllJLwGyg5ttiDh2RJ
 BVjKgUOB17Q/YmgqkQ4gKoj4IynpvAUhzOkafzjdPPNAFlncXdbPB6k4hKPpyJAYQtAK Zw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 368c15qgjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Jan 2021 10:04:39 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BF61B10002A;
        Tue, 26 Jan 2021 10:04:38 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B100B2288C8;
        Tue, 26 Jan 2021 10:04:38 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 26 Jan 2021 10:04:38
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
Subject: [PATCH v2 08/14] dt-bindings: reset: add IDs for SCMI reset domains on stm32mp15
Date:   Tue, 26 Jan 2021 10:01:14 +0100
Message-ID: <20210126090120.19900-9-gabriel.fernandez@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210126090120.19900-1-gabriel.fernandez@foss.st.com>
References: <20210126090120.19900-1-gabriel.fernandez@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-26_06:2021-01-25,2021-01-26 signatures=0
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

