Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39C42B1B22
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 13:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgKMM1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 07:27:41 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:26302 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726237AbgKMM1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 07:27:37 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0ADCDGU4023151;
        Fri, 13 Nov 2020 13:27:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=HdXPcM6waAIGKpwJ/di7i2L0+52iFpv+3+uBIYa3/BI=;
 b=ikXe53F+o0lZqf9vVnN03So8MbK/Oo3x4YyRQ+C2KA0O8U3YyZFYOkICw/Vxh/P1l+mD
 v1YfDrwDKNLZkBqpnyDKVcy7gskrNVKSPvulSEBy2ECCzFexJYN16wJA7+ysg9ZDAAe+
 UM+p4oCMjLUAjxgwH+FhsIXCAZpX9i1gzeBChKwDSjEqI5GZoOdFDxGOeo1+zZM+bXj4
 CzKyHqRs2UsEjHKplSnRD2HPwY+Pgbu3w5yBjpyW9s9xtDaDrkgtnQsaPkQI6rtfTeg/
 5ZvDPXL66EhwIddoJhMPqEJvXsDrAexWlqe7i/F/m2W8NbRPTD4Nkf9tcH7j1JJDzlkK pg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34nhx5k998-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Nov 2020 13:27:28 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7719B10002A;
        Fri, 13 Nov 2020 13:27:27 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 67C2B254665;
        Fri, 13 Nov 2020 13:27:27 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 13 Nov 2020 13:27:26
 +0100
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH v2 1/1] mfd: stmfx: fix dev_err_probe call in stmfx_chip_init
Date:   Fri, 13 Nov 2020 13:27:25 +0100
Message-ID: <20201113122725.12971-1-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-13_10:2020-11-13,2020-11-13 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ret may be 0 so, dev_err_probe should be called only when ret is an error
code.

Fixes: 41c9c06c491a ("mfd: stmfx: Simplify with dev_err_probe()")
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
v2: address Lee's comment about error handling area
---
 drivers/mfd/stmfx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/stmfx.c b/drivers/mfd/stmfx.c
index 5e680bfdf5c9..988e2ba6dd0f 100644
--- a/drivers/mfd/stmfx.c
+++ b/drivers/mfd/stmfx.c
@@ -329,11 +329,11 @@ static int stmfx_chip_init(struct i2c_client *client)
 
 	stmfx->vdd = devm_regulator_get_optional(&client->dev, "vdd");
 	ret = PTR_ERR_OR_ZERO(stmfx->vdd);
-	if (ret == -ENODEV) {
-		stmfx->vdd = NULL;
-	} else {
-		return dev_err_probe(&client->dev, ret,
-				     "Failed to get VDD regulator\n");
+	if (ret) {
+		if (ret == -ENODEV)
+			stmfx->vdd = NULL;
+		else
+			return dev_err_probe(&client->dev, ret, "Failed to get VDD regulator\n");
 	}
 
 	if (stmfx->vdd) {
-- 
2.17.1

