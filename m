Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55CD12D3BC4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 08:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbgLIG7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 01:59:14 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:55326 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728190AbgLIG7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 01:59:14 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B96rvla060026;
        Wed, 9 Dec 2020 06:58:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=YPXG9y/ZjhBLvup24kkCZbKkvoUdidf84zgGRD5QHZE=;
 b=mePum36e7D9qU7YdK9YosEgCCEl+y9YE4478G/ZG+I2M6LpCBREzdtOkdt8XxSEKXxto
 Lww71yA3Oj7ner1a1OfdtjxK+ieYKAYj9OK7JTc/qM9re1zEJuys5CpUIlXruTSjTYk4
 YTKB/y0GPidvY4sGxZzuOnjYqPT07hDS8smM28GrHRz4MM7jeRWhvFAMMo1qlIVEEeai
 WgsTnQJXdFLgWxxtTz9lbEu+cjpSXSMy+EiISk2fIMlzrvtlFJK3jeOmtfhVIimf14k8
 3ounAT4s9hoFt1MfCB4KMX8Sac/aGrbSkRnRBJRdgC9sz/Jjidb21zEFUg/KakPyeIC6 DQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 3581mqxg0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 09 Dec 2020 06:58:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B96soov026476;
        Wed, 9 Dec 2020 06:56:27 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 358kspne2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Dec 2020 06:56:27 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0B96uN7O004580;
        Wed, 9 Dec 2020 06:56:24 GMT
Received: from mwanda (/102.36.221.92) by default (Oracle Beehive Gateway
 v4.0) with ESMTP ; Tue, 08 Dec 2020 22:55:31 -0800
MIME-Version: 1.0
Message-ID: <X9B03LFICh/QykQ6@mwanda>
Date:   Tue, 8 Dec 2020 22:55:24 -0800 (PST)
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Eric Biederman <ebiederm@xmission.com>,
        Dave Young <dyoung@redhat.com>
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] kexec: Fix error code in kexec_calculate_store_digests()
X-Mailer: git-send-email haha only kidding
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=2
 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012090047
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 mlxlogscore=999
 clxscore=1011 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012090047
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return -ENOMEM on allocation failure instead of returning success.

Fixes: a43cac0d9dc2 ("kexec: split kexec_file syscall code to kexec_file.c")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 kernel/kexec_file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index b02086d70492..9570f380a825 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -735,8 +735,10 @@ static int kexec_calculate_store_digests(struct kimage *image)
 
 	sha_region_sz = KEXEC_SEGMENT_MAX * sizeof(struct kexec_sha_region);
 	sha_regions = vzalloc(sha_region_sz);
-	if (!sha_regions)
+	if (!sha_regions) {
+		ret = -ENOMEM;
 		goto out_free_desc;
+	}
 
 	desc->tfm   = tfm;
 
-- 
2.29.2

