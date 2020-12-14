Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E7C2D97C2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 12:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438794AbgLNL4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 06:56:07 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:38486 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730991AbgLNL4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 06:56:06 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BEBnkCS140859;
        Mon, 14 Dec 2020 11:55:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=0iQky8MTG41IHzMruSm4cjXNdRJ2e3+bpUkzpXJ92nE=;
 b=FnHJ72xajo+S4PlY3l+8P11GTbZVZqK+WzeVb+7a582juCZ5c50eNYicd7SGpxUiBGow
 lM1Bc9vf8kXFUFwMDD6AuTyHmIDC5O8p/wbDrkm/2GYIQlDxgJ6HpS8AngDxucBq1yJU
 UjZQv9WhjXETotIQvTtPM1F3yBFQAmIBU7140OEKl0BCrgk6LGqXruQaweTeEpkaWYHF
 hfLxnVavDWUJrhZTTQcGzXoxEN8rlxYZBq+pM1RQcG8J2h6Hzz4OAeNTGdZ8edawTHQK
 gU4osp5yY40kMeLoMEfy19RMyYp6PdQTKcPqw5XHhsFyPZH2ud3t/zqDZH8ssgDdsG+F 2Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 35cntkvr25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Dec 2020 11:55:11 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BEBp9Dr012697;
        Mon, 14 Dec 2020 11:53:10 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 35d7ekcetr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Dec 2020 11:53:10 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BEBr7s5006091;
        Mon, 14 Dec 2020 11:53:10 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 14 Dec 2020 03:53:06 -0800
Date:   Mon, 14 Dec 2020 14:52:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Russell King <rmk+kernel@armlinux.org.uk>
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] fs/adfs: bigdir: Fix another error code in adfs_fplus_read()
Message-ID: <X9dSGhuIWbOfmp7I@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9834 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012140084
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9834 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012140084
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This should return -EINVAL if the checkbyte is wrong instead of success.

Fixes: d79288b4f61b ("fs/adfs: bigdir: calculate and validate directory checkbyte")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Sorry for not catching this one last time.  :/

 fs/adfs/dir_fplus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/adfs/dir_fplus.c b/fs/adfs/dir_fplus.c
index 4a15924014da..a5e47c94a5b9 100644
--- a/fs/adfs/dir_fplus.c
+++ b/fs/adfs/dir_fplus.c
@@ -143,6 +143,7 @@ static int adfs_fplus_read(struct super_block *sb, u32 indaddr,
 
 	if (adfs_fplus_checkbyte(dir) != t->bigdircheckbyte) {
 		adfs_error(sb, "dir %06x checkbyte mismatch\n", indaddr);
+		ret = -EINVAL;
 		goto out;
 	}
 
-- 
2.29.2

