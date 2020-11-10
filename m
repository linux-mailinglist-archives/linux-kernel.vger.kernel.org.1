Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E7B2AD8C5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 15:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731576AbgKJO1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 09:27:52 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:55116 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730059AbgKJO1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 09:27:50 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AAEQmCD031683;
        Tue, 10 Nov 2020 15:27:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=4Ty83/TowSR8YVPhqDC5ICQjWJPGZm9kuRNoKkYMLlU=;
 b=LMeeg88hMbk9n8RMA90/GLscZQaGtjXgKLFaedYMoqWZ5G9R4Fyu8lXo7wpBcLYkqDIJ
 c8lxM2DF5D2vCKy83SPGcs5Mw4BJgRhUOC7DhN8NKpWRNHxs642+xu6jK+ruUrIM4+1M
 AdZew5giFo8ugbdaVUOw7HXI3O82sJ/Lv/XJWRqVPHOO1T8UnHXvQmr3v0t7FDB+K86w
 yYeh7nMzkscoKMa1Yas2PcW6taljbbKbJob2Apkbt7veLtFUDXzGBhWJRlQdb5QZyv2+
 hhjfKvVRpWpnAAlHXLj4q5BA9/XAWJqMAfDOGUYwNGTK7boukkXhdwfYjIH1lNG88H4W IQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34nkbn0r2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Nov 2020 15:27:42 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8453310002A;
        Tue, 10 Nov 2020 15:27:41 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 76E292BA2A5;
        Tue, 10 Nov 2020 15:27:41 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 10 Nov 2020 15:27:40
 +0100
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 2/2] ARM: dts: stm32: fix dmamux reg property on stm32h743
Date:   Tue, 10 Nov 2020 15:27:37 +0100
Message-ID: <20201110142737.13106-2-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201110142737.13106-1-amelie.delaunay@st.com>
References: <20201110142737.13106-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG3NODE2.st.com
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
 arch/arm/boot/dts/stm32h743.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
index 7febe19e780d..b083afd0ebd6 100644
--- a/arch/arm/boot/dts/stm32h743.dtsi
+++ b/arch/arm/boot/dts/stm32h743.dtsi
@@ -274,7 +274,7 @@
 
 		dmamux1: dma-router@40020800 {
 			compatible = "st,stm32h7-dmamux";
-			reg = <0x40020800 0x1c>;
+			reg = <0x40020800 0x40>;
 			#dma-cells = <3>;
 			dma-channels = <16>;
 			dma-requests = <128>;
-- 
2.17.1

