Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482942DD1E9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 14:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbgLQNI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 08:08:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:47196 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728357AbgLQNIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 08:08:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E9A98AE64;
        Thu, 17 Dec 2020 13:08:09 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     david@redhat.com, mhocko@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, pasha.tatashin@soleen.com,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 4/5] powerpc/memhotplug: Enable MHP_MEMMAP_ON_MEMORY when supported
Date:   Thu, 17 Dec 2020 14:07:57 +0100
Message-Id: <20201217130758.11565-5-osalvador@suse.de>
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
 arch/powerpc/platforms/pseries/hotplug-memory.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 7efe6ec5d14a..a7f68e282ec1 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -610,6 +610,7 @@ static int dlpar_memory_remove_by_ic(u32 lmbs_to_remove, u32 drc_index)
 
 static int dlpar_add_lmb(struct drmem_lmb *lmb)
 {
+	mhp_t mhp_flags = MHP_NONE;
 	unsigned long block_sz;
 	int nid, rc;
 
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
-- 
2.26.2

