Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB812EA809
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 10:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbhAEJuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 04:50:09 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:18136 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728690AbhAEJt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 04:49:56 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1059ls3e009604;
        Tue, 5 Jan 2021 10:49:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=8VQVjuIjAWhXRhZPWLiv4kmSLHbtYSuNMmvdHOu/vt8=;
 b=dXmPafP5UVX55pY94Oa6bB/lcOsdpyIRAkK7HR4bRhQG4nBRCQP5j6X+pZli/Ls4sbyr
 EXnA5xN7780XRo9c7eD6+RQZSpkdrpn+JySS+yVDRGZ1XCz2fGbyvpLJ/0qvMDyVdZYw
 n4LvlWhsugY/vmivRxfnfEwxqgoX59rZeD5ILWVtPdE9OEbLEfZr+Zor/bLARrGhiI/M
 YUd2oYy8KPC8cU+sAQFD6XBhfh9QOv7o2OCIN/pEsz2W6X+PJXuCmDtDF3W15LW6o/cJ
 /5TYEOn37uMbaAw6pBPEbyffN5syp9qWJ+qFzjVhwpmEtHncrgpDc2qgQKEt3RZhvPdG /Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 35teuv07p1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Jan 2021 10:49:09 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0906110002A;
        Tue,  5 Jan 2021 10:49:09 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EBBF123051B;
        Tue,  5 Jan 2021 10:49:08 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 5 Jan 2021 10:49:08
 +0100
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [PATCH v2 3/3] usb: dwc2: disable Link Power Management on STM32MP15 HS OTG
Date:   Tue, 5 Jan 2021 10:48:55 +0100
Message-ID: <20210105094855.30763-4-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210105094855.30763-1-amelie.delaunay@foss.st.com>
References: <20210105094855.30763-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-05_01:2021-01-05,2021-01-05 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Link Power Management (LPM) on STM32MP15 OTG HS encounters instabilities
with some Host controllers. OTG core fails to exit L1 state in 200us:
"dwc2 49000000.usb-otg: Failed to exit L1 sleep state in 200us."
Then the device is still not enumerated.

To avoid this issue, disable Link Power Management on STM32MP15 HS OTG.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Acked-by: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
---
 drivers/usb/dwc2/params.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
index 9e5dd7f3f2f6..92df3d620f7d 100644
--- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -194,6 +194,10 @@ static void dwc2_set_stm32mp15_hsotg_params(struct dwc2_hsotg *hsotg)
 	p->host_perio_tx_fifo_size = 256;
 	p->ahbcfg = GAHBCFG_HBSTLEN_INCR16 << GAHBCFG_HBSTLEN_SHIFT;
 	p->power_down = DWC2_POWER_DOWN_PARAM_NONE;
+	p->lpm = false;
+	p->lpm_clock_gating = false;
+	p->besl = false;
+	p->hird_threshold_en = false;
 }
 
 const struct of_device_id dwc2_of_match_table[] = {
-- 
2.17.1

