Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B68C52F545E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 21:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbhAMUwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 15:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbhAMUwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 15:52:09 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A0FC061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 12:51:29 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kzn6y-005uvP-KI; Wed, 13 Jan 2021 21:51:24 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2] mm/slub: disable user tracing for kmemleak caches by default
Date:   Wed, 13 Jan 2021 21:51:14 +0100
Message-Id: <20210113215114.d94efa13ba30.I117b6764e725b3192318bbcf4269b13b709539ae@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If kmemleak is enabled, it uses a kmem cache for its own objects.
These objects are used to hold information kmemleak uses, including
a stack trace. If slub_debug is also turned on, each of them has
*another* stack trace, so the overhead adds up, and on my tests (on
ARCH=um, admittedly) 2/3rds of the allocations end up being doing
the stack tracing.

Turn off SLAB_STORE_USER if SLAB_NOLEAKTRACE was given, to avoid
storing the essentially same data twice.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
Perhaps instead it should go the other way around, and kmemleak
could even use/access the stack trace that's already in there ...
But I don't really care too much, I can just turn off slub debug
for the kmemleak caches via the command line anyway :-)

v2:
 - strip SLAB_STORE_USER only coming from slub_debug so that the
   command line args always take effect

---
 mm/slub.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 34dcc09e2ec9..a66c9948c529 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1412,6 +1412,15 @@ slab_flags_t kmem_cache_flags(unsigned int object_size,
 	size_t len;
 	char *next_block;
 	slab_flags_t block_flags;
+	slab_flags_t slub_debug_local = slub_debug;
+
+	/*
+	 * If the slab cache is for debugging (e.g. kmemleak) then
+	 * don't store user (stack trace) information by default,
+	 * but let the user enable it via the command line below.
+	 */
+	if (flags & SLAB_NOLEAKTRACE)
+		slub_debug_local &= ~SLAB_STORE_USER;
 
 	len = strlen(name);
 	next_block = slub_debug_string;
@@ -1446,7 +1455,7 @@ slab_flags_t kmem_cache_flags(unsigned int object_size,
 		}
 	}
 
-	return flags | slub_debug;
+	return flags | slub_debug_local;
 }
 #else /* !CONFIG_SLUB_DEBUG */
 static inline void setup_object_debug(struct kmem_cache *s,
-- 
2.26.2

