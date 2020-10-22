Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9AC2963DB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 19:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369225AbgJVRkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 13:40:15 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:33022 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2900809AbgJVRkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 13:40:14 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09MHcRlQ032683;
        Thu, 22 Oct 2020 19:40:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=Xw2dy81ycIuPHgArY2fy2sR4NSk39ZIqh0+V1r9E/1g=;
 b=Ee5NYNnVjcoDL5X8c9yTGtXrZ09WHlB7MZzMNDboKy/S/Wn74O/3UATiNAnv27HLIrql
 1PSyoAhG43w6F9r5vFSmvscZMkJP9qZZirRtpdmR4wXGRAOL+NJV9y3V4ufa7XPUWj2Y
 0VD5mFxGkbx/I1gmqFaLSZHGD+X4opTzhXX/IdxyUIVVNsnwO5ik0CfMn5uU2GESu9yq
 FZFjp2FG8uGrV7/fHB5tKO1kzLEETeOgNfTa0tyhvqmfHTrLHJpxqxjyKo2wI4PM9RrJ
 Kyspkp+h/GWtfnnZFm5BedVNXGmqz0U3LY0JN9/4DdIdc5XYPDmd1TUk/WWIb2W2ua35 Yw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34apedr4ch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Oct 2020 19:40:02 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8FEE310002A;
        Thu, 22 Oct 2020 19:40:01 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 79B892B415C;
        Thu, 22 Oct 2020 19:40:01 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 22 Oct 2020 19:40:00
 +0200
From:   Patrick Delaunay <patrick.delaunay@st.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Patrick Delaunay <patrick.delaunay@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] ARM: dts: stm32: reorder spi4 within stm32mp15-pinctrl
Date:   Thu, 22 Oct 2020 19:38:51 +0200
Message-ID: <20201022173851.20114-1-patrick.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-22_12:2020-10-20,2020-10-22 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move spi4 at the right alphabetical place within stm32mp15-pinctrl

Fixes: 4fe663890ac5 ("ARM: dts: stm32: Fix spi4 pins in stm32mp15-pinctrl")
Signed-off-by: Patrick Delaunay <patrick.delaunay@st.com>
---

 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi | 28 ++++++++++++------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
index d84686e00370..c9e514165672 100644
--- a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
@@ -1591,6 +1591,20 @@
 		};
 	};
 
+	spi4_pins_a: spi4-0 {
+		pins {
+			pinmux = <STM32_PINMUX('E', 12, AF5)>, /* SPI4_SCK */
+				 <STM32_PINMUX('E', 6, AF5)>;  /* SPI4_MOSI */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <1>;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('E', 13, AF5)>; /* SPI4_MISO */
+			bias-disable;
+		};
+	};
+
 	uart4_pins_a: uart4-0 {
 		pins1 {
 			pinmux = <STM32_PINMUX('G', 11, AF6)>; /* UART4_TX */
@@ -1726,20 +1740,6 @@
 		};
 	};
 
-	spi4_pins_a: spi4-0 {
-		pins {
-			pinmux = <STM32_PINMUX('E', 12, AF5)>, /* SPI4_SCK */
-				 <STM32_PINMUX('E', 6, AF5)>;  /* SPI4_MOSI */
-			bias-disable;
-			drive-push-pull;
-			slew-rate = <1>;
-		};
-		pins2 {
-			pinmux = <STM32_PINMUX('E', 13, AF5)>; /* SPI4_MISO */
-			bias-disable;
-		};
-	};
-
 	usart2_pins_a: usart2-0 {
 		pins1 {
 			pinmux = <STM32_PINMUX('F', 5, AF7)>, /* USART2_TX */
-- 
2.17.1

