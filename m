Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B2A2B18C5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 11:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgKMKJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 05:09:25 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:45084 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgKMKJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 05:09:23 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ADA44We195662;
        Fri, 13 Nov 2020 10:09:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=CmOkNnoq4aouIzIKH5BdnPNOjPDxlp5PbgvCa+MCvGk=;
 b=dI57/+8hQXv2he9Ovg5TnVAUuFuHYAM82lFIXcQbjrtLPV7GerAapaQ4Z5wj6gIZUA5J
 02MituRHDV5X2aTmzaLiekpz0kBe35D1QMLql5cjsnS7DhN5gCd5otHEHBghGj4D0yt1
 tlcAqHg9lT2x53EUUUwVSqwIGHR2PPO82BtGShXH8WNJVzj158EV3F2DfkQOb4PvGPIN
 w40wsZcCk6rzf7vWGFJVw5KWFAlRxy/9zergNwvCyc41Bzhxh6T/1eJArspl29WcVmyn
 eArnpahUzu1ng5OYO48vULf6UTTq/VCFaxjgC/JmKIKQB8nfeiJnU8erSPeskB7jeh/1 Xg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 34nkhm9rnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Nov 2020 10:09:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ADA6HoS164926;
        Fri, 13 Nov 2020 10:09:05 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 34rtktbk6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Nov 2020 10:09:05 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0ADA8vq3027309;
        Fri, 13 Nov 2020 10:08:57 GMT
Received: from mwanda (/10.175.206.108)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Nov 2020 02:08:56 -0800
Date:   Fri, 13 Nov 2020 13:08:50 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Andrew Jeffery <andrew@aj.id.au>, Tom Rix <trix@redhat.com>,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] soc: aspeed: Fix a reference leak in aspeed_socinfo_init()
Message-ID: <20201113100850.GA168908@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9803 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011130060
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9803 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1011 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011130060
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This needs to call of_node_put(np) before returning if of_iomap() fails.

Fixes: e0218dca5787 ("soc: aspeed: Add soc info driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/soc/aspeed/aspeed-socinfo.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/aspeed/aspeed-socinfo.c b/drivers/soc/aspeed/aspeed-socinfo.c
index 20a1d4aeb051..773930e0cb10 100644
--- a/drivers/soc/aspeed/aspeed-socinfo.c
+++ b/drivers/soc/aspeed/aspeed-socinfo.c
@@ -74,8 +74,10 @@ static int __init aspeed_socinfo_init(void)
 	}
 
 	reg = of_iomap(np, 0);
-	if (!reg)
+	if (!reg) {
+		of_node_put(np);
 		return -ENODEV;
+	}
 	siliconid = readl(reg);
 	iounmap(reg);
 
-- 
2.28.0

