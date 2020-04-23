Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47B91B5C50
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 15:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgDWNTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 09:19:41 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:51327 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727886AbgDWNTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 09:19:39 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03NDDJS7010131;
        Thu, 23 Apr 2020 15:19:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=0iFYsQyTUgOk84NaKLSbcNPEPJCYxqyXlBWbTghS5Vs=;
 b=ARJ/Ze+lhSBdkjhrtjMbG9AwPUER0k+I0n044Kbq7nlCH5CH5uEjxAfVLQ+nUK6C0Zi3
 EnuXkKmX7Yg6XAGbw8ckt6Ph/UBhWW8C8/pmE+S/rF+Hk6PeH2M9Kwx5UmGM8WDS6Ecf
 yph6SqD61MwPZ0WXpTvbqKAD92UYZMAKUkfanhP54xZWz6au2jV7hAGSy4j2zGD00Vc+
 aMgf8yXdmsyh4uetu6PCAtGm1A2Bc6epn1m1qv72ft1YPh0N8bTQPkXYe5Fka3H/d+l4
 In2Slfhq7Cn6mB0Kv7sXOoq8ZWThxDY+d31vHXN8g/5p7UNCfxkD97Uf2FfTQ5s9LiTp vw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30fqawmx8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Apr 2020 15:19:23 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A316510002A;
        Thu, 23 Apr 2020 15:19:22 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9844C20758D;
        Thu, 23 Apr 2020 15:19:22 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 23 Apr 2020 15:19:21
 +0200
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <robh+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <gregkh@linuxfoundation.org>,
        <loic.pallardy@st.com>, <linus.walleij@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v2 5/5] ARM: dts: stm32: Use ETZPC firewall bus
Date:   Thu, 23 Apr 2020 15:19:13 +0200
Message-ID: <20200423131913.30786-6-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200423131913.30786-1-benjamin.gaignard@st.com>
References: <20200423131913.30786-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-23_10:2020-04-23,2020-04-23 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow STM32 ETZPC to check firewall configuration before populating
the platform bus.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
version 2:
- fix unit name in soc node

 arch/arm/boot/dts/stm32mp151.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
index 3ea05ba48215..0290eb6f3c35 100644
--- a/arch/arm/boot/dts/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/stm32mp151.dtsi
@@ -4,6 +4,7 @@
  * Author: Ludovic Barre <ludovic.barre@st.com> for STMicroelectronics.
  */
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/bus/stm32/stm32-etzpc.h>
 #include <dt-bindings/clock/stm32mp1-clks.h>
 #include <dt-bindings/reset/stm32mp1-resets.h>
 
@@ -110,8 +111,10 @@
 		status = "disabled";
 	};
 
-	soc {
-		compatible = "simple-bus";
+	etzpc_bus: soc@5c007000 {
+		compatible = "st,stm32-etzpc-bus", "simple-bus";
+		reg = <0x5c007000 0x400>;
+		#firewall-cells = <2>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 		interrupt-parent = <&intc>;
-- 
2.15.0

