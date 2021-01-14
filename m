Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599B92F672D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbhANROT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:14:19 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:45190 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728465AbhANROQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:14:16 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10EHCe8A031982;
        Thu, 14 Jan 2021 18:13:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=2lo+OyU1IpPkkgxOb9zUqjirZckmzwOSq2OQw/y+JCc=;
 b=g2zGjY6xJa4FB6C8B3jFcw0kw5epBTYnnX83ZRxw6ZbCvXpZAdBWuhpvZhqFjyrcaHbl
 pa3xOiqpPs+Qx0H5QoRiqkteYsk/eAslWR1QNUJSro+7qGKpGOFBuLF2YAzDCvESORrs
 PvExSoaRSQnXb/2PlEn7xAmBw1dABQO63vstDtuBh1FXmMZfrgS2lJZndwf3uisYAF35
 hcbBhMpe30w5LaW1YrmAEbl/KAQomwgjScyBk1i0rQDIr7yn5iH+OKOrsqd43CgihfGo
 RKmt2Jg8IbOlzdVMJg1S7wTT4dA5bIapqhS2ZYXjFj9RySI1xm8uShG2eQeR6HqW9Td6 ug== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 35y5kyy4wt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jan 2021 18:13:26 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 63F9010002A;
        Thu, 14 Jan 2021 18:13:25 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 519A825D03A;
        Thu, 14 Jan 2021 18:13:25 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 14 Jan 2021 18:13:24
 +0100
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [PATCH v2 1/2] dt-bindings: phy: phy-stm32-usbphyc: add #clock-cells required property
Date:   Thu, 14 Jan 2021 18:13:13 +0100
Message-ID: <20210114171314.18946-2-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210114171314.18946-1-amelie.delaunay@foss.st.com>
References: <20210114171314.18946-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-14_06:2021-01-14,2021-01-14 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usbphyc provides a unique clock called ck_usbo_48m.
STM32 USB OTG needs a 48Mhz clock (utmifs_clk48) for Full-Speed operation.
ck_usbo_48m is a possible parent clock for USB OTG 48Mhz clock.

ck_usbo_48m is available as soon as the PLL is enabled.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
No change in v2.
---
 .../devicetree/bindings/phy/phy-stm32-usbphyc.yaml          | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml b/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml
index 46df6786727a..4e4da64b8e01 100644
--- a/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml
@@ -51,6 +51,10 @@ properties:
   vdda1v8-supply:
     description: regulator providing 1V8 power supply to the PLL block
 
+  '#clock-cells':
+    description: number of clock cells for ck_usbo_48m consumer
+    const: 0
+
 #Required child nodes:
 
 patternProperties:
@@ -102,6 +106,7 @@ required:
   - "#size-cells"
   - vdda1v1-supply
   - vdda1v8-supply
+  - '#clock-cells'
   - usb-phy@0
   - usb-phy@1
 
@@ -120,6 +125,7 @@ examples:
         vdda1v8-supply = <&reg18>;
         #address-cells = <1>;
         #size-cells = <0>;
+        #clock-cells = <0>;
 
         usbphyc_port0: usb-phy@0 {
             reg = <0>;
-- 
2.17.1

