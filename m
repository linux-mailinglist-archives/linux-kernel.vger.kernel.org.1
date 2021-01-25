Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC17C3021F7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 06:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbhAYF47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 00:56:59 -0500
Received: from foss.arm.com ([217.140.110.172]:42596 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbhAYFzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 00:55:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 458A4ED1;
        Sun, 24 Jan 2021 21:54:40 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.91.197])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D97C73F66B;
        Sun, 24 Jan 2021 21:54:37 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     david@redhat.com, Anshuman Khandual <anshuman.khandual@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/memory_hotplug: Rename all existing 'memhp' into 'mhp'
Date:   Mon, 25 Jan 2021 11:24:53 +0530
Message-Id: <1611554093-27316-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This renames all 'memhp' instances to 'mhp' except for memhp_default_state
for being a kernel command line option. This is just a clean up and should
not cause a functional change.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
During hotplug arch callback series, it was proposed to convert all the
remaining 'memhp' into 'mhp' instead.

https://lore.kernel.org/linux-mm/c37de2d0-28a1-4f7d-f944-cfd7d81c334d@redhat.com/

This applies on v5.11-rc5. After this change, 'memhp' is only mentioned
for 'memhp_default_state' kernel command line paramater and its related
function. A tree wide search gives the following result.

$git grep memhp

Documentation/admin-guide/kernel-parameters.txt:        memhp_default_state=online/offline
mm/memory_hotplug.c:static int __init setup_memhp_default_state(char *str)
mm/memory_hotplug.c:__setup("memhp_default_state=", setup_memhp_default_state);

 drivers/base/memory.c          | 10 +++++-----
 include/linux/memory_hotplug.h |  4 ++--
 mm/memory_hotplug.c            | 12 ++++++------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index f0303c8b4f14..8c7a5818fea9 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -35,7 +35,7 @@ static const char *const online_type_to_str[] = {
 	[MMOP_ONLINE_MOVABLE] = "online_movable",
 };
 
-int memhp_online_type_from_str(const char *str)
+int mhp_online_type_from_str(const char *str)
 {
 	int i;
 
@@ -253,7 +253,7 @@ static int memory_subsys_offline(struct device *dev)
 static ssize_t state_store(struct device *dev, struct device_attribute *attr,
 			   const char *buf, size_t count)
 {
-	const int online_type = memhp_online_type_from_str(buf);
+	const int online_type = mhp_online_type_from_str(buf);
 	struct memory_block *mem = to_memory_block(dev);
 	int ret;
 
@@ -387,19 +387,19 @@ static ssize_t auto_online_blocks_show(struct device *dev,
 				       struct device_attribute *attr, char *buf)
 {
 	return sysfs_emit(buf, "%s\n",
-			  online_type_to_str[memhp_default_online_type]);
+			  online_type_to_str[mhp_default_online_type]);
 }
 
 static ssize_t auto_online_blocks_store(struct device *dev,
 					struct device_attribute *attr,
 					const char *buf, size_t count)
 {
-	const int online_type = memhp_online_type_from_str(buf);
+	const int online_type = mhp_online_type_from_str(buf);
 
 	if (online_type < 0)
 		return -EINVAL;
 
-	memhp_default_online_type = online_type;
+	mhp_default_online_type = online_type;
 	return count;
 }
 
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index e4c80561e519..e0cc6bc1e948 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -134,10 +134,10 @@ extern int arch_add_memory(int nid, u64 start, u64 size,
 			   struct mhp_params *params);
 extern u64 max_mem_size;
 
-extern int memhp_online_type_from_str(const char *str);
+extern int mhp_online_type_from_str(const char *str);
 
 /* Default online_type (MMOP_*) when new memory blocks are added. */
-extern int memhp_default_online_type;
+extern int mhp_default_online_type;
 /* If movable_node boot option specified */
 extern bool movable_node_enabled;
 static inline bool movable_node_is_enabled(void)
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index fb734a865807..5e35e4024785 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -67,17 +67,17 @@ void put_online_mems(void)
 bool movable_node_enabled = false;
 
 #ifndef CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE
-int memhp_default_online_type = MMOP_OFFLINE;
+int mhp_default_online_type = MMOP_OFFLINE;
 #else
-int memhp_default_online_type = MMOP_ONLINE;
+int mhp_default_online_type = MMOP_ONLINE;
 #endif
 
 static int __init setup_memhp_default_state(char *str)
 {
-	const int online_type = memhp_online_type_from_str(str);
+	const int online_type = mhp_online_type_from_str(str);
 
 	if (online_type >= 0)
-		memhp_default_online_type = online_type;
+		mhp_default_online_type = online_type;
 
 	return 1;
 }
@@ -992,7 +992,7 @@ static int check_hotplug_memory_range(u64 start, u64 size)
 
 static int online_memory_block(struct memory_block *mem, void *arg)
 {
-	mem->online_type = memhp_default_online_type;
+	mem->online_type = mhp_default_online_type;
 	return device_online(&mem->dev);
 }
 
@@ -1073,7 +1073,7 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 		merge_system_ram_resource(res);
 
 	/* online pages if requested */
-	if (memhp_default_online_type != MMOP_OFFLINE)
+	if (mhp_default_online_type != MMOP_OFFLINE)
 		walk_memory_blocks(start, size, NULL, online_memory_block);
 
 	return ret;
-- 
2.20.1

