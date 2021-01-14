Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05EB52F60DD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 13:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbhANMOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 07:14:05 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:14786 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728696AbhANMOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 07:14:04 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10ECCrCw004475;
        Thu, 14 Jan 2021 13:13:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=NTpsfT6iksXu3OeTq0fWgBp3yo+NoitLUQurl4MlQio=;
 b=bUSoSEnW0GZ1k2+zWVhpce7TiMyYKO3r0JqxetI1HpXa2+0FYbunitEMUK9ZBKJur3kV
 rHEhZTtensiBQlcPjnCDoAOy9MokJrvgNpxE42KH39oKeNfT/5KW/FGnIdwZAbsTlWHv
 rXpTP6o/kvZpgdX/wlqYZq+kHtDmCFjTScwrxl62CbIQ6ycMIrlRGlkB76ecNiUiI5uM
 RiRpr6sKrDMB/lAO34YC7eV3IFcWvgbOM1Jw/d+3RpXcK26NUcjb6D0Yci1FjUZZ2Saf
 PosdKiBiOG1iLhSQpLxm3LLaTXq4Y9tPhiN7MAnLHIULT8YKr4TCRUndMw6g04Tp6Ptl UA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 35yp3y29k3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jan 2021 13:13:14 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 85AAA10002A;
        Thu, 14 Jan 2021 13:13:13 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7A38F23BD5D;
        Thu, 14 Jan 2021 13:13:13 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG2NODE3.st.com (10.75.127.6)
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
Subject: [PATCH 3/4] ARM: dts: stm32: remove usbphyc ports vdda1v1-vdda1v8 on stm32mp15xx-dkx
Date:   Thu, 14 Jan 2021 13:13:07 +0100
Message-ID: <20210114121308.31326-4-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210114121308.31326-1-amelie.delaunay@foss.st.com>
References: <20210114121308.31326-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-14_04:2021-01-14,2021-01-14 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vdda1v1 and vdda1v8 supplies are required by USB PLL, not by the PHYs.
Remove them from usbphyc child phy nodes now that they are managed in
usbphyc parent node at SoC level.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
index 89c0e1ddc387..59f18846cf5d 100644
--- a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
+++ b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
@@ -694,14 +694,10 @@
 
 &usbphyc_port0 {
 	phy-supply = <&vdd_usb>;
-	vdda1v1-supply = <&reg11>;
-	vdda1v8-supply = <&reg18>;
 };
 
 &usbphyc_port1 {
 	phy-supply = <&vdd_usb>;
-	vdda1v1-supply = <&reg11>;
-	vdda1v8-supply = <&reg18>;
 };
 
 &vrefbuf {
-- 
2.17.1

