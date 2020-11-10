Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEE22AD39D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 11:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgKJKXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 05:23:31 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:12654 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726219AbgKJKX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 05:23:28 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AAAGbeI015461;
        Tue, 10 Nov 2020 11:23:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=1xcFMDEaGnn+y5A6sfvnpf2TqKcRdrKxBKQJReGEAGY=;
 b=iBfVQzTtX9Mq2Bw4XS4kF4npPfkXNC1ZrL0RF8KumTlxQW2+cxz/jT8PZJDOtRK7u4p3
 SCc5JDqNKFw4B+GCaeo5YMMFStFEWti7fI+u2IVxfAlyoSkEVXvhGnXun3Wql+ZbztLb
 7HPKZxpVF2wyK1M2COgr/fjFMo5bvWcrVNEekGZdlOCfRqiBvntswSqSGfxYri6FaDTh
 vMTQkin1VBdC/oC5+27hvHK8yokRT2fD/EF7QCmTFDoujXW+LvwK3qQilAacvXyG1H9R
 mLdlhBnbDKjL1nX6yn8xKx10fwdNbYJlNm27Gpv7IbuHQt1R2ukSFzzv/b0ojDI2/yl3 Vg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34nj80q9gs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Nov 2020 11:23:13 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9E77810002A;
        Tue, 10 Nov 2020 11:23:12 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8DC5023EDB0;
        Tue, 10 Nov 2020 11:23:12 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 10 Nov 2020 11:23:12
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
Subject: [PATCH 1/2] phy: stm32: don't print an error on probe deferral
Date:   Tue, 10 Nov 2020 11:23:04 +0100
Message-ID: <20201110102305.27205-1-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-10_04:2020-11-05,2020-11-10 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change stm32-usbphyc driver to not print an error message when the device
probe operation is deferred.

Signed-off-by: Etienne Carriere <etienne.carriere@st.com>
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/phy/st/phy-stm32-usbphyc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/st/phy-stm32-usbphyc.c b/drivers/phy/st/phy-stm32-usbphyc.c
index 2b3639cba51a..fe3085eec201 100644
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
+		dev_err_probe(dev, PTR_ERR(usbphyc->clk), "clk get_failed\n");
 
 	ret = clk_prepare_enable(usbphyc->clk);
 	if (ret) {
-- 
2.17.1

