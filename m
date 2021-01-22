Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAFB300114
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 12:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbhAVK77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 05:59:59 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:12452 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727641AbhAVKwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 05:52:20 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10MAmErT002447;
        Fri, 22 Jan 2021 11:51:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=RivJUiIy5TU2ksiPgssKrK3H7tEeukdkhC6QDU08094=;
 b=YP0+WpvIGw/pMnBI9P4BLEJbUBUTXiRGpDOFSdVdL1O0VsYESLTEdLz89Xycmt6lUB4n
 XuqwUDZyuZVIVGD8dDdyJ62jfXuJjP64j7FnNhoRyvcgMDarnv9Cj3o8hFI+St0ex1nE
 K7FA8XFqwuGWLkEHnR/R6zVDQCzNRVkAJ/8b4+Yqul23FFWGUb1a/dy18Bclxx3OknLt
 pB4G/t5kMgaFgk5FUoH/mF1HNsE0B1/DrScX61nupmbrGNG9pUdLO9sRxMk2GaRbpjlu
 DnUYOMv8WFfT9t6QLnLws5u9ULAJuDPWmWPRA+hAws6SNzSDflsLwoFOg4ytBa5YlILi 9Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3668pqhduy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jan 2021 11:51:26 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7B6B610002A;
        Fri, 22 Jan 2021 11:51:25 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6D92122DBCA;
        Fri, 22 Jan 2021 11:51:25 +0100 (CET)
Received: from localhost (10.75.127.48) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 22 Jan 2021 11:51:25
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
        <linux-kernel@vger.kernel.org>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH 09/14] dt-bindings: reset: add MCU HOLD BOOT ID for SCMI reset domains on stm32mp15
Date:   Fri, 22 Jan 2021 11:50:56 +0100
Message-ID: <20210122105101.27374-10-gabriel.fernandez@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210122105101.27374-1-gabriel.fernandez@foss.st.com>
References: <20210122105101.27374-1-gabriel.fernandez@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-22_06:2021-01-21,2021-01-22 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>

Add ID to SCMI0 to exposes reset controller for the MCU HOLD BOOT resource.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
---
 include/dt-bindings/reset/stm32mp1-resets.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/reset/stm32mp1-resets.h b/include/dt-bindings/reset/stm32mp1-resets.h
index bc71924faa54..f3a0ed317835 100644
--- a/include/dt-bindings/reset/stm32mp1-resets.h
+++ b/include/dt-bindings/reset/stm32mp1-resets.h
@@ -7,6 +7,7 @@
 #ifndef _DT_BINDINGS_STM32MP1_RESET_H_
 #define _DT_BINDINGS_STM32MP1_RESET_H_
 
+#define MCU_HOLD_BOOT_R	2144
 #define LTDC_R		3072
 #define DSI_R		3076
 #define DDRPERFM_R	3080
@@ -117,5 +118,6 @@
 #define RST_SCMI0_RNG1		8
 #define RST_SCMI0_MDMA		9
 #define RST_SCMI0_MCU		10
+#define RST_SCMI0_MCU_HOLD_BOOT	11
 
 #endif /* _DT_BINDINGS_STM32MP1_RESET_H_ */
-- 
2.17.1

