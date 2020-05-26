Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4C11CD298
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 09:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbgEKHb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 03:31:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:47424 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728573AbgEKHb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 03:31:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 00914AC90;
        Mon, 11 May 2020 07:31:56 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH 2/2] xen/xenbus: let xenbus_map_ring_valloc() return errno values only
Date:   Mon, 11 May 2020 09:31:51 +0200
Message-Id: <20200511073151.19043-3-jgross@suse.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200511073151.19043-1-jgross@suse.com>
References: <20200511073151.19043-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Today xenbus_map_ring_valloc() can return either a negative errno
value (-ENOMEM or -EINVAL) or a grant status value. This is a mess as
e.g -ENOMEM and GNTST_eagain have the same numeric value.

Fix that by turning all grant mapping errors into -ENOENT. This is
no problem as all callers of xenbus_map_ring_valloc() only use the
return value to print an error message, and in case of mapping errors
the grant status value has already been printed by __xenbus_map_ring()
before.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/xen/xenbus/xenbus_client.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_client.c b/drivers/xen/xenbus/xenbus_client.c
index d8e5c5e4fa67..5e6b256ca916 100644
--- a/drivers/xen/xenbus/xenbus_client.c
+++ b/drivers/xen/xenbus/xenbus_client.c
@@ -456,8 +456,7 @@ EXPORT_SYMBOL_GPL(xenbus_free_evtchn);
  * Map @nr_grefs pages of memory into this domain from another
  * domain's grant table.  xenbus_map_ring_valloc allocates @nr_grefs
  * pages of virtual address space, maps the pages to that address, and
- * sets *vaddr to that address.  Returns 0 on success, and GNTST_*
- * (see xen/include/interface/grant_table.h) or -ENOMEM / -EINVAL on
+ * sets *vaddr to that address.  Returns 0 on success, and -errno on
  * error. If an error is returned, device will switch to
  * XenbusStateClosing and the error message will be saved in XenStore.
  */
@@ -477,18 +476,11 @@ int xenbus_map_ring_valloc(struct xenbus_device *dev, grant_ref_t *gnt_refs,
 		return -ENOMEM;
 
 	info->node = kzalloc(sizeof(*info->node), GFP_KERNEL);
-	if (!info->node) {
+	if (!info->node)
 		err = -ENOMEM;
-		goto out;
-	}
-
-	err = ring_ops->map(dev, info, gnt_refs, nr_grefs, vaddr);
-
-	/* Some hypervisors are buggy and can return 1. */
-	if (err > 0)
-		err = GNTST_general_error;
+	else
+		err = ring_ops->map(dev, info, gnt_refs, nr_grefs, vaddr);
 
- out:
 	kfree(info->node);
 	kfree(info);
 	return err;
@@ -507,7 +499,6 @@ static int __xenbus_map_ring(struct xenbus_device *dev,
 			     bool *leaked)
 {
 	int i, j;
-	int err = GNTST_okay;
 
 	if (nr_grefs > XENBUS_MAX_RING_GRANTS)
 		return -EINVAL;
@@ -522,7 +513,6 @@ static int __xenbus_map_ring(struct xenbus_device *dev,
 
 	for (i = 0; i < nr_grefs; i++) {
 		if (info->map[i].status != GNTST_okay) {
-			err = info->map[i].status;
 			xenbus_dev_fatal(dev, info->map[i].status,
 					 "mapping in shared page %d from domain %d",
 					 gnt_refs[i], dev->otherend_id);
@@ -531,7 +521,7 @@ static int __xenbus_map_ring(struct xenbus_device *dev,
 			handles[i] = info->map[i].handle;
 	}
 
-	return GNTST_okay;
+	return 0;
 
  fail:
 	for (i = j = 0; i < nr_grefs; i++) {
@@ -554,7 +544,7 @@ static int __xenbus_map_ring(struct xenbus_device *dev,
 		}
 	}
 
-	return err;
+	return -ENOENT;
 }
 
 /**
-- 
2.26.1

