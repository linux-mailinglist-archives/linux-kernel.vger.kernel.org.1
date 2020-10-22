Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB3A6295F32
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 14:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505787AbgJVM6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 08:58:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:60034 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411014AbgJVM6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 08:58:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8A3ADAD79;
        Thu, 22 Oct 2020 12:58:42 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     david@redhat.com
Cc:     mhocko@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, pasha.tatashin@soleen.com,
        Oscar Salvador <osalvador@suse.de>
Subject: [RFC PATCH 1/3] mm,memory_hotplug: Introduce MHP_MEMMAP_ON_MEMORY
Date:   Thu, 22 Oct 2020 14:58:33 +0200
Message-Id: <20201022125835.26396-2-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20201022125835.26396-1-osalvador@suse.de>
References: <20201022125835.26396-1-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MHP_MEMMAP_ON_MEMORY tells the system that we want the memmap
pagetables to be built from the hot-added range.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/memory_hotplug.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index d65c6fdc5cfc..dda2d0e5d1ba 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -70,6 +70,14 @@ typedef int __bitwise mhp_t;
  */
 #define MEMHP_MERGE_RESOURCE	((__force mhp_t)BIT(0))
 
+/*
+ * We want memmap (struct page array) to be self contained.
+ * To do so, we will use the beginning of the hot-added range to build
+ * the page tables for the memmap array that describes the entire range.
+ * Only selected architectures support it with SPARSE_VMEMMAP.
+ */
+#define MEMHP_MEMMAP_ON_MEMORY	((__force mhp_t)BIT(1))
+
 /*
  * Extended parameters for memory hotplug:
  * altmap: alternative allocator for memmap array (optional)
-- 
2.26.2

