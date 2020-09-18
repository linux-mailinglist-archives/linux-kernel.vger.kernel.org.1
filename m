Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E927270002
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 16:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgIROgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 10:36:33 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47568 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgIROgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 10:36:32 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08IEXkRn045952;
        Fri, 18 Sep 2020 14:36:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=rlQ+LZaYgJGtJpEry/0h8n+m3Iqcym6BQ6YDma7gB3g=;
 b=FHAsrGXv3QQ19lxFmk013373NlHLEuNtiGP3oUlCWsfYRljvyTbdj+cRU3SrVW58TsNW
 V8N+yOtdmxQGttbeMDtUx5ZNXbsPEPezS3UDZzf38yyhH7CxQe6d0ZY6apPOU2aFpwoE
 JWWnVDqRsbaMByuRSK/bDzkvG7dr+d5dy4J9ywNBEywuWf3yA92h0N1QCCuh7wD8CTRT
 VhNgFF8T1gpo3pkOagpdLC3TP9+agEJO2MpPa35Gx/LU19EXo2iASkg2CScbXQlckF/N
 TOur4JU+0E9R8s+ZLISF6qaGKZp9mvBg405twXVr9O7TA7nG3GQDrlgjC+w7YJTX8DW3 eA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 33gnrrfkn3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Sep 2020 14:36:26 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08IETchf112571;
        Fri, 18 Sep 2020 14:34:25 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 33h88epdjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Sep 2020 14:34:25 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08IEYOlD032693;
        Fri, 18 Sep 2020 14:34:24 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 18 Sep 2020 14:34:11 +0000
Date:   Fri, 18 Sep 2020 17:34:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] misc: hisi_hikey_usb: delete a stray tab
Message-ID: <20200918143405.GF909725@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9747 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009180118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9747 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 bulkscore=0 suspectscore=0
 clxscore=1011 mlxlogscore=999 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009180119
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This return statement is indented one tab too far.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/misc/hisi_hikey_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/hisi_hikey_usb.c b/drivers/misc/hisi_hikey_usb.c
index 2ddd4072788d..0913509d2628 100644
--- a/drivers/misc/hisi_hikey_usb.c
+++ b/drivers/misc/hisi_hikey_usb.c
@@ -163,7 +163,7 @@ static int hisi_hikey_usb_parse_kirin970(struct platform_device *pdev,
 		dev_err(&pdev->dev,
 			"get hub-vdd-supply failed with error %ld\n",
 			PTR_ERR(regulator));
-			return PTR_ERR(regulator);
+		return PTR_ERR(regulator);
 	}
 	hisi_hikey_usb->regulator = regulator;
 
-- 
2.28.0

