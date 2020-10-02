Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B3F28123B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 14:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387824AbgJBMWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 08:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387783AbgJBMW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 08:22:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EFAC0613E3
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 05:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=PSl4e4bvc0UrKwYaparRx8nOFITZgZOLYb17gUiAPo4=; b=X1Hf2bS6r1+v79yUY1wuVYC3Gq
        MDZqVWuDYZIWaD+3Zo3tFXAHdjNllVDLCvouVYbnYiYiXGQ1VMywtp0KVLqWzFw02dYW0sL98F1By
        IaoTnx4rLl+ffDuiMESwxTkw6+rvS6LQPkgODQZJYZ+judGYGe4IYI4IRSyuGRNM0L6mNqjh1X8Kq
        TtgiXyGM6+W2jZDvV/4Ky5QmllYMo81DYxgnngX4OU0qbM/sHtVWe2BAT+k5Otq1Xp/wS3yDw8Yz+
        mG7pmSLrSYvwpUf06azhbpWXvpjo2QwON7nRAHpYbHal6VH5+vW1Zj+MUB5KqTriVc7BOpXyqBaOt
        Y7hhMztw==;
Received: from [2001:4bb8:180:7b62:f738:1861:1acc:15c8] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOK4l-0003Lt-Ax; Fri, 02 Oct 2020 12:22:15 +0000
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
        linux-mm@kvack.org, Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: [PATCH 07/11] drm/i915: stop using kmap in i915_gem_object_map
Date:   Fri,  2 Oct 2020 14:22:00 +0200
Message-Id: <20201002122204.1534411-8-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201002122204.1534411-1-hch@lst.de>
References: <20201002122204.1534411-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmap for !PageHighmem is just a convoluted way to say page_address,
and kunmap is a no-op in that case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_pages.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_pages.c b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
index d6eeefab3d018b..6550c0bc824ea2 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_pages.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
@@ -162,8 +162,6 @@ static void unmap_object(struct drm_i915_gem_object *obj, void *ptr)
 {
 	if (is_vmalloc_addr(ptr))
 		vunmap(ptr);
-	else
-		kunmap(kmap_to_page(ptr));
 }
 
 struct sg_table *
@@ -277,11 +275,10 @@ static void *i915_gem_object_map(struct drm_i915_gem_object *obj,
 		 * forever.
 		 *
 		 * So if the page is beyond the 32b boundary, make an explicit
-		 * vmap. On 64b, this check will be optimised away as we can
-		 * directly kmap any page on the system.
+		 * vmap.
 		 */
 		if (!PageHighMem(page))
-			return kmap(page);
+			return page_address(page);
 	}
 
 	mem = stack;
-- 
2.28.0

