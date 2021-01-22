Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18A1300121
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 12:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbhAVLDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 06:03:52 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:35770 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727658AbhAVKwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 05:52:23 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10MAlUGJ011277;
        Fri, 22 Jan 2021 11:51:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=tRfkUbsOHdsqqLC7XEqLwhsAVzj6M9H/lhJ1kalkBTY=;
 b=i/N24KvBNjMxlVMSsZ/V9qlY7SqHiKNM8JNoXCOKK3CjcOuhh284iH3uNp7ylO2Z68rn
 CIBByFnYMgfZSOMx2FW88lCrmJYKxklP6ezKmeyhhGbjD8O793+0v69kMDn+pFhJ/YZ7
 S8dhqd24XO0l59TlLkFoqz/HAVeqdFBN5DmLqrpZTE3Cy3bKEPz97fZn9Q7nJPQjBnF2
 Lt/87kyCxAqL94x0tb/VpwycU4aVDrGV936dPGGPaPjM8DAI215p23lmlWaby3Fovmao
 2xtsql6RXGnFbo7ywE9NjrnomOcd2fHju+DTbMwzYOP9yoV71FhGBvhRzvFdP3WZUArt LA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3668pe1e2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jan 2021 11:51:28 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 41FC310002A;
        Fri, 22 Jan 2021 11:51:28 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3348B22DBCA;
        Fri, 22 Jan 2021 11:51:28 +0100 (CET)
Received: from localhost (10.75.127.51) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 22 Jan 2021 11:51:27
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
Subject: [PATCH 13/14] dt-bindings: clock: stm32mp1 new compatible for secure rcc
Date:   Fri, 22 Jan 2021 11:51:00 +0100
Message-ID: <20210122105101.27374-14-gabriel.fernandez@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210122105101.27374-1-gabriel.fernandez@foss.st.com>
References: <20210122105101.27374-1-gabriel.fernandez@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-22_06:2021-01-21,2021-01-22 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>

Introduce new compatible string "st,stm32mp1-rcc-secure" for
stm32mp1 clock driver when the device is configured with RCC
security support hardened.

Signed-off-by: Etienne Carriere <etienne.carriere@st.com>
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
---
 Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml b/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
index 4e385508f516..95f5990775c4 100644
--- a/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
+++ b/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
@@ -54,6 +54,7 @@ properties:
 
   compatible:
     items:
+      - const: st,stm32mp1-rcc-secure
       - const: st,stm32mp1-rcc
       - const: syscon
 
@@ -71,7 +72,7 @@ additionalProperties: false
 examples:
   - |
     rcc: rcc@50000000 {
-        compatible = "st,stm32mp1-rcc", "syscon";
+        compatible = "st,stm32mp1-rcc-secure", "syscon";
         reg = <0x50000000 0x1000>;
         #clock-cells = <1>;
         #reset-cells = <1>;
-- 
2.17.1

