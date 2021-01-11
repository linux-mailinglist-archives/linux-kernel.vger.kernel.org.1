Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F9F2F0EDB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 10:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbhAKJQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 04:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727690AbhAKJQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 04:16:34 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6D5C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 01:15:53 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id c17so12813677qvv.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 01:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=mA0JHK6xgqVKJnr+4pNXEncnoduYcHjsc3imT7Uizfs=;
        b=sSWE8ojTbdN1FkVPnp4Ry7+Ll9EPCJKk/KnWSf9cs9pEXp9cN5FZ190rDQZ+xM4fWH
         CKLujtR3RtAp0+bN5PcWfA4gEDB2KBexnB8oyvOnyHeu32hFrQ5/XHmgjWRInoq2YQG8
         JefEBxyjKiLn3f/OTLefT9T4kPn3+Oq22FO5hguParALreQBrE4/HispUrLtvDWPRq8X
         l8Yw/aqEi+vBRg6ToTGPt0coEW9H9UTKQMLIGecqOLOuegvwPmUgYE9rry21nM+Anois
         gMQOmLypgMoIYL2ZvOvatClJNCLCo4T0N8dUb509awl2iL/mQ9i3GmOgGnfcViTIFdIr
         0GzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc:content-transfer-encoding;
        bh=mA0JHK6xgqVKJnr+4pNXEncnoduYcHjsc3imT7Uizfs=;
        b=B3aGRTm0Qo75m2QGfAwDwhZb8Q9I0+AfhSScYxerL0XcCK5exs7LBEBP5A8IMSUNeF
         n7nFUjnp4Mf+V5L/xrZ5EALbxe/BPkj6OKwKUKqahGPo/9LLt9dfBF77L9JfCHypfHxX
         Qya9faC+vSeaJqKBQqUMskwMHHnk4gcF6GJOudPw5p4jGBQO1iCJ+l64tREQRbFQYEpZ
         kGEhY8Crd2ZnpNVaXfe+6WXkmXGFM2FrA98S8c+FREiSEaNd4q3wgcsBpvDbNGDZJOqJ
         LWe1QoHnogWcEf6pceWy38G1VtV2fGwytuUYx22qtY7RlfM+3wi4pFCn3O2UNEgXCAKd
         nYYQ==
X-Gm-Message-State: AOAM533M4JNVY9zVbE6pp03/j0B4W0c5xoGcrrsgR8hHl/YIyIOEDEG4
        i+LqeOQGIx7XXLLcUOfTSHvPfzEiAQ==
X-Google-Smtp-Source: ABdhPJyYlHEJKPA2IGd8db8i6p9fRK2i1i2q7ieQFolg0VDYM54ZSle9WYAjTPMFcA0542Gi1yzi8aW6OQ==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:ad4:438f:: with SMTP id s15mr18357736qvr.13.1610356552994;
 Mon, 11 Jan 2021 01:15:52 -0800 (PST)
Date:   Mon, 11 Jan 2021 10:15:43 +0100
Message-Id: <20210111091544.3287013-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH mm 1/2] kfence: add option to use KFENCE without static keys
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org
Cc:     glider@google.com, dvyukov@google.com, andreyknvl@google.com,
        jannh@google.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com,
        "=?UTF-8?q?J=C3=B6rn=20Engel?=" <joern@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For certain usecases, specifically where the sample interval is always
set to a very low value such as 1ms, it can make sense to use a dynamic
branch instead of static branches due to the overhead of toggling a
static branch.

Therefore, add a new Kconfig option to remove the static branches and
instead check kfence_allocation_gate if a KFENCE allocation should be
set up.

Suggested-by: J=C3=B6rn Engel <joern@purestorage.com>
Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/kfence.h | 11 ++++++++++-
 lib/Kconfig.kfence     | 12 +++++++++++-
 mm/kfence/core.c       | 32 ++++++++++++++++++--------------
 3 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/include/linux/kfence.h b/include/linux/kfence.h
index 76246889ecdb..dc86b69d3903 100644
--- a/include/linux/kfence.h
+++ b/include/linux/kfence.h
@@ -4,7 +4,6 @@
 #define _LINUX_KFENCE_H
=20
 #include <linux/mm.h>
-#include <linux/static_key.h>
 #include <linux/types.h>
=20
 #ifdef CONFIG_KFENCE
@@ -17,7 +16,13 @@
 #define KFENCE_POOL_SIZE ((CONFIG_KFENCE_NUM_OBJECTS + 1) * 2 * PAGE_SIZE)
 extern char *__kfence_pool;
=20
+#ifdef CONFIG_KFENCE_STATIC_KEYS
+#include <linux/static_key.h>
 DECLARE_STATIC_KEY_FALSE(kfence_allocation_key);
+#else
+#include <linux/atomic.h>
+extern atomic_t kfence_allocation_gate;
+#endif
=20
 /**
  * is_kfence_address() - check if an address belongs to KFENCE pool
@@ -104,7 +109,11 @@ void *__kfence_alloc(struct kmem_cache *s, size_t size=
, gfp_t flags);
  */
 static __always_inline void *kfence_alloc(struct kmem_cache *s, size_t siz=
e, gfp_t flags)
 {
+#ifdef CONFIG_KFENCE_STATIC_KEYS
 	if (static_branch_unlikely(&kfence_allocation_key))
+#else
+	if (unlikely(!atomic_read(&kfence_allocation_gate)))
+#endif
 		return __kfence_alloc(s, size, flags);
 	return NULL;
 }
