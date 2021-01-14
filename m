Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 840F32F60DC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 13:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbhANMOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 07:14:04 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:50874 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727806AbhANMOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 07:14:03 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10ECCe4e016159;
        Thu, 14 Jan 2021 13:13:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=JfIx5atQouE/R4/zGfspOhyNCyg29ivNiiZH2lPhL+E=;
 b=5Lv/q7+gtkL1gF7R6wp1As5lrIbScvigmNY7O56a+Cfq1JNB50jPjqtEBIXI3JReUCD9
 1+3kglTOSm2/N5tnnK0nW4TvNFBiZyGOJrJpeYzwgyO8cuCKfJFVqpqQRghb8kUhtvD6
 KjVG7P36+qwFt2a0EdQziltNuwR/06IJHVSkbBNPGZDDzia/4w86pvhzPeMXhDDko5BC
 TW+vqKtVn/isD4bsuSJ0Z6kTcc4+QZvs+C0AY20aKIx2qP1D9OP6r/pn//bziGRxJO9P
 W7Z0YrlTc/075vtCMUOG5dJ7ZIJTKQTR7YW+4u/Rg73kV8ckB79NMGTfVlubcMQOu74P JQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 35y5kywkmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jan 2021 13:13:11 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CFA1710002A;
        Thu, 14 Jan 2021 13:13:10 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C056823BD5F;
        Thu, 14 Jan 2021 13:13:10 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 14 Jan 2021 13:13:10
 +0100
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [PATCH 0/4] ARM: stm32: USBPHYC updates on stm32mp15
Date:   Thu, 14 Jan 2021 13:13:04 +0100
Message-ID: <20210114121308.31326-1-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-14_04:2021-01-14,2021-01-14 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series updates usbphyc parent and child nodes to follow latest DT
bindings.

Amelie Delaunay (4):
  ARM: dts: stm32: add usbphyc vdda1v1 and vdda1v8 supplies on
    stm32mp151
  ARM: dts: stm32: remove usbphyc ports vdda1v1-vdda1v8 on
    stm32mp157c-ed1
  ARM: dts: stm32: remove usbphyc ports vdda1v1-vdda1v8 on
    stm32mp15xx-dkx
  ARM: dts: stm32: add #clock-cells property to usbphyc node on
    stm32mp151

 arch/arm/boot/dts/stm32mp151.dtsi      | 3 +++
 arch/arm/boot/dts/stm32mp157c-ed1.dts  | 4 ----
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi | 4 ----
 3 files changed, 3 insertions(+), 8 deletions(-)

-- 
2.17.1

