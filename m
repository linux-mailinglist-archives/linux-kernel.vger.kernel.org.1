Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599A22E6E79
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 07:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgL2GXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 01:23:48 -0500
Received: from owa.iluvatar.ai ([103.91.158.24]:7948 "EHLO smg.iluvatar.ai"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725832AbgL2GXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 01:23:47 -0500
X-Greylist: delayed 947 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Dec 2020 01:23:45 EST
X-AuditID: 0a650161-e69ff70000001043-aa-5feac78f81d4
Received: from owa.iluvatar.ai (s-10-101-1-102.iluvatar.local [10.101.1.102])
        by smg.iluvatar.ai (Symantec Messaging Gateway) with SMTP id 68.D9.04163.F87CAEF5; Tue, 29 Dec 2020 14:07:11 +0800 (HKT)
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=iluvatar.ai; s=key_2018;
        c=relaxed/relaxed; t=1609222031; h=from:subject:to:date:message-id;
        bh=ROVUYILnVzqcz4E3LVoA3VuJn1nyEJeIrPUlHBkrVPs=;
        b=Rtb1kY4lGIb+zpfhxUk//d03eCXgOmjB8uOGZtQLaXkijQ12GEs6GBp5pAVqvjJsefhW+kio3gJ
        xlmsIs9lRtcXH2QwGwURCIZF09izVBRvdlB8Kd8COLfdTOYIs4Oc21AQ9JU+IiZgagIiFMAPrHmTe
        S19aamotzfvO2nRA4k8=
Received: from hsj-Precision-5520.iluvatar.local (10.101.199.252) by
 S-10-101-1-102.iluvatar.local (10.101.1.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1415.2; Tue, 29 Dec 2020 14:07:11 +0800
From:   Huang Shijie <sjhuang@iluvatar.ai>
To:     <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <shijie8@gmail.com>,
        Huang Shijie <sjhuang@iluvatar.ai>
Subject: [PATCH] lib/genalloc: fix the overflow when size is too big
Date:   Tue, 29 Dec 2020 14:06:57 +0800
Message-ID: <20201229060657.3389-1-sjhuang@iluvatar.ai>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.101.199.252]
X-ClientProxiedBy: S-10-101-1-105.iluvatar.local (10.101.1.105) To
 S-10-101-1-102.iluvatar.local (10.101.1.102)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some graphic card has very big memory on chip, such as 32G bytes.

In the following case, it will cause overflow:
  --------------------------------------------
  pool = gen_pool_create(PAGE_SHIFT, NUMA_NO_NODE);
  ret = gen_pool_add(pool, 0x1000000, SZ_32G, NUMA_NO_NODE);

  va = gen_pool_alloc(pool, SZ_4G);
  --------------------------------------------

The overflow occurs in gen_pool_alloc_algo_owner():

  --------------------------------------------
		....
		size = nbits << order;
		....
  --------------------------------------------

The @nbits is "int" type, so it will overflow.
Then the gen_pool_avail() will return the wrong value.

This patch converts some "int" to "unsigned long", and
changes the compare code in while.

Reported-by: Shi Jiasheng <jiasheng.shi@iluvatar.ai>
Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
 lib/genalloc.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/lib/genalloc.c b/lib/genalloc.c
index 7f1244b5294a..dab97bb69df6 100644
--- a/lib/genalloc.c
+++ b/lib/genalloc.c
@@ -81,14 +81,14 @@ static int clear_bits_ll(unsigned long *addr, unsigned long mask_to_clear)
  * users set the same bit, one user will return remain bits, otherwise
  * return 0.
  */
-static int bitmap_set_ll(unsigned long *map, int start, int nr)
+static int bitmap_set_ll(unsigned long *map, unsigned long start, unsigned long nr)
 {
 	unsigned long *p = map + BIT_WORD(start);
-	const int size = start + nr;
+	const unsigned long size = start + nr;
 	int bits_to_set = BITS_PER_LONG - (start % BITS_PER_LONG);
 	unsigned long mask_to_set = BITMAP_FIRST_WORD_MASK(start);
 
-	while (nr - bits_to_set >= 0) {
+	while (nr >= bits_to_set) {
 		if (set_bits_ll(p, mask_to_set))
 			return nr;
 		nr -= bits_to_set;
@@ -116,14 +116,15 @@ static int bitmap_set_ll(unsigned long *map, int start, int nr)
  * users clear the same bit, one user will return remain bits,
  * otherwise return 0.
  */
-static int bitmap_clear_ll(unsigned long *map, int start, int nr)
+static unsigned long
+bitmap_clear_ll(unsigned long *map, unsigned long start, unsigned long nr)
 {
 	unsigned long *p = map + BIT_WORD(start);
-	const int size = start + nr;
+	const unsigned long size = start + nr;
 	int bits_to_clear = BITS_PER_LONG - (start % BITS_PER_LONG);
 	unsigned long mask_to_clear = BITMAP_FIRST_WORD_MASK(start);
 
-	while (nr - bits_to_clear >= 0) {
+	while (nr >= bits_to_clear) {
 		if (clear_bits_ll(p, mask_to_clear))
 			return nr;
 		nr -= bits_to_clear;
@@ -183,8 +184,8 @@ int gen_pool_add_owner(struct gen_pool *pool, unsigned long virt, phys_addr_t ph
 		 size_t size, int nid, void *owner)
 {
 	struct gen_pool_chunk *chunk;
-	int nbits = size >> pool->min_alloc_order;
-	int nbytes = sizeof(struct gen_pool_chunk) +
+	unsigned long nbits = size >> pool->min_alloc_order;
+	unsigned long nbytes = sizeof(struct gen_pool_chunk) +
 				BITS_TO_LONGS(nbits) * sizeof(long);
 
 	chunk = vzalloc_node(nbytes, nid);
@@ -242,7 +243,7 @@ void gen_pool_destroy(struct gen_pool *pool)
 	struct list_head *_chunk, *_next_chunk;
 	struct gen_pool_chunk *chunk;
 	int order = pool->min_alloc_order;
-	int bit, end_bit;
+	unsigned long bit, end_bit;
 
 	list_for_each_safe(_chunk, _next_chunk, &pool->chunks) {
 		chunk = list_entry(_chunk, struct gen_pool_chunk, next_chunk);
@@ -278,7 +279,7 @@ unsigned long gen_pool_alloc_algo_owner(struct gen_pool *pool, size_t size,
 	struct gen_pool_chunk *chunk;
 	unsigned long addr = 0;
 	int order = pool->min_alloc_order;
-	int nbits, start_bit, end_bit, remain;
+	unsigned long nbits, start_bit, end_bit, remain;
 
 #ifndef CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG
 	BUG_ON(in_nmi());
@@ -487,7 +488,7 @@ void gen_pool_free_owner(struct gen_pool *pool, unsigned long addr, size_t size,
 {
 	struct gen_pool_chunk *chunk;
 	int order = pool->min_alloc_order;
-	int start_bit, nbits, remain;
+	unsigned long start_bit, nbits, remain;
 
 #ifndef CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG
 	BUG_ON(in_nmi());
@@ -755,7 +756,7 @@ unsigned long gen_pool_best_fit(unsigned long *map, unsigned long size,
 	index = bitmap_find_next_zero_area(map, size, start, nr, 0);
 
 	while (index < size) {
-		int next_bit = find_next_bit(map, size, index + nr);
+		unsigned long next_bit = find_next_bit(map, size, index + nr);
 		if ((next_bit - index) < len) {
 			len = next_bit - index;
 			start_bit = index;
-- 
2.17.1

