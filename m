Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F38B2B1939
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 11:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgKMKlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 05:41:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:39758 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726288AbgKMKku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 05:40:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 57F99AF06;
        Fri, 13 Nov 2020 10:40:48 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mateusz Nosek <mateusznosek0@gmail.com>,
        Laura Abbott <labbott@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v3 4/5] mm, page_poison: remove CONFIG_PAGE_POISONING_NO_SANITY
Date:   Fri, 13 Nov 2020 11:40:32 +0100
Message-Id: <20201113104033.22907-5-vbabka@suse.cz>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201113104033.22907-1-vbabka@suse.cz>
References: <20201113104033.22907-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_PAGE_POISONING_NO_SANITY skips the check on page alloc whether the
poison pattern was corrupted, suggesting a use-after-free. The motivation to
introduce it in commit 8823b1dbc05f ("mm/page_poison.c: enable PAGE_POISONING
as a separate option") was to simply sanitize freed pages, optimally together
with CONFIG_PAGE_POISONING_ZERO.

These days we have an init_on_free=1 boot option, which makes this use case of
page poisoning redundant. For sanitizing, writing zeroes is sufficient, there
is pretty much no benefit from writing the 0xAA poison pattern to freed pages,
without checking it back on alloc. Thus, remove this option and suggest
init_on_free instead in the main config's help.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_balloon.c |  4 +---
 mm/Kconfig.debug                | 15 ++++-----------
 mm/page_poison.c                |  3 ---
 3 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index e53faed6ba93..8985fc2cea86 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -1114,9 +1114,7 @@ static int virtballoon_validate(struct virtio_device *vdev)
 	 * page reporting as it could potentially change the contents
 	 * of our free pages.
 	 */
-	if (!want_init_on_free() &&
-	    (IS_ENABLED(CONFIG_PAGE_POISONING_NO_SANITY) ||
-	     !page_poisoning_enabled_static()))
+	if (!want_init_on_free() && !page_poisoning_enabled_static())
 		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_PAGE_POISON);
 	else if (!virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON))
 		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_REPORTING);
diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index c57786ad5be9..14e29fe5bfa6 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -74,18 +74,11 @@ config PAGE_POISONING
 	  Note that "poison" here is not the same thing as the "HWPoison"
 	  for CONFIG_MEMORY_FAILURE. This is software poisoning only.
 
-	  If unsure, say N
+	  If you are only interested in sanitization of freed pages without
+	  checking the poison pattern on alloc, you can boot the kernel with
+	  "init_on_free=1" instead of enabling this.
 
-config PAGE_POISONING_NO_SANITY
-	depends on PAGE_POISONING
-	bool "Only poison, don't sanity check"
-	help
-	   Skip the sanity checking on alloc, only fill the pages with
-	   poison on free. This reduces some of the overhead of the
-	   poisoning feature.
-
-	   If you are only interested in sanitization, say Y. Otherwise
-	   say N.
+	  If unsure, say N
 
 config PAGE_POISONING_ZERO
 	bool "Use zero for poisoning instead of debugging value"
diff --git a/mm/page_poison.c b/mm/page_poison.c
index 0d899a01d107..65cdf844c8ad 100644
--- a/mm/page_poison.c
+++ b/mm/page_poison.c
@@ -51,9 +51,6 @@ static void check_poison_mem(unsigned char *mem, size_t bytes)
 	unsigned char *start;
 	unsigned char *end;
 
-	if (IS_ENABLED(CONFIG_PAGE_POISONING_NO_SANITY))
-		return;
-
 	start = memchr_inv(mem, PAGE_POISON, bytes);
 	if (!start)
 		return;
-- 
2.29.2

