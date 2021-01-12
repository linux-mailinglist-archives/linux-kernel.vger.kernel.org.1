Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63FAE2F3569
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406331AbhALQRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:17:21 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:37488 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406308AbhALQRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:17:18 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGDncD162440;
        Tue, 12 Jan 2021 16:16:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=cBDR1xz46FbLcWGwDrw4R82HVM8wlEpMYBip+dlRY2w=;
 b=TO+FbgHAB0sJSKpp3/1YzDydYcNjdnecN2tohed43qicU633meJzKootEHpGf+f9t7Ed
 o5H+TzxtYW0z2pEOjMvVscLhw3QBOUPC4L2TQfqXriEPx/LIwkzmL8Ct3D1tmeuYF6ox
 B/2qnzltNaEhVrlQp8GnOovNHfSeY8BAR875QlXegxNwapcmJVkuR1pZ5yjhWfWWGebI
 Tk3CYV+9DKJNVDHGzOv9O90E4yXqf6B3DihlxbV6JUFmzyWv/TRHhhoRsf6ZN2NlWg7F
 LMwHNFntoP5Eg3oxalGw+qjTK7Qv3JuyJe3oKuV/HPpWAzH9x/Gi5+Tr9Aq/p+sH8ch+ yQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 360kcyq5xy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:16:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGAWc1161760;
        Tue, 12 Jan 2021 16:14:21 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 360kf5q5gs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:14:21 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10CGEK0b020044;
        Tue, 12 Jan 2021 16:14:20 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 08:14:18 -0800
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
Subject: [PATCH v2 53/70] mm/huge_memory: Use vma_next() instead of vma linked list
Date:   Tue, 12 Jan 2021 11:12:23 -0500
Message-Id: <20210112161240.2024684-54-Liam.Howlett@Oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210112161240.2024684-1-Liam.Howlett@Oracle.com>
References: <20210112161240.2024684-1-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120093
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/huge_memory.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ec2bb93f74314..4005beb23daf9 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2304,12 +2304,12 @@ void vma_adjust_trans_huge(struct vm_area_struct *vma,
 		split_huge_pmd_address(vma, end, false, NULL);
 
 	/*
-	 * If we're also updating the vma->vm_next->vm_start, if the new
-	 * vm_next->vm_start isn't hpage aligned and it could previously
+	 * If we're also updating the vma_next(vma)->vm_start, if the new
+	 * vma_next()->vm_start isn't hpage aligned and it could previously
 	 * contain an hugepage: check if we need to split an huge pmd.
 	 */
 	if (adjust_next > 0) {
-		struct vm_area_struct *next = vma->vm_next;
+		struct vm_area_struct *next = vma_next(vma->vm_mm, vma);
 		unsigned long nstart = next->vm_start;
 		nstart += adjust_next;
 		if (nstart & ~HPAGE_PMD_MASK &&
-- 
2.28.0

