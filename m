Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96B922EA807
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 10:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbhAEJt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 04:49:59 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:29018 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728587AbhAEJtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 04:49:55 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1059lGvG002392;
        Tue, 5 Jan 2021 10:49:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=YmIuRgeSstg5OjqebldFDcXsvmGwpN/ZsnLVMvOWUFs=;
 b=mccxkKKAwANKarv/1Ox3QWzOhtvDNFfTZs+z5FfJGSiRrE9nkmbssW0K5AiZ7dgwyOB9
 +igRja8u0s0Mt5vn/67P3pjq7vodCzouAfWFdfYKNFZ1/uM/Pqst6wXxAAYK0hQ4kY9L
 jWpVhHUxMU+ejOp+P50KEitvvysScnPLZxy8CdQC+35vBGOCMf6mFdU1flh9rxroB/Ua
 rom6sSR9E7WES1g0Ne08C5RU5V5gKsPHnPwjg44TcGeR9w5o/xDIZrC45aoiEQ/aN3Qf
 JgLPG4vH2DC4TfSF2AFE/5ogNG14P1joBNajU3uUQWKHZOXTO12WxRJvYRjOY6+ayshg Eg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 35tf66v6yq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Jan 2021 10:49:08 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 226AC10002A;
        Tue,  5 Jan 2021 10:49:08 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 15D9523051A;
        Tue,  5 Jan 2021 10:49:08 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 5 Jan 2021 10:49:07
 +0100
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [PATCH v2 2/3] usb: dwc2: enable FS/LS PHY clock select on STM32MP15 FS OTG
Date:   Tue, 5 Jan 2021 10:48:54 +0100
Message-ID: <20210105094855.30763-3-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210105094855.30763-1-amelie.delaunay@foss.st.com>
References: <20210105094855.30763-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-05_01:2021-01-05,2021-01-05 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the core is in FS host mode, using the FS transceiver, and a Low-Speed
device is connected, transceiver clock is 6Mhz.
So, to support Low-Speed devices, enable support of FS/LS Low Power mode,
so that the PHY supplies a 6 MHz clock during Low-Speed mode.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Acked-by: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
---
 drivers/usb/dwc2/params.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
index 0df693319f0a..9e5dd7f3f2f6 100644
--- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -179,6 +179,8 @@ static void dwc2_set_stm32mp15_fsotg_params(struct dwc2_hsotg *hsotg)
 	p->activate_stm_id_vb_detection = true;
 	p->ahbcfg = GAHBCFG_HBSTLEN_INCR16 << GAHBCFG_HBSTLEN_SHIFT;
 	p->power_down = DWC2_POWER_DOWN_PARAM_NONE;
+	p->host_support_fs_ls_low_power = true;
+	p->host_ls_low_power_phy_clk = true;
 }
 
 static void dwc2_set_stm32mp15_hsotg_params(struct dwc2_hsotg *hsotg)
-- 
2.17.1

