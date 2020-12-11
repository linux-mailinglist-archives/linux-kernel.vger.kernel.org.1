Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1FA52D7880
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 16:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391375AbgLKPBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 10:01:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34710 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2437536AbgLKPBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 10:01:12 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BBEs5He149875;
        Fri, 11 Dec 2020 10:00:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=LiveotuZsmsXshSorNSc8PYuECgX0r0WH3tjDnOKDhM=;
 b=Ugu4DmE4lnvVysz1KJqzJ48wADQQdYo6D+cw8W2voX4w/z+8rrtwTEjaWognJqa+XVtW
 +1BkEFXsLxr+8bgcOcE2C0Nf6xG39LRsN/ySpS+xlYtthhXWAXJULb6939+5im5LrAiK
 ah3Eln64rXt81v1unMNVEdVQsJnpRnoL9ydw5EFwcK1Br87T5pgEueLT4/C7MW18R0qj
 S+v552qxjWnJrDBdeoHcJLbnvzoKGSoLXlKBdC99LmncedM/cQIMmh5vjTDlTYrBF5Yq
 N8+gYZkX5qW3Fq1wDVqQqUS8pI4CLgIT6CN9e8Wj7BALRGtvwQbkfTcdpErkb0Nuv/fQ EQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35c5gfa74w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Dec 2020 10:00:01 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BBEvjhH024711;
        Fri, 11 Dec 2020 14:59:59 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3581u875jg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Dec 2020 14:59:59 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BBExuas33292684
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Dec 2020 14:59:57 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2DB24C04A;
        Fri, 11 Dec 2020 14:59:56 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 774284C044;
        Fri, 11 Dec 2020 14:59:56 +0000 (GMT)
Received: from pomme.tlslab.ibm.com (unknown [9.145.156.139])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 11 Dec 2020 14:59:56 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, nathanl@linux.ibm.com,
        cheloha@linux.ibm.com
Subject: [PATCH] powerpc/memhotplug: quieting some DLPAR operations
Date:   Fri, 11 Dec 2020 15:59:54 +0100
Message-Id: <20201211145954.90143-1-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-11_02:2020-12-11,2020-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012110091
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When attempting to remove by index a set of LMB a lot of messages are
displayed on the console, even when everything goes fine:

 pseries-hotplug-mem: Attempting to hot-remove LMB, drc index 8000002d
 Offlined Pages 4096
 pseries-hotplug-mem: Memory at 2d0000000 was hot-removed

The 2 messages prefixed by "pseries-hotplug-mem" are not really helpful for
the end user, they should be debug outputs.

In case of error, because some of the LMB's pages couldn't be offlined, the
following is displayed on the console:

 pseries-hotplug-mem: Attempting to hot-remove LMB, drc index 8000003e
 pseries-hotplug-mem: Failed to hot-remove memory at 3e0000000
 dlpar: Could not handle DLPAR request "memory remove index 0x8000003e"

Again, the 2 messages prefixed by "pseries-hotplug-mem" are useless, and the
generic DLPAR prefixed message should be enough. Turning the 2 firts at
DEBUG level.

These 2 first changes are mainly triggered by the changes introduced in
drmgr:
https://groups.google.com/g/powerpc-utils-devel/c/Y6ef4NB3EzM/m/9cu5JHRxAQAJ

Also, when adding a bunch of LMBs, a message is displayed in the console per LMB
like these ones:
 pseries-hotplug-mem: Memory at 7e0000000 (drc index 8000007e) was hot-added
 pseries-hotplug-mem: Memory at 7f0000000 (drc index 8000007f) was hot-added
 pseries-hotplug-mem: Memory at 800000000 (drc index 80000080) was hot-added
 pseries-hotplug-mem: Memory at 810000000 (drc index 80000081) was hot-added

When adding 1TB of memory and LMB size is 256MB, this leads to 4096
messages to be displayed on the console. These messages are not really
helpful for the end user, so moving them to the DEBUG level.

Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/hotplug-memory.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 7efe6ec5d14a..8377f1f7c78e 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -479,7 +479,7 @@ static int dlpar_memory_remove_by_index(u32 drc_index)
 	int lmb_found;
 	int rc;
 
-	pr_info("Attempting to hot-remove LMB, drc index %x\n", drc_index);
+	pr_debug("Attempting to hot-remove LMB, drc index %x\n", drc_index);
 
 	lmb_found = 0;
 	for_each_drmem_lmb(lmb) {
@@ -497,10 +497,10 @@ static int dlpar_memory_remove_by_index(u32 drc_index)
 		rc = -EINVAL;
 
 	if (rc)
-		pr_info("Failed to hot-remove memory at %llx\n",
-			lmb->base_addr);
+		pr_debug("Failed to hot-remove memory at %llx\n",
+			 lmb->base_addr);
 	else
-		pr_info("Memory at %llx was hot-removed\n", lmb->base_addr);
+		pr_debug("Memory at %llx was hot-removed\n", lmb->base_addr);
 
 	return rc;
 }
@@ -717,8 +717,8 @@ static int dlpar_memory_add_by_count(u32 lmbs_to_add)
 			if (!drmem_lmb_reserved(lmb))
 				continue;
 
-			pr_info("Memory at %llx (drc index %x) was hot-added\n",
-				lmb->base_addr, lmb->drc_index);
+			pr_debug("Memory at %llx (drc index %x) was hot-added\n",
+				 lmb->base_addr, lmb->drc_index);
 			drmem_remove_lmb_reservation(lmb);
 		}
 		rc = 0;
-- 
2.29.2

