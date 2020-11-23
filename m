Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0DE12C01F3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 10:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgKWJCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 04:02:25 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:21150 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726912AbgKWJCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 04:02:21 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0AN923RO001995;
        Mon, 23 Nov 2020 10:02:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=ARMYpQFAPbN6ehNxLX8y/wnbOUUC+Hbw3gasCf3TBEA=;
 b=IYRvp9IrVUZ/xvNUF7sITtwJjCwQRWyfeTPvkgbbFlILtOBdB4XP11hOEp08J2cJPcqa
 Fab+xXRCSYCyttYNcAeiha9jTDdft4Y2Wg2iceKSxLXpV60DpW4fsHtGbsJfd3UQSjRo
 z+e3iur26xmeCUV488ee9sqXjq7nML9gzQhW6Y5bcGpK+Bf3731Hb+qEVaN5+pPQ0CD1
 NyQg5mnQlVocDO2RpytS/LQ1f3P95PyrMD5h/sQB3ZYvdU593KnJxJcOUPs6p1vA94yP
 FwC8CcHaqWWmYK1lYx9YIkmDBXhQqFiftdNyyF1Sc6WoZz8W1aK5UEu9XVbmj1WwoyrJ pw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34y05h064g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Nov 2020 10:02:11 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4DE25100039;
        Mon, 23 Nov 2020 10:02:10 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 35E45231F81;
        Mon, 23 Nov 2020 10:02:10 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 23 Nov 2020 10:01:18
 +0100
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 1/3] usb: dwc2: set ahbcfg parameter for STM32MP15 OTG HS and FS
Date:   Mon, 23 Nov 2020 10:01:12 +0100
Message-ID: <20201123090114.12641-2-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201123090114.12641-1-amelie.delaunay@st.com>
References: <20201123090114.12641-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-23_02:2020-11-20,2020-11-23 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

STM32MP15 ahbcfg register default value sets Burst length/type (HBSTLEN)
to Single (32-bit accesses on AHB), which is not recommended, according
to STM32MP157 Reference manual [1].
This patch sets Burst length/type (HBSTLEN) so that bus transactions
target 16x32 bit accesses. This improves OTG controller performance.

[1] https://www.st.com/resource/en/reference_manual/dm00327659.pdf, p.3149

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/usb/dwc2/params.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
index 267543c3dc38..0df693319f0a 100644
--- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -177,6 +177,7 @@ static void dwc2_set_stm32mp15_fsotg_params(struct dwc2_hsotg *hsotg)
 	p->i2c_enable = false;
 	p->activate_stm_fs_transceiver = true;
 	p->activate_stm_id_vb_detection = true;
+	p->ahbcfg = GAHBCFG_HBSTLEN_INCR16 << GAHBCFG_HBSTLEN_SHIFT;
 	p->power_down = DWC2_POWER_DOWN_PARAM_NONE;
 }
 
@@ -189,6 +190,7 @@ static void dwc2_set_stm32mp15_hsotg_params(struct dwc2_hsotg *hsotg)
 	p->host_rx_fifo_size = 440;
 	p->host_nperio_tx_fifo_size = 256;
 	p->host_perio_tx_fifo_size = 256;
+	p->ahbcfg = GAHBCFG_HBSTLEN_INCR16 << GAHBCFG_HBSTLEN_SHIFT;
 	p->power_down = DWC2_POWER_DOWN_PARAM_NONE;
 }
 
-- 
2.17.1