diff --git a/lib/Kconfig.kfence b/lib/Kconfig.kfence
index d3ea24fa30fc..78f50ccb3b45 100644
--- a/lib/Kconfig.kfence
+++ b/lib/Kconfig.kfence
@@ -6,7 +6,6 @@ config HAVE_ARCH_KFENCE
 menuconfig KFENCE
 	bool "KFENCE: low-overhead sampling-based memory safety error detector"
 	depends on HAVE_ARCH_KFENCE && (SLAB || SLUB)
-	depends on JUMP_LABEL # To ensure performance, require jump labels
 	select STACKTRACE
 	help
 	  KFENCE is a low-overhead sampling-based detector of heap out-of-bounds
@@ -25,6 +24,17 @@ menuconfig KFENCE
=20
 if KFENCE
=20
+config KFENCE_STATIC_KEYS
+	bool "Use static keys to set up allocations"
+	default y
+	depends on JUMP_LABEL # To ensure performance, require jump labels
+	help
+	  Use static keys (static branches) to set up KFENCE allocations. Using
+	  static keys is normally recommended, because it avoids a dynamic
+	  branch in the allocator's fast path. However, with very low sample
+	  intervals, or on systems that do not support jump labels, a dynamic
+	  branch may still be an acceptable performance trade-off.
+
 config KFENCE_SAMPLE_INTERVAL
 	int "Default sample interval in milliseconds"
 	default 100
diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index f0816d5f5913..96a9a98e7453 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -88,11 +88,13 @@ struct kfence_metadata kfence_metadata[CONFIG_KFENCE_NU=
M_OBJECTS];
 static struct list_head kfence_freelist =3D LIST_HEAD_INIT(kfence_freelist=
);
 static DEFINE_RAW_SPINLOCK(kfence_freelist_lock); /* Lock protecting freel=
ist. */
=20
+#ifdef CONFIG_KFENCE_STATIC_KEYS
 /* The static key to set up a KFENCE allocation. */
 DEFINE_STATIC_KEY_FALSE(kfence_allocation_key);
+#endif
=20
 /* Gates the allocation, ensuring only one succeeds in a given period. */
-static atomic_t allocation_gate =3D ATOMIC_INIT(1);
+atomic_t kfence_allocation_gate =3D ATOMIC_INIT(1);
=20
 /* Statistics counters for debugfs. */
 enum kfence_counter_id {
@@ -583,29 +585,31 @@ late_initcall(kfence_debugfs_init);
 static struct delayed_work kfence_timer;
 static void toggle_allocation_gate(struct work_struct *work)
 {
-	unsigned long end_wait;
-
 	if (!READ_ONCE(kfence_enabled))
 		return;
=20
 	/* Enable static key, and await allocation to happen. */
-	atomic_set(&allocation_gate, 0);
+	atomic_set(&kfence_allocation_gate, 0);
+#ifdef CONFIG_KFENCE_STATIC_KEYS
 	static_branch_enable(&kfence_allocation_key);
 	/*
 	 * Await an allocation. Timeout after 1 second, in case the kernel stops
 	 * doing allocations, to avoid stalling this worker task for too long.
 	 */
-	end_wait =3D jiffies + HZ;
-	do {
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		if (atomic_read(&allocation_gate) !=3D 0)
-			break;
-		schedule_timeout(1);
-	} while (time_before(jiffies, end_wait));
-	__set_current_state(TASK_RUNNING);
-
+	{
+		unsigned long end_wait =3D jiffies + HZ;
+
+		do {
+			set_current_state(TASK_UNINTERRUPTIBLE);
+			if (atomic_read(&kfence_allocation_gate) !=3D 0)
+				break;
+			schedule_timeout(1);
+		} while (time_before(jiffies, end_wait));
+		__set_current_state(TASK_RUNNING);
+	}
 	/* Disable static key and reset timer. */
 	static_branch_disable(&kfence_allocation_key);
+#endif
 	schedule_delayed_work(&kfence_timer, msecs_to_jiffies(kfence_sample_inter=
val));
 }
 static DECLARE_DELAYED_WORK(kfence_timer, toggle_allocation_gate);
@@ -711,7 +715,7 @@ void *__kfence_alloc(struct kmem_cache *s, size_t size,=
 gfp_t flags)
 	 * sense to continue writing to it and pay the associated contention
 	 * cost, in case we have a large number of concurrent allocations.
 	 */
-	if (atomic_read(&allocation_gate) || atomic_inc_return(&allocation_gate) =
> 1)
+	if (atomic_read(&kfence_allocation_gate) || atomic_inc_return(&kfence_all=
ocation_gate) > 1)
 		return NULL;
=20
 	if (!READ_ONCE(kfence_enabled))
--=20
2.30.0.284.gd98b1dd5eaa7-goog

