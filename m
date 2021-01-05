Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53CE2EAA1F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 12:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbhAELnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 06:43:52 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:42534 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728822AbhAELnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 06:43:52 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 105BZcc7032610;
        Tue, 5 Jan 2021 11:43:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=zKOUk2wPIoowVZgO6OUhoYKIvVuPqMlNx5ZFBmqNXLI=;
 b=hcjsf/faB7pCmQtgOnJXSaPZL0kD+kFpj5eh4S6EY9RsiVc8VSVCkB1YYZSuhWA5Fkn6
 gSCgGN/A3L8wyAJdshpGos0FVwgmL2GbLiH0dZJQ6qKfhqnNAfwX5HDI96h2GRcDoA8h
 JJYH9TVIQwYaD+4lZXj9Pu0FXCfzcJp9E1E1v7aTz0Ov5HHXpA9lqKfIS97BLOiLH0ZB
 xS2cdOr3iYSa8Giu1NPJii7yrVgmAEvofjAfWCSoukVu2xv06CromB2K8LtU/Z7Xe+9E
 zHnCyZNKbg6ZvcMVpYt8IUYDrbvUF67JGQza0UZOWOA4NpcUniiOm3CTCXNyQlDglxjh XQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 35tg8r0ec2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 05 Jan 2021 11:43:08 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 105BaKhj024144;
        Tue, 5 Jan 2021 11:43:07 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 35uxnshxv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Jan 2021 11:43:07 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 105Bh6WS025417;
        Tue, 5 Jan 2021 11:43:06 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 05 Jan 2021 11:43:05 +0000
Date:   Tue, 5 Jan 2021 14:42:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mark Brown <broonie@kernel.org>,
        Xiaolei Wang <xiaolei.wang@windriver.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] regmap: debugfs: Fix a reversed if statement in
 regmap_debugfs_init()
Message-ID: <X/RQpfAwRdLg0GqQ@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9854 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101050073
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9854 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 phishscore=0 bulkscore=0
 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101050073
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code will leak "map->debugfs_name" because the if statement is
reversed so it only frees NULL pointers instead of non-NULL.  In
fact the if statement is not required and should just be removed
because kfree() accepts NULL pointers.

Fixes: cffa4b2122f5 ("regmap: debugfs: Fix a memory leak when calling regmap_attach_dev")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/base/regmap/regmap-debugfs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index bf03cd343be2..ff2ee87987c7 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -594,9 +594,7 @@ void regmap_debugfs_init(struct regmap *map)
 	}
 
 	if (!strcmp(name, "dummy")) {
-		if (!map->debugfs_name)
-			kfree(map->debugfs_name);
-
+		kfree(map->debugfs_name);
 		map->debugfs_name = kasprintf(GFP_KERNEL, "dummy%d",
 						dummy_index);
 		if (!map->debugfs_name)
-- 
2.29.2

