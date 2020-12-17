Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C01212DD1E8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 14:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgLQNIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 08:08:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:47186 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726983AbgLQNIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 08:08:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 663DFAE61;
        Thu, 17 Dec 2020 13:08:09 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     david@redhat.com, mhocko@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, pasha.tatashin@soleen.com,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 3/5] acpi,memhotplug: Enable MHP_MEMMAP_ON_MEMORY when supported
Date:   Thu, 17 Dec 2020 14:07:56 +0100
Message-Id: <20201217130758.11565-4-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20201217130758.11565-1-osalvador@suse.de>
References: <20201217130758.11565-1-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let the caller check whether it can pass MHP_MEMMAP_ON_MEMORY by
checking mhp_supports_memmap_on_memory().
MHP_MEMMAP_ON_MEMORY can only be set in case
ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE is enabled, the architecture supports
altmap, and the range to be added spans a single memory block.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 drivers/acpi/acpi_memhotplug.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index b02fd51e5589..8cc195c4c861 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -171,6 +171,7 @@ static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
 	acpi_handle handle = mem_device->device->handle;
 	int result, num_enabled = 0;
 	struct acpi_memory_info *info;
+	mhp_t mhp_flags = MHP_NONE;
 	int node;
 
 	node = acpi_get_node(handle);
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

