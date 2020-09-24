Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4960277171
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 14:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgIXMsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 08:48:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62956 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727770AbgIXMsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 08:48:01 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08OCZEjl099148;
        Thu, 24 Sep 2020 08:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=qQrYYa0Fz8zvGS/ETimspZ0IXWq9z6yIxTrOcbkxEV8=;
 b=oHXYEtbBpWt1cvEclqy8jUZ6OqJNZDHJokCySLmUb8DoOCcrkUnhsP0vfdz5KyK5A1Ow
 cHicdfZYwHob6AvuST7jSz1QW/JzKW7YPVh3jYzaGfjZYfKOesm6r4w3rLnhHaeMIZjt
 lpWr8AEbK+YryduLfAiQPPAwMKNsLfx1PzuAG4JP7ypWBlbTVU3kJyl4x5NGKeW0RU5r
 GP5pfZtd1jnFk9Nf6apd1CZgo9ARriYKU63esle/gQQJh/11jcZ1jpfSrBL+MLrFdPy8
 iXizBYmlZVuH9jDYwtgHoXHTrbOT9gc6SwxFMbT0QgZTnlYw7sGeAtfMl+NwYlJ1rcyq hQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33rtuahw87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Sep 2020 08:47:54 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08OCZUbC100376;
        Thu, 24 Sep 2020 08:47:53 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33rtuahw6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Sep 2020 08:47:53 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08OCllaG014729;
        Thu, 24 Sep 2020 12:47:50 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 33n98gtqvh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Sep 2020 12:47:50 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08OClmk631916404
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Sep 2020 12:47:48 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59F5711C04C;
        Thu, 24 Sep 2020 12:47:48 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C6D711C054;
        Thu, 24 Sep 2020 12:47:47 +0000 (GMT)
Received: from oc8242746057.ibm.com.com (unknown [9.171.75.6])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 24 Sep 2020 12:47:47 +0000 (GMT)
From:   Alexander Egorenkov <egorenar@linux.ibm.com>
To:     dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     ebiederm@xmission.com, akpm@linux-foundation.org,
        ktkhai@virtuozzo.com, keescook@chromium.org,
        christian.brauner@ubuntu.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexander Egorenkov <egorenar@linux.ibm.com>
Subject: [PATCH v2 1/1] kdump: append uts_namespace.name offset to VMCOREINFO
Date:   Thu, 24 Sep 2020 14:46:47 +0200
Message-Id: <20200924124647.300080-1-egorenar@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-24_08:2020-09-24,2020-09-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 mlxscore=0 phishscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240097
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The offset of the field 'init_uts_ns.name' has changed
since

commit 9a56493f6942c0e2df1579986128721da96e00d8
Author: Kirill Tkhai <ktkhai@virtuozzo.com>
Date:   Mon Aug 3 13:16:21 2020 +0300

    uts: Use generic ns_common::count

Link: https://lore.kernel.org/r/159644978167.604812.1773586504374412107.stgit@localhost.localdomain

Make the offset of the field 'uts_namespace.name' available
in VMCOREINFO because tools like 'crash-utility' and
'makedumpfile' must be able to read it from crash dumps.

Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
---
 kernel/crash_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 106e4500fd53..173fdc261882 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -447,6 +447,7 @@ static int __init crash_save_vmcoreinfo_init(void)
 	VMCOREINFO_PAGESIZE(PAGE_SIZE);
 
 	VMCOREINFO_SYMBOL(init_uts_ns);
+	VMCOREINFO_OFFSET(uts_namespace, name);
 	VMCOREINFO_SYMBOL(node_online_map);
 #ifdef CONFIG_MMU
 	VMCOREINFO_SYMBOL_ARRAY(swapper_pg_dir);
-- 
2.26.2

