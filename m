Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C28741E58F5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 09:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgE1Hk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 03:40:29 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:64958 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725920AbgE1Hk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 03:40:29 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04S7c97Q017148;
        Thu, 28 May 2020 09:40:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=ny7mQIqTfJ+SgnawgJlePYPXP/ZG5n/aoxf+iVaqbhk=;
 b=imAOvlF2RyYXb0f4h4QmFUEyhecg3eg0a6xukki+hYV9fyJt/mSInBgmwhIW13cMKyw4
 tuPfn4fmqbO1UutJJ3UyZVrEbYpVGHwr/+rcxajrrRC/r0I2HIfSQx0cwNBOpVybhwqe
 WKwao04rCJjIEYhg7/fuFVlpZHh01/fJLBCgmWUpqrlvUYDJNf9xiUhdR9eweiOITpHj
 1y2jGBrCDSPJs6ppFU40tEMi+pQj35IY0VQ3HAI3aFJu/MIAeyj+yBu6nRxC5pu1ZURm
 5sFakYswujMFHfq0/ABtzrmTy7mNKp3Cb6yK6y2EzGEDb+ex2cw2CD5pa9dxz1wqfLdS uA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 316sa29wu9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 May 2020 09:40:08 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 45007100038;
        Thu, 28 May 2020 09:40:08 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 33B892B1881;
        Thu, 28 May 2020 09:40:08 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 28 May 2020 09:40:07
 +0200
From:   Erwan Le Ray <erwan.leray@st.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Erwan Le Ray <erwan.leray@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH 0/2] STM32 Fix uart nodes in stm32mp15-pinctrl
Date:   Thu, 28 May 2020 09:40:01 +0200
Message-ID: <20200528074003.24875-1-erwan.leray@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-28_02:2020-05-28,2020-05-27 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix uart nodes ordering and uart7_pins_a comments in stm32mp15-pinctrl.

Erwan Le Ray (2):
  ARM: dts: stm32: fix uart nodes ordering in stm32mp15-pinctrl
  ARM: dts: stm32: fix uart7_pins_a comments in stm32mp15-pinctrl

 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi | 130 +++++++++++------------
 1 file changed, 65 insertions(+), 65 deletions(-)

-- 
2.17.1

