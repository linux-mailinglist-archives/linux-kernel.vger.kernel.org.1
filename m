Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F4F27010F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 17:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgIRPcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 11:32:03 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:3364 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725941AbgIRPcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 11:32:03 -0400
X-Greylist: delayed 585 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 11:32:02 EDT
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 08IFB8Qm000340;
        Fri, 18 Sep 2020 10:22:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type;
 s=PODMain02222019; bh=DvSvElzMKAfboUO59AHqtSsVF1P5Kkz4YTFNCPqjIu8=;
 b=OWdSJPl2EJqrlmrztyiSrKbGAHakk6TUuAXA3xv/7479T+5BVW1dULj31WxvY9fQBH1U
 GyZyrR3Z8mbe3CmYBga0lKDRYAbVc8yD1vydMwVGhayP5uH6hG/ln8SKlbqFDcNsTLpn
 8qNtlL4Rqk/Cz91xxCugJq0nsWcJ4hRrplvhbw/unzEhREx3ANyn7sYUWbVGTldvDsKV
 mL18vlYXzVDrkJzqggww4SQkpIwk2RRpub+b6T95e/Bcrd8vR0JChF0iaPZhMj9UyCOp
 SdGPV3yr54006EjicD8ujM5/Pg3jfnAH7Tx+BfvEHPFT1QQXe9t6J30hkJXE02AhvfwS kw== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 33k5pgcrwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 18 Sep 2020 10:22:13 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 18 Sep
 2020 16:22:12 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Fri, 18 Sep 2020 16:22:12 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4298E2C4;
        Fri, 18 Sep 2020 15:22:12 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <dan.carpenter@oracle.com>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH] regmap: debugfs: Fix more error path regressions
Date:   Fri, 18 Sep 2020 16:22:12 +0100
Message-ID: <20200918152212.22200-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 mlxlogscore=982 malwarescore=0 spamscore=0 phishscore=0 suspectscore=1
 lowpriorityscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009180125
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many error paths in __regmap_init rely on ret being pre-initialised to
-EINVAL, add an extra initialisation in after the new call to
regmap_set_name.

Fixes: 94cc89eb8fa5 ("regmap: debugfs: Fix handling of name string for debugfs init delays")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/base/regmap/regmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index b24f14ea96d8a..4c2a114584236 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -723,6 +723,8 @@ struct regmap *__regmap_init(struct device *dev,
 	if (ret)
 		goto err_map;
 
+	ret = -EINVAL; /* Later error paths rely on this */
+
 	if (config->disable_locking) {
 		map->lock = map->unlock = regmap_lock_unlock_none;
 		map->can_sleep = config->can_sleep;
-- 
2.11.0

