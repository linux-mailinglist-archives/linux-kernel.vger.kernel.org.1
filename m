Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93FD227F0DA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 19:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731565AbgI3RwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 13:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731492AbgI3Rv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 13:51:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240CBC0613D2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 10:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=xnYvbbr90efHFoDVTt6qGpKYl4GIRbFbSmGm2q0tkCk=; b=KBWFZCTNZLSuYgS04nOzQz06zg
        iDkJxQcVbBokFEgWWXdCe9ESfaBeWIxbzGzZff4SUGcqeqHkpzsN7dmTenlSI91q7a2zSY02a9jXH
        Ak7Jl3G4PYWbF62vy72xbdSHKUVJLeQbVLveFrSoT8if5aSkLj4691ODUbFRSLTBhRhD7tnTMfGgG
        HlEREA85fARHi76yzdkL6zUsUF6Qi/EeSDzgfVfxtSyJ5INDSxvZTT2XM4v74lKEg1QEzUDENmidp
        Mg01aSGkzddIjZVQFma+JQjehLuH+Ctxzf4AIW28h2v7nfy71SPfHeKffF2+p4fV/pMDRMx5tolPn
        iJPzFoiA==;
Received: from [2001:4bb8:180:7b62:c70:4a89:bc61:4] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNgGY-0001Cn-BM; Wed, 30 Sep 2020 17:51:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nitin Gupta <ngupta@vflare.org>, x86@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-mm@kvack.org
Subject: [PATCH 08/10] xen/xenbus: use apply_to_page_range directly in xenbus_map_ring_pv
Date:   Wed, 30 Sep 2020 19:51:31 +0200
Message-Id: <20200930175133.1252382-9-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930175133.1252382-1-hch@lst.de>
References: <20200930175133.1252382-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replacing alloc_vm_area with get_vm_area_caller + apply_page_range
allows to fill put the phys_addr values directly instead of doing
another loop over all addresses.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 drivers/xen/xenbus/xenbus_client.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_client.c b/drivers/xen/xenbus/xenbus_client.c
index 2690318ad50f48..fd80e318b99cc7 100644
--- a/drivers/xen/xenbus/xenbus_client.c
+++ b/drivers/xen/xenbus/xenbus_client.c
@@ -73,16 +73,13 @@ struct map_ring_valloc {
 	struct xenbus_map_node *node;
 
 	/* Why do we need two arrays? See comment of __xenbus_map_ring */
-	union {
-		unsigned long addrs[XENBUS_MAX_RING_GRANTS];
-		pte_t *ptes[XENBUS_MAX_RING_GRANTS];
-	};
+	unsigned long addrs[XENBUS_MAX_RING_GRANTS];
 	phys_addr_t phys_addrs[XENBUS_MAX_RING_GRANTS];
 
 	struct gnttab_map_grant_ref map[XENBUS_MAX_RING_GRANTS];
 	struct gnttab_unmap_grant_ref unmap[XENBUS_MAX_RING_GRANTS];
 
-	unsigned int idx;	/* HVM only. */
+	unsigned int idx;
 };
 
 static DEFINE_SPINLOCK(xenbus_valloc_lock);
@@ -686,6 +683,14 @@ int xenbus_unmap_ring_vfree(struct xenbus_device *dev, void *vaddr)
 EXPORT_SYMBOL_GPL(xenbus_unmap_ring_vfree);
 
 #ifdef CONFIG_XEN_PV
+static int map_ring_apply(pte_t *pte, unsigned long addr, void *data)
+{
+	struct map_ring_valloc *info = data;
+
+	info->phys_addrs[info->idx++] = arbitrary_virt_to_machine(pte).maddr;
+	return 0;
+}
+
 static int xenbus_map_ring_pv(struct xenbus_device *dev,
 			      struct map_ring_valloc *info,
 			      grant_ref_t *gnt_refs,
@@ -694,18 +699,15 @@ static int xenbus_map_ring_pv(struct xenbus_device *dev,
 {
 	struct xenbus_map_node *node = info->node;
 	struct vm_struct *area;
-	int err = GNTST_okay;
-	int i;
-	bool leaked;
+	bool leaked = false;
+	int err = -ENOMEM;
 
-	area = alloc_vm_area(XEN_PAGE_SIZE * nr_grefs, info->ptes);
+	area = get_vm_area(XEN_PAGE_SIZE * nr_grefs, VM_IOREMAP);
 	if (!area)
 		return -ENOMEM;
-
-	for (i = 0; i < nr_grefs; i++)
-		info->phys_addrs[i] =
-			arbitrary_virt_to_machine(info->ptes[i]).maddr;
-
+	if (apply_to_page_range(&init_mm, (unsigned long)area->addr,
+				XEN_PAGE_SIZE * nr_grefs, map_ring_apply, info))
+		goto failed;
 	err = __xenbus_map_ring(dev, gnt_refs, nr_grefs, node->handles,
 				info, GNTMAP_host_map | GNTMAP_contains_pte,
 				&leaked);
-- 
2.28.0

