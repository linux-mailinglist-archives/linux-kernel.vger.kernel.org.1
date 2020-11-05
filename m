Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91BE72A7B8F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 11:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbgKEKYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 05:24:36 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:57250 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725998AbgKEKYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 05:24:35 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A5A89PT014169;
        Thu, 5 Nov 2020 11:24:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=TOuuQi7kHFY4nckI56A30MbQUrrRmpJCi/1iA3R/tbM=;
 b=gxqofYC0WvJbsxfztzPn2daT+CLJI7Orb+dr7fJX2wsdnSTIIvnPxBtRQOGYUbRWfScw
 Q4WAeEtGeAeIjaAZP7iswYNatbym5cd0OqO9wsh3yj/hEIOiBjuzWnVM/2WhEUXRvobi
 CNDvmvCAwXcXQt3GRSIBThYLk5iAyQ9ngQjJB9kA1/2Pi6jRdAoXbuJB1sl+2J8Mcnd2
 YsqukI1iS3XpSvLdgMG7hsPwq0OPMV5esSg0mbqj4ZAPFDOt4WuUxW2eKVwkc78cAoxj
 ecDl3E5ufPLZcpr2pWb49bEG79N9raN2MY4eQN7TeEfYROSL9eTlYzpwdmtGi9r1Vv3h +w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34gywr739r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Nov 2020 11:24:24 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CD86B100039;
        Thu,  5 Nov 2020 11:24:23 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BA10A23E140;
        Thu,  5 Nov 2020 11:24:23 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 5 Nov 2020 11:23:43
 +0100
From:   Lionel Debieve <lionel.debieve@st.com>
To:     Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Nicolas Toromanoff <nicolas.toromanoff@st.com>
Subject: [PATCH 2/3] ARM: dts: stm32: enable CRC1 by default on stm32mp15
Date:   Thu, 5 Nov 2020 11:23:30 +0100
Message-ID: <20201105102331.12984-3-lionel.debieve@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201105102331.12984-1-lionel.debieve@st.com>
References: <20201105102331.12984-1-lionel.debieve@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-05_05:2020-11-05,2020-11-05 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Toromanoff <nicolas.toromanoff@st.com>

Enable CRC1 device for CRC-32 accelerated support on
stm32mp15 STMicroelectronics platforms.

Signed-off-by: Nicolas Toromanoff <nicolas.toromanoff@st.com>
Signed-off-by: Lionel Debieve <lionel.debieve@st.com>
---
 arch/arm/boot/dts/stm32mp157c-ed1.dts  | 4 ++++
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c-ed1.dts b/arch/arm/boot/dts/stm32mp157c-ed1.dts
index 1a98a29b3283..99796ffa43bf 100644
--- a/arch/arm/boot/dts/stm32mp157c-ed1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ed1.dts
@@ -115,6 +115,10 @@
 	};
 };
 
+&crc1 {
+	status = "okay";
+};
+
 &dac {
 	pinctrl-names = "default";
 	pinctrl-0 = <&dac_ch1_pins_a &dac_ch2_pins_a>;
diff --git a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
index e92a18542306..4e74e55a4f07 100644
--- a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
+++ b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
@@ -124,6 +124,10 @@
 	status = "okay";
 };
 
+&crc1 {
+	status = "okay";
+};
+
 &dts {
 	status = "okay";
 };
-- 
2.17.1

