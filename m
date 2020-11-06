Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8532A99FC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 17:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbgKFQ6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 11:58:36 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:56045 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726422AbgKFQ6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 11:58:35 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A6Gw7nD029551;
        Fri, 6 Nov 2020 17:58:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=GozlANq+XkXoD4Q74QGPnPPxDV3VlqucsLYQ1hhMIvo=;
 b=osKMH6zfoiMC/79lUCvr2D56sQZvaNxunhEWee4CxvNhUeY+ClsJf1iG2nkz0VXeLAWi
 Ce9+gjQr7IZm1g86nTFj+5XmKTft5ICyAeAns2ThTqd6kosjNzWtqZ3j2IdjIZzppzWX
 ZXTzHoQOiyiXq2fJwPLydWL2yJaam+gvXf6ExAxkQVxUqIRccRq/4ltCgNqcpnkPdZ/4
 Kb+npNjyNvcYQr4zy1usu8r6dFFL+TKIodJmWJM7UTqGJ86yYSbk5JDzE+OcPGuVKKD2
 YWfqRyH0/R2A/PanP/7BsyavIBrmGztHxQL9+hmwO5XnPxtixjBCCxfTMsdzXjB61yFw GQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34gyw1x7ya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Nov 2020 17:58:11 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 86EA510002A;
        Fri,  6 Nov 2020 17:58:10 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5FD4F2C41F5;
        Fri,  6 Nov 2020 17:58:10 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Nov 2020 17:58:09
 +0100
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Russell King <linux@armlinux.org.uk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Jun Li <lijun.kernel@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH v5 0/5] STUSB1600 support on STM32MP15xx-DKx
Date:   Fri, 6 Nov 2020 17:58:00 +0100
Message-ID: <20201106165805.31534-1-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-06_06:2020-11-05,2020-11-06 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds missing bindings for Type-C typec-power-opmode property
and STUSB160x Type-C port controllers [1].
STUSB160x driver requires to get power operation mode via device tree,
that's why this series also adds the optional DT property
typec-power-opmode for usb-c-connector to select the power operation mode
capability.
Tested on stm32mp157c-dk2 [2], which has a Type-C connector managed by
STUSB1600, and connected to USB OTG controller. 

[1] https://www.st.com/en/interfaces-and-transceivers/usb-type-c-and-power-delivery-controllers.html
[2] https://www.st.com/en/evaluation-tools/stm32mp157c-dk2.html


Amelie Delaunay (5):
  dt-bindings: connector: add typec-power-opmode property to
    usb-connector
  dt-bindings: usb: Add DT bindings for STUSB160x Type-C controller
  usb: typec: stusb160x: fix power-opmode property with
    typec-power-opmode
  ARM: dts: stm32: add STUSB1600 Type-C using I2C4 on stm32mp15xx-dkx
  ARM: multi_v7_defconfig: enable STUSB160X Type-C port controller
    support

---
Changes in v5:
- add additionalProperties to st,stusb160x yaml
- add Heikki reviewed-by on stusb160x driver patch 3/5
Changes in v4:
- power-opmode DT property renamed to typec-power-opmode and mutually
  exclusive condition with new-source-frs-typec-current added
- Due to DT property renaming, patch 3/5 is added to update stusb160x
  driver.
---
 .../bindings/connector/usb-connector.yaml     | 24 +++++
 .../devicetree/bindings/usb/st,stusb160x.yaml | 87 +++++++++++++++++++
 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi      |  7 ++
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi        | 30 +++++++
 arch/arm/configs/multi_v7_defconfig           |  2 +
 drivers/usb/typec/stusb160x.c                 |  2 +-
 6 files changed, 151 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/usb/st,stusb160x.yaml

-- 
2.17.1

