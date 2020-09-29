Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4C727D5DE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 20:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgI2SgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 14:36:02 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54848 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbgI2Sf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 14:35:59 -0400
Received: by mail-wm1-f67.google.com with SMTP id s13so5629130wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 11:35:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H9FfRvaA+Wp3IJ0z7DJTjMPazUzC1jfP34QSVpIB8gM=;
        b=LB+oU1CEUmGZEgy8UYGG/SXqH2eWawzEcDHHpFX0VipZUCM9IxOMKsstoLQCIZHuyb
         87GxMD5njGnQ50PWy/KyqgZO/WjHSi2NXPOcw42Gp2bNKFHmMtXrNJH3eecNaq9T4cwm
         i71YwEVRSRMxuCV7w5eLI4nXiXWoaqkrO9Y8jPWr05hp3P2dr4XRbRGiuAbMo3KlKaJv
         bArH1jn1Bsf6zALxoMUli2uHfLtTFbxEJTZkPy38BYpYbXnyFbc/Eda4ohV5dj0pCphV
         i7LscYLazyO+ORaByWEagzaJpbr68wEoTIkS7F3ly1IGkkS/F3xU7uUH51+FmquAQp02
         i8oA==
X-Gm-Message-State: AOAM532VEH43L3OobM385qdRmjsghxkkI9O+fNeJW6ediiU7KGDcfiBU
        U+bA89tFR3wJOmI7g2tjwA0=
X-Google-Smtp-Source: ABdhPJz8ttasfOla2Nh3dmzYRTGGwGjvXLTOok9ECPboyXttbJf8+eh2xPs5JtcBJcd50lm/HCBFRQ==
X-Received: by 2002:a05:600c:2909:: with SMTP id i9mr6280384wmd.160.1601404556735;
        Tue, 29 Sep 2020 11:35:56 -0700 (PDT)
Received: from localhost.localdomain ([185.248.161.177])
        by smtp.gmail.com with ESMTPSA id b188sm12151271wmb.2.2020.09.29.11.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 11:35:56 -0700 (PDT)
From:   Alexander Popov <alex.popov@linux.com>
To:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        Will Deacon <will@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Laura Abbott <labbott@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Machek <pavel@denx.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        Alexander Popov <alex.popov@linux.com>
Cc:     notify@kernel.org
Subject: [PATCH RFC v2 4/6] mm: Implement slab quarantine randomization
Date:   Tue, 29 Sep 2020 21:35:11 +0300
Message-Id: <20200929183513.380760-5-alex.popov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200929183513.380760-1-alex.popov@linux.com>
References: <20200929183513.380760-1-alex.popov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The randomization is very important for the slab quarantine security
properties. Without it the number of kmalloc()+kfree() calls that are
needed for overwriting the vulnerable object is almost the same.
That would be good for stable use-after-free exploitation, and we
should not allow that.

This commit contains very compact and hackish changes that introduce
the quarantine randomization. At first all quarantine batches are filled
by objects. Then during the quarantine reducing we randomly choose and
free 1/2 of objects from a randomly chosen batch. Now the randomized
quarantine releases the freed object at an unpredictable moment, which
is harmful for the heap spraying technique employed by use-after-free
exploits.

Signed-off-by: Alexander Popov <alex.popov@linux.com>
---
 mm/kasan/quarantine.c | 79 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 69 insertions(+), 10 deletions(-)

diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
index 61666263c53e..4ce100605086 100644
--- a/mm/kasan/quarantine.c
+++ b/mm/kasan/quarantine.c
@@ -29,6 +29,7 @@
 #include <linux/srcu.h>
 #include <linux/string.h>
 #include <linux/types.h>
+#include <linux/random.h>
 
 #include "../slab.h"
 #include "kasan.h"
@@ -89,8 +90,13 @@ static void qlist_move_all(struct qlist_head *from, struct qlist_head *to)
 }
 
 #define QUARANTINE_PERCPU_SIZE (1 << 20)
+
+#ifdef CONFIG_KASAN
 #define QUARANTINE_BATCHES \
 	(1024 > 4 * CONFIG_NR_CPUS ? 1024 : 4 * CONFIG_NR_CPUS)
+#else
+#define QUARANTINE_BATCHES 128
+#endif
 
 /*
  * The object quarantine consists of per-cpu queues and a global queue,
@@ -110,10 +116,7 @@ DEFINE_STATIC_SRCU(remove_cache_srcu);
 /* Maximum size of the global queue. */
 static unsigned long quarantine_max_size;
 
