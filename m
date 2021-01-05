Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC1D2EA6F9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 10:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbhAEJGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 04:06:48 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:8860 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727658AbhAEJGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 04:06:30 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10593qwo012400;
        Tue, 5 Jan 2021 10:05:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=O140SVpPX52EvSpVTor2Elkzvf+rEN1U4v684qmVLoY=;
 b=PvK3OvbOtFQ0yUNjOpkKI+9CE+OeBi67C8GjeW3ObL0jQvPpksRcCIEWo0Pr7cdpxPcv
 iU3KLx9xHe8gosx8L1NvEZ3W0EQmUcCO3Nnf2vSH4t58sLiQsvUBABtizhhTgyrAfvz2
 L2LL7syqqfF+SryntfV4OOxfPnJ9EgARUhYZjYCVAdy+GJ/IGQKiIH0A8z/HOEnMoMId
 K/DKWCIEix7Xp4VdDCm/XKxKMqayiRthnw5hjQ4/T01IsYWWR/ATc/gGjYJOR65TC9Zv
 CDoVfrBVgfOdLEmfdhCxzDJopoCSvoDw41QVyGbXmq3OpvaLB5RqRXrzqNaqxqW5KCbI Nw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 35teuuywx6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Jan 2021 10:05:34 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 44094100034;
        Tue,  5 Jan 2021 10:05:33 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2D52322AA5B;
        Tue,  5 Jan 2021 10:05:33 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 5 Jan 2021 10:05:32
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
Subject: [PATCH v2 0/6] STM32 USBPHYC PLL management rework
Date:   Tue, 5 Jan 2021 10:05:19 +0100
Message-ID: <20210105090525.23164-1-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-05_01:2021-01-05,2021-01-05 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

STM32 USBPHYC controls the USB PLL. PLL requires to be powered with 1v1 and 1v8
supplies. To ensure a good behavior of the PLL, during boot, runtime and
suspend/resume sequences, this series reworks its management to fix regulators
issues and improve PLL status reliability.

---
Changes in v2:
- Move author mail address from @st.com to @foss.st.com
- Add Rob's Reviewed-by on bindings patch 1/6

Amelie Delaunay (6):
  dt-bindings: phy: phy-stm32-usbphyc: move PLL supplies to parent node
  phy: stm32: manage 1v1 and 1v8 supplies at pll activation/deactivation
  phy: stm32: replace regulator_bulk* by multiple regulator_*
  phy: stm32: ensure pll is disabled before phys creation
  phy: stm32: ensure phy are no more active when removing the driver
  phy: stm32: rework PLL Lock detection

 .../bindings/phy/phy-stm32-usbphyc.yaml       |  22 +-
 drivers/phy/st/phy-stm32-usbphyc.c            | 222 +++++++++++-------
 2 files changed, 153 insertions(+), 91 deletions(-)

-- 
2.17.1

