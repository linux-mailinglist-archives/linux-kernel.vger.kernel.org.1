Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64CDB2F358F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406255AbhALQU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:20:56 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:54818 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393000AbhALQPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:15:02 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CG9VrI086407;
        Tue, 12 Jan 2021 16:13:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=3vWVb3ONfSO094YorfWSLiUmsyCUMgsICIMeGUHTxVo=;
 b=LhJND0jxJ7lGw6NAO5icBH8ptfALDyh8vbSUYWT5wqgLvcjmJR1rpXvwy4JI4TDx4n5N
 k/8TzwBkHXzi1g+2axVcmqCSTsBg7gl9QDD3mIXeDqXV1hEcAaNWxgRdbU0+yGdPaMRe
 yx32bd2rb05d/OuTek3rFjZ85BCoUtHAAd5i3cCdjCZ11Vrbwe2HuctCCCVPXWX8eB7+
 1a6bC2W35EceoH6E1DUQY2ztlfrW1P7Vstl+HoD8HfO3jc6Gt2xHaw1AW7IaxVzRKaG0
 2dJvrpSeRUjJlyVCaHKjOgE8SmQ4bLh/Oy+mJe1F7C4BeMiTFFrKX0jiS1zazW9lojzr xw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 360kg1q4vy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:13:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGAWTQ161824;
        Tue, 12 Jan 2021 16:13:41 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 360kf5q4gy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:13:41 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10CGDevW017774;
        Tue, 12 Jan 2021 16:13:40 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 08:13:40 -0800
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
Subject: [PATCH v2 29/70] arch/parsic: Remove mmap linked list from kernel/cache
Date:   Tue, 12 Jan 2021 11:11:59 -0500
Message-Id: <20210112161240.2024684-30-Liam.Howlett@Oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101120092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Start using the maple tree

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/parisc/kernel/cache.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/parisc/kernel/cache.c b/arch/parisc/kernel/cache.c
index 86a1a63563fd5..288a25e1b1c29 100644
--- a/arch/parisc/kernel/cache.c
+++ b/arch/parisc/kernel/cache.c
@@ -520,8 +520,9 @@ static inline unsigned long mm_total_size(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
 	unsigned long usize = 0;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
 
-	for (vma = mm->mmap; vma; vma = vma->vm_next)
+	mas_for_each(&mas, vma, ULONG_MAX)
 		usize += vma->vm_end - vma->vm_start;
 	return usize;
 }
@@ -548,6 +549,7 @@ void flush_cache_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
 	pgd_t *pgd;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
 
 	/* Flushing the whole cache on each cpu takes forever on
 	   rp3440, etc.  So, avoid it if the mm isn't too big.  */
@@ -560,7 +562,7 @@ void flush_cache_mm(struct mm_struct *mm)
 	}
 
 	if (mm->context == mfsp(3)) {
-		for (vma = mm->mmap; vma; vma = vma->vm_next) {
+		mas_for_each(&mas, vma, ULONG_MAX) {
 			flush_user_dcache_range_asm(vma->vm_start, vma->vm_end);
 			if (vma->vm_flags & VM_EXEC)
 				flush_user_icache_range_asm(vma->vm_start, vma->vm_end);
@@ -570,7 +572,7 @@ void flush_cache_mm(struct mm_struct *mm)
 	}
 
 	pgd = mm->pgd;
-	for (vma = mm->mmap; vma; vma = vma->vm_next) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		unsigned long addr;
 
 		for (addr = vma->vm_start; addr < vma->vm_end;
-- 
2.28.0

