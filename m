Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFAD2F3558
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405313AbhALQPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:15:38 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:35512 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404242AbhALQPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:15:34 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGAeGO142569;
        Tue, 12 Jan 2021 16:12:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=ikRH38xaIk1SkEb7Cy5dZX+GeJsJD/ikhP5bk7GpRmw=;
 b=AaRNlPZkdSQHoUvlbb/XAY50jnPGkVcdag74OA/tCZ8JqaYDjCn/ssAzlMDfDAbFo5jH
 yPizayEuNwqMTvxuUir65N8s+Cgc8l2ucXkWllb88LOLQZXqcCvprTyVKDaghypZ4qOO
 cCyf35upGpaQ/nW9xAslbuvq6osVTnyNwtz8kgqb0f16Z8RcshZHw8vvbZ6fzuPmIsmD
 +Z+qt1W4Pf+5UjFQxxVCmdbguowzTcByAQ5uj3EEN+mKjlxdFE/aYjYmDEmHzdVWWTMQ
 CmuyYDALht9ANvTcovDJjYDB5F680ZFjivmD/nc/RE7iFZAfCr3F7Y07FDEVGKSmP0jn xw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 360kcyq5at-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:12:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGBZ2G142889;
        Tue, 12 Jan 2021 16:12:57 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 360ke6rfss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:12:57 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10CGCuYl003977;
        Tue, 12 Jan 2021 16:12:56 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 08:12:56 -0800
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
Subject: [PATCH v2 03/70] radix tree test suite: Add support for kmem_cache_free_bulk
Date:   Tue, 12 Jan 2021 11:11:33 -0500
Message-Id: <20210112161240.2024684-4-Liam.Howlett@Oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210112161240.2024684-1-Liam.Howlett@Oracle.com>
References: <20210112161240.2024684-1-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101120092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 tools/testing/radix-tree/linux.c      | 9 +++++++++
 tools/testing/radix-tree/linux/slab.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/linux.c
index 93f7de81fbe87..380bbc0a48d6f 100644
--- a/tools/testing/radix-tree/linux.c
+++ b/tools/testing/radix-tree/linux.c
@@ -91,6 +91,15 @@ void kmem_cache_free(struct kmem_cache *cachep, void *objp)
 	pthread_mutex_unlock(&cachep->lock);
 }
 
+void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t size, void **list)
+{
+	if (kmalloc_verbose)
+		printk("Bulk free %p[0-%lu]\n", list, size - 1);
+
+	for (int i = 0; i < size; i++)
+		kmem_cache_free(cachep, list[i]);
+}
+
 void *kmalloc(size_t size, gfp_t gfp)
 {
 	void *ret;
diff --git a/tools/testing/radix-tree/linux/slab.h b/tools/testing/radix-tree/linux/slab.h
index 2958830ce4d76..53b79c15b3a22 100644
--- a/tools/testing/radix-tree/linux/slab.h
+++ b/tools/testing/radix-tree/linux/slab.h
@@ -24,4 +24,5 @@ struct kmem_cache *kmem_cache_create(const char *name, unsigned int size,
 			unsigned int align, unsigned int flags,
 			void (*ctor)(void *));
 
+void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t, void **);
 #endif		/* SLAB_H */
-- 
2.28.0

