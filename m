Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5F7273D14
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 10:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgIVIQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 04:16:36 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:33820 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgIVIQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 04:16:36 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08M8FPqC040009;
        Tue, 22 Sep 2020 08:16:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=NP69j30IgNuQBIP+fCRRkwYYH5uUJbj2+PP/5UVMlZ0=;
 b=dsREZJIyn2aaz/9Q42qsnZV1q4RGCsFuxkwJXiyZZK7KvtRcRxmrHZfKORFKs6PsIgda
 AdvIdmdN0nRQf7TSqVb5vof4ihnVSpuOQcZBjMvlp4+Yi/RCjdv6APmdxHyGk8vDvFZN
 eNCAy6ONOZh7QtinVgkz9w+l7ItqJ/1AaZgfL5DMhPmUTfhHk13p7Hsr7RQYwILuwujF
 yDsX4N4iRkVjYcmjtQIzY0zEC6hzHLOHwYfE3UDQepszW8Rg6KPHn2HTHqehnazOFKJd
 A+7n1RklmLg7c3s+7bxnB+foiYVJ7qmBoOapbv0GBa+6VdxgFwlvBMei+VPcSbq4nuix ZQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 33qcptr8q2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Sep 2020 08:16:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08M8BQYu042800;
        Tue, 22 Sep 2020 08:14:25 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 33nujmvc4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Sep 2020 08:14:25 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08M8ENc9030944;
        Tue, 22 Sep 2020 08:14:23 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Sep 2020 01:14:22 -0700
Date:   Tue, 22 Sep 2020 11:14:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Liam Girdwood <lrg@slimlogic.co.uk>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] mfd: max8998: fix potential double free in probe
Message-ID: <20200922081416.GB1274646@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9751 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 adultscore=0 spamscore=0 suspectscore=2
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009220067
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9751 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 mlxlogscore=999
 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1011 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009220068
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The problem is that mfd_add_devices() calls mfd_remove_devices() on
failure and then the probe function will also call mfd_remove_devices().
I don't know exactly what problems this will cause but I'm pretty sure
that it will trigger the BUG_ON() at the start of ida_free().

One thing that this patch changes is that it adds a check for if
max8998_irq_init() fails.

Fixes: 156f252857df ("drivers: regulator: add Maxim 8998 driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Checking max8998_irq_init() is slightly risky because sometimes these
functions have been failing and we didn't know.

 drivers/mfd/max8998.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/max8998.c b/drivers/mfd/max8998.c
index 785f8e9841b7..9713c3ea4a63 100644
--- a/drivers/mfd/max8998.c
+++ b/drivers/mfd/max8998.c
@@ -202,7 +202,9 @@ static int max8998_i2c_probe(struct i2c_client *i2c,
 	}
 	i2c_set_clientdata(max8998->rtc, max8998);
 
-	max8998_irq_init(max8998);
+	ret = max8998_irq_init(max8998);
+	if (ret)
+		goto unregister_dummy;
 
 	pm_runtime_set_active(max8998->dev);
 
@@ -222,15 +224,15 @@ static int max8998_i2c_probe(struct i2c_client *i2c,
 	}
 
 	if (ret < 0)
-		goto err;
+		goto release_irq;
 
 	device_init_wakeup(max8998->dev, max8998->wakeup);
 
-	return ret;
+	return 0;
 
-err:
-	mfd_remove_devices(max8998->dev);
+release_irq:
 	max8998_irq_exit(max8998);
+unregister_dummy:
 	i2c_unregister_device(max8998->rtc);
 	return ret;
 }
-- 
2.28.0

