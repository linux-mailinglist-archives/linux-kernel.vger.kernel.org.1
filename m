Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B919A2C3EF7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 12:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbgKYLU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 06:20:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:39986 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbgKYLU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 06:20:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7C94FAD64;
        Wed, 25 Nov 2020 11:20:54 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     david@redhat.com
Cc:     mhocko@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, pasha.tatashin@soleen.com,
        Oscar Salvador <osalvador@suse.de>
Subject: [RFC PATCH v2 1/4] mm,memory_hotplug: Introduce MHP_MEMMAP_ON_MEMORY
Date:   Wed, 25 Nov 2020 12:20:45 +0100
Message-Id: <20201125112048.8211-2-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20201125112048.8211-1-osalvador@suse.de>
References: <20201125112048.8211-1-osalvador@suse.de>
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
index 551093b74596..5b1ea1f8d1ab 100644
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
+#define MHP_MEMMAP_ON_MEMORY	((__force mhp_t)BIT(1))
+
 /*
  * Extended parameters for memory hotplug:
  * altmap: alternative allocator for memmap array (optional)
-- 
2.26.2

