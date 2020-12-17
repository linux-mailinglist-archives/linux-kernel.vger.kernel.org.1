Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421F22DD017
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 12:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgLQLIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 06:08:06 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:55642 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbgLQLIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 06:08:05 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BHAxsvd141550;
        Thu, 17 Dec 2020 11:07:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=BfkkFkzqmk/IWHuN2MKYZ9BaPDB2Wnl5NclBQcnvv5c=;
 b=rMQA6zRzIac15qqdt2lWs7dMGNgTurBujHE7cc4dhUX5bdIDglQDyWZb2R2tTIKzkKYA
 2ClPU546y8HJFI6KACyau55jm8IopK2rwvNZx13mQWRjDJvO3FByOSXD/1f8oEP/PUld
 ykwuwIzVPUxczxlrEp0bc30d765pEqItHKi+kBRyw5An5rE4Ng0Nf/zFKW6sDcqcuGZF
 L321KF5zrGTpvLdwQc6tUHMaQ5vZslv1UsnIhcNaxSYLSPOOmVG/CQsPjLP6hNYuh69S
 6Lv/uTfQ2+TG+lPML0wmbWwVOnAAgiH0I6s4E+uNdtoBPBhJ+SFs5bHu2nU7LIyBN8Sn Wg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 35ckcbn0v1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Dec 2020 11:07:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BHB5Fff105775;
        Thu, 17 Dec 2020 11:05:17 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 35g3redvu8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Dec 2020 11:05:17 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BHB56Av017139;
        Thu, 17 Dec 2020 11:05:06 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Dec 2020 03:05:06 -0800
Date:   Thu, 17 Dec 2020 14:04:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Swapnil Jakhade <sjakhade@cadence.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Yuti Amonkar <yamonkar@cadence.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] phy: cadence-torrent: Fix error code in
 cdns_torrent_phy_probe()
Message-ID: <X9s7Wxq+b6ls0q7o@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9837 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012170081
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9837 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 clxscore=1011
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012170080
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This error path should return -EINVAL, but currently it returns
success.

Fixes: d09945eacad0 ("phy: cadence-torrent: Check total lane count for all subnodes is within limit")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index f310e15d94cb..591a15834b48 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -2298,6 +2298,7 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 
 	if (total_num_lanes > MAX_NUM_LANES) {
 		dev_err(dev, "Invalid lane configuration\n");
+		ret = -EINVAL;
 		goto put_lnk_rst;
 	}
 
-- 
2.29.2

