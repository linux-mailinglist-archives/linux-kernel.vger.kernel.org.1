Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9592A9DFF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 20:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbgKFT0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 14:26:32 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:37388 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728167AbgKFT0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 14:26:32 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A6JDaPt041942;
        Fri, 6 Nov 2020 19:26:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=v8aUxlzhOmPPnjHBTuKWh9NcWoNY4jT3BjUF/BStqrA=;
 b=Dl9SFax0z/C9Urha1XxIsRDM1wQtZiLG0tmmxzIl+Z9/Jm0QD98A7uKqjHlGUe0xr4Go
 IPgRtPvoI+ieaCn12yCouXOWLoog+x1p0exk4E+F78AhdsP3SN5+lWZm8VA0+cYiCJRS
 /jA8iN/rq6FOOPoiZyajwFPFMd+xH9V/x1UH2xadYs62/x+hhW/JnjpvPsjLMGafEOmG
 gACrZvO4QOq0YeXu/Nlri0iby8oBzTudkskTOS7OI8zpbXLwbtptmbhv0E3srA4/VpPA
 lx8MU+8BOQt30WO7kxw1UDAzsnRt+I4a/yiXb0R7Fj16pnts0RFrZaLkQmFEEVtAfS/U jw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 34hhvctkvq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 06 Nov 2020 19:26:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A6JEqa8042516;
        Fri, 6 Nov 2020 19:24:23 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 34hw0kqkm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Nov 2020 19:24:23 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A6JOMax006726;
        Fri, 6 Nov 2020 19:24:22 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 06 Nov 2020 11:24:21 -0800
Date:   Fri, 6 Nov 2020 22:24:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Lars Poeschel <poeschel@lemonage.de>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] auxdisplay: fix use after free in lcd2s_i2c_remove()
Message-ID: <20201106192415.GA2696904@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9797 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011060135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9797 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=2
 impostorscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011060135
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kfree() needs to be moved down a line to prevent a use after free.

Fixes: 8c9108d014c5 ("auxdisplay: add a driver for lcd2s character display")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/auxdisplay/lcd2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/auxdisplay/lcd2s.c b/drivers/auxdisplay/lcd2s.c
index cfa5f86deeef..3eb7f04db6cb 100644
--- a/drivers/auxdisplay/lcd2s.c
+++ b/drivers/auxdisplay/lcd2s.c
@@ -348,8 +348,8 @@ static int lcd2s_i2c_remove(struct i2c_client *i2c)
 {
 	struct lcd2s_data *lcd2s = i2c_get_clientdata(i2c);
 
-	kfree(lcd2s->charlcd);
 	charlcd_unregister(lcd2s->charlcd);
+	kfree(lcd2s->charlcd);
 	return 0;
 }
 
-- 
2.28.0

