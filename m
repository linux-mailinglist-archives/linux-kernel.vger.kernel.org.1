Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 239DF2AD8C4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 15:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730831AbgKJO1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 09:27:51 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:55112 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730097AbgKJO1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 09:27:50 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AAEQmCC031683;
        Tue, 10 Nov 2020 15:27:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=BuSIs1RLZzn0DgKmvlINLOfEYXG1qK86zGXQ02OVN/E=;
 b=xoy0bVj/2BNSyj4i137dqmqri5SVPGhQtk0v0Q2c8a1K+31/PHkd1J0wWxTYWF7QiJwz
 BzolwFi0VRo5to9MgD8rodeHFKy2FcGvIGhAx/h6Jcromh0WQMzRl7ACtRY1oEEI6xah
 jR4UmYHHj0WZr7eh9dzqK8XixvZzPPWpZ/8hqF1yMq8kayaSJC0ViES9PSA24RwKY3Jl
 cN1mM9qv/Q2Kn7yd4Z3sppBoFRsPeh5eBoJ0JSdgbGpyyO59ad8slueUgIGmg9v4TlWU
 Mu6oaO4eRrRZ7vtcDn1j0BIZh3ovh8BKNQnEVUh4B/DoZFEaxK1x6ptSsjQB4S6STE61 wA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34nkbn0r28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Nov 2020 15:27:40 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 583AB10002A;
        Tue, 10 Nov 2020 15:27:40 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 462FA2BA2A5;
        Tue, 10 Nov 2020 15:27:40 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 10 Nov 2020 15:27:39
 +0100
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 1/2] ARM: dts: stm32: fix dmamux reg property on stm32mp151
Date:   Tue, 10 Nov 2020 15:27:36 +0100
Message-ID: <20201110142737.13106-1-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-10_05:2020-11-10,2020-11-10 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reg property length should cover all DMAMUX_CxCR registers.
DMAMUX_CxCR Address offset: 0x000 + 0x04 * x (x = 0 to 15), so latest
offset is at 0x3c, so length should be 0x40.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32mp151.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
index 928e31db1526..719a4276a348 100644
--- a/arch/arm/boot/dts/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/stm32mp151.dtsi
@@ -1001,7 +1001,7 @@
 
 		dmamux1: dma-router@48002000 {
 			compatible = "st,stm32h7-dmamux";
-			reg = <0x48002000 0x1c>;
+			reg = <0x48002000 0x40>;
 			#dma-cells = <3>;
 			dma-requests = <128>;
 			dma-masters = <&dma1 &dma2>;
-- 
2.17.1

