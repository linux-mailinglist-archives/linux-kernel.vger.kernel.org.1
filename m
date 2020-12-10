Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD9C2D64B4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 19:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404138AbgLJSRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 13:17:01 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:36158 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390956AbgLJRGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 12:06:11 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BAGnOxa044309;
        Thu, 10 Dec 2020 17:05:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=T3f2iioNMsddV/BdYOhgIz2yD0d1GU7JgNBoiBWdKz4=;
 b=fdJyMXAKrqBDHDpORnST8deE0HHBD/nA8cluUXTqm24ynnXXqF4Bal153HZe0NLSoeQk
 egLQL1H92Y1ayYGN3elNJ5wjCzcq/bDmNm+Oh/40qTYeM6WtF3uRQLKGHOQsM7DsWTts
 HrKIlduZGarFafXaixRi78joUOGziGBt59tDOxZFltWVM014sb07KJ3nCpSEfMQlkMD7
 6DA2alj/fNrl2Nw6gHMKbWWY6YWjN+72AMH9BehXwMZn9DmBVNtyHDxBc9IAvJj+W0GR
 ntSv16WRsUqcXd9aY0VlCIlkkkZd3yjk7L4ALQUtukWmnUFIv8jO4/wm/o9f8hFvyJoG 7g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 35825meh3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Dec 2020 17:05:12 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BAGw17t033335;
        Thu, 10 Dec 2020 17:05:11 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 358m52gc12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Dec 2020 17:05:11 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BAH59aP013029;
        Thu, 10 Dec 2020 17:05:09 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Dec 2020 09:05:09 -0800
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
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 27/28] mmap: Update count_vma_pages_range() to only use one ma_state
Date:   Thu, 10 Dec 2020 12:04:01 -0500
Message-Id: <20201210170402.3468568-28-Liam.Howlett@Oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201210170402.3468568-1-Liam.Howlett@Oracle.com>
References: <20201210170402.3468568-1-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012100106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501 mlxscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012100106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 284c90504b44c..7a575e6f1e7df 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -483,17 +483,15 @@ static unsigned long count_vma_pages_range(struct mm_struct *mm,
 	MA_STATE(mas, &mm->mm_mt, addr, addr);
 
 	/* Find first overlaping mapping */
-	vma = find_vma_intersection(mm, addr, end);
+	vma = mas_find(&mas, end - 1);
 	if (!vma)
 		return 0;
 
 	vm_start = vma->vm_start;
 	vm_end = vma->vm_end;
-
 	nr_pages = (min(end, vm_end) - max(addr, vm_start)) >> PAGE_SHIFT;
 
 	/* Iterate over the rest of the overlaps */
-	mas.index = mas.last = vm_end;
 	mas_for_each(&mas, vma, end) {
 		vm_start = vma->vm_start;
 		vm_end = vma->vm_end;
-- 
2.28.0

