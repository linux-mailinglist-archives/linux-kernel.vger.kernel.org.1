Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3105F28713C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 11:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbgJHJKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 05:10:07 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:42952 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725802AbgJHJKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 05:10:07 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 098988QE020349;
        Thu, 8 Oct 2020 11:09:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=jXqH2UDOby99d4qrNiPaX/nj3Vx3ew8x+EOd0UDJu8g=;
 b=dMJroOBtEk4LKhs71+0vuMln0FbG6WS3sBLvWzCpgAT3rvVxLqDB3ijZuqQBg2yR4U/R
 op/71VIZm+MpKDFhwUgXr5qpi9odKGXdEPEndv7449ufwwPBQAGbJwx43dzTFUjwgZfY
 buwgiMKrtzz6G+TtPz+18vVEyNWD4YnV3vKmkeBzRBdPSZMeNkHH4hWVvUluuhJM2ib3
 KC8DX4DyRt/qEqY2r0skTZmGNudHoZhL/TWm9lL1X1PCmAWSa0of+5/DIli/12chTz65
 k8p287bNs7hxtLw1LV4FbIN2q4TnEsJ4rd645B7is4yYHdK1ToHQYkRvaBt8GnEueH7k OA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3402tk9wf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Oct 2020 11:09:53 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3A4CA10002A;
        Thu,  8 Oct 2020 11:09:51 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag1node1.st.com [10.75.127.1])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 25F5F2AE6B1;
        Thu,  8 Oct 2020 11:09:51 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG1NODE1.st.com (10.75.127.1)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 8 Oct 2020 11:09:50
 +0200
From:   Hugues Fruchet <hugues.fruchet@st.com>
To:     Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Alain Volmat <alain.volmat@st.com>,
        Amelie DELAUNAY <amelie.delaunay@st.com>
Subject: [PATCH] ARM: dts: stm32: fix DCMI DMA features on stm32mp15 family
Date:   Thu, 8 Oct 2020 11:09:42 +0200
Message-ID: <1602148182-25869-1-git-send-email-hugues.fruchet@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG1NODE1.st.com
 (10.75.127.1)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-08_04:2020-10-08,2020-10-08 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable FIFO mode with half-full threshold.

Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
---
 arch/arm/boot/dts/stm32mp151.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
index bfe2902..cfba9a1 100644
--- a/arch/arm/boot/dts/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/stm32mp151.dtsi
@@ -1091,7 +1091,7 @@
 			resets = <&rcc CAMITF_R>;
 			clocks = <&rcc DCMI>;
 			clock-names = "mclk";
-			dmas = <&dmamux1 75 0x400 0x0d>;
+			dmas = <&dmamux1 75 0x400 0x01>;
 			dma-names = "tx";
 			status = "disabled";
 		};
-- 
2.7.4

