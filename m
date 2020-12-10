Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBBE2D6489
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 19:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403996AbgLJRIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 12:08:00 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:59252 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392453AbgLJRHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 12:07:30 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BAGo1MJ119818;
        Thu, 10 Dec 2020 17:06:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=ikRH38xaIk1SkEb7Cy5dZX+GeJsJD/ikhP5bk7GpRmw=;
 b=Q3WT5qvY/7gSXdGvbxMb8RSSmuivBrTJ7+kus9QpsPEXaXiIoCyApEGRa3YZIj1Z9dpK
 gc8Sxe3nr4P2T3Gl0AEPEMHJROV8+eI04EAD840QjHfPXARDRg4stAid9Xo1v0qO4GPx
 SrX92+Gye6/vhON3rFt88nC7uIAen44A1+GQsfJgfYj2w+y9lGkV34s2+wLL/bCJR5lb
 /DG5x7JOE5WAL1SNqylvaFz5g9ckZ/EPmn4NyifadVvk4jVfJZhUWQaSFPeMgotMo7fX
 SOIoRXUBlSjmK697aTY6l0BOY2DBsTT95DjQG9XyCkkCKM5RmO/uMuacmeaQS2TWXP5Z 9w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 3581mr6fuv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Dec 2020 17:06:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BAGwjUC046108;
        Thu, 10 Dec 2020 17:04:35 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 358m41xavj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Dec 2020 17:04:35 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BAH4Xr1012657;
        Thu, 10 Dec 2020 17:04:33 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Dec 2020 09:04:32 -0800
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
Subject: [PATCH 03/28] radix tree test suite: Add support for kmem_cache_free_bulk
Date:   Thu, 10 Dec 2020 12:03:37 -0500
Message-Id: <20201210170402.3468568-4-Liam.Howlett@Oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201210170402.3468568-1-Liam.Howlett@Oracle.com>
References: <20201210170402.3468568-1-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=2 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012100106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 mlxlogscore=999
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012100106
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

