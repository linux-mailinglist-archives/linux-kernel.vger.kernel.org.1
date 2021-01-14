Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48FC12F61B2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 14:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbhANNQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 08:16:41 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:17950 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725884AbhANNQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 08:16:40 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10ED3EfT010817;
        Thu, 14 Jan 2021 14:15:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=0yITV9Unr5TMpD6GGlqjTAmm7hXiyAS/6iZIuILS1XQ=;
 b=JYSq6HcjjNUbgU7HaHf+bQRCCZG8RoW4Nran6cG3dPNJfGHFJ2vk8c+pVpE2KqIVFlWi
 3qtkkI1ohB36eKvUWTX7Bq/LylWhdZZMLuoDjSB2cNRO/z6rYtH3H8Px38Tnh/mv2e1j
 ij2SJqgMhcnhBtfF+iDNzBc5RS9WS20Hw862Ny/24XIZvs9a4w95e6c7FSNMraTmHoCA
 jNbkn669aEBvaUQJYa9qxvYL2v62mKTgH+OZooTwFYZzU+xrJDEMf8gkpfpkdtE5HRvv
 I1DSvCZ9uQO0W8GnCt3fmZ0c5CuKkwWltsNSvbECFMeTL7eCzb1gBH9RqrCP5/dY0+2s 8g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 35yp3y2kkn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jan 2021 14:15:49 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 77E07100038;
        Thu, 14 Jan 2021 14:15:49 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6C5B4246DB4;
        Thu, 14 Jan 2021 14:15:49 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 14 Jan 2021 14:15:48
 +0100
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [PATCH v2 1/3] ARM: dts: stm32: add usbphyc vdda1v1 and vdda1v8 supplies on stm32mp151
Date:   Thu, 14 Jan 2021 14:15:22 +0100
Message-ID: <20210114131524.3298-2-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210114131524.3298-1-amelie.delaunay@foss.st.com>
References: <20210114131524.3298-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-14_04:2021-01-14,2021-01-14 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vdda1v1 and vdda1v8 supplies are required by USB PLL. Add them in usbphyc
node.

Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 arch/arm/boot/dts/stm32mp151.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
index 3c75abacb374..07cb927ba06d 100644
--- a/arch/arm/boot/dts/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/stm32mp151.dtsi
@@ -1486,6 +1486,8 @@
 			reg = <0x5a006000 0x1000>;
 			clocks = <&rcc USBPHY_K>;
 			resets = <&rcc USBPHY_R>;
+			vdda1v1-supply = <&reg11>;
+			vdda1v8-supply = <&reg18>;
 			status = "disabled";
 
 			usbphyc_port0: usb-phy@0 {
-- 
2.17.1

