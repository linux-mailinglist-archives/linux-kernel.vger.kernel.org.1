Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6470D2F60E2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 13:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbhANMOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 07:14:17 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:58228 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728691AbhANMOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 07:14:04 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10ECC2PZ029600;
        Thu, 14 Jan 2021 13:13:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=c+Aah01poqisBSnVrKowoWFXX7asidtG2KzrPV6ZGbc=;
 b=Z00ey/3SLkrS4pJbcNkh6/Lxl6AgxgZwo+Xhx6A/y7cv5lmHMyWm6YCjfHmQacoiq88P
 7AwvhRWqoNguDDTUtunyY/GYU88tvcCPBmZM5I3tG14PEHhifx+ndCq+aExbTQs5kh0B
 eipvZ2XVi7CCMfcyA17czThK/6wChYZ4uyj5eLzzC93a2a9fxcdnn0HNXbQ2Zvi5mhDI
 7ZapI3EYLEh4bjMhtuxEhWBF9mcIFjUGFs5CFVKuCEeA65EClA+A4x0HjS/HRZgjG0XT
 QCE/Ockp2GkofojIQpZ86RRyOegoEsbczB8ayx5n7eQwAQbMxB1qa0TC2zxj2r83VEfL 3g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 362379d9xw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jan 2021 13:13:14 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 61740100034;
        Thu, 14 Jan 2021 13:13:14 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 54F9623BD5D;
        Thu, 14 Jan 2021 13:13:14 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 14 Jan 2021 13:13:13
 +0100
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [PATCH 4/4] ARM: dts: stm32: add #clock-cells property to usbphyc node on stm32mp151
Date:   Thu, 14 Jan 2021 13:13:08 +0100
Message-ID: <20210114121308.31326-5-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210114121308.31326-1-amelie.delaunay@foss.st.com>
References: <20210114121308.31326-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-14_04:2021-01-14,2021-01-14 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usbphyc is a 48Mhz clock provider: the clock can be used as clock source
for USB OTG. Add #clock-cells property to usbphyc node to reflect this
capability.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 arch/arm/boot/dts/stm32mp151.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
index 07cb927ba06d..51acb2b04720 100644
--- a/arch/arm/boot/dts/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/stm32mp151.dtsi
@@ -1482,6 +1482,7 @@
 		usbphyc: usbphyc@5a006000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
+			#clock-cells = <0>;
 			compatible = "st,stm32mp1-usbphyc";
 			reg = <0x5a006000 0x1000>;
 			clocks = <&rcc USBPHY_K>;
-- 
2.17.1

