Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949EB2AD8E6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 15:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730744AbgKJOgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 09:36:52 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:11278 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726721AbgKJOgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 09:36:51 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AAEVoEM024503;
        Tue, 10 Nov 2020 15:36:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=mFr7Ui8Iql0dktouHacp+cT97Cl9za3NdjBtbhITl9k=;
 b=swFcLPEoP8AaLoTC2Q1cgfZOMyv4PETC6uds+noRNSpqPofafKvIxnEcZa3F40xZFWmc
 cDXF1gciTncG1/vfY41gkcsrOTfsGmFOfAj4J/42cf4OqE7ZIEwuEQE3TkAu8YX47ITI
 nTxFhv0WBp6ZSNRhcCECQQeS543f/3+rZRCr0rP1LCB07k1kk192Ho7tV0wNX/6JpMlo
 04zo3IC30E726aJA3yuYqyS1+KJy/xC3v6cLiTnum6SQa3eADZFFDAxxZUZJ6+0SUbhl
 0Dmgop4YMLLvDEKOZUM8xAPNxZjf98lcmtw2hACeR+lJQTxkooCvlDOSvgf5ujqi7KeS Pw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34nhkcs7s7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Nov 2020 15:36:42 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4DA93100034;
        Tue, 10 Nov 2020 15:36:42 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 404022BA2D3;
        Tue, 10 Nov 2020 15:36:42 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 10 Nov 2020 15:36:41
 +0100
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 1/1] ARM: dts: stm32: fix mdma1 clients channel priority level on stm32mp151
Date:   Tue, 10 Nov 2020 15:36:41 +0100
Message-ID: <20201110143641.13879-1-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-10_05:2020-11-10,2020-11-10 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update mdma1 clients channel priority level following stm32-mdma bindings.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32mp151.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
index 719a4276a348..b95c46c82223 100644
--- a/arch/arm/boot/dts/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/stm32mp151.dtsi
@@ -1294,7 +1294,7 @@
 			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&rcc HASH1>;
 			resets = <&rcc HASH1_R>;
-			dmas = <&mdma1 31 0x10 0x1000A02 0x0 0x0>;
+			dmas = <&mdma1 31 0x2 0x1000A02 0x0 0x0>;
 			dma-names = "in";
 			dma-maxburst = <2>;
 			status = "disabled";
@@ -1358,8 +1358,8 @@
 			reg = <0x58003000 0x1000>, <0x70000000 0x10000000>;
 			reg-names = "qspi", "qspi_mm";
 			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
-			dmas = <&mdma1 22 0x10 0x100002 0x0 0x0>,
-			       <&mdma1 22 0x10 0x100008 0x0 0x0>;
+			dmas = <&mdma1 22 0x2 0x100002 0x0 0x0>,
+			       <&mdma1 22 0x2 0x100008 0x0 0x0>;
 			dma-names = "tx", "rx";
 			clocks = <&rcc QSPI_K>;
 			resets = <&rcc QSPI_R>;
-- 
2.17.1

