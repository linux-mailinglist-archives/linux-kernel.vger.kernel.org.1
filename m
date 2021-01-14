Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B85C2F61B4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 14:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbhANNQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 08:16:43 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:39222 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725955AbhANNQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 08:16:42 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10ED2bID016430;
        Thu, 14 Jan 2021 14:15:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=dE1TUuVGYcUczJw86WcXEkSTgFgz2gMWVXOhCYrwAEI=;
 b=RbbyH+XiQ4AzI0iJTjK5eW7p8vXySbcEHv/xolEjuXRU4qhWE9JYuCGC8qF8yEYOL9kn
 BXn52AAL6GHwgTGCsADaLbXN1xa3DtkLxWRFZ4dXfoKwCWelyavR8Wrhv5BC0FeUz96T
 6iib/LCmHEz8pBQ3PqY+LA0zXr2Qs4Rz34QCh5ZO2hzaROnVvBFlNAnV5wWOErgjg8g5
 oaT3C8ZPGcqByR1blrhiBIvdNBm+UXuv3NeY7faQpcFcpTr9qFFwajp1U1zU35w5UgRo
 NJZ4ZsnHDxQb4ISR71+6KyBtZoLSVqfqac6EKW7NduJhb+C84MHl/eb4ePua2iQzjeDO ww== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 35y5kywwmv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jan 2021 14:15:49 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A31A110002A;
        Thu, 14 Jan 2021 14:15:48 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 92770246DB4;
        Thu, 14 Jan 2021 14:15:48 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG2NODE3.st.com (10.75.127.6)
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
Subject: [PATCH v2 0/3] ARM: stm32: USBPHYC updates on stm32mp15
Date:   Thu, 14 Jan 2021 14:15:21 +0100
Message-ID: <20210114131524.3298-1-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-14_04:2021-01-14,2021-01-14 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series updates usbphyc parent and child nodes to follow latest DT
bindings.

---
Changes in v2:
- squash all DT board patches in one patch
- update also non-ST DT

Amelie Delaunay (3):
  ARM: dts: stm32: add usbphyc vdda1v1 and vdda1v8 supplies on
    stm32mp151
  ARM: dts: stm32: remove usbphyc ports vdda1v1 & vdda1v8 on stm32mp15
    boards
  ARM: dts: stm32: add #clock-cells property to usbphyc node on
    stm32mp151

 arch/arm/boot/dts/stm32mp151.dtsi                  | 3 +++
 arch/arm/boot/dts/stm32mp157a-stinger96.dtsi       | 4 ----
 arch/arm/boot/dts/stm32mp157c-ed1.dts              | 4 ----
 arch/arm/boot/dts/stm32mp15xx-dhcom-drc02.dtsi     | 2 --
 arch/arm/boot/dts/stm32mp15xx-dhcom-pdk2.dtsi      | 4 ----
 arch/arm/boot/dts/stm32mp15xx-dhcom-picoitx.dtsi   | 4 ----
 arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi | 4 ----
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi             | 4 ----
 8 files changed, 3 insertions(+), 26 deletions(-)

-- 
2.17.1

