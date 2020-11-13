Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE5A2B18D5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 11:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgKMKOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 05:14:39 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:60286 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgKMKOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 05:14:38 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ADAAnDI160473;
        Fri, 13 Nov 2020 10:14:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=l4B1MAfnMRL1EsdoVAfHURAMa/V+QkYO+uBwIFlUECI=;
 b=UAVKs+wSiu554wUg2pEOoJBXFMlWor1sID20/T5QjkK6iBMmBu21uLSI8czAqsraCk/D
 865SYqSmUiEsVbu2KyEGrTa3kroZJV4CY306TDFoXU0DYP34rFbwpVQg9ENvpQ4BufMV
 N0QsVvOfhmmV6Bce5uqTFE606Pbxx9lObwWsqmfWxIB6y9y20gVutQqHhRZlX9SvE+Jq
 pcZrlGrGigUrMEnxBdCCbcqjH0jfBVHK+1ocMYSWcJi6694gECT+dDIUwYcBO5zApSuc
 eTq0rhwV9Ui/h4mN8zowpMj6pFwtEjjXk4flYdEWtWDTl4bwpOvLPE1UmmVhaBdjP3I2 vg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 34p72f006g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Nov 2020 10:14:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ADABMgB097084;
        Fri, 13 Nov 2020 10:14:30 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 34p55stf3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Nov 2020 10:14:29 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0ADAERu7032154;
        Fri, 13 Nov 2020 10:14:28 GMT
Received: from mwanda (/10.175.206.108)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Nov 2020 02:14:27 -0800
Date:   Fri, 13 Nov 2020 13:14:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Andy Gross <agross@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] clk: qcom: lpass-sc7180: Clean up on error in
 lpass_sc7180_init()
Message-ID: <20201113101419.GC168908@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9803 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011130061
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9803 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011130061
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the first driver if the second driver can't be registered.

Fixes: 4ee9fe3e292b ("clk: qcom: lpass-sc7180: Disentangle the two clock devices")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/clk/qcom/lpasscorecc-sc7180.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/lpasscorecc-sc7180.c b/drivers/clk/qcom/lpasscorecc-sc7180.c
index 1a3925badd7c..9081649f476f 100644
--- a/drivers/clk/qcom/lpasscorecc-sc7180.c
+++ b/drivers/clk/qcom/lpasscorecc-sc7180.c
@@ -491,7 +491,13 @@ static int __init lpass_sc7180_init(void)
 	if (ret)
 		return ret;
 
-	return platform_driver_register(&lpass_hm_sc7180_driver);
+	ret = platform_driver_register(&lpass_hm_sc7180_driver);
+	if (ret) {
+		platform_driver_unregister(&lpass_core_cc_sc7180_driver);
+		return ret;
+	}
+
+	return 0;
 }
 subsys_initcall(lpass_sc7180_init);
 
-- 
2.28.0

