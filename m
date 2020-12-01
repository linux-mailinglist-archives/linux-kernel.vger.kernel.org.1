Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73EEA2CA1CF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 12:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388079AbgLALwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 06:52:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:43616 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729344AbgLALwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 06:52:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 715A8AD43;
        Tue,  1 Dec 2020 11:52:11 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     david@redhat.com
Cc:     mhocko@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, pasha.tatashin@soleen.com,
        Oscar Salvador <osalvador@suse.de>
Subject: [RFC PATCH v3 3/4] mm,memory_hotplug: Enable MHP_MEMMAP_ON_MEMORY when supported
Date:   Tue,  1 Dec 2020 12:51:57 +0100
Message-Id: <20201201115158.22638-4-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20201201115158.22638-1-osalvador@suse.de>
References: <20201201115158.22638-1-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let the callers check whether they can use MHP_MEMMAP_ON_MEMORY by
checking mhp_supports_memmap_on_memory().
Currently, we only support MHP_MEMMAP_ON_MEMORY in case
CONFIG_SPARSEMEM_VMEMMAP is enabled, the architecture supports altmap,
and the range to be added spans a single memory block.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 arch/powerpc/platforms/pseries/hotplug-memory.c | 5 ++++-
 drivers/acpi/acpi_memhotplug.c                  | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 7efe6ec5d14a..3aba817e729e 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -612,6 +612,7 @@ static int dlpar_add_lmb(struct drmem_lmb *lmb)
 {
 	unsigned long block_sz;
 	int nid, rc;
+	mhp_t mhp_flags = MHP_NONE;
 
 	if (lmb->flags & DRCONF_MEM_ASSIGNED)
 		return -EINVAL;
@@ -629,8 +630,10 @@ static int dlpar_add_lmb(struct drmem_lmb *lmb)
 	if (nid < 0 || !node_possible(nid))
 		nid = first_online_node;
 
+	if (mhp_supports_memmap_on_memory(block_sz))
+		mhp_flags |= MHP_MEMMAP_ON_MEMORY;
 	/* Add the memory */
-	rc = __add_memory(nid, lmb->base_addr, block_sz, MHP_NONE);
+	rc = __add_memory(nid, lmb->base_addr, block_sz, mhp_flags);
 	if (rc) {
 		invalidate_lmb_associativity_index(lmb);
 		return rc;
diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index b02fd51e5589..1fe645ef0b6c 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -172,6 +172,7 @@ static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
 	int result, num_enabled = 0;
 	struct acpi_memory_info *info;
 	int node;
+	mhp_t mhp_flags = MHP_NONE;
 
 	node = acpi_get_node(handle);
 	/*
@@ -194,8 +195,10 @@ static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
 		if (node < 0)
 			node = memory_add_physaddr_to_nid(info->start_addr);
 
+		if (mhp_supports_memmap_on_memory(info->length))
+			mhp_flags |= MHP_MEMMAP_ON_MEMORY;
 		result = __add_memory(node, info->start_addr, info->length,
-				      MHP_NONE);
+				      mhp_flags);
 
 		/*
 		 * If the memory block has been used by the kernel, add_memory()
-- 
2.26.2

