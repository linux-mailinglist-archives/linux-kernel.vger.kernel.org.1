Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCEE2D78B3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 16:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437609AbgLKPDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 10:03:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11100 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2437567AbgLKPCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 10:02:47 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BBExrAu141051;
        Fri, 11 Dec 2020 10:02:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=otgUGtIR9Bd/ZgbggKCoLmq/vegsS4ieatGKMBsv2dQ=;
 b=jsCCvHdYUncQrCaAOFPAnHrqs9oBkU+6l5/hdIiVjFo28hFsiwZXWVgSJZxEYnEY5hNy
 P1227Oi8q9GMC9/3O75fjRhwxlJAib4Ue8gDstF6KJBx5fkRYVCaUqMFID50iPz1A9ob
 /LJayCWNEx7+lVFnXXPrhbUGXpe2CMKqSDBabUZfdO1u6yBMugqPRRDLcGz7HLhOJuGb
 AjDP3I5s1vfKlqQByIrlrtqzMigi3et6LlKb5JP9QeVb7V9xEC4e9RsXPlGEqVWZEt/4
 2Pt8sU8zFUgtKNLa4uqs3hm5GF4TUQ7ZwqNEaSaX91TKBzyG9h9HEX1mu0Q9CU8I/Orp yA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35cb18r3ca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Dec 2020 10:02:04 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BBEvd0Z019712;
        Fri, 11 Dec 2020 15:02:01 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3581fhq631-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Dec 2020 15:02:01 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BBF1w1c49086774
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Dec 2020 15:01:58 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A58164C059;
        Fri, 11 Dec 2020 15:01:58 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 615334C044;
        Fri, 11 Dec 2020 15:01:58 +0000 (GMT)
Received: from pomme.tlslab.ibm.com (unknown [9.145.156.139])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 11 Dec 2020 15:01:58 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        nathanl@linux.ibm.com, cheloha@linux.ibm.com
Subject: [PATCH] mm/memory_hotplug: quieting offline operation
Date:   Fri, 11 Dec 2020 16:01:57 +0100
Message-Id: <20201211150157.91399-1-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-11_02:2020-12-11,2020-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=807 spamscore=0 priorityscore=1501
 phishscore=0 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 suspectscore=3 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012110095
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On PowerPC, when dymically removing memory from a system we can see in the console a
lot of messages like this:
[  186.575389] Offlined Pages 4096

This message is displayed on each LMB (256MB) removed, which means that we
removing 1TB of memory, this message is displayed 4096 times.

Moving it to DEBUG to not flood the console.

Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
---
 mm/memory_hotplug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index b44d4c7ba73b..c47a53a16782 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1587,7 +1587,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 
 	/* Mark all sections offline and remove free pages from the buddy. */
 	__offline_isolated_pages(start_pfn, end_pfn);
-	pr_info("Offlined Pages %ld\n", nr_pages);
+	pr_debug("Offlined Pages %ld\n", nr_pages);
 
 	/*
 	 * The memory sections are marked offline, and the pageblock flags
-- 
2.29.2

