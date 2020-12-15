Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3682DB0AC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 16:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730753AbgLOP6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 10:58:24 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:57078 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730393AbgLOP5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:57:38 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BFFrfvK097745;
        Tue, 15 Dec 2020 15:56:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=X8cotNVRvYPO4IUOxh1+ibuoxANk5xMy4g8PWcjkYoE=;
 b=uQkiV4fE+2HBOEJy8GroAMsRbXPEt3PQWq3I+2AMzVlpAgSx4iXcx6agTNNTvqb+Zmaw
 vuMB6MV0DAysMk3FrYS5Feffd5nVdd29LdVmt6sSZ7+G13qTFh4B/akcjbkTyu2hH4ST
 F7X65wMVrer3eACpMcb/bNGkqAN8NB0/lLvgw9qjmykCAhyqLo2Tisnkt5EzeasR77YG
 GXnrqBI6qFMKO9nTK+5cvTDE1tSH2JFU0U31lDSXShordCZF+OrYp5HFDSiLE2115A2H
 QwE4oBsKmMX05MrI3qWH2XKFKm9N53TrNdc+P+8pd/u9UkfeRYlFQXBKSMH2wo7bEVRw Lw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 35cntm38p0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Dec 2020 15:56:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BFFVEoe135187;
        Tue, 15 Dec 2020 15:54:48 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 35d7en7ewk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Dec 2020 15:54:48 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BFFsl7A019173;
        Tue, 15 Dec 2020 15:54:47 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Dec 2020 07:54:47 -0800
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@google.com>
Subject: [PATCH v2] mm/mmap: Don't unlock VMAs in remap_file_pages()
Date:   Tue, 15 Dec 2020 10:54:41 -0500
Message-Id: <20201215155441.1497432-1-Liam.Howlett@Oracle.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9836 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012150109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9836 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012150110
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_mmap() will unlock the necessary VMAs.  There is also a bug in the
loop which will evaluate as false and not unlock any VMAs anyways.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 5c8b4485860de..f7fecb77f84fd 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3025,25 +3025,9 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 
 	flags &= MAP_NONBLOCK;
 	flags |= MAP_SHARED | MAP_FIXED | MAP_POPULATE;
-	if (vma->vm_flags & VM_LOCKED) {
-		struct vm_area_struct *tmp;
+	if (vma->vm_flags & VM_LOCKED)
 		flags |= MAP_LOCKED;
 
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

