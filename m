Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D722F3593
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406706AbhALQV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:21:26 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:54252 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392178AbhALQOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:14:32 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CG9cwE086533;
        Tue, 12 Jan 2021 16:12:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=IaS3VstQRyAQCrwZJPzq41vWO/VS9hU5ELixoOxktmg=;
 b=U2wT3qM96Ekgg7x6rVCXs+WkGQbSW5NKV7xeAl1cT5OQkwWFAamkLlmIYj5ezGwXzskw
 yJH3p1OY7N+uk8ZTvHCQvAVqgWbl6NmNYG3HaU3RFbYYSrKKR9V2PKL/wv6pDT84Fzpi
 0bSLkKiauTvWarQoqTViewkIRAsxlSvSF981efyHk5S+kRczjjSvHrWUWpnpcKHRyS5l
 +DJKXAhhVbVkB1qea7aOIFNXEX3DBngLvx8U/OFzM4L1Y2XNGy/Uf+/pzP4R3U79HzvR
 MRhRgVzAe2jkmQZG/o3VxFm8V3ordWY764aqC90dIe+w9+hjvOMvhZo7rh6RIwZ0EU/E yA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 360kg1q4sn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:12:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGA2RS094568;
        Tue, 12 Jan 2021 16:12:57 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 360key11gy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:12:57 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10CGCsDV017363;
        Tue, 12 Jan 2021 16:12:54 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 08:12:53 -0800
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
Subject: [PATCH v2 01/70] radix tree test suite: Enhancements for Maple Tree
Date:   Tue, 12 Jan 2021 11:11:31 -0500
Message-Id: <20210112161240.2024684-2-Liam.Howlett@Oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210112161240.2024684-1-Liam.Howlett@Oracle.com>
References: <20210112161240.2024684-1-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
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

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 tools/testing/radix-tree/linux.c        | 16 +++++++++++++++-
 tools/testing/radix-tree/linux/kernel.h |  1 +
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/linux.c
index 2d9c59df60de0..93f7de81fbe87 100644
--- a/tools/testing/radix-tree/linux.c
+++ b/tools/testing/radix-tree/linux.c
@@ -24,15 +24,28 @@ struct kmem_cache {
 	int nr_objs;
 	void *objs;
 	void (*ctor)(void *);
+	unsigned int non_kernel;
 };
 
+void kmem_cache_set_non_kernel(struct kmem_cache *cachep, unsigned int val)
+{
+	cachep->non_kernel = val;
+}
+
+unsigned long kmem_cache_get_alloc(struct kmem_cache *cachep)
+{
+	return cachep->size * nr_allocated;
+}
 void *kmem_cache_alloc(struct kmem_cache *cachep, int gfp)
 {
 	void *p;
 
-	if (!(gfp & __GFP_DIRECT_RECLAIM))
+	if (!(gfp & __GFP_DIRECT_RECLAIM) && !cachep->non_kernel)
 		return NULL;
 
+	if (!(gfp & __GFP_DIRECT_RECLAIM))
+		cachep->non_kernel--;
+
 	pthread_mutex_lock(&cachep->lock);
 	if (cachep->nr_objs) {
 		struct radix_tree_node *node = cachep->objs;
@@ -116,5 +129,6 @@ kmem_cache_create(const char *name, unsigned int size, unsigned int align,
 	ret->nr_objs = 0;
 	ret->objs = NULL;
 	ret->ctor = ctor;
+	ret->non_kernel = 0;
 	return ret;
 }
diff --git a/tools/testing/radix-tree/linux/kernel.h b/tools/testing/radix-tree/linux/kernel.h
index 39867fd80c8fa..c5c9d05f29da9 100644
--- a/tools/testing/radix-tree/linux/kernel.h
+++ b/tools/testing/radix-tree/linux/kernel.h
@@ -14,6 +14,7 @@
 #include "../../../include/linux/kconfig.h"
 
 #define printk printf
+#define pr_err printk
 #define pr_info printk
 #define pr_debug printk
 #define pr_cont printk
-- 
2.28.0

