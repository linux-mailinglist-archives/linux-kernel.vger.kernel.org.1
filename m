Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 384FB2CB539
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 07:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbgLBGqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 01:46:37 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41172 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728629AbgLBGqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 01:46:36 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B26PMR4141582;
        Wed, 2 Dec 2020 06:45:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=tar26mco4FLDQKq0VgON1HN/qAhgxk4k9zgSvINewiI=;
 b=pAEZyTq1F7ltfbdIzl1sZRgocTWUqkzluzgsDyuPlE4gEdZXo8EFUVsvIqkZthvcyoDf
 orBeyacWPdNdZR39AaWgoXM5torc065SHY1Mg9UIT6UlxCCANuIxIVzEs9uN7F87l1/v
 PpP/jsvIctqefsLLSJ2ZxKkmveWGZxeSj0OasryOGq2YgAyYzZ7gHUMcQnuyFVPE62ix
 ZfAlVAOp7X3evQvl5I6GLec9Rqyn5HdBHTDwbUfuUQDJvrHjdRgkZzDVfvqdV/ZSYGHH
 ixy7xIABkejAjSvWwVxJ82JECMqmjUUNDmXn2Yv7I2SaHb+g2DmVUuG+mdREugFNklPm tA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 353dyqph96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 02 Dec 2020 06:45:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B26QIru004916;
        Wed, 2 Dec 2020 06:45:44 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 3540atp7b3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Dec 2020 06:45:44 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0B26jdpl021459;
        Wed, 2 Dec 2020 06:45:39 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Dec 2020 22:45:38 -0800
Date:   Wed, 2 Dec 2020 09:45:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] pstore: Tidy up an error check
Message-ID: <X8c4C2q6qaZ8qX6L@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9822 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012020039
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9822 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 clxscore=1011 mlxscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012020039
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The crypto_alloc_comp() function never returns NULL, it returns error
pointers on error.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 fs/pstore/platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 36714df37d5d..b7a2a2a31dee 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -315,7 +315,7 @@ static void allocate_buf_for_compression(void)
 	}
 
 	ctx = crypto_alloc_comp(zbackend->name, 0, 0);
-	if (IS_ERR_OR_NULL(ctx)) {
+	if (IS_ERR(ctx)) {
 		kfree(buf);
 		pr_err("crypto_alloc_comp('%s') failed: %ld\n", zbackend->name,
 		       PTR_ERR(ctx));
-- 
2.29.2

