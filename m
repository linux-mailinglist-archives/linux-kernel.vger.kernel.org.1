Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14AFB2DEE4C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 11:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgLSK6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 05:58:54 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50600 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgLSK6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 05:58:53 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BJAtTtY003630;
        Sat, 19 Dec 2020 10:58:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=eJ8NhlhCDae83l+6g6h/GoQhGOAuDALhJENu/2Eo1FA=;
 b=JLibvFbUEYWv4r7inrcs6UQmX90GgncWCKuiZZ8xoLR/31R57WASIjwM7/mRh4lfSLJ6
 hFfNMHsgyFhglRZVIYhVFEsbBgf58GWqj7XceqOJbBOvIEuIYstMdTy/dOVWwkAWMMFZ
 6xxeqxzGI8NwZSoOYLDyKzb9wcrbyK1YuqJECNA6VoD/gaYGh4f+45F9gTT96vZfxcbB
 vExaWpvrgVcOfknRaTHuaQHPKmVdMMQA6IerQRTW1Lxdu+/Wryzv36g8taBxlDf9h9Pd
 4B1Z440u7bHuoXXrOdaBZa4+5rgEhtGhQSxQohHVCtqc/CBjUE06PvtQ4ZoOuTo8pCZ9 Xw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 35h8xqrpkk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 19 Dec 2020 10:58:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BJAoLKo195664;
        Sat, 19 Dec 2020 10:56:03 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 35h6mrug9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Dec 2020 10:56:03 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BJAu1mi031577;
        Sat, 19 Dec 2020 10:56:01 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 19 Dec 2020 02:56:01 -0800
Date:   Sat, 19 Dec 2020 13:55:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] nvmem: core: Fix a resource leak on error in
 nvmem_add_cells_from_of()
Message-ID: <X93cOvjVvzfig1Pu@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9839 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012190079
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9839 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012190079
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This doesn't call of_node_put() on the error path so it leads to a
memory leak.

Fixes: 0749aa25af82 ("nvmem: core: fix regression in of_nvmem_cell_get()")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
The kfree_const() could just be replaced with kfree().  Someone got over
excited converting things from kfree() to kfree_const().

 drivers/nvmem/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 177f5bf27c6d..68ae6f24b57f 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -713,6 +713,7 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 				cell->name, nvmem->stride);
 			/* Cells already added will be freed later. */
 			kfree_const(cell->name);
+			of_node_put(cell->np);
 			kfree(cell);
 			return -EINVAL;
 		}
-- 
2.29.2

