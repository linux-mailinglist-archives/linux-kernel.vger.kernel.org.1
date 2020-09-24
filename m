Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE5A276CAA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 11:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbgIXJBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 05:01:21 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:45363 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727343AbgIXJBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 05:01:15 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08O8ujat013743;
        Thu, 24 Sep 2020 11:00:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=yt89q6fCorzpP6Hwf16Fhv2NPbv9IxAdURAsVwLdMFE=;
 b=kPbwuH7oRpHHEZcRh8HtWo8XZ3d63l1i4OZmvYCBW4zg4XykTTi/dhnR3Jc1o8QQ7SsJ
 FoomG4kESpvyGYTYdOS9D1ALErZ53o2OnFUPH250B+kMgDZ6+GcQEzkRlOePk7tYoWfG
 X9sBUpozvicr8YLsBt402C0xvRKeAZPV3Elr4sXHXAf97mRRjWwG2NofJZcypvo3LYHc
 nEx5RFX2irVIdcIbMNOpbgMMd+Mlc6xRJjciHRXpw1w+PcuguxXcBnAMmHecCJlpZIg+
 lo017/4Q2txMJu8CTd1y1sIBmvIjuO77nLyJmNWo38zhcQgNc1Tr5W10ESMLdMoNEf+I vg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 33n7f02r6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Sep 2020 11:00:56 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EB28E10002A;
        Thu, 24 Sep 2020 11:00:55 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D2781222D1D;
        Thu, 24 Sep 2020 11:00:55 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 24 Sep 2020 11:00:55
 +0200
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Russell King <linux@armlinux.org.uk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH v3 0/6] Add STUSB160x Type-C port controller support
Date:   Thu, 24 Sep 2020 11:00:43 +0200
Message-ID: <20200924090049.9041-1-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-24_05:2020-09-24,2020-09-24 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for STMicroelectronics STUSB160x Type-C port
controllers [1].
STUSB160x driver requires to get power operation mode via device tree,
that's why this series also adds the optional DT property power-opmode
for usb-c-connector to select the power operation mode capability and
a function to convert the power operation mode string into power
operation mode value.
This driver has been tested on stm32mp157c-dk2 [2], which has a Type-C
connector managed by STUSB1600, and connected to USB OTG controller. 

[1] https://www.st.com/en/interfaces-and-transceivers/usb-type-c-and-power-delivery-controllers.html
[2] https://www.st.com/en/evaluation-tools/stm32mp157c-dk2.html

Amelie Delaunay (6):
  dt-bindings: connector: add power-opmode optional property to
    usb-connector
  usb: typec: add typec_find_pwr_opmode
  dt-bindings: usb: Add DT bindings for STUSB160x Type-C controller
  usb: typec: add support for STUSB160x Type-C controller family
  ARM: dts: stm32: add STUSB1600 Type-C using I2C4 on stm32mp15xx-dkx
  ARM: multi_v7_defconfig: enable STUSB160X Type-C port controller
    support
---
Changes in v3:
- usb_power_delivery string removed from power-opmode possible values as
in case of power delivery support, source-pdos property can be used
Changes in v2:
- power-opmode DT property description updated.
---
 .../bindings/connector/usb-connector.yaml     |  18 +
 .../devicetree/bindings/usb/st,stusb160x.yaml |  85 ++
 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi      |   7 +
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi        |  38 +
 arch/arm/configs/multi_v7_defconfig           |   2 +
 drivers/usb/typec/Kconfig                     |  12 +
 drivers/usb/typec/Makefile                    |   1 +
 drivers/usb/typec/class.c                     |  15 +
 drivers/usb/typec/stusb160x.c                 | 875 ++++++++++++++++++
 include/linux/usb/typec.h                     |   1 +
 10 files changed, 1054 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/st,stusb160x.yaml
 create mode 100644 drivers/usb/typec/stusb160x.c

-- 
2.17.1