-/*
- * Target size of a batch in global_quarantine.
- * Usually equal to QUARANTINE_PERCPU_SIZE unless we have too much RAM.
- */
+/* Target size of a batch in global_quarantine. */
 static unsigned long quarantine_batch_size;
 
 /*
@@ -191,7 +194,12 @@ void quarantine_put(struct kasan_free_meta *info, struct kmem_cache *cache)
 
 	q = this_cpu_ptr(&cpu_quarantine);
 	qlist_put(q, &info->quarantine_link, cache->size);
+#ifdef CONFIG_KASAN
 	if (unlikely(q->bytes > QUARANTINE_PERCPU_SIZE)) {
+#else
+	if (unlikely(q->bytes > min_t(size_t, QUARANTINE_PERCPU_SIZE,
+					READ_ONCE(quarantine_batch_size)))) {
+#endif
 		qlist_move_all(q, &temp);
 
 		raw_spin_lock(&quarantine_lock);
@@ -204,7 +212,7 @@ void quarantine_put(struct kasan_free_meta *info, struct kmem_cache *cache)
 			new_tail = quarantine_tail + 1;
 			if (new_tail == QUARANTINE_BATCHES)
 				new_tail = 0;
-			if (new_tail != quarantine_head)
+			if (new_tail != quarantine_head || !IS_ENABLED(CONFIG_KASAN))
 				quarantine_tail = new_tail;
 		}
 		raw_spin_unlock(&quarantine_lock);
@@ -213,12 +221,43 @@ void quarantine_put(struct kasan_free_meta *info, struct kmem_cache *cache)
 	local_irq_restore(flags);
 }
 
+static void qlist_move_random(struct qlist_head *from, struct qlist_head *to)
+{
+	struct qlist_node *curr;
+
+	if (unlikely(qlist_empty(from)))
+		return;
+
+	curr = from->head;
+	qlist_init(from);
+	while (curr) {
+		struct qlist_node *next = curr->next;
+		struct kmem_cache *obj_cache = qlink_to_cache(curr);
+		int rnd =  get_random_int();
+
+		/*
+		 * Hackish quarantine randomization, part 2:
+		 * move only 1/2 of objects to the destination list.
+		 * TODO: use random bits sparingly for better performance.
+		 */
+		if (rnd % 2 == 0)
+			qlist_put(to, curr, obj_cache->size);
+		else
+			qlist_put(from, curr, obj_cache->size);
+
+		curr = next;
+	}
+}
+
 void quarantine_reduce(void)
 {
-	size_t total_size, new_quarantine_size, percpu_quarantines;
+	size_t total_size;
 	unsigned long flags;
 	int srcu_idx;
 	struct qlist_head to_free = QLIST_INIT;
+#ifdef CONFIG_KASAN
+	size_t new_quarantine_size, percpu_quarantines;
+#endif
 
 	if (likely(READ_ONCE(quarantine_size) <=
 		   READ_ONCE(quarantine_max_size)))
@@ -236,12 +275,12 @@ void quarantine_reduce(void)
 	srcu_idx = srcu_read_lock(&remove_cache_srcu);
 	raw_spin_lock_irqsave(&quarantine_lock, flags);
 
-	/*
-	 * Update quarantine size in case of hotplug. Allocate a fraction of
-	 * the installed memory to quarantine minus per-cpu queue limits.
-	 */
+	/* Update quarantine size in case of hotplug */
 	total_size = (totalram_pages() << PAGE_SHIFT) /
 		QUARANTINE_FRACTION;
+
+#ifdef CONFIG_KASAN
+	/* Subtract per-cpu queue limits from total quarantine size */
 	percpu_quarantines = QUARANTINE_PERCPU_SIZE * num_online_cpus();
 	new_quarantine_size = (total_size < percpu_quarantines) ?
 		0 : total_size - percpu_quarantines;
@@ -257,6 +296,26 @@ void quarantine_reduce(void)
 		if (quarantine_head == QUARANTINE_BATCHES)
 			quarantine_head = 0;
 	}
+#else /* CONFIG_KASAN */
+	/*
+	 * Don't subtract per-cpu queue limits from total quarantine
+	 * size to consume all quarantine slots.
+	 */
+	WRITE_ONCE(quarantine_max_size, total_size);
+	WRITE_ONCE(quarantine_batch_size, total_size / QUARANTINE_BATCHES);
+
+	/*
+	 * Hackish quarantine randomization, part 1:
+	 * pick a random batch for reducing.
+	 */
+	if (likely(quarantine_size > quarantine_max_size)) {
+		do {
+			quarantine_head = get_random_int() % QUARANTINE_BATCHES;
+		} while (quarantine_head == quarantine_tail);
+		qlist_move_random(&global_quarantine[quarantine_head], &to_free);
+		WRITE_ONCE(quarantine_size, quarantine_size - to_free.bytes);
+	}
+#endif
 
 	raw_spin_unlock_irqrestore(&quarantine_lock, flags);
 
-- 
2.26.2

