Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1FAD2D33C3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 21:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbgLHUYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 15:24:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18970 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726168AbgLHUYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:24:37 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B8JWxfM032406;
        Tue, 8 Dec 2020 14:54:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=95UgXRvXPJHyqp6xYKFILnHAYH7bcIsFJBiXKdV66yk=;
 b=qJwv4TuYQmvExqtNYaiC6tSY6dkKY8OXJyibtLSMYJzyoGAqL3IxWLtCcnHc+nZpLm5D
 KDWwEBjczxXCQp22KLFIhnI9dyiGZ4qkT5vgSzspaCZV/XoVhnhqjEZE/9exKiJ1KjwH
 o1Be1C090zsN44SBbo7QuNaZi7gLOeWU/+pJ3amkQzvG+Ur1iv1OHEK0OFue1oRI41ei
 lkVaA2fESKbBxU0UXSSBdOixAPT0l6tXV37xwY+kuWXOfxPI+4g4w3Kl/wBMUAhz+DsD
 Y6wHsxzKIYUg0JeXn3KuKq/nX96l8sYKZrX8Q3JIvbI1KzvFLNyYwn2fZl/5sugYmd8p dQ== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35ae0kkrtn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Dec 2020 14:54:38 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B8Jpekf030479;
        Tue, 8 Dec 2020 19:54:37 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03wdc.us.ibm.com with ESMTP id 3581u92515-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Dec 2020 19:54:37 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B8JsaFq25887338
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Dec 2020 19:54:36 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADCA228058;
        Tue,  8 Dec 2020 19:54:36 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 582AE28064;
        Tue,  8 Dec 2020 19:54:36 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.40.195.188])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  8 Dec 2020 19:54:36 +0000 (GMT)
From:   Tyrel Datwyler <tyreld@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH] powerpc/rtas: fix typo of ibm,open-errinjct in rtas filter
Date:   Tue,  8 Dec 2020 13:54:34 -0600
Message-Id: <20201208195434.8289-1-tyreld@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-08_14:2020-12-08,2020-12-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1 spamscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 mlxscore=0 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012080120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit bd59380c5ba4 ("powerpc/rtas: Restrict RTAS requests from userspace")
introduced the following error when invoking the errinjct userspace
tool.

[root@ltcalpine2-lp5 librtas]# errinjct open
[327884.071171] sys_rtas: RTAS call blocked - exploit attempt?
[327884.071186] sys_rtas: token=0x26, nargs=0 (called by errinjct)
errinjct: Could not open RTAS error injection facility
errinjct: librtas: open: Unexpected I/O error

The entry for ibm,open-errinjct in rtas_filter array has a typo where
the "j" is omitted in the rtas call name. After fixing this typo the
errinjct tool functions again as expected.

[root@ltcalpine2-lp5 linux]# errinjct open
RTAS error injection facility open, token = 1

fixes: bd59380c5ba4 ("powerpc/rtas: Restrict RTAS requests from userspace")
Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 arch/powerpc/kernel/rtas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 954f41676f69..cccb32cf0e08 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -1030,7 +1030,7 @@ static struct rtas_filter rtas_filters[] __ro_after_init = {
 	{ "ibm,display-message", -1, 0, -1, -1, -1 },
 	{ "ibm,errinjct", -1, 2, -1, -1, -1, 1024 },
 	{ "ibm,close-errinjct", -1, -1, -1, -1, -1 },
-	{ "ibm,open-errinct", -1, -1, -1, -1, -1 },
+	{ "ibm,open-errinjct", -1, -1, -1, -1, -1 },
 	{ "ibm,get-config-addr-info2", -1, -1, -1, -1, -1 },
 	{ "ibm,get-dynamic-sensor-state", -1, 1, -1, -1, -1 },
 	{ "ibm,get-indices", -1, 2, 3, -1, -1 },
-- 
2.27.0

