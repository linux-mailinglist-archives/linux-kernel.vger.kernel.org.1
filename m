Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4D62F4F9A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 17:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbhAMQK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 11:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbhAMQKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 11:10:25 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA2DC061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:09:45 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kziiM-005q3K-Du; Wed, 13 Jan 2021 17:09:42 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] mm/slub: disable user tracing for kmemleak caches
Date:   Wed, 13 Jan 2021 17:09:31 +0100
Message-Id: <20210113170931.929f808099d2.I117b6764e725b3192318bbcf4269b13b709539ae@changeid>
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

---
 mm/slub.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 34dcc09e2ec9..625a32a6645b 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1446,7 +1446,16 @@ slab_flags_t kmem_cache_flags(unsigned int object_size,
 		}
 	}
 
-	return flags | slub_debug;
+	flags |= slub_debug;
+
+	/*
+	 * If the slab cache is for debugging (e.g. kmemleak) then
+	 * don't store user (stack trace) information.
+	 */
+	if (flags & SLAB_NOLEAKTRACE)
+		flags &= ~SLAB_STORE_USER;
+
+	return flags;
 }
 #else /* !CONFIG_SLUB_DEBUG */
 static inline void setup_object_debug(struct kmem_cache *s,
-- 
2.26.2

