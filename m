Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46FE526FB4A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 13:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgIRLUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 07:20:09 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:16408 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726396AbgIRLUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 07:20:09 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 08IBGTrD008149;
        Fri, 18 Sep 2020 06:20:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type;
 s=PODMain02222019; bh=Q800TS0evx14zXUv69XdE9EKqqGRgZZzTJtJhCWXB6I=;
 b=CCptp7ov0II9cHJcJeRUyYTbzIfZ1ZadKdffdR3cymON6TprfZ89Ut5iPh3yTIHYLGWW
 6m2gypkTZbMvSG+CiS+jWxpXUGY0xRQTOH2HIhf4ZzQpMGp+MjwTZky2iMunL8u6xAa/
 85xdqrD0ZD3XQcw6dQGPbpqvTptYLkrwgj/Zt6VMF9SEu4XbVrBY1j/JQE39VbVh8kVb
 VCrzSonD9YaawWBvpkRI5/R6m1CzJrjBsTqAgBBb8axtqHsc57ge5Kss8lxk81ohVV4V
 4/qj7OVDz9nxTWDeUEZwkI5CjI7P9/7xlO+oTq9SjySm0TqAj8QonWDsf0krXtwPWUMG Xw== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 33k5prmha7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 18 Sep 2020 06:20:05 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 18 Sep
 2020 12:20:02 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Fri, 18 Sep 2020 12:20:02 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 99C3E2A1;
        Fri, 18 Sep 2020 11:20:02 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <dan.carpenter@oracle.com>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH] regmap: debugfs: Add back in erroneously removed initialisation of ret
Date:   Fri, 18 Sep 2020 12:20:02 +0100
Message-ID: <20200918112002.15216-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxlogscore=999
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 suspectscore=1
 lowpriorityscore=0 malwarescore=0 mlxscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009180093
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: 94cc89eb8fa5 ("regmap: debugfs: Fix handling of name string for debugfs init delays")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/base/regmap/regmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index d0f7cc574ff34..b24f14ea96d8a 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -706,9 +706,9 @@ struct regmap *__regmap_init(struct device *dev,
 			     const char *lock_name)
 {
 	struct regmap *map;
+	int ret = -EINVAL;
 	enum regmap_endian reg_endian, val_endian;
 	int i, j;
-	int ret;
 
 	if (!config)
 		goto err;
-- 
2.11.0

