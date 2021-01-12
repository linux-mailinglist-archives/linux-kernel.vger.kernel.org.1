Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB632F3536
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392790AbhALQOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:14:36 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41696 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392754AbhALQOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:14:34 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CG980L181173;
        Tue, 12 Jan 2021 16:13:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=kVpvdfxd3L7/j0RPZoAVv8TfHOAf56J1c3geoQhB48g=;
 b=V0HTCG3F7qaFwv6klQ4XLkxeDBGm3Y+KhIl1spYgClxT1d/tAeWr0PjCJpSCcpiMs39C
 GsUvdM4+Zp7NSRHJ2QUia3oEXPUatKA7F3QhAe4ksgu2u1cjZ6em0Z/CFyWjaOjgwCS3
 45quKwkZf3wDA9y0jsOy+UlWgYRcSmBHdD4+O8wdmhFyJJi4Eu++Qi7H2kDT0rgPQ8m4
 z48aUIwJ5NxqO97UqmGAr9hM2ZQWwSwoCPM3zyzsFpgqCFkm5zzMPDEbCjRqjcbs2+9x
 XOJpHseKB/Ggi/MF//VkHthqvDPkuZ2CxmAaBdiyR4fNaHNnFYuNC71m1Xe/K4br7sBt 6A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 360kvjy1jy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:13:21 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGA1be094411;
        Tue, 12 Jan 2021 16:13:20 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 360key122k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:13:20 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10CGDJ9K019447;
        Tue, 12 Jan 2021 16:13:19 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 08:13:19 -0800
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
Subject: [PATCH v2 15/70] mm/mmap: Change vm_brk_flags() to use mm_populate_vma()
Date:   Tue, 12 Jan 2021 11:11:45 -0500
Message-Id: <20210112161240.2024684-16-Liam.Howlett@Oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210112161240.2024684-1-Liam.Howlett@Oracle.com>
References: <20210112161240.2024684-1-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=857 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101120092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=861 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Skip searching for the vma to populate after creating it by passing in a pointer.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index f500d5e490f1c..cab665a6daa05 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3045,10 +3045,10 @@ int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long flags)
 	// This vma left intentionally blank.
 	mas_walk(&mas);
 	ret = do_brk_flags(&mas, &vma, addr, len, flags);
-	populate = ((mm->def_flags & VM_LOCKED) != 0);
 	mmap_write_unlock(mm);
+	populate = ((mm->def_flags & VM_LOCKED) != 0);
 	if (populate && !ret)
-		mm_populate(addr, len);
+		mm_populate_vma(vma, addr, addr + len);
 	return ret;
 }
 EXPORT_SYMBOL(vm_brk_flags);
-- 
2.28.0

