Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF902DAEAB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 15:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbgLOONw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 09:13:52 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:57132 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgLOONv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 09:13:51 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BFE4ZYZ174028;
        Tue, 15 Dec 2020 14:13:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=hQZopvQ/2R5bSnNeMOXl1coVQ2s6ZfV7/1lCPOpAMAw=;
 b=izzUehyiEZhxfmQwPvuFtsamc/STFyB4jIuANkVlBeLEXtHaaIfcvHMfeiAj9MVU/7cq
 oyWGl9pFOswDg6zz/1GVJm3EvwdUlj8+qaB7DP20e5mKmME4TXqkre/Mfu2zCTMXx8g/
 hTLkUzbsbNck7HzslNWcJQygJ3YhiDYlx4f3pJVTTa7/NEdxnqGc4ojVRz96Gt0clDP4
 WmRgpYnMQ0aqseAgYFi+khxDVP1U3Nuh/Hb/y16WamSqHyIDhNdFXXDziD0CguZP7Pkl
 34tE/+O5KseMiEzfi02VhiyQgadnCQVuH19cIkCcTHWW5V8HgpckBYO/iPmEhCnaNxD4 JA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 35cn9raqpk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Dec 2020 14:13:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BFE5CNV045124;
        Tue, 15 Dec 2020 14:13:06 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 35d7en2fwa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Dec 2020 14:13:06 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BFED6FQ022201;
        Tue, 15 Dec 2020 14:13:06 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Dec 2020 06:13:04 -0800
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@google.com>
Subject: [PATCH] mm/mmap: Don't unlock VMAs in remap_file_pages()
Date:   Tue, 15 Dec 2020 09:13:00 -0500
Message-Id: <20201215141300.1436976-1-Liam.Howlett@Oracle.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9835 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012150101
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9835 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012150101
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_mmap() will unlock the necessary VMAs.  There is also a bug in the
loop which will evaluate as false and not unlock any VMAs anyways.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 5c8b4485860de..008adf20611e5 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3025,25 +3025,6 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 
 	flags &= MAP_NONBLOCK;
 	flags |= MAP_SHARED | MAP_FIXED | MAP_POPULATE;
-	if (vma->vm_flags & VM_LOCKED) {
-		struct vm_area_struct *tmp;
-		flags |= MAP_LOCKED;
-
-		/* drop PG_Mlocked flag for over-mapped range */
-		for (tmp = vma; tmp->vm_start >= start + size;
-				tmp = tmp->vm_next) {
-			/*
-			 * Split pmd and munlock page on the border
-			 * of the range.
-			 */
-			vma_adjust_trans_huge(tmp, start, start + size, 0);
-
-			munlock_vma_pages_range(tmp,
-					max(tmp->vm_start, start),
-					min(tmp->vm_end, start + size));
-		}
-	}
-
 	file = get_file(vma->vm_file);
 	ret = do_mmap(vma->vm_file, start, size,
 			prot, flags, pgoff, &populate, NULL);
-- 
2.28.0

