Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2491F590A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 18:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbgFJQcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 12:32:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:60636 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728174AbgFJQbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 12:31:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0B2CCAF2C;
        Wed, 10 Jun 2020 16:31:55 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, vinmenon@codeaurora.org,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>
Subject: [PATCH 5/9] mm, slub: make reclaim_account attribute read-only
Date:   Wed, 10 Jun 2020 18:31:31 +0200
Message-Id: <20200610163135.17364-6-vbabka@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610163135.17364-1-vbabka@suse.cz>
References: <20200610163135.17364-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The attribute reflects the SLAB_RECLAIM_ACCOUNT cache flag. It's not clear why
this attribute was writable in the first place, as it's tied to how the cache
is used by its creator, it's not a user tunable. Furthermore:

- it affects slab merging, but that's not being checked while toggled
- if affects whether __GFP_RECLAIMABLE flag is used to allocate page, but
  the runtime toggle doesn't update allocflags
- it affects cache_vmstat_idx() so runtime toggling might lead to incosistency
  of NR_SLAB_RECLAIMABLE and NR_SLAB_UNRECLAIMABLE

Thus make it read-only.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Roman Gushchin <guro@fb.com>
---
 mm/slub.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 0108829838e7..8dd2925448ae 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5223,16 +5223,7 @@ static ssize_t reclaim_account_show(struct kmem_cache *s, char *buf)
 {
 	return sprintf(buf, "%d\n", !!(s->flags & SLAB_RECLAIM_ACCOUNT));
 }
-
-static ssize_t reclaim_account_store(struct kmem_cache *s,
-				const char *buf, size_t length)
-{
-	s->flags &= ~SLAB_RECLAIM_ACCOUNT;
-	if (buf[0] == '1')
-		s->flags |= SLAB_RECLAIM_ACCOUNT;
-	return length;
-}
-SLAB_ATTR(reclaim_account);
+SLAB_ATTR_RO(reclaim_account);
 
 static ssize_t hwcache_align_show(struct kmem_cache *s, char *buf)
 {
-- 
2.26.2

