Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F3227B402
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 20:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgI1SDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 14:03:07 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:45303 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726600AbgI1SBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:01:18 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 7A193EAB;
        Mon, 28 Sep 2020 13:55:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 28 Sep 2020 13:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=nnBLzQcFmKx5h
        yU3MIHb5MmWVYU/HVsQSzx32OV/OSc=; b=Q/ZciFth/aUmefHcm5EEVJELC9iNH
        jeR9dbHWioBEqE/AQ1yutvLyEj4hU6hOLz59KedvxWktTRaCGByiMufg69lzGXJR
        D0QlWAQgPSH15WLLVc1hUf8mi8U/zZw49tSrvyuP3hoyCCkDllofewr1+yfQLxD3
        AlNHKtIKemiFFprSRiMEOM3rLwM4la+sQ0ciljZOmBKyNWZCyCBwZf4CR2ZTWxLa
        7VJQPkPU2ZrFpPb29mIdUEWQSRV6f9laE4+HqFzONBNcE4b1rBX00sxfy0E82l+1
        Ygj3iQfyPr/sWW7uUZAigLaqkR2OGcrdMbbIMl8vcs/IKsgig769j1iPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=nnBLzQcFmKx5hyU3MIHb5MmWVYU/HVsQSzx32OV/OSc=; b=m/+0TnpP
        BeKneCabUUV20m6siEpEtpF9cvZHM+kwxIAEa9SFkwLmPO9NzVOrYOe2BL2FMNNU
        pKPb+1YUyU4b74FLtTSRzYWDNiHpbIN0ZhSJeCXsrFrN7bD5Nn71e86J4sVvu2cF
        Y3U0xB/7yEvZvAvD7y4b8/DD8aYAEGEowQIsxI5evefDcvn4gKypf0vgQ9Ckd7E+
        rb88xMHh9pDHu2dJ2wf+U9mpcDDqqpGwVRGIsIli10+qd3cop0xRN7T+kgGRBLEr
        BbY0u4xpMiwQNHKzCnoNO0EK2ztXw5V7OOFOrHqNzUQLYTLS7Qzlll4OMkRuzb3e
        NDvQ7CoZBYmbig==
X-ME-Sender: <xms:jiNyX6xbjpqoR9EukQSydxTaHvMGZ-jeV1fUGWHZb-CGI3-_Q_BeTg>
    <xme:jiNyX2Ssf6fkNTsH79TPwaX6pdT6OZPF2xAa3ysWj24hepql7VXdxkYFn2Fvdcokj
    fNZ8JBVRyDWV0T08Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeigdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeduhfffve
    ektdduhfdutdfgtdekkedvhfetuedufedtgffgvdevleehheevjefgtdenucfkphepuddv
    rdegiedruddtiedrudeigeenucevlhhushhtvghrufhiiigvpeduvdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:jyNyX8WWzqEUyzQcWZaXunazSZHGZkhI5WTEVhhBnnfjxAr4rUUUcg>
    <xmx:jyNyXwic6pj7w6Uo8h0t2fAjyc7d6kvM9weqXG_abrP4Jn27t4rCjw>
    <xmx:jyNyX8Bjt-cjfCISjXFZG0C7Ko3CjT1oEOA9DGWo5b1F5mEJMojkiA>
    <xmx:jyNyX0acHhL3aCghQqfg2-SqkX-2gb7A5xk8I7VuaW1hxhxE0Zj6eiw1gFw>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id 939873064610;
        Mon, 28 Sep 2020 13:55:26 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH v2 24/30] mm: madvise: add page size options to MADV_HUGEPAGE and MADV_NOHUGEPAGE.
Date:   Mon, 28 Sep 2020 13:54:22 -0400
Message-Id: <20200928175428.4110504-25-zi.yan@sent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928175428.4110504-1-zi.yan@sent.com>
References: <20200928175428.4110504-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

It allows user to specify up to what page size kernel will generate THPs
to back up the memory range in madvise. Because we now have PMD and PUD
THPs, they require different amount of kernel effort to be generated,
and we want to prevent user from getting long page fault latency if we
always try to allocate PUD THPs first.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/uapi/asm-generic/mman-common.h | 23 +++++++++++++++++++++++
 mm/khugepaged.c                        |  1 +
 mm/madvise.c                           | 17 +++++++++++++++--
 3 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index f94f65d429be..8009acb55fca 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -6,6 +6,7 @@
  Author: Michael S. Tsirkin <mst@mellanox.co.il>, Mellanox Technologies Ltd.
  Based on: asm-xxx/mman.h
 */
