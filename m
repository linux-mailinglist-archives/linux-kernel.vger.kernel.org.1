Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8BA2993EC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 18:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1780281AbgJZReL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 13:34:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:43898 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1780087AbgJZReI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 13:34:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BE5E7AEFE;
        Mon, 26 Oct 2020 17:34:06 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mateusz Nosek <mateusznosek0@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 3/3] mm, page_alloc: reduce static keys in prep_new_page()
Date:   Mon, 26 Oct 2020 18:33:58 +0100
Message-Id: <20201026173358.14704-4-vbabka@suse.cz>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201026173358.14704-1-vbabka@suse.cz>
References: <20201026173358.14704-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

prep_new_page() will always zero a new page (regardless of __GFP_ZERO) when
init_on_alloc is enabled, but will also always skip zeroing if the page was
already zeroed on free by init_on_free or page poisoning.

The latter check implemented by free_pages_prezeroed() can involve two
different static keys. As prep_new_page() is really a hot path, let's introduce
a single static key free_pages_not_prezeroed for this purpose and initialize it
in init_mem_debugging().

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/page_alloc.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2a1be197649d..980780f5f242 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -171,6 +171,8 @@ EXPORT_SYMBOL(init_on_alloc);
 DEFINE_STATIC_KEY_FALSE_RO(init_on_free);
 EXPORT_SYMBOL(init_on_free);
 
+static DEFINE_STATIC_KEY_TRUE_RO(free_pages_not_prezeroed);
+
 static bool _init_on_alloc_enabled_early __read_mostly
 				= IS_ENABLED(CONFIG_INIT_ON_ALLOC_DEFAULT_ON);
 static int __init early_init_on_alloc(char *buf)
@@ -777,6 +779,16 @@ void init_mem_debugging()
 		}
 	}
 
+	/*
+	 * We have a special static key that controls whether prep_new_page will
+	 * never need to zero the page. This mode is enabled when page is
+	 * already zeroed by init_on_free or page_poisoning zero mode.
+	 */
+	if (_init_on_free_enabled_early ||
+			(IS_ENABLED(CONFIG_PAGE_POISONING_ZERO)
+				&& page_poisoning_enabled()))
+		static_branch_disable(&free_pages_not_prezeroed);
+
 #ifdef CONFIG_PAGE_POISONING
 	/*
 	 * Page poisoning is debug page alloc for some arches. If
@@ -2216,12 +2228,6 @@ static inline int check_new_page(struct page *page)
 	return 1;
 }
 
-static inline bool free_pages_prezeroed(void)
-{
-	return (IS_ENABLED(CONFIG_PAGE_POISONING_ZERO) &&
-		page_poisoning_enabled_static()) || want_init_on_free();
-}
-
 #ifdef CONFIG_DEBUG_VM
 /*
  * With DEBUG_VM enabled, order-0 pages are checked for expected state when
@@ -2291,7 +2297,8 @@ static void prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags
 {
 	post_alloc_hook(page, order, gfp_flags);
 
-	if (!free_pages_prezeroed() && want_init_on_alloc(gfp_flags))
+	if (static_branch_likely(&free_pages_not_prezeroed)
+					&& want_init_on_alloc(gfp_flags))
 		kernel_init_free_pages(page, 1 << order);
 
 	if (order && (gfp_flags & __GFP_COMP))
-- 
2.29.0

