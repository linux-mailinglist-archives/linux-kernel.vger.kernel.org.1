Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E5927D5E1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 20:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgI2SgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 14:36:06 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52915 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbgI2SgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 14:36:03 -0400
Received: by mail-wm1-f67.google.com with SMTP id q9so5653400wmj.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 11:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1AriX1I1xNfjnxfNSmAKzK7wEz9F3HLx249hrusGBIU=;
        b=AXH2uuHwtKXd8jjXKWaSd7WGViesO48h/cas/Wh40Su8WFlArbm1D96O9/GU/LKVM7
         clDi+hnd3fyJJfhF/b3nNnTaxnmPZUQzBKnbyc5ZQFUg9FrfTbiava3E7YEMKy0ZOkBD
         zaRzrTzXKxj9L6DDXw6sNUiNZXEyO6eBE0PdRMt+fguRgjXJ36219zUcH+MycHmuNKt/
         o2IIFo4shSUqS0PBDJ/KtSWMpo0fEbzk7NmQqKQLEnd3Hj9n2oSb6gRPAz71T4oYBwP4
         o6KFy7ytwF7MnexJMhnMhtnmUVNQm9CNDL9AU0YDPEQlpHktDqw9N4QrYhsJZB6v71Pk
         gisw==
X-Gm-Message-State: AOAM5312V8JvLiCKhX+GNBhHBcZLBf+4l7vLejM92XQqkVtrkdQOC7Oq
        Zok+eSer2lpbqtIlvTx+Cdo=
X-Google-Smtp-Source: ABdhPJw8R3kY6IgJeu8H0uvfxSq+fvJCLPzv970QVYzDqIIZL9GZMM3MlhWS8bLeqHe+hKlVyU728w==
X-Received: by 2002:a1c:6a08:: with SMTP id f8mr6140532wmc.151.1601404561398;
        Tue, 29 Sep 2020 11:36:01 -0700 (PDT)
Received: from localhost.localdomain ([185.248.161.177])
        by smtp.gmail.com with ESMTPSA id b188sm12151271wmb.2.2020.09.29.11.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 11:36:00 -0700 (PDT)
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
Subject: [PATCH RFC v2 5/6] lkdtm: Add heap quarantine tests
Date:   Tue, 29 Sep 2020 21:35:12 +0300
Message-Id: <20200929183513.380760-6-alex.popov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200929183513.380760-1-alex.popov@linux.com>
References: <20200929183513.380760-1-alex.popov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tests for CONFIG_SLAB_QUARANTINE.

The HEAP_SPRAY test aims to reallocate a recently freed heap object.
It allocates and frees an object from a separate kmem_cache and then
allocates 400000 similar objects from it. I.e. this test performs an
original heap spraying technique for use-after-free exploitation.
If CONFIG_SLAB_QUARANTINE is disabled, the freed object is instantly
reallocated and overwritten, which is required for a successful attack.

The PUSH_THROUGH_QUARANTINE test allocates and frees an object from a
separate kmem_cache and then performs kmem_cache_alloc()+kmem_cache_free()
400000 times. This test pushes the object through the heap quarantine and
reallocates it after it returns back to the allocator freelist.
If CONFIG_SLAB_QUARANTINE is enabled, this test should show that the
randomized quarantine will release the freed object at an unpredictable
moment, which makes use-after-free exploitation much harder.

Signed-off-by: Alexander Popov <alex.popov@linux.com>
---
 drivers/misc/lkdtm/core.c  |   2 +
 drivers/misc/lkdtm/heap.c  | 110 +++++++++++++++++++++++++++++++++++++
 drivers/misc/lkdtm/lkdtm.h |   2 +
 3 files changed, 114 insertions(+)

diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index a5e344df9166..6be5ca49ae6b 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -126,6 +126,8 @@ static const struct crashtype crashtypes[] = {
 	CRASHTYPE(SLAB_FREE_DOUBLE),
 	CRASHTYPE(SLAB_FREE_CROSS),
 	CRASHTYPE(SLAB_FREE_PAGE),
+	CRASHTYPE(HEAP_SPRAY),
+	CRASHTYPE(PUSH_THROUGH_QUARANTINE),
 	CRASHTYPE(SOFTLOCKUP),
 	CRASHTYPE(HARDLOCKUP),
 	CRASHTYPE(SPINLOCKUP),
diff --git a/drivers/misc/lkdtm/heap.c b/drivers/misc/lkdtm/heap.c
index 1323bc16f113..f666a08d9462 100644
--- a/drivers/misc/lkdtm/heap.c
+++ b/drivers/misc/lkdtm/heap.c
@@ -10,6 +10,7 @@
 static struct kmem_cache *double_free_cache;
 static struct kmem_cache *a_cache;
 static struct kmem_cache *b_cache;
+static struct kmem_cache *spray_cache;
 
 /*
  * This tries to stay within the next largest power-of-2 kmalloc cache
@@ -204,6 +205,112 @@ static void ctor_a(void *region)
 { }
 static void ctor_b(void *region)
 { }
+static void ctor_spray(void *region)
+{ }
+
+#define SPRAY_LENGTH 400000
+#define SPRAY_ITEM_SIZE 333
+
+void lkdtm_HEAP_SPRAY(void)
+{
+	int *addr;
+	int **spray_addrs = NULL;
+	unsigned long i = 0;
+
+	addr = kmem_cache_alloc(spray_cache, GFP_KERNEL);
+	if (!addr) {
+		pr_info("Can't allocate memory in spray_cache cache\n");
+		return;
+	}
+
+	memset(addr, 0xA5, SPRAY_ITEM_SIZE);
+	kmem_cache_free(spray_cache, addr);
+	pr_info("Allocated and freed spray_cache object %p of size %d\n",
+					addr, SPRAY_ITEM_SIZE);
+
+	spray_addrs = kcalloc(SPRAY_LENGTH, sizeof(int *), GFP_KERNEL);
+	if (!spray_addrs) {
+		pr_info("Unable to allocate memory for spray_addrs\n");
+		return;
+	}
+
+	pr_info("Original heap spraying: allocate %d objects of size %d...\n",
+					SPRAY_LENGTH, SPRAY_ITEM_SIZE);
+	for (i = 0; i < SPRAY_LENGTH; i++) {
+		spray_addrs[i] = kmem_cache_alloc(spray_cache, GFP_KERNEL);
+		if (!spray_addrs[i]) {
+			pr_info("Can't allocate memory in spray_cache cache\n");
+			break;
+		}
+
+		memset(spray_addrs[i], 0x42, SPRAY_ITEM_SIZE);
+
+		if (spray_addrs[i] == addr) {
+			pr_info("FAIL: attempt %lu: freed object is reallocated\n", i);
+			break;
+		}
+	}
+
+	if (i == SPRAY_LENGTH)
+		pr_info("OK: original heap spraying hasn't succeed\n");
+
+	for (i = 0; i < SPRAY_LENGTH; i++) {
+		if (spray_addrs[i])
+			kmem_cache_free(spray_cache, spray_addrs[i]);
+	}
+
+	kfree(spray_addrs);
+}
+
+/*
+ * Pushing an object through the quarantine requires both allocating and
+ * freeing memory. Objects are released from the quarantine on new memory
+ * allocations, but only when the quarantine size is over the limit.
+ * And the quarantine size grows on new memory freeing.
+ *
+ * This test should show that the randomized quarantine will release the
+ * freed object at an unpredictable moment.
+ */
+void lkdtm_PUSH_THROUGH_QUARANTINE(void)
+{
+	int *addr;
+	int *push_addr;
+	unsigned long i;
+
+	addr = kmem_cache_alloc(spray_cache, GFP_KERNEL);
+	if (!addr) {
+		pr_info("Can't allocate memory in spray_cache cache\n");
+		return;
+	}
+
+	memset(addr, 0xA5, SPRAY_ITEM_SIZE);
+	kmem_cache_free(spray_cache, addr);
+	pr_info("Allocated and freed spray_cache object %p of size %d\n",
+					addr, SPRAY_ITEM_SIZE);
+
+	pr_info("Push through quarantine: allocate and free %d objects of size %d...\n",
+					SPRAY_LENGTH, SPRAY_ITEM_SIZE);
+	for (i = 0; i < SPRAY_LENGTH; i++) {
+		push_addr = kmem_cache_alloc(spray_cache, GFP_KERNEL);
+		if (!push_addr) {
+			pr_info("Can't allocate memory in spray_cache cache\n");
+			break;
+		}
+
+		memset(push_addr, 0x42, SPRAY_ITEM_SIZE);
+		kmem_cache_free(spray_cache, push_addr);
+
+		if (push_addr == addr) {
+			pr_info("Target object is reallocated at attempt %lu\n", i);
+			break;
+		}
+	}
+
+	if (i == SPRAY_LENGTH) {
+		pr_info("Target object is NOT reallocated in %d attempts\n",
+					SPRAY_LENGTH);
+	}
+}
 
 void __init lkdtm_heap_init(void)
 {
@@ -211,6 +318,8 @@ void __init lkdtm_heap_init(void)
 					      64, 0, 0, ctor_double_free);
 	a_cache = kmem_cache_create("lkdtm-heap-a", 64, 0, 0, ctor_a);
 	b_cache = kmem_cache_create("lkdtm-heap-b", 64, 0, 0, ctor_b);
+	spray_cache = kmem_cache_create("lkdtm-heap-spray",
+					SPRAY_ITEM_SIZE, 0, 0, ctor_spray);
 }
 
 void __exit lkdtm_heap_exit(void)
@@ -218,4 +327,5 @@ void __exit lkdtm_heap_exit(void)
 	kmem_cache_destroy(double_free_cache);
 	kmem_cache_destroy(a_cache);
 	kmem_cache_destroy(b_cache);
+	kmem_cache_destroy(spray_cache);
 }
diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
index 8878538b2c13..d6b4b0708359 100644
--- a/drivers/misc/lkdtm/lkdtm.h
+++ b/drivers/misc/lkdtm/lkdtm.h
@@ -45,6 +45,8 @@ void lkdtm_READ_BUDDY_AFTER_FREE(void);
 void lkdtm_SLAB_FREE_DOUBLE(void);
 void lkdtm_SLAB_FREE_CROSS(void);
 void lkdtm_SLAB_FREE_PAGE(void);
+void lkdtm_HEAP_SPRAY(void);
+void lkdtm_PUSH_THROUGH_QUARANTINE(void);
 
 /* lkdtm_perms.c */
 void __init lkdtm_perms_init(void);
-- 
2.26.2

