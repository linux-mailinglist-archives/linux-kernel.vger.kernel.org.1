Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA47200261
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 09:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbgFSHCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 03:02:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59072 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728109AbgFSHCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 03:02:04 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05J6WgYp175276;
        Fri, 19 Jun 2020 03:01:57 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31rpvr2ca2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Jun 2020 03:01:56 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05J703dq007890;
        Fri, 19 Jun 2020 07:01:53 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 31qur629vm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Jun 2020 07:01:53 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05J71oik50331706
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Jun 2020 07:01:50 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 695AFA405B;
        Fri, 19 Jun 2020 07:01:50 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC64DA405F;
        Fri, 19 Jun 2020 07:01:23 +0000 (GMT)
Received: from satheesh.ibmuc.com (unknown [9.199.32.210])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 19 Jun 2020 07:01:23 +0000 (GMT)
From:   Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        Laurent Dufour <ldufour@linux.ibm.com>
Subject: [PATCH V2] powerpc/pseries/svm: Remove unwanted check for shared_lppaca_size
Date:   Fri, 19 Jun 2020 12:31:13 +0530
Message-Id: <20200619070113.16696-1-sathnaga@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-19_01:2020-06-18,2020-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 cotscore=-2147483648 impostorscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 priorityscore=1501 spamscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006190043
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Early secure guest boot hits the below crash while booting with
vcpus numbers aligned with page boundary for PAGE size of 64k
and LPPACA size of 1k i.e 64, 128 etc, due to the BUG_ON assert
for shared_lppaca_total_size equal to shared_lppaca_size,

 [    0.000000] Partition configured for 64 cpus.
 [    0.000000] CPU maps initialized for 1 thread per core
 [    0.000000] ------------[ cut here ]------------
 [    0.000000] kernel BUG at arch/powerpc/kernel/paca.c:89!
 [    0.000000] Oops: Exception in kernel mode, sig: 5 [#1]
 [    0.000000] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA pSeries

which is not necessary, let's remove it.

Fixes: bd104e6db6f0 ("powerpc/pseries/svm: Use shared memory for LPPACA structures")
Cc: linux-kernel@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc: Ram Pai <linuxram@us.ibm.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Laurent Dufour <ldufour@linux.ibm.com>
Reviewed-by: Laurent Dufour <ldufour@linux.ibm.com>
Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Signed-off-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
---

V2:
Added Reviewed by Thiago and Laurent.
Added Fixes tag as per Thiago suggest.

V1: https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20200609105731.14032-1-sathnaga@linux.vnet.ibm.com/ 
---
 arch/powerpc/kernel/paca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 2168372b792d..74da65aacbc9 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -87,7 +87,7 @@ static void *__init alloc_shared_lppaca(unsigned long size, unsigned long align,
 	 * This is very early in boot, so no harm done if the kernel crashes at
 	 * this point.
 	 */
-	BUG_ON(shared_lppaca_size >= shared_lppaca_total_size);
+	BUG_ON(shared_lppaca_size > shared_lppaca_total_size);
 
 	return ptr;
 }
-- 
2.26.2

