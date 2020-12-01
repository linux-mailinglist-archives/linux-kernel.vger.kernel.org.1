Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 840D72CA23C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 13:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbgLAMKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 07:10:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:40518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730389AbgLAMKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 07:10:37 -0500
Received: from mail.kernel.org (ip5f5ad5d9.dynamic.kabel-deutschland.de [95.90.213.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F2FB2168B;
        Tue,  1 Dec 2020 12:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606824555;
        bh=00Liju21Er2M3g/gbYfAr5vIJRge9a8TkK8yrhqytHg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nNsTYROUFTOI3r7bgCEg+qmFH82ctTtW/Q2aoap9Qz2xTlo46KXLS/G5ssDYjcAMG
         lUYo1QF0WIwT5Lz823sWkv7SmLpLWSr625KG0cfamGbJtMcrWKw/8GE/Ig62eFP+Xp
         tiR0ljuujV3z7WychRmRgGBdV+kjGToZfOWtMzCc=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kk4T3-00DGdI-5v; Tue, 01 Dec 2020 13:09:13 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v5 11/16] memblock: fix kernel-doc markups
Date:   Tue,  1 Dec 2020 13:09:04 +0100
Message-Id: <6928fde0940ef3cf077794706b54a35da152b745.1606823973.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1606823973.git.mchehab+huawei@kernel.org>
References: <cover.1606823973.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some identifiers have different names between their prototypes
and the kernel-doc markup.

Acked-by: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/linux/memblock.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index b93c44b9121e..9cc6da7b513e 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -243,85 +243,85 @@ static inline bool memblock_is_mirror(struct memblock_region *m)
 	return m->flags & MEMBLOCK_MIRROR;
 }
 
 static inline bool memblock_is_nomap(struct memblock_region *m)
 {
 	return m->flags & MEMBLOCK_NOMAP;
 }
 
 int memblock_search_pfn_nid(unsigned long pfn, unsigned long *start_pfn,
 			    unsigned long  *end_pfn);
 void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
 			  unsigned long *out_end_pfn, int *out_nid);
 
 /**
  * for_each_mem_pfn_range - early memory pfn range iterator
  * @i: an integer used as loop variable
  * @nid: node selector, %MAX_NUMNODES for all nodes
  * @p_start: ptr to ulong for start pfn of the range, can be %NULL
  * @p_end: ptr to ulong for end pfn of the range, can be %NULL
  * @p_nid: ptr to int for nid of the range, can be %NULL
  *
  * Walks over configured memory ranges.
  */
 #define for_each_mem_pfn_range(i, nid, p_start, p_end, p_nid)		\
 	for (i = -1, __next_mem_pfn_range(&i, nid, p_start, p_end, p_nid); \
 	     i >= 0; __next_mem_pfn_range(&i, nid, p_start, p_end, p_nid))
 
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 void __next_mem_pfn_range_in_zone(u64 *idx, struct zone *zone,
 				  unsigned long *out_spfn,
 				  unsigned long *out_epfn);
 /**
- * for_each_free_mem_range_in_zone - iterate through zone specific free
+ * for_each_free_mem_pfn_range_in_zone - iterate through zone specific free
  * memblock areas
  * @i: u64 used as loop variable
  * @zone: zone in which all of the memory blocks reside
  * @p_start: ptr to phys_addr_t for start address of the range, can be %NULL
  * @p_end: ptr to phys_addr_t for end address of the range, can be %NULL
  *
  * Walks over free (memory && !reserved) areas of memblock in a specific
  * zone. Available once memblock and an empty zone is initialized. The main
  * assumption is that the zone start, end, and pgdat have been associated.
  * This way we can use the zone to determine NUMA node, and if a given part
  * of the memblock is valid for the zone.
  */
 #define for_each_free_mem_pfn_range_in_zone(i, zone, p_start, p_end)	\
 	for (i = 0,							\
 	     __next_mem_pfn_range_in_zone(&i, zone, p_start, p_end);	\
 	     i != U64_MAX;					\
 	     __next_mem_pfn_range_in_zone(&i, zone, p_start, p_end))
 
 /**
- * for_each_free_mem_range_in_zone_from - iterate through zone specific
+ * for_each_free_mem_pfn_range_in_zone_from - iterate through zone specific
  * free memblock areas from a given point
  * @i: u64 used as loop variable
  * @zone: zone in which all of the memory blocks reside
  * @p_start: ptr to phys_addr_t for start address of the range, can be %NULL
  * @p_end: ptr to phys_addr_t for end address of the range, can be %NULL
  *
  * Walks over free (memory && !reserved) areas of memblock in a specific
  * zone, continuing from current position. Available as soon as memblock is
  * initialized.
  */
 #define for_each_free_mem_pfn_range_in_zone_from(i, zone, p_start, p_end) \
 	for (; i != U64_MAX;					  \
 	     __next_mem_pfn_range_in_zone(&i, zone, p_start, p_end))
 
 int __init deferred_page_init_max_threads(const struct cpumask *node_cpumask);
 
 #endif /* CONFIG_DEFERRED_STRUCT_PAGE_INIT */
 
 /**
  * for_each_free_mem_range - iterate through free memblock areas
  * @i: u64 used as loop variable
  * @nid: node selector, %NUMA_NO_NODE for all nodes
  * @flags: pick from blocks based on memory attributes
  * @p_start: ptr to phys_addr_t for start address of the range, can be %NULL
  * @p_end: ptr to phys_addr_t for end address of the range, can be %NULL
  * @p_nid: ptr to int for nid of the range, can be %NULL
  *
  * Walks over free (memory && !reserved) areas of memblock.  Available as
  * soon as memblock is initialized.
  */
 #define for_each_free_mem_range(i, nid, flags, p_start, p_end, p_nid)	\
 	__for_each_mem_range(i, &memblock.memory, &memblock.reserved,	\
-- 
2.28.0

