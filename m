Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 300322F354F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393031AbhALQPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:15:07 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:54874 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392524AbhALQPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:15:06 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CG9WLP086456;
        Tue, 12 Jan 2021 16:13:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=XzacnTtll8Y3H74LoI3ku0bEMoV1Y0GeCbHIbg8Ris0=;
 b=n+ZcdSre92uOklk2IhTDVQFroU4nlMi5M632oS5iKdBYE8/UkTYpr2nssG493PK5c+1c
 XHvbMs13WbpS3QugBsxayLVA8m6SCkBSz44EbD3+o/GyDTTpB7wE8o9Obw0nIuJkU3ad
 gAHGLGE5hbZj7OJwnEUBbXn90tvp95+WknE9NFUUwcGgUgY34cln9rnrxPBwPhIA3DD6
 8TuhXIInZePCcoWm0hy8ZC8T9AwpdR66w2iu0ghFQXbUctmqPR86gPvEAtvKMM5ZIVzs
 IkHxUo1hb6wsHFK4Nd5lQODKuba/9joZkig3EzpT99soj2gQcGP+sKEhpR5dSQYTr3bC tA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 360kg1q4w8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:13:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGBaO3143216;
        Tue, 12 Jan 2021 16:13:45 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 360ke6rh14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:13:45 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10CGDirn004504;
        Tue, 12 Jan 2021 16:13:44 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 08:13:44 -0800
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@google.com>, Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jerome Glisse <jglisse@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 32/70] arch/powerpc: Optimize cell spu task sync.
Date:   Tue, 12 Jan 2021 11:12:02 -0500
Message-Id: <20210112161240.2024684-33-Liam.Howlett@Oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210112161240.2024684-1-Liam.Howlett@Oracle.com>
References: <20210112161240.2024684-1-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101120092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101120092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the vma api to look up the spu reference instead of walking the linked list.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/powerpc/oprofile/cell/spu_task_sync.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/oprofile/cell/spu_task_sync.c b/arch/powerpc/oprofile/cell/spu_task_sync.c
index 489f993100d56..47b4d4e9b628d 100644
--- a/arch/powerpc/oprofile/cell/spu_task_sync.c
+++ b/arch/powerpc/oprofile/cell/spu_task_sync.c
@@ -333,19 +333,17 @@ get_exec_dcookie_and_offset(struct spu *spu, unsigned int *offsetp,
 	}
 
 	mmap_read_lock(mm);
-	for (vma = mm->mmap; vma; vma = vma->vm_next) {
-		if (vma->vm_start > spu_ref || vma->vm_end <= spu_ref)
-			continue;
-		my_offset = spu_ref - vma->vm_start;
-		if (!vma->vm_file)
-			goto fail_no_image_cookie;
-
-		pr_debug("Found spu ELF at %X(object-id:%lx) for file %pD\n",
-			 my_offset, spu_ref, vma->vm_file);
-		*offsetp = my_offset;
-		break;
-	}
+	vma = find_vma_intersection(mm, spu_ref, spu_ref + 1);
+	if (!vma)
+		goto fail_no_image_cookie;
+
+	my_offset = spu_ref - vma->vm_start;
+	if (!vma->vm_file)
+		goto fail_no_image_cookie;
 
+	pr_debug("Found spu ELF at %X(object-id:%lx) for file %pD\n",
+		 my_offset, spu_ref, vma->vm_file);
+	*offsetp = my_offset;
 	*spu_bin_dcookie = fast_get_dcookie(&vma->vm_file->f_path);
 	pr_debug("got dcookie for %pD\n", vma->vm_file);
 
-- 
2.28.0

