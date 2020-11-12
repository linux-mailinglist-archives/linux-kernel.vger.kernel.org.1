Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9EF2B080C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 16:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbgKLPCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 10:02:36 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:59684 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728507AbgKLPCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 10:02:35 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0ACF1e9i000765;
        Thu, 12 Nov 2020 09:02:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=I/NF3nub6uPHdzCyjfku7U3YJ0PL4tdvBuI5HnvOvIw=;
 b=ZTG9Fj60TtZqKLd57j69zEKLoB7XxisWQSyTX2mQqZ3nnnjwv5YaWAGgmcS4csVGfw3A
 uXPQ0EVH262j9+m72MKtQrH5Au9rpn8qNEhKzZuZXbBVBMDUVbSh5eaEFgwNH2Gx4fGu
 wChHXyDCH8YhgGCuYVVlCqCI6tnZ03Y06cB1kiEppZPC4F4IYDLNwJcOnXUzRgzGxUyl
 hKbmOU8rT3omG63GQ9ZDULZjyIN4z2c5xRuf1Up+y+SSDL8QzE7gUOyXhbhNr2vXsVMp
 iLOx4s1RJttkfOcZDx+QaTsclU32v/JpUxWA+0WbZ/rtbENrpkZRO2TJABW+geQFgfcf QQ== 
Received: from ediex02.ad.cirrus.com ([5.172.152.52])
        by mx0b-001ae601.pphosted.com with ESMTP id 34rn3chg3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 12 Nov 2020 09:02:29 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 12 Nov
 2020 15:02:26 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Thu, 12 Nov 2020 15:02:26 +0000
Received: from archtower.ad.cirrus.com (unknown [198.61.65.51])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 21B9C45;
        Thu, 12 Nov 2020 15:02:26 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH] regmap: Fix order of regmap write log
Date:   Thu, 12 Nov 2020 15:02:17 +0000
Message-ID: <20201112150217.459844-1-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 clxscore=1011 mlxlogscore=959 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011120091
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_regmap_write can trigger a _regmap_select_page, which will call
another _regmap_write that will be executed first, but the log shows
the inverse order

Also, keep consistency with _regmap_read which only logs in case of
success

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 drivers/base/regmap/regmap.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 5db536ccfcd6b..297e95be25b3b 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1924,12 +1924,15 @@ int _regmap_write(struct regmap *map, unsigned int reg,
 		}
 	}
 
-	if (regmap_should_log(map))
-		dev_info(map->dev, "%x <= %x\n", reg, val);
+	ret = map->reg_write(context, reg, val);
+	if (ret == 0) {
+		if (regmap_should_log(map))
+			dev_info(map->dev, "%x <= %x\n", reg, val);
 
-	trace_regmap_reg_write(map, reg, val);
+		trace_regmap_reg_write(map, reg, val);
+	}
 
-	return map->reg_write(context, reg, val);
+	return ret;
 }
 
 /**
-- 
2.29.2

