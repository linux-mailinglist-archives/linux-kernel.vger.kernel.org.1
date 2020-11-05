Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2532A2A7B92
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 11:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbgKEKYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 05:24:43 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:1266 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725998AbgKEKYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 05:24:39 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A5A80P9027052;
        Thu, 5 Nov 2020 11:24:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=20xvGXuazbtiZb+CzKyJdyuDvP0fmQmKpdBY1dOqpwA=;
 b=0QVniARsAqTxxBBQyqvP8slP0mSG+QUG5+74e4Ra9DLRLvWk2GkuizqZXNqqA7TpbQjk
 +5Te8ClLOnIgle9EzNFb4zAZHL+4BYqLwBZtl19t+mYz6/4s7LLy5j2eg7rmmBYYCnzN
 6aCx6PTvYRCPipUpi+6xmJI2pOW7+rfA2IgKLa8PKFXe8lqS8w1ilhpye76SQivGCFRy
 wJ02GvRi+YyInqD58TCNMjDsrXHQOrUbxSGY4HXUnenUjt/JTOIve4ggOiSJywQwMsAf
 16KuSewmCQPcHF94jSmSnDxkOm1HKuRp2Uakr/MEKFVpXeMprl9rhlmpeoa+WIag5eyb zQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34h00en8pc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Nov 2020 11:24:24 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C87B5100038;
        Thu,  5 Nov 2020 11:24:23 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B8724238FDF;
        Thu,  5 Nov 2020 11:24:23 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 5 Nov 2020 11:23:42
 +0100
From:   Lionel Debieve <lionel.debieve@st.com>
To:     Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Nicolas Toromanoff <nicolas.toromanoff@st.com>
Subject: [PATCH 1/3] ARM: dts: stm32: enable HASH by default on stm32mp15
Date:   Thu, 5 Nov 2020 11:23:29 +0100
Message-ID: <20201105102331.12984-2-lionel.debieve@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201105102331.12984-1-lionel.debieve@st.com>
References: <20201105102331.12984-1-lionel.debieve@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-05_05:2020-11-05,2020-11-05 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable HASH1 device for HASH accelerated support on
stm32mp15 STMicroelectronics platforms.

Signed-off-by: Lionel Debieve <lionel.debieve@st.com>
---
 arch/arm/boot/dts/stm32mp157c-ed1.dts  | 4 ++++
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c-ed1.dts b/arch/arm/boot/dts/stm32mp157c-ed1.dts
index 2e77ccec3fc1..1a98a29b3283 100644
--- a/arch/arm/boot/dts/stm32mp157c-ed1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ed1.dts
@@ -136,6 +136,10 @@
 	contiguous-area = <&gpu_reserved>;
 };
 
+&hash1 {
+	status = "okay";
+};
+
 &i2c4 {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&i2c4_pins_a>;
diff --git a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
index 93398cfae97e..e92a18542306 100644
--- a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
+++ b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
@@ -151,6 +151,10 @@
 	contiguous-area = <&gpu_reserved>;
 };
 
+&hash1 {
+	status = "okay";
+};
+
 &i2c1 {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&i2c1_pins_a>;
-- 
2.17.1

