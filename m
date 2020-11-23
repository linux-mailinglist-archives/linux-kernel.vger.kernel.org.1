Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36AB2C01F5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 10:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgKWJC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 04:02:28 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:38458 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727983AbgKWJCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 04:02:23 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0AN8wQg7011534;
        Mon, 23 Nov 2020 10:02:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=LXvgTHQI0eYF62IvHYLnCBkMkZy/vMxDWx34Jatxj7E=;
 b=MnSKVDDQGr/07oiBcRpzYuizM5aCnRaV3BNM0Gqqu1oMjf/S+ygjy7EWPxquFZZ/4/Hg
 +9weMb0+Znu/xWYIM0eZRW7lA6wgw4Dm+lCo1AQLVSRaK1biaCxfGK7hBLw3GyjUJv0P
 zbeJN72qTP8DEISPnk+ddfb/4TFh2E5ehYa8OuQDf8mlaREQRvnanKwUU26pnXTMclGK
 TkY+jtRdiuNkWIvogS1DjHTRIox4OE+B33kRewlVSsJk2PyweV31EGdrQzGKakPRNhQA
 bM2CdLqPVfVyG6R+PNrSQXtzkx2c2xt0wD7kaoEH3EDjD1soEe4fM9pOviV46NYDnCI/ dA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34y0fgh61a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Nov 2020 10:02:15 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4664B100038;
        Mon, 23 Nov 2020 10:02:10 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2BF5423129F;
        Mon, 23 Nov 2020 10:02:10 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 23 Nov 2020 10:01:17
 +0100
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 0/3] STM32MP15 OTG params updates
Date:   Mon, 23 Nov 2020 10:01:11 +0100
Message-ID: <20201123090114.12641-1-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-23_02:2020-11-20,2020-11-23 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset brings some updates on STM32MP15 OTG HS and FS.
It sets ahbcfg parameter for both HS and FS as the value reported by the
hardware is not recommended.
It also disables Link Power Management on OTG HS because with some Host
controllers (at least seen with some USB 3.2 Gen2 controllers), OTG doesn't
succeed to exit L1 state.
It also enables FS/LS PHY clock selection when the Core is in FS Host mode,
to have 6MHz PHY clock when the connected device is LS, and 48Mhz PHY clock
otherwise. 

Amelie Delaunay (3):
  usb: dwc2: set ahbcfg parameter for STM32MP15 OTG HS and FS
  usb: dwc2: enable FS/LS PHY clock select on STM32MP15 FS OTG
  usb: dwc2: disable Link Power Management on STM32MP15 HS OTG

 drivers/usb/dwc2/params.c | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
2.17.1

