Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2AB72C1655
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 21:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387516AbgKWUPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 15:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731687AbgKWUPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 15:15:15 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E77C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:15:15 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id g17so6453362qtr.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=NLiVUxn9nGZzjemtf3cQRZI6tHXp7YKQ8dqUNAbFdqU=;
        b=sEEd+SR5E0QujIT6LdTNMkP8lvByK/biZ74au0Czx9ejMJ7eteUUr04ivXsXnZo0g+
         ATjcA39S/TY8d8NJxKDXQ1milDVgJmFjdelMKmd3E+kadIQWJxzBS/HP4OQn/3jV53EX
         zbtTSa1kT/UkktYPQ1CYBza1aMMLQSg3uRWLqRuPvi8Iq0z26TFAB3ZXNeF1Mu+LBYeo
         iAHQizMKbfGB75rv0K24dDQV7pzlIuD8FAttvqmJn27tLVdR7ewFAbw6w0P0VPS6I0vX
         dyjKhQWaiOUXrKBzq1gX3WWhDNtOnk2CyVHfR21g9XT+kNzCmuYSC4AQuXtmhHH+46yn
         Gylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NLiVUxn9nGZzjemtf3cQRZI6tHXp7YKQ8dqUNAbFdqU=;
        b=hcKD+ipEdch7AQGn4+ZHIcPJVVVjPmqjFBjWI/ukP/Ygw42uEYzsoJ435dglQI+ZRz
         uXoaMUGzf16UiNSWkWYa+w6vraSztHYbd69oRrVpKYWnNMxnDkXxrl//u4s+ZGrz4qtp
         +WvS9BfU+JfS5TIeoArZqwUcyrPtONKIAMPnHgcAX1uAsndkKpg1pFIScpEjng+umi0G
         zf8xgR8LugpHGG7GLDMjppMvZNRub739j9Z5Zuc28057YFp5QXDCxGHThVJYQXBXMTM8
         cJ7u3swBFQylD4vtKL1kcGYjvvh0uSBT4dWA91BdpsJICZ48BcUMMPvS3m2szjXLkb7s
         JFkA==
X-Gm-Message-State: AOAM530/3Vd7DUl70Q9xd17RfEZ7IcDomom16CNNv46QH8TvRI+oltx5
        0e1fWXLHCSpNOcJgaZ8WygIaqcluI1MDD9Rh
X-Google-Smtp-Source: ABdhPJxOc7uK81qXmguJVdi7tYU8ToxOxicUm1j1rL9VWGPliVVPXjfCwHBWb4jXxW7bR846SidQKgv2RVKPCxk+
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:4a8a:: with SMTP id
 h10mr1086459qvx.55.1606162514671; Mon, 23 Nov 2020 12:15:14 -0800 (PST)
Date:   Mon, 23 Nov 2020 21:14:39 +0100
In-Reply-To: <cover.1606162397.git.andreyknvl@google.com>
Message-Id: <131a6694a978a9a8b150187e539eecc8bcbf759b.1606162397.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1606162397.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH mm v4 09/19] kasan: open-code kasan_unpoison_slab
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's the external annotation kasan_unpoison_slab() that is currently
defined as static inline and uses kasan_unpoison_range(). Open-code this
function in mempool.c. Otherwise with an upcoming change this function
will result in an unnecessary function call.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Marco Elver <elver@google.com>
Link: https://linux-review.googlesource.com/id/Ia7c8b659f79209935cbaab3913bf7f082cc43a0e
---
 include/linux/kasan.h | 6 ------
 mm/mempool.c          | 2 +-
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 1594177f86bb..872bf145ddde 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -106,11 +106,6 @@ struct kasan_cache {
 	int free_meta_offset;
 };
 
-size_t __ksize(const void *);
-static inline void kasan_unpoison_slab(const void *ptr)
-{
-	kasan_unpoison_range(ptr, __ksize(ptr));
-}
 size_t kasan_metadata_size(struct kmem_cache *cache);
 
 bool kasan_save_enable_multi_shot(void);
@@ -166,7 +161,6 @@ static inline bool kasan_slab_free(struct kmem_cache *s, void *object,
 	return false;
 }
 
-static inline void kasan_unpoison_slab(const void *ptr) { }
 static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
 
 #endif /* CONFIG_KASAN */
diff --git a/mm/mempool.c b/mm/mempool.c
index f473cdddaff0..583a9865b181 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -112,7 +112,7 @@ static __always_inline void kasan_poison_element(mempool_t *pool, void *element)
 static void kasan_unpoison_element(mempool_t *pool, void *element)
 {
 	if (pool->alloc == mempool_alloc_slab || pool->alloc == mempool_kmalloc)
-		kasan_unpoison_slab(element);
+		kasan_unpoison_range(element, __ksize(element));
 	else if (pool->alloc == mempool_alloc_pages)
 		kasan_alloc_pages(element, (unsigned long)pool->pool_data);
 }
-- 
2.29.2.454.gaff20da3a2-goog

