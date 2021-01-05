Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56A72EA805
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 10:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbhAEJt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 04:49:57 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:29012 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728340AbhAEJtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 04:49:55 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1059lGvF002392;
        Tue, 5 Jan 2021 10:49:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=P6bqie7w0/hFqyjwRS5cr4EagH5X+V9yAXASQZyhJvY=;
 b=cI5AD3uw0aPsLMbHKfWj2s/i/+lTAHRjWMgVr0OI1dCmWwp7M3UCNbLEhf/7sSRwxOu8
 pKDM+Mk7Dtk+W5YE03wbsSoYKM6wqL/3zVGwXRv8jsiYg+xKyrx7RqB6OXkPGbCO3GmB
 MVvBWxcsaqx4KPRnWMs6j9d0S1l0MCLaHRIa2J2nzjA4mscpi85biRPhvTNv85Jv2rl9
 2INRC97yq2S1Z+5NSt7amJO4Rbv7BB9YbhvbP64bzvb9X3UkWr5JU4OFUKHuf4ZQyNus
 an+XZ3GDQt0YfvtZuu3Wcz0U67a9RspCdBlxlJeApvhgx1v39pRYEdKFZRuxVHvMfPCF nw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 35tf66v6yj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Jan 2021 10:49:06 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1055C10002A;
        Tue,  5 Jan 2021 10:49:06 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0100F230519;
        Tue,  5 Jan 2021 10:49:05 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 5 Jan 2021 10:49:05
 +0100
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [PATCH v2 0/3] STM32MP15 OTG params updates
Date:   Tue, 5 Jan 2021 10:48:52 +0100
Message-ID: <20210105094855.30763-1-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-05_01:2021-01-05,2021-01-05 signatures=0
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

---
Changes in v2:
- Move author mail address from @st.com to @foss.st.com
- Add Minas' Reviewed-by on all patches

Amelie Delaunay (3):
  usb: dwc2: set ahbcfg parameter for STM32MP15 OTG HS and FS
  usb: dwc2: enable FS/LS PHY clock select on STM32MP15 FS OTG
  usb: dwc2: disable Link Power Management on STM32MP15 HS OTG

 drivers/usb/dwc2/params.c | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
2.17.1

