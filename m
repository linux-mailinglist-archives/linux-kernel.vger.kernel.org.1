Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4DC2B40B2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 11:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbgKPKSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 05:18:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:53144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728854AbgKPKSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 05:18:31 -0500
Received: from mail.kernel.org (ip5f5ad5de.dynamic.kabel-deutschland.de [95.90.213.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F944241A3;
        Mon, 16 Nov 2020 10:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605521908;
        bh=CEaWy/9rCKH0y9rg+TtKCtrGstISKnLe8WUJn9c9U2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oxdK+++V98RlV2eiilD+A8q0VukrYAH9azfgvpEcxRk2Mg6/bNEC6KgGNo7l/ALd8
         EYYFRhPVJh1XA2piWCy3xBPCqEdZEvSZN/spHvuQX8OyKVFpbdKbTabnsIXcQUAMHd
         VnI6/iNjv9v9+FRaYGs8ENURDo6j84UTe641ezkA=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kebac-00FwEd-Ie; Mon, 16 Nov 2020 11:18:26 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Linux Doc Mailing List" <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v4 21/27] memblock: fix kernel-doc markups
Date:   Mon, 16 Nov 2020 11:18:17 +0100
Message-Id: <261dbe3eb58c66ba6bc289593e70a4399d111448.1605521731.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1605521731.git.mchehab+huawei@kernel.org>
References: <cover.1605521731.git.mchehab+huawei@kernel.org>
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
index ef131255cedc..95fe3cb71c54 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -255,61 +255,61 @@ void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
 
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
-- 
2.28.0

