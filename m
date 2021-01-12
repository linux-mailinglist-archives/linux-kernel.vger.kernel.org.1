Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A76682F3559
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406097AbhALQQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:16:13 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:44430 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406053AbhALQQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:16:10 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CG9QLj181328;
        Tue, 12 Jan 2021 16:15:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=QiywBzm37PWawJQCCrvx2Qc6ncD6vLKNgVVp8bepQwk=;
 b=bsxkJdUPJZGn4mdgIYqdcw16fRXKLDyI23nhWeG/tVal9gXSV2yn4ZgnNgfEDBOyEvf3
 JImWjSxlLedeP4tHjFf4jZQtJKqLeLuHihke9OYOFnRplJJxyuip0NxxLPv4hJHzus7X
 UNZaMuOsCgRrvtv90ohJR2VLyeH8A9asdraNvBMdmvnXG2puzdAApTXYtZk7HCll29sz
 iGTtR+1sgE5CvSc7UP1bAQH3npnlox2kecL/6aCSh0cdFFPLsbZJtBRxh1KEJ5qahdbb
 Yver2Jz9v92xiAkPmGd8kFKe19BMhcemcWxnWCpfDr3vbEDsBeBNC0mRB/gy6UGgXagj ag== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 360kvjy1u8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:15:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGAaJd100407;
        Tue, 12 Jan 2021 16:13:00 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 360keh7hna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:12:59 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10CGCw4G029726;
        Tue, 12 Jan 2021 16:12:58 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 08:12:58 -0800
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
Subject: [PATCH v2 04/70] radix tree test suite: Add keme_cache_alloc_bulk() support
Date:   Tue, 12 Jan 2021 11:11:34 -0500
Message-Id: <20210112161240.2024684-5-Liam.Howlett@Oracle.com>
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

