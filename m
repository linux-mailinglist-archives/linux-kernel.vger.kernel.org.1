Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF032CF265
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 17:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388147AbgLDQwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 11:52:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:58414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbgLDQwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 11:52:43 -0500
From:   Arnd Bergmann <arnd@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        Madhav Chauhan <madhav.chauhan@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Martin Peres <martin.peres@mupuf.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/ttm: fix unused function warning
Date:   Fri,  4 Dec 2020 17:51:52 +0100
Message-Id: <20201204165158.3748141-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

ttm_pool_type_count() is not used when debugfs is disabled:

drivers/gpu/drm/ttm/ttm_pool.c:243:21: error: unused function 'ttm_pool_type_count' [-Werror,-Wunused-function]
static unsigned int ttm_pool_type_count(struct ttm_pool_type *pt)

Move the definition into the #ifdef block.

Fixes: d099fc8f540a ("drm/ttm: new TT backend allocation pool v3")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/ttm/ttm_pool.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 5455b2044759..7b2f60616750 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -239,21 +239,6 @@ static struct page *ttm_pool_type_take(struct ttm_pool_type *pt)
 	return p;
 }
 
-/* Count the number of pages available in a pool_type */
-static unsigned int ttm_pool_type_count(struct ttm_pool_type *pt)
-{
-	unsigned int count = 0;
-	struct page *p;
-
-	spin_lock(&pt->lock);
-	/* Only used for debugfs, the overhead doesn't matter */
-	list_for_each_entry(p, &pt->pages, lru)
-		++count;
-	spin_unlock(&pt->lock);
-
-	return count;
-}
-
 /* Initialize and add a pool type to the global shrinker list */
 static void ttm_pool_type_init(struct ttm_pool_type *pt, struct ttm_pool *pool,
 			       enum ttm_caching caching, unsigned int order)
@@ -543,6 +528,20 @@ void ttm_pool_fini(struct ttm_pool *pool)
 EXPORT_SYMBOL(ttm_pool_fini);
 
 #ifdef CONFIG_DEBUG_FS
+/* Count the number of pages available in a pool_type */
+static unsigned int ttm_pool_type_count(struct ttm_pool_type *pt)
+{
+	unsigned int count = 0;
+	struct page *p;
+
+	spin_lock(&pt->lock);
+	/* Only used for debugfs, the overhead doesn't matter */
+	list_for_each_entry(p, &pt->pages, lru)
+		++count;
+	spin_unlock(&pt->lock);
+
+	return count;
+}
 
 /* Dump information about the different pool types */
 static void ttm_pool_debugfs_orders(struct ttm_pool_type *pt,
-- 
2.27.0

