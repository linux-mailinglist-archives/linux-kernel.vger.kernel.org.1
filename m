Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93DD42F5E96
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 11:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbhANKU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 05:20:56 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:22072 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728536AbhANKUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 05:20:54 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10EAGtID027251;
        Thu, 14 Jan 2021 11:20:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=uRMtnaR4nE3tG37P3bZ8OgCpL4zhPMq+PIk8rSGnLv4=;
 b=EflVwLSqpcVEBNdMVtazs0PYctOw+4RxXuYyNyPMPkipOPlGvll051525PXwM6TQfkkn
 Y2D3qaMNcpw/OullNs0z3hb5r9rTlbNVYo96Ax46mXT0/L294Jbh1BBETR/V9ncrcbm6
 r6HAaOLFLsNww7D4Vk2l6UO+M2jLSf+HY6gDk5TFu+UokLC6fqe64HNtp7cBLseKB8lv
 1VfOnMS44MJieiBirl1ZVTEBF2/fFvjD/5cSXgi76sQsfcUzVhwJDbQ0qfRLUZg/VkF3
 BMwqmGjqgnl6qPebB1/PDMzvxo6CwEu4qN1tL0t+b3MfUAZDyWM4gGdqLpTQ7BO4neNn mQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 35yp3y1p90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jan 2021 11:20:00 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 244DA10002A;
        Thu, 14 Jan 2021 11:19:59 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0F6F322E763;
        Thu, 14 Jan 2021 11:19:59 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 14 Jan 2021 11:19:58
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
Subject: [PATCH 0/2] STM32 USBPHYC ck_usbo_48m clock provider
Date:   Thu, 14 Jan 2021 11:19:47 +0100
Message-ID: <20210114101949.23859-1-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-14_03:2021-01-13,2021-01-14 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

STM32 USBPHYC provides clocks to STM32 RCC pour STM32 USB controllers.
Specifically, ck_usbo_48m is a possible clock parent for USB OTG clock,
during OTG Full-Speed operation.

This series registers the usbphyc as clock provider of this ck_usbo_48m clock.

Amelie Delaunay (2):
  dt-bindings: phy: phy-stm32-usbphyc: add #clock-cells required
    property
  phy: stm32: register usbphyc as clock provider of ck_usbo_48m clock

 .../bindings/phy/phy-stm32-usbphyc.yaml       |  6 ++
 drivers/phy/st/phy-stm32-usbphyc.c            | 66 +++++++++++++++++++
 2 files changed, 72 insertions(+)

-- 
2.17.1

