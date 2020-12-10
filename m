Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF532D64C1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 19:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391026AbgLJRFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 12:05:49 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:35480 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390956AbgLJRFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 12:05:39 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BAGnOGR044303;
        Thu, 10 Dec 2020 17:04:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=QiywBzm37PWawJQCCrvx2Qc6ncD6vLKNgVVp8bepQwk=;
 b=hRPjphSeo8ART5FXvvJI1aFC0CESc+6+eG0QSUvMN2BddEV6wmN0ac62WTscCCOBZSH9
 4SRiUpYVY8eCSxKOLgwqoG6UivU/t5v3j2uG3uQPgeOZeR6bTA9WOUO4TAYy8l/RXCvH
 NI6nm+RRv8HSuvlkg+WQVoRjIW8ZibSlfux1pnHKUNzYTDn5Lz4XARIRUnNhbWkkC9Bn
 X60Gx/hSzkKSnFSrsZ4QJyLFKCDz8mwBvYZN1Uo221G2mX/xKX4cvvxudU2y6nz8+zd2
 wRVxvnQFJ3Mctc0M3LgVVD9dy/XGMXy4hhRnY63b8BBXNJ9xCfSyPdP8cPaeh/v+T08T YA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 35825meh0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Dec 2020 17:04:36 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BAGwsJV080212;
        Thu, 10 Dec 2020 17:04:35 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 358kywm2wb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Dec 2020 17:04:35 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BAH4YXE008882;
        Thu, 10 Dec 2020 17:04:34 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Dec 2020 09:04:34 -0800
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
Subject: [PATCH 04/28] radix tree test suite: Add keme_cache_alloc_bulk() support
Date:   Thu, 10 Dec 2020 12:03:38 -0500
Message-Id: <20201210170402.3468568-5-Liam.Howlett@Oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201210170402.3468568-1-Liam.Howlett@Oracle.com>
References: <20201210170402.3468568-1-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=2 mlxlogscore=999 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012100106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 clxscore=1011 priorityscore=1501 mlxscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012100106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 tools/testing/radix-tree/linux.c      | 51 +++++++++++++++++++++++++++
 tools/testing/radix-tree/linux/slab.h |  1 +
 2 files changed, 52 insertions(+)

diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/linux.c
index 380bbc0a48d6f..fb19a40ebb465 100644
--- a/tools/testing/radix-tree/linux.c
+++ b/tools/testing/radix-tree/linux.c
@@ -99,6 +99,57 @@ void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t size, void **list)
 	for (int i = 0; i < size; i++)
 		kmem_cache_free(cachep, list[i]);
 }
+int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t size,
+			  void **p)
+{
+	size_t i;
+
+	if (kmalloc_verbose)
+		printk("Bulk alloc %lu\n", size);
+
+	if (!(gfp & __GFP_DIRECT_RECLAIM) && cachep->non_kernel < size)
+		return 0;
+
+	if (!(gfp & __GFP_DIRECT_RECLAIM))
+		cachep->non_kernel -= size;
+
+	pthread_mutex_lock(&cachep->lock);
+	if (cachep->nr_objs >= size) {
+		struct radix_tree_node *node = cachep->objs;
+
+		for (i = 0; i < size; i++) {
+			cachep->nr_objs--;
+			cachep->objs = node->parent;
+			p[i] = cachep->objs;
+		}
+		pthread_mutex_unlock(&cachep->lock);
+		node->parent = NULL;
+	} else {
+		pthread_mutex_unlock(&cachep->lock);
+		for (i = 0; i < size; i++) {
+			if (cachep->align) {
+				posix_memalign(&p[i], cachep->align,
+					       cachep->size * size);
+			} else {
+				p[i] = malloc(cachep->size * size);
+			}
+			if (cachep->ctor)
+				cachep->ctor(p[i]);
+			else if (gfp & __GFP_ZERO)
+				memset(p[i], 0, cachep->size);
+		}
+	}
+
+	for (i = 0; i < size; i++) {
+		uatomic_inc(&nr_allocated);
+		uatomic_inc(&nr_tallocated);
+		if (kmalloc_verbose)
+			printf("Allocating %p from slab\n", p[i]);
+	}
+
+	return size;
+}
+
 
 void *kmalloc(size_t size, gfp_t gfp)
 {
diff --git a/tools/testing/radix-tree/linux/slab.h b/tools/testing/radix-tree/linux/slab.h
index 53b79c15b3a22..ba42b8cc11d09 100644
--- a/tools/testing/radix-tree/linux/slab.h
+++ b/tools/testing/radix-tree/linux/slab.h
@@ -25,4 +25,5 @@ struct kmem_cache *kmem_cache_create(const char *name, unsigned int size,
 			void (*ctor)(void *));
 
 void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t, void **);
+int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t, size_t, void **);
 #endif		/* SLAB_H */
-- 
2.28.0

