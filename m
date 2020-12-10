Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD84A2D6498
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 19:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404116AbgLJSM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 13:12:58 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:49938 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392420AbgLJRH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 12:07:27 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BAGnVIm139709;
        Thu, 10 Dec 2020 17:06:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=IaS3VstQRyAQCrwZJPzq41vWO/VS9hU5ELixoOxktmg=;
 b=Ckrr3wXfynLYWhnb8D+74LU3AYRmZBYtqiroTmpVrgILx53wqTFidXU/kqGOcJnQsywr
 0BD6vm1FFwV+7cx1CgjKmxBkOPh53nAqsvUGuxjga1xjPhcTKMdJdAZrK1ti4jpMn2Vw
 ZgNF56m6sBfnq89LsCzB78ktSb3pLX5D6EozhbPAI7Nn3Mh7k8o/09Uj0ag/JdQIYGgY
 zFxbqUj2fsiJQkyhVZuOZMIt5VqPsa6W0zdBefPg4pu1u3mt5ni4b/p6Oo6/jyyjg0Jg
 KogrLOYmLZNs7tmx2nbeI5JokIq3rttSWEplq2ftYWZf73g21pq0irIwQncpXyVDe2tB Ig== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 357yqc6mc2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Dec 2020 17:06:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BAGvJSS162352;
        Thu, 10 Dec 2020 17:04:31 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 358ksrr53m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Dec 2020 17:04:31 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BAH4U12017307;
        Thu, 10 Dec 2020 17:04:30 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Dec 2020 09:04:30 -0800
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
Subject: [PATCH 01/28] radix tree test suite: Enhancements for Maple Tree
Date:   Thu, 10 Dec 2020 12:03:35 -0500
Message-Id: <20201210170402.3468568-2-Liam.Howlett@Oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201210170402.3468568-1-Liam.Howlett@Oracle.com>
References: <20201210170402.3468568-1-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012100106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012100106
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

