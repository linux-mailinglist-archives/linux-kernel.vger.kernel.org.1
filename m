Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81C3C26CC5A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbgIPUnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:43:04 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:17012 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726652AbgIPREe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:04:34 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 08GFeaAi025252;
        Wed, 16 Sep 2020 10:44:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type;
 s=PODMain02222019; bh=nFKZCH0kN2Gt59QfN2Op+UT82VEXFIRegFKnaH31KkQ=;
 b=DMUdRZNbGfQjTVqpbwTpXWg8DdX6jiZNv4TaJ9AZEfLzguZShUcUjsXyCH7fC3fxDsgv
 HD91lkmX3yCOnH5WtmccrhUQf0mfSz8PEUb5eIAKX7arYCRvN6gxQ6qpNqhwFbjE6RdJ
 gePOKfro+glV/ZmQn/khdt7LP1o2ZhJHU8r/iPeXu5mpm+yrZ39mOEqLEBGuw8UtQ47u
 kfXOE+sHMunzCbOGkvA15tIwcqNszyIRHf2NJZYZS0nVyYrScm34ZDrNoCDVf151Tn5A
 3tHjN9b+wsA4tNsUk/FYgTTlYy7ftF9WqHDaNcoFwsAmM+YXMqsVCQjjSQ1b0va45sp4 Og== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 33k5prhd5h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 16 Sep 2020 10:44:35 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 16 Sep
 2020 16:44:33 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Wed, 16 Sep 2020 16:44:33 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6BD1C45;
        Wed, 16 Sep 2020 15:44:33 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH] regmap: debugfs: Duplicate name string if delaying debugfs init
Date:   Wed, 16 Sep 2020 16:44:33 +0100
Message-ID: <20200916154433.7003-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxlogscore=993
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 suspectscore=3
 lowpriorityscore=0 malwarescore=0 mlxscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009160115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In regmap_debugfs_init the initialisation of the debugfs is delayed
if the root node isn't ready yet. Most callers of regmap_debugfs_init
pass the name from the regmap_config, which is considered temporary
ie. may be unallocated after the regmap_init call returns. This leads
to a potential use after free, where config->name has been freed by
the time it is used in regmap_debugfs_initcall.

This situation can be seen on Zynq, where the architecture init_irq
callback registers a syscon device, using a local variable for the
regmap_config. As init_irq is very early in the platform bring up the
regmap debugfs root isn't ready yet. Although this doesn't crash it
does result in the debugfs entry not having the correct name.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/base/regmap/regmap-debugfs.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index f58baff2be0af..184fc327192bf 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -569,7 +569,12 @@ void regmap_debugfs_init(struct regmap *map, const char *name)
 		if (!node)
 			return;
 		node->map = map;
-		node->name = name;
+		node->name = kstrdup(name, GFP_KERNEL);
+		if (!node->name) {
+			kfree(node);
+			return;
+		}
+
 		mutex_lock(&regmap_debugfs_early_lock);
 		list_add(&node->link, &regmap_debugfs_early_list);
 		mutex_unlock(&regmap_debugfs_early_lock);
@@ -681,6 +686,7 @@ void regmap_debugfs_initcall(void)
 	list_for_each_entry_safe(node, tmp, &regmap_debugfs_early_list, link) {
 		regmap_debugfs_init(node->map, node->name);
 		list_del(&node->link);
+		kfree(node->name);
 		kfree(node);
 	}
 	mutex_unlock(&regmap_debugfs_early_lock);
-- 
2.11.0

