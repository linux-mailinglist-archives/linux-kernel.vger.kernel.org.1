Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2935A2EA806
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 10:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbhAEJt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 04:49:58 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:42230 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726589AbhAEJtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 04:49:55 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1059kvJA005754;
        Tue, 5 Jan 2021 10:49:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=vYfqQLYQirAYyccNfjfHJ4bB+gtWVjtxynejUYP/4KE=;
 b=CXw6QxPX6uFlICw8Z/fMkIRJwdmEptQryiNERbLF1od7E3pnGXBlXzvVGVWzDFoNCZQC
 Kzv4z3Qi0mvWKcPqClureL3tPX7RFmeW3e0iLr3l1JKJzwk2ZbPSPvg2eXT3dd9hIX/Q
 O9zXeVildwSIj+ZcHJSHLpmw6KmDcicN7fSg+3bydJTEXasEpv+cyagtHLWLNoEItxJP
 6G0sGxuFKup2LQYghNkL66eq6aLVe2ncEmROVvsov1I5x42K73P6avjO5EjxlfIyS0Pk
 QM7BNtso8A6oTT28pN5J8tgFWxm79MlPKlwpkx9gCSFv9x6S/3x6NEWr3sldD+LzbUtQ Hw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 35th25ky83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Jan 2021 10:49:07 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2D4E1100038;
        Tue,  5 Jan 2021 10:49:07 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1E435230519;
        Tue,  5 Jan 2021 10:49:07 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 5 Jan 2021 10:49:06
 +0100
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [PATCH v2 1/3] usb: dwc2: set ahbcfg parameter for STM32MP15 OTG HS and FS
Date:   Tue, 5 Jan 2021 10:48:53 +0100
Message-ID: <20210105094855.30763-2-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210105094855.30763-1-amelie.delaunay@foss.st.com>
References: <20210105094855.30763-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-05_01:2021-01-05,2021-01-05 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

STM32MP15 ahbcfg register default value sets Burst length/type (HBSTLEN)
to Single (32-bit accesses on AHB), which is not recommended, according
to STM32MP157 Reference manual [1].
This patch sets Burst length/type (HBSTLEN) so that bus transactions
target 16x32 bit accesses. This improves OTG controller performance.

[1] https://www.st.com/resource/en/reference_manual/dm00327659.pdf, p.3149

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Acked-by: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
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

