Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F832A7370
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 01:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733037AbgKEACl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 19:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728323AbgKEACk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 19:02:40 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F66AC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 16:02:39 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id t14so102574wrs.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 16:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Ocomz11lJ9KE0anC5CzM99SKlSLQ0mxGbD3mCLha9hU=;
        b=TtFB7UefTiyPVVP+/kDhkkT/QxrHuTo+WYQ5Nvww663l3VqibyXgl53WW2WtoolN3r
         wYf3SBvI/y4/ED+RCCuwa5/pUZX+bY9wrT2Bkruuc8LKJG6Bx3xM1sQnPbF8GcOx8QmF
         mz7OfwCckO0gu8SIJZZwnULGnyIrzmYFoX7VIZiDvB2t8IjiO5TJICScNGjWfBA3MowY
         ev/8Po/TamKjG9Q11/jRnwJFgLkXoxfftwqGS4W/r0zgAIkuTcAbu3CICmE1xGNfhTHR
         o/P2LK0i0XtpoXyE+a1Wqq6TJ8dXDS83gGcR1mvWnopVytCSBBuVDZGQMksX5hYTNfHR
         TmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ocomz11lJ9KE0anC5CzM99SKlSLQ0mxGbD3mCLha9hU=;
        b=Vf+2lRoi6ogU9X5cIWuqZaB4LSuAMQxmAgxrtJFeDaFd3pbGfx8m82mdW76aasJ3qu
         +tlAcx9VV8FxdnTQOi+NIal+b0siMurljfRhiL1quBAvtvTj3ipg2OXKB9WyBLajKwJE
         IEcjfz1i75+/PG4/SABJ5LgCSNd/p70iTD93MI0clD76tpwiTb31Nb1QITl3JQtYtsXT
         Nk4RrOMwjqKU+mqMihcj2H1D4lMxkS5S3KYNIKjv4bamLrjMg8XBOE4Ncvk8ZtApOY37
         +EBNXMc0mkh8oL9G7nl+hGHz1nGvtUNjE5zKSxeUeoMm0BkI7/n7iD34xMAmjo4Q7KfB
         CK1A==
X-Gm-Message-State: AOAM533ojapiNBsdiH01NcoXDhPdUhC5AOH5zHyiEkwL+U4ryH4JtzXi
        MVKhbUjOe6XHdesCcfXyiyy3lWFed9xhKSPS
X-Google-Smtp-Source: ABdhPJxLptJ2NppRam2U5gruDbgx9bSTsC/cH6+ET8/IVRhCo/jAA8pQOAD70gM5B+ZoIP4EkLlv3XYmcaaXloEn
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:600c:22d3:: with SMTP id
 19mr178957wmg.161.1604534557830; Wed, 04 Nov 2020 16:02:37 -0800 (PST)
Date:   Thu,  5 Nov 2020 01:02:11 +0100
In-Reply-To: <cover.1604534322.git.andreyknvl@google.com>
Message-Id: <e6fab9ed577dc3861c3ea0bde82bfd04df2bcce1.1604534322.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604534322.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH 01/20] kasan: simplify quarantine_put call site
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Evgenii Stepanov <eugenis@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move get_free_info() call into quarantine_put() to simplify the call site.

No functional changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Link: https://linux-review.googlesource.com/id/Iab0f04e7ebf8d83247024b7190c67c3c34c7940f
---
 mm/kasan/common.c     | 2 +-
 mm/kasan/kasan.h      | 5 ++---
 mm/kasan/quarantine.c | 3 ++-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 2bb0ef6da6bd..5712c66c11c1 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -308,7 +308,7 @@ static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
 
 	kasan_set_free_info(cache, object, tag);
 
-	quarantine_put(get_free_info(cache, object), cache);
+	quarantine_put(cache, object);
 
 	return IS_ENABLED(CONFIG_KASAN_GENERIC);
 }
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index b0a57d8f9803..994be9979ffd 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -214,12 +214,11 @@ struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
 
 #if defined(CONFIG_KASAN_GENERIC) && \
 	(defined(CONFIG_SLAB) || defined(CONFIG_SLUB))
-void quarantine_put(struct kasan_free_meta *info, struct kmem_cache *cache);
+void quarantine_put(struct kmem_cache *cache, void *object);
 void quarantine_reduce(void);
 void quarantine_remove_cache(struct kmem_cache *cache);
 #else
-static inline void quarantine_put(struct kasan_free_meta *info,
-				struct kmem_cache *cache) { }
+static inline void quarantine_put(struct kmem_cache *cache, void *object) { }
 static inline void quarantine_reduce(void) { }
 static inline void quarantine_remove_cache(struct kmem_cache *cache) { }
 #endif
diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
index 580ff5610fc1..a0792f0d6d0f 100644
--- a/mm/kasan/quarantine.c
+++ b/mm/kasan/quarantine.c
@@ -161,11 +161,12 @@ static void qlist_free_all(struct qlist_head *q, struct kmem_cache *cache)
 	qlist_init(q);
 }
 
-void quarantine_put(struct kasan_free_meta *info, struct kmem_cache *cache)
+void quarantine_put(struct kmem_cache *cache, void *object)
 {
 	unsigned long flags;
 	struct qlist_head *q;
 	struct qlist_head temp = QLIST_INIT;
+	struct kasan_free_meta *info = get_free_info(cache, object);
 
 	/*
 	 * Note: irq must be disabled until after we move the batch to the
-- 
2.29.1.341.ge80a0c044ae-goog