+#include <asm-generic/hugetlb_encode.h>
 
 #define PROT_READ	0x1		/* page can be read */
 #define PROT_WRITE	0x2		/* page can be written */
@@ -80,4 +81,26 @@
 #define PKEY_ACCESS_MASK	(PKEY_DISABLE_ACCESS |\
 				 PKEY_DISABLE_WRITE)
 
+
+/*
+ * Huge page size encoding when MADV_HUGEPAGE is specified, and a huge page
+ * size other than the default is desired.  See hugetlb_encode.h.
+ */
+#define MADV_HUGEPAGE_SHIFT	HUGETLB_FLAG_ENCODE_SHIFT
+#define MADV_HUGEPAGE_MASK	HUGETLB_FLAG_ENCODE_MASK
+#define MADV_BEHAVIOR_MASK	((1<<MADV_HUGEPAGE_SHIFT) - 1)
+
+#define MADV_HUGEPAGE_64KB	HUGETLB_FLAG_ENCODE_64KB
+#define MADV_HUGEPAGE_512KB	HUGETLB_FLAG_ENCODE_512KB
+#define MADV_HUGEPAGE_1MB	HUGETLB_FLAG_ENCODE_1MB
+#define MADV_HUGEPAGE_2MB	HUGETLB_FLAG_ENCODE_2MB
+#define MADV_HUGEPAGE_8MB	HUGETLB_FLAG_ENCODE_8MB
+#define MADV_HUGEPAGE_16MB	HUGETLB_FLAG_ENCODE_16MB
+#define MADV_HUGEPAGE_32MB	HUGETLB_FLAG_ENCODE_32MB
+#define MADV_HUGEPAGE_256MB	HUGETLB_FLAG_ENCODE_256MB
+#define MADV_HUGEPAGE_512MB	HUGETLB_FLAG_ENCODE_512MB
+#define MADV_HUGEPAGE_1GB	HUGETLB_FLAG_ENCODE_1GB
+#define MADV_HUGEPAGE_2GB	HUGETLB_FLAG_ENCODE_2GB
+#define MADV_HUGEPAGE_16GB	HUGETLB_FLAG_ENCODE_16GB
+
 #endif /* __ASM_GENERIC_MMAN_COMMON_H */
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 636a0f32b09e..b34c78085017 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -345,6 +345,7 @@ struct attribute_group khugepaged_attr_group = {
 int hugepage_madvise(struct vm_area_struct *vma,
 		     unsigned long *vm_flags, int advice)
 {
+	advice = advice & MADV_BEHAVIOR_MASK;
 	switch (advice) {
 	case MADV_HUGEPAGE:
 #ifdef CONFIG_S390
diff --git a/mm/madvise.c b/mm/madvise.c
index 16e7b8eadb13..32066cc0b34f 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -40,6 +40,19 @@ struct madvise_walk_private {
 	bool pageout;
 };
 
+static inline int get_behavior(int behavior)
+{
+	int behavior_no_flags = behavior & MADV_BEHAVIOR_MASK;
+	/*
+	 * only MADV_HUGEPAGE and MADV_NOHUGEPAGE have extra huge page size
+	 * flags
+	 */
+	VM_BUG_ON(behavior_no_flags != MADV_HUGEPAGE &&
+		  behavior_no_flags != MADV_NOHUGEPAGE &&
+		  (behavior & (~MADV_BEHAVIOR_MASK)));
+	return behavior_no_flags;
+}
+
 /*
  * Any behaviour which results in changes to the vma->vm_flags needs to
  * take mmap_lock for writing. Others, which simply traverse vmas, need
@@ -74,7 +87,7 @@ static long madvise_behavior(struct vm_area_struct *vma,
 	pgoff_t pgoff;
 	unsigned long new_flags = vma->vm_flags;
 
-	switch (behavior) {
+	switch (get_behavior(behavior)) {
 	case MADV_NORMAL:
 		new_flags = new_flags & ~VM_RAND_READ & ~VM_SEQ_READ;
 		break;
@@ -953,7 +966,7 @@ madvise_vma(struct vm_area_struct *vma, struct vm_area_struct **prev,
 static bool
 madvise_behavior_valid(int behavior)
 {
-	switch (behavior) {
+	switch (get_behavior(behavior)) {
 	case MADV_DOFORK:
 	case MADV_DONTFORK:
 	case MADV_NORMAL:
-- 
2.28.0

