Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793542D647F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 19:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404013AbgLJRIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 12:08:01 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:37796 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403960AbgLJRHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 12:07:43 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BAGnOUV044314;
        Thu, 10 Dec 2020 17:06:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=BYmybpgJJ4d55f5GNwUB/pYERLG+Xai0zCFVglgkl08=;
 b=R1FzNWTv8CI9u3QS7OV6Zg60kNcdjvy7dNnxCzl1gKJSFH7EzIOc/p9SczoYFt0aRLdl
 9btzUHemBCyKCk6s0HE0A4Wg/mKit+hSJ/D5ZF9Z35LHZLi2ZDne5Wwfl54YYnX3dBXq
 rmlWH+D+k9FPlIvFRSTyGqrmFL86Msd5MWoPH/bA/G6Q5zqLUpSVQkVdejht0Nr4Kyc9
 S91Lk4TR7p83pPqis61KwxfR1SOyLuwGsskymfzGVdrQo6ZaDkPsnimKq7PqpQcevhYV
 b8yE3MhBc/RtRbM93ggmbjUQzrKkJEqGTovhM8qz38ItmGAQUOKFK+grQIE3cAo6NFki 5w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 35825mehfs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Dec 2020 17:06:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BAGwvvk080537;
        Thu, 10 Dec 2020 17:04:44 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 358kywm345-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Dec 2020 17:04:44 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BAH4gEB012705;
        Thu, 10 Dec 2020 17:04:42 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Dec 2020 09:04:42 -0800
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
Subject: [PATCH 08/28] mm/mmap: Change find_vma() to use the maple tree
Date:   Thu, 10 Dec 2020 12:03:42 -0500
Message-Id: <20201210170402.3468568-9-Liam.Howlett@Oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201210170402.3468568-1-Liam.Howlett@Oracle.com>
References: <20201210170402.3468568-1-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
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

Start using the maple tree to find VMA entries in an mm_struct.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 6999c2bcf0496..53876d66a27ea 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2484,10 +2484,17 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 
 EXPORT_SYMBOL(get_unmapped_area);
 
-/* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
+/**
+ * find_vma() - Find the VMA for a given address, or the next vma.  May return
+ * NULL in the case of no vma at addr or above
+ * @mm The mm_struct to check
+ * @addr: The address
+ *
+ * Returns: The VMA assoicated with addr, or the next vma.
+ * May return NULL in the case of no vma at addr or above.
+ */
 struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
 {
-	struct rb_node *rb_node;
 	struct vm_area_struct *vma;
 
 	/* Check the cache first. */
@@ -2495,24 +2502,10 @@ struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
 	if (likely(vma))
 		return vma;
 
-	rb_node = mm->mm_rb.rb_node;
-
-	while (rb_node) {
-		struct vm_area_struct *tmp;
-
-		tmp = rb_entry(rb_node, struct vm_area_struct, vm_rb);
-
-		if (tmp->vm_end > addr) {
-			vma = tmp;
-			if (tmp->vm_start <= addr)
-				break;
-			rb_node = rb_node->rb_left;
-		} else
-			rb_node = rb_node->rb_right;
-	}
-
+	vma = mt_find(&mm->mm_mt, &addr, ULONG_MAX);
 	if (vma)
 		vmacache_update(addr, vma);
+
 	return vma;
 }
 EXPORT_SYMBOL(find_vma);
-- 
2.28.0

