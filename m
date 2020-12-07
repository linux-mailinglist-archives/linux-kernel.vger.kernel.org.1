Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156772D17FA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 18:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgLGR5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 12:57:04 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41992 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgLGR5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 12:57:04 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B7HsBGA168672;
        Mon, 7 Dec 2020 17:56:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=2qoV9t4oMDr+80NiF6UJxp7Yc6katy906iDlX3M96e4=;
 b=WnSQ9MH21KvEJ2A909sf/pZyqMt00VqH/VxO8zZd3DFcoHhgr70bnrdZ6vECoDUAIiLz
 fgPhJNDJ2bQ/2e4B/J8W89UolTUI4Ylv0A6FEYNiQViYYsUUTVM1GNGttZg5BV1JTFbX
 +jSYPgfNYNENy5Lggpz9w+C6R39YUR8u6VUhTRb57ss8E20czLY+GAcTLWwzfpGiB19w
 c4oa8IeCXxxPwj2qd2I+L8XaEv3aMp8fEcu4Y5H77Oc1Zl+pP6VFrtVRs8qZhtQMN4u7
 NRvMRFKbkmGQYxkoGZcCMuSsOmk2BdglzPp6OSnwpdyG0KV1eY4JAUG6lBJoGZ0LQRO8 9w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 3581mqpnxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 07 Dec 2020 17:56:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B7HtemK094978;
        Mon, 7 Dec 2020 17:56:17 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 358m4wkn3d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Dec 2020 17:56:17 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0B7HuG5k016291;
        Mon, 7 Dec 2020 17:56:16 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Dec 2020 09:56:15 -0800
Date:   Mon, 7 Dec 2020 20:55:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Support Opensource <support.opensource@diasemi.com>,
        Adam Ward <Adam.Ward.opensource@diasemi.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] regulator: da9121: Potential Oops in
 da9121_assign_chip_model()
Message-ID: <X85soGKnWAjPUA7a@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9828 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012070116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9828 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 clxscore=1011 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012070116
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a missing "return ret;" on this error path so we call
"da9121_check_device_type(i2c, chip);" which will end up dereferencing
"chip->regmap" and lead to an Oops.

Fixes: c860476b9e3a ("regulator: da9121: Add device variant regmaps")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/regulator/da9121-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/da9121-regulator.c b/drivers/regulator/da9121-regulator.c
index db1c2cc838bc..e4fc3a7cd5d8 100644
--- a/drivers/regulator/da9121-regulator.c
+++ b/drivers/regulator/da9121-regulator.c
@@ -915,6 +915,7 @@ static int da9121_assign_chip_model(struct i2c_client *i2c,
 		ret = PTR_ERR(chip->regmap);
 		dev_err(chip->dev, "Failed to configure a register map: %d\n",
 			ret);
+		return ret;
 	}
 
 	ret = da9121_check_device_type(i2c, chip);
-- 
2.29.2

