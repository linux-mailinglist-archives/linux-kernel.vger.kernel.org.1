Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 936CF2AD39C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 11:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbgKJKXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 05:23:33 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:45474 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727325AbgKJKXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 05:23:31 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AAAGjkk020555;
        Tue, 10 Nov 2020 11:23:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=SAM8FttZW2H48y7jY4eJofzOj8s3m04uqqIn5J4eMFo=;
 b=bWl3YNSQmNUYdsaO78M2VW3QAyxcV3260FNvtX7gm72OOOyqmDfXVcqQlae6bI6/tIdO
 ds3Mqcu3Ck9WhNClwD03g+5p4Ld0ybpSqbwyCUOq9svLzd8B+JsBccCWkiD/wgL9iw5M
 EhRRuAcVgroB6KjRC5aosbRs1tdGECyuFrYqViDD0Ja4rY9QOTrPz5aHqj3njU8wu3Wb
 Gy8Nu/moTGQxYJt6d5wLKM7L7BTMX8bG2vAT9qMaJM+tWj/G2Gofiv3w66UZXbAcbXiH
 ivhhWn8wocXLJ/V935DtdsP96O2+lA1u87YwqD9ArE+Rt+hpJlnAN1v62MYUhW54ZaKg 3A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34nkbmygsv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Nov 2020 11:23:14 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C0346100034;
        Tue, 10 Nov 2020 11:23:13 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B06E823EDB0;
        Tue, 10 Nov 2020 11:23:13 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 10 Nov 2020 11:23:13
 +0100
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Etienne Carriere <etienne.carriere@st.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 2/2] phy: stm32: defer probe for reset controller
Date:   Tue, 10 Nov 2020 11:23:05 +0100
Message-ID: <20201110102305.27205-2-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201110102305.27205-1-amelie.delaunay@st.com>
References: <20201110102305.27205-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-10_04:2020-11-05,2020-11-10 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change stm32-usbphyc driver to defer its probe when the expected reset
control has its probe operation deferred.

Signed-off-by: Etienne Carriere <etienne.carriere@st.com>
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/phy/st/phy-stm32-usbphyc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/phy/st/phy-stm32-usbphyc.c b/drivers/phy/st/phy-stm32-usbphyc.c
index fe3085eec201..f3f582a3ccdb 100644
--- a/drivers/phy/st/phy-stm32-usbphyc.c
+++ b/drivers/phy/st/phy-stm32-usbphyc.c
@@ -342,6 +342,10 @@ static int stm32_usbphyc_probe(struct platform_device *pdev)
 		reset_control_assert(usbphyc->rst);
 		udelay(2);
 		reset_control_deassert(usbphyc->rst);
+	} else {
+		ret = PTR_ERR(usbphyc->rst);
+		if (ret == -EPROBE_DEFER)
+			goto clk_disable;
 	}
 
 	usbphyc->switch_setup = -EINVAL;
-- 
2.17.1

