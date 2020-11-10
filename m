Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED5182AD714
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 14:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbgKJNFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 08:05:47 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:1591 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727536AbgKJNFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 08:05:46 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AAD1oiR027641;
        Tue, 10 Nov 2020 14:05:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=MuYQyOZreHtwFmW6B23D6vQIwX6LkmB9NG2Ttxx8lrs=;
 b=VS9i6dw/B/t2ScqTK7Mmv5L1ZqSm5IRsXCuFVe4SLMfDvHcXjB9b/N+HHecXaUWxnD7I
 9XO5YJ6IHkpAw2rsh8KYPIfGCQ8vKCsOY9i0UZG7VVae4+01+arKmHjZHk5aqjsKv5XT
 QgE+xu5xELJtRw2+RISaHX+Tg0w3CUUFa2ZfKXyvnpRTJh0PkRB+pEI7yHtpMUOnLw4K
 rWfnYrCZTOkwkuQpm3uF76AAj7UwUZigXQNjLMUGwsgqicOVAQ7SQj36T8w1hAwyswxo
 Bu8AEJqMto3IGw4k8d0G77k+YWcvBoo3dRUpD/fR3iZs8D4YU0/mvA/2qYSn8OfN+Ond iQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34nhkcrr1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Nov 2020 14:05:33 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 69873100038;
        Tue, 10 Nov 2020 14:05:32 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5967825613B;
        Tue, 10 Nov 2020 14:05:32 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 10 Nov 2020 14:05:31
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
Subject: [PATCH v2 1/2] phy: stm32: don't print an error on probe deferral
Date:   Tue, 10 Nov 2020 14:05:31 +0100
Message-ID: <20201110130531.7610-1-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-10_05:2020-11-10,2020-11-10 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change stm32-usbphyc driver to not print an error message when the device
probe operation is deferred.

Signed-off-by: Etienne Carriere <etienne.carriere@st.com>
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
v2: add missing return
---
 drivers/phy/st/phy-stm32-usbphyc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/st/phy-stm32-usbphyc.c b/drivers/phy/st/phy-stm32-usbphyc.c
index 2b3639cba51a..3630f83dea53 100644
--- a/drivers/phy/st/phy-stm32-usbphyc.c
+++ b/drivers/phy/st/phy-stm32-usbphyc.c
@@ -328,11 +328,8 @@ static int stm32_usbphyc_probe(struct platform_device *pdev)
 		return PTR_ERR(usbphyc->base);
 
 	usbphyc->clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(usbphyc->clk)) {
-		ret = PTR_ERR(usbphyc->clk);
-		dev_err(dev, "clk get failed: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(usbphyc->clk))
+		return dev_err_probe(dev, PTR_ERR(usbphyc->clk), "clk get_failed\n");
 
 	ret = clk_prepare_enable(usbphyc->clk);
 	if (ret) {
-- 
2.17.1

