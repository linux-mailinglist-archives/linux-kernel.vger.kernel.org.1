Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC13F2AD0C9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 09:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbgKJIEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 03:04:13 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:55620 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726462AbgKJIEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 03:04:12 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AA82nC9001686;
        Tue, 10 Nov 2020 09:04:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=64TjGNurhU58K6SRpxGU5jfooD3SAdtkt7wKdxzo2Gk=;
 b=rlx08U4NeuOYI99GHlQ0yu6/LUmCcMPs5BCQQRKgdfZHH8dDoCKjwQQWZ9+vNiTOY1ln
 kF4F9HVvhfR9XBo0XpHTuD2PYZr5y1qDFu0GyMlxPiYPYiB6Wj9hGI/RPcOKTrtwL76o
 XugoKyG/r/QQbbmPKkqt2jbj4FiLEApky931ENW2QQREBJUUwMuo09YSvIH3UR1sagBj
 d9ordx8JY86FGHZm/42rPw7XvUVB7t8tw2inmcmwo4L+UfBOG8NZY41YxUoJ8AqzWkJx
 lQI3wvQRVc0pWfd7feF1eZCVjKavqZRvZUe7p2cKU0cFkvtPbJIYjgbyJ9SMM0Cx46nQ BA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34nkbmxnqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Nov 2020 09:04:02 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1040C10002A;
        Tue, 10 Nov 2020 09:04:02 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F22A322E873;
        Tue, 10 Nov 2020 09:04:01 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 10 Nov 2020 09:04:01
 +0100
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 1/1] mfd: stmfx: fix dev_err_probe call in stmfx_chip_init
Date:   Tue, 10 Nov 2020 09:04:00 +0100
Message-ID: <20201110080400.7207-1-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-10_03:2020-11-05,2020-11-10 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ret may be 0 so, dev_err_probe should be called only when ret is an error
code.

Fixes: 41c9c06c491a ("mfd: stmfx: Simplify with dev_err_probe()")
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/mfd/stmfx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/stmfx.c b/drivers/mfd/stmfx.c
index 5e680bfdf5c9..360fb4646688 100644
--- a/drivers/mfd/stmfx.c
+++ b/drivers/mfd/stmfx.c
@@ -329,12 +329,11 @@ static int stmfx_chip_init(struct i2c_client *client)
 
 	stmfx->vdd = devm_regulator_get_optional(&client->dev, "vdd");
 	ret = PTR_ERR_OR_ZERO(stmfx->vdd);
-	if (ret == -ENODEV) {
+	if (ret == -ENODEV)
 		stmfx->vdd = NULL;
-	} else {
+	else if (ret)
 		return dev_err_probe(&client->dev, ret,
 				     "Failed to get VDD regulator\n");
-	}
 
 	if (stmfx->vdd) {
 		ret = regulator_enable(stmfx->vdd);
-- 
2.17.1

