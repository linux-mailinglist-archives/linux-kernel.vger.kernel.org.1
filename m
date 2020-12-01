Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC5A2CA1D1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 12:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730227AbgLALwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 06:52:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:43646 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgLALwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 06:52:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E5CDEAD6D;
        Tue,  1 Dec 2020 11:52:11 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     david@redhat.com
Cc:     mhocko@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, pasha.tatashin@soleen.com,
        Oscar Salvador <osalvador@suse.de>
Subject: [RFC PATCH v3 4/4] mm,memory_hotplug: Add mhp_memmap_on_memory boot option
Date:   Tue,  1 Dec 2020 12:51:58 +0100
Message-Id: <20201201115158.22638-5-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20201201115158.22638-1-osalvador@suse.de>
References: <20201201115158.22638-1-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Self stored memmap leads to a sparse memory situation which is unsuitable
for workloads that requires large contiguous memory chunks.

Make this an opt-in which needs to be explicitly enabled.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/memory_hotplug.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 4b4708512f82..858d6161e915 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -42,6 +42,8 @@
 #include "internal.h"
 #include "shuffle.h"
 
+static bool memmap_on_memory_enabled __read_mostly = false;
+
 /*
  * online_page_callback contains pointer to current page onlining function.
  * Initially it is generic_online_page(). If it is required it could be
@@ -1034,7 +1036,7 @@ bool __weak arch_support_memmap_on_memory(void)
 
 bool mhp_supports_memmap_on_memory(unsigned long size)
 {
-	if (!arch_support_memmap_on_memory() ||
+	if (!memmap_on_memory_enabled || !arch_support_memmap_on_memory() ||
 	    !IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP) ||
 	    size > memory_block_size_bytes())
 		return false;
@@ -1422,6 +1424,13 @@ static int __init cmdline_parse_movable_node(char *p)
 }
 early_param("movable_node", cmdline_parse_movable_node);
 
+static int __init cmdline_parse_memmap_on_memory(char *p)
+{
+	memmap_on_memory_enabled = true;
+	return 0;
+}
+early_param("mhp_memmap_on_memory", cmdline_parse_memmap_on_memory);
+
 /* check which state of node_states will be changed when offline memory */
 static void node_states_check_changes_offline(unsigned long nr_pages,
 		struct zone *zone, struct memory_notify *arg)
-- 
2.26.2

