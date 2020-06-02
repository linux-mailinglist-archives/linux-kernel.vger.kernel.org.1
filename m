Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80BCD1EBD64
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 15:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgFBNym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 09:54:42 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52588 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgFBNym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 09:54:42 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 052DqYKO120296;
        Tue, 2 Jun 2020 13:54:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : reply-to : mime-version : content-type;
 s=corp-2020-01-29; bh=PvGlKKbIzRg+r/rxEzHH7QUrhuv1NTZV4doWX07tn4o=;
 b=rORvsn2dvfxdda6CIal3pCOM1RbD9OnHPl26ZLw5ONJ2y0cxGoo1O22WiYU7m822AAIu
 VbcMAeWlcMFLzA8mzZ63E2Pj5g6Ds+poCt+SCZNf+1fKk0bnvglQBuF0xE//vAn3MIQU
 V3gBtSLn/Zl7Hhw4smg2Bkf1IZAci4bpgpBwYPefKwt8YzOcF2bG/kTOJte8bdgimbNt
 1h/4Es+smv9HxxntTFWSlChEb1WdGfxKEC89iSLqJCU8akrV5qo7AonT8/SFx+OjSTf3
 HtFT8XOljBdQIZAQSL+n3FtGv7Bz7z1v+nRFD7tjtvNXGvSr6r9jAJqzak+8GYWEXTGq 7g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 31bewqv7gp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 02 Jun 2020 13:54:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 052DrP2a142498;
        Tue, 2 Jun 2020 13:54:18 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 31c12p80yc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Jun 2020 13:54:18 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 052DsGZr004520;
        Tue, 2 Jun 2020 13:54:16 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Jun 2020 06:54:16 -0700
Date:   Tue, 2 Jun 2020 16:54:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Zhou Wang <wangzhou1@hisilicon.com>,
        Shukun Tan <tanshukun1@huawei.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH v2] crypto: hisilicon - allow smaller reads in debugfs
Message-ID: <20200602135409.GA59808@mwanda>
Reply-To: b6da310b-e633-9f74-f7af-7791d803aaf5@huawei.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9639 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006020098
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9639 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 bulkscore=0
 phishscore=0 suspectscore=0 impostorscore=0 cotscore=-2147483648
 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006020098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Originally this code rejected any read less than 256 bytes.  There
is no need for this artificial limit.  We should just use the normal
helper functions to read a string from the kernel.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: Use simple_read_from_buffer().  The v1 was slightly half arsed
because I left the original check for:

	if (*pos)
		return 0;

So it could result in partial reads.  The new code means that if you
want to read the buffer one byte at a time, that's fine or if you want
to read it in one 256 byte chunk that's also fine.  Plus it deletes 21
lines of code and is a lot cleaner.

 drivers/crypto/hisilicon/qm.c | 33 ++++++---------------------------
 1 file changed, 6 insertions(+), 27 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 9bb263cec6c30..13ccb9e29a2e1 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -1064,19 +1064,10 @@ static ssize_t qm_cmd_read(struct file *filp, char __user *buffer,
 	char buf[QM_DBG_READ_LEN];
 	int len;
 
-	if (*pos)
-		return 0;
-
-	if (count < QM_DBG_READ_LEN)
-		return -ENOSPC;
+	len = scnprintf(buf, QM_DBG_READ_LEN, "%s\n",
+			"Please echo help to cmd to get help information");
 
-	len = snprintf(buf, QM_DBG_READ_LEN, "%s\n",
-		       "Please echo help to cmd to get help information");
-
-	if (copy_to_user(buffer, buf, len))
-		return -EFAULT;
-
-	return (*pos = len);
+	return simple_read_from_buffer(buffer, count, pos, buf, len);
 }
 
 static void *qm_ctx_alloc(struct hisi_qm *qm, size_t ctx_size,
@@ -2691,24 +2682,12 @@ static ssize_t qm_status_read(struct file *filp, char __user *buffer,
 {
 	struct hisi_qm *qm = filp->private_data;
 	char buf[QM_DBG_READ_LEN];
-	int val, cp_len, len;
-
-	if (*pos)
-		return 0;
-
-	if (count < QM_DBG_READ_LEN)
-		return -ENOSPC;
+	int val, len;
 
 	val = atomic_read(&qm->status.flags);
-	len = snprintf(buf, QM_DBG_READ_LEN, "%s\n", qm_s[val]);
-	if (!len)
-		return -EFAULT;
-
-	cp_len = copy_to_user(buffer, buf, len);
-	if (cp_len)
-		return -EFAULT;
+	len = scnprintf(buf, QM_DBG_READ_LEN, "%s\n", qm_s[val]);
 
-	return (*pos = len);
+	return simple_read_from_buffer(buffer, count, pos, buf, len);
 }
 
 static const struct file_operations qm_status_fops = {
-- 
2.26.2

