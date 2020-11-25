Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339832C3EF8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 12:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgKYLU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 06:20:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:40176 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728535AbgKYLU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 06:20:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5FF1EAEFF;
        Wed, 25 Nov 2020 11:20:56 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     david@redhat.com
Cc:     mhocko@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, pasha.tatashin@soleen.com,
        Oscar Salvador <osalvador@suse.de>
Subject: [RFC PATCH v2 4/4] mm,memory_hotplug: Enable MHP_MEMMAP_ON_MEMORY when supported
Date:   Wed, 25 Nov 2020 12:20:48 +0100
Message-Id: <20201125112048.8211-5-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20201125112048.8211-1-osalvador@suse.de>
References: <20201125112048.8211-1-osalvador@suse.de>
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
 drivers/acpi/acpi_memhotplug.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

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

