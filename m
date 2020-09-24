Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82238277347
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 15:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgIXN7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 09:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728148AbgIXN7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 09:59:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559D7C0613D5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 06:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=X+38u3dxn/7egb0TxSukZV81QAaP08nl9fHTuMV9EMQ=; b=uu25bWkHo+Hl7Pv/rKxKpa+6P4
        BHLFMKp4K/8UDfROjPA4Ae2Eh5k+yTJFfu+RAvj1L9krzANI/zjRwfKYM/zsgaWcPV6nmH4Hxg+De
        AWPM3v8Oca4Zul2mpMbnZdDPftGBE9ef4mz5QtL0o4NIe6A9ODUCLIL6vivqj4asYns9nniEMLLv4
        JanSFdyALR7K6k0IJIxIW4LU+EtxaghLks3e7eMcxljYpzfM2oZXYNnBT+UPOvVriZp7nosdFqmOW
        mpVnRwbMmLG/ksy86yoATba6R5XOZXKSbTkq+PTth7Gz++eLMVHv522QJZ8XQKYxGLcq1VzdTJ4nm
        Y34AuxnA==;
Received: from p4fdb0c34.dip0.t-ipconnect.de ([79.219.12.52] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLRm3-0003wA-9Q; Thu, 24 Sep 2020 13:59:03 +0000
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
Subject: [PATCH 07/11] drm/i915: stop using kmap in i915_gem_object_map
Date:   Thu, 24 Sep 2020 15:58:49 +0200
Message-Id: <20200924135853.875294-8-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200924135853.875294-1-hch@lst.de>
References: <20200924135853.875294-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmap for !PageHighmem is just a convoluted way to say page_address,
and kunmap is a no-op in that case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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

