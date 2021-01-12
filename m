Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A55A2F358D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406678AbhALQUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:20:43 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:42808 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393020AbhALQPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:15:06 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CG97Jp181150;
        Tue, 12 Jan 2021 16:13:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=rwx+ISwRfsUXG+859qoeHVRR4OT2xAHrhQ1qrn5w4y8=;
 b=iTmFQO3xNBl5RouLZWpm5Ew0Y0JmF2qvUoDtTxH0m9kH1My3Eyp5SopCriFrlQ/EMg7J
 G+Zy6WBH4O3ev7I2WWjM90ewVQTI4HbPvtaDx+c+Glv5U+AtdDTHYJJvz5Nosbxq9z+w
 tBpL/AFLsDbZLY+ejWL45MOSlMq8l8CwL+3ohBdGsWSbRfHIllGOYZKvXTLN8+JK97kF
 90k+wIpD4bF3slCnQCbf7n+o8htavUL4G9o2XBHJ8cPHavqsOdL6kskk5lh4SCiwviWp
 AiBVVlmdV+vuBDjOYGhoHS//dTUDC37Eo7Ourzq4VgGAyzN1wjV7xR6NJsPRNkTFKXwC iA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 360kvjy1ns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:13:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGAaXU100373;
        Tue, 12 Jan 2021 16:13:55 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 360keh7jv4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:13:55 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10CGDsNk004663;
        Tue, 12 Jan 2021 16:13:54 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 08:13:54 -0800
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
Subject: [PATCH v2 38/70] drivers/oprofile: Lookup address in tree instead of linked list.
Date:   Tue, 12 Jan 2021 11:12:08 -0500
Message-Id: <20210112161240.2024684-39-Liam.Howlett@Oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210112161240.2024684-1-Liam.Howlett@Oracle.com>
References: <20210112161240.2024684-1-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101120092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the vma interface to find the vma if one exists instead of the linked list

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 drivers/oprofile/buffer_sync.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/oprofile/buffer_sync.c b/drivers/oprofile/buffer_sync.c
index cc917865f13ab..c63703b3bcebe 100644
--- a/drivers/oprofile/buffer_sync.c
+++ b/drivers/oprofile/buffer_sync.c
@@ -253,15 +253,12 @@ static unsigned long get_exec_dcookie(struct mm_struct *mm)
 static unsigned long
 lookup_dcookie(struct mm_struct *mm, unsigned long addr, off_t *offset)
 {
-	unsigned long cookie = NO_COOKIE;
+	unsigned long cookie = INVALID_COOKIE;
 	struct vm_area_struct *vma;
 
 	mmap_read_lock(mm);
-	for (vma = find_vma(mm, addr); vma; vma = vma->vm_next) {
-
-		if (addr < vma->vm_start || addr >= vma->vm_end)
-			continue;
-
+	vma = find_vma_intersection(mm, addr, addr + 1);
+	if (vma) {
 		if (vma->vm_file) {
 			cookie = fast_get_dcookie(&vma->vm_file->f_path);
 			*offset = (vma->vm_pgoff << PAGE_SHIFT) + addr -
@@ -269,13 +266,10 @@ lookup_dcookie(struct mm_struct *mm, unsigned long addr, off_t *offset)
 		} else {
 			/* must be an anonymous map */
 			*offset = addr;
+			cookie = NO_COOKIE;
 		}
-
-		break;
 	}
 
-	if (!vma)
-		cookie = INVALID_COOKIE;
 	mmap_read_unlock(mm);
 
 	return cookie;
-- 
2.28.0

