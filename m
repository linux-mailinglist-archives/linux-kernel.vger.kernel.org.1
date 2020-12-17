Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C99C72DD1EF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 14:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgLQNJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 08:09:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:47602 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727786AbgLQNJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 08:09:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 74ABEAE65;
        Thu, 17 Dec 2020 13:08:10 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     david@redhat.com, mhocko@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, pasha.tatashin@soleen.com,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 5/5] mm,memory_hotplug: Add kernel boot option to enable memmap_on_memory
Date:   Thu, 17 Dec 2020 14:07:58 +0100
Message-Id: <20201217130758.11565-6-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20201217130758.11565-1-osalvador@suse.de>
References: <20201217130758.11565-1-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Self stored memmap leads to a sparse memory situation which is unsuitable
for workloads that requires large contiguous memory chunks, so make this
an opt-in which needs to be explicitly enabled.

To control this, let memory_hotplug have its own memory space, as suggested
by David, so we can add memory_hotplug.memmap_on_memory parameter.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 .../admin-guide/kernel-parameters.txt         | 14 ++++++++++++
 mm/Makefile                                   |  5 ++++-
 mm/memory_hotplug.c                           | 22 ++++++++++++++++++-
 3 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c722ec19cd00..8ff3d7c87165 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2776,6 +2776,20 @@
 			seconds.  Use this parameter to check at some
 			other rate.  0 disables periodic checking.
 
+	memory_hotplug.memmap_on_memory
+			[KNL,X86,ARM,PPC] Boolean flag to enable this feature.
+			Format: {on | off (default)}
+			When enabled, memory to build the pages tables for the
+			memmap array describing the hot-added range will be taken
+			from the range itself, so the memmap page tables will be
+			self-hosted.
+			Since only single memory device ranges are supported at
+			the moment, this option is disabled by default because
+			it might have an impact on workloads that needs large
+			contiguous memory chunks.
+			The state of the flag can be read in
+			/sys/module/memory_hotplug/parameters/memmap_on_memory.
+
 	memtest=	[KNL,X86,ARM,PPC] Enable memtest
 			Format: <integer>
 			default : 0 <disable>
diff --git a/mm/Makefile b/mm/Makefile
index 6b581f8337e8..0425cec6cb17 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -58,9 +58,13 @@ obj-y			:= filemap.o mempool.o oom_kill.o fadvise.o \
 page-alloc-y := page_alloc.o
 page-alloc-$(CONFIG_SHUFFLE_PAGE_ALLOCATOR) += shuffle.o
 
+# Give 'memory_hotplug' its own module-parameter namespace
+memory-hotplug-$(CONFIG_MEMORY_HOTPLUG) += memory_hotplug.o
+
 obj-y += page-alloc.o
 obj-y += init-mm.o
 obj-y += memblock.o
+obj-y += $(memory-hotplug-y)
 
 ifdef CONFIG_MMU
 	obj-$(CONFIG_ADVISE_SYSCALLS)	+= madvise.o
@@ -83,7 +87,6 @@ obj-$(CONFIG_SLUB) += slub.o
 obj-$(CONFIG_KASAN)	+= kasan/
 obj-$(CONFIG_KFENCE) += kfence/
 obj-$(CONFIG_FAILSLAB) += failslab.o
-obj-$(CONFIG_MEMORY_HOTPLUG) += memory_hotplug.o
 obj-$(CONFIG_MEMTEST)		+= memtest.o
 obj-$(CONFIG_MIGRATION) += migrate.o
 obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 9371e7d3f583..f5f95f49b98a 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -42,7 +42,27 @@
 #include "internal.h"
 #include "shuffle.h"
 
-static bool memmap_on_memory_enabled;
+/*
+ * memory_hotplug.memmap_on_memory parameter
+ */
+static bool memmap_on_memory_enabled __ro_after_init;
+
+static int memmap_on_memory_show(char *buffer, const struct kernel_param *kp)
+{
+	return sprintf(buffer, "%s\n",
+		       memmap_on_memory_enabled ? "on" : "off");
+}
+
+static __meminit int memmap_on_memory_store(const char *val,
+					    const struct kernel_param *kp)
+{
+	if (!IS_ENABLED(CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE))
+		return -EINVAL;
+
+	return param_set_bool(val, kp);
+}
+module_param_call(memmap_on_memory, memmap_on_memory_store,
+		  memmap_on_memory_show, &memmap_on_memory_enabled, 0400);
 
 /*
  * online_page_callback contains pointer to current page onlining function.
-- 
2.26.2

