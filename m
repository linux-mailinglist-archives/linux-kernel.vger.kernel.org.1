Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A046B27980E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 11:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbgIZJDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 05:03:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18274 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726305AbgIZJDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 05:03:30 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08Q8Xpk8105208;
        Sat, 26 Sep 2020 05:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : mime-version : content-type; s=pp1;
 bh=QceCXEG9SK2//eoVadzS4EOOkIVCS1fxx1yIJmTSDYQ=;
 b=Ov6kqqn4N5FyGk6R3PraUQAgg/eYayo1yzReW3rMRgtCmrLbDMEz/44ZgtU3Ffmb0mLQ
 Q/w67sLoIixRhXMw6c/y0E9QZPE1qyo2zyQqkigpEoUlpR01VrlrG9RuSltrbgie+y6v
 DrC60YxHaDgVz+yq5iab79IN/2NTc0EBIDdnPXP3iWhu5c9AcjYmUMK88IPU83nN60Qo
 Pe4osmWUzmOfGcl6AMNwcBdwS6SaEhN9g3ciBjBq6rbuEwLxLQ+Ck4T/6Iab1iil8jbB
 INFl+7WCbe0xVVrPnp79Fjx3tGTYvY9rlVjT57AxImHf/VNEQGzFoIuqVkWEaR/kXTJs xw== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33t19csg1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 26 Sep 2020 05:03:29 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08Q91fYY002162;
        Sat, 26 Sep 2020 09:03:27 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 33svwgr41x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 26 Sep 2020 09:03:27 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08Q93Oo925821684
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Sep 2020 09:03:24 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47994A4066;
        Sat, 26 Sep 2020 09:03:24 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4A35A4062;
        Sat, 26 Sep 2020 09:03:23 +0000 (GMT)
Received: from localhost (unknown [9.145.18.16])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 26 Sep 2020 09:03:23 +0000 (GMT)
Date:   Sat, 26 Sep 2020 11:03:22 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.9-rc7
Message-ID: <your-ad-here.call-01601111002-ext-0188@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-26_06:2020-09-24,2020-09-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 priorityscore=1501 suspectscore=2 bulkscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009260079
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull s390 changes for 5.9-rc7.

Thank you,
Vasily

The following changes since commit ba4f184e126b751d1bffad5897f263108befc780:

  Linux 5.9-rc6 (2020-09-20 16:33:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.9-7

for you to fetch changes up to f7e80983f0cf470bb82036e73bff4d5a7daf8fc2:

  s390/zcrypt: Fix ZCRYPT_PERDEV_REQCNT ioctl (2020-09-24 09:57:24 +0200)

----------------------------------------------------------------
s390 fixes for 5.9-rc7

- Fix truncated ZCRYPT_PERDEV_REQCNT ioctl result. Copy entire reqcnt list.

----------------------------------------------------------------
Christian Borntraeger (1):
      s390/zcrypt: Fix ZCRYPT_PERDEV_REQCNT ioctl

 drivers/s390/crypto/zcrypt_api.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index 4dbbfd88262c..f314936b5462 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -1449,7 +1449,8 @@ static long zcrypt_unlocked_ioctl(struct file *filp, unsigned int cmd,
 		if (!reqcnt)
 			return -ENOMEM;
 		zcrypt_perdev_reqcnt(reqcnt, AP_DEVICES);
-		if (copy_to_user((int __user *) arg, reqcnt, sizeof(reqcnt)))
+		if (copy_to_user((int __user *) arg, reqcnt,
+				 sizeof(u32) * AP_DEVICES))
 			rc = -EFAULT;
 		kfree(reqcnt);
 		return rc;
