Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 183FB2C1644
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 21:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731470AbgKWUPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 15:15:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731115AbgKWUO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 15:14:58 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC4CC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:14:56 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id i39so14498530qtb.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=X8He+i5DTpgfYKqVr7f46nksdkLo8KZ5P0WRCUmFYW8=;
        b=vE2RlTTzBzO5Gu2A4Wlttso8aG+Md8VyWf3JRDOc1Rk1bLUV819+D3mRFk8KL3kdCG
         eXUGqYHjERGJSQYpOySgTRgSxDqdgGaOMismdtSjBIQFp7VMipUQnz3fsflxJBsTgjmH
         NTkvIqSK2uP2oEw57s2L/OQz6kWSVTj1zYVffNLK8eHvX8vuv0hOk/6SCps9Wj1XwINP
         adkHqjEHjQsc17VN0LO03Evgdty940In8beiJqeKz0sawcA/v6PNFAx/exm7EBcnbW+R
         oqSoQUga4Kh5eizfSuq5arMaMeewWgBhiYoyf2DJQl0xvTuFK0f+3u+3d79cZRKSlWGJ
         CCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=X8He+i5DTpgfYKqVr7f46nksdkLo8KZ5P0WRCUmFYW8=;
        b=k3C+evT9vYUm2z6bhcBPYa4sfz6qcxZgr2lCWgVM5lyevIMo+IzZMGEBMbXb1GSQYt
         bmbPfselhMDCvDZfInIg5ULsNVdt0srAdBkQednV5jIaIOfWk0LmN54pfjk02USlhdcO
         sAxf9pmPnUSYf2Eus0w0MPVrEu3uuReEeQ/BOdcCddoZy+Pe7dBNU2kkFKfwWWUOopFD
         4qvA4GHmRrF/df++AcDUAizfR4uwOqrfjlqsYS3aWvgBfK6BovFylgO2z8BMHdv5CTCa
         KpvThuOnfkONH7YuE1vEC5cjv/UdNpRnFC+MmFfKyqRdFEKKzb6RB9M5sIEGRZMs1f8n
         QVcQ==
X-Gm-Message-State: AOAM532BhXhf5jeqAbeJqZm8fEFIckCjM+Wowg++tNUj6oB5N7omLneC
        7jic4UHaocPJfgM4v96tQkHy5M5ORRmY5DLQ
X-Google-Smtp-Source: ABdhPJwdwL1lWnof+uE3ypolP2P0M2AIXFB3wOTJiySzgHkkoCi1sbMWbkPHW5t6+b/xqQEPSNiAl3jFR3LB4TT+
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:eac4:: with SMTP id
 y4mr1134178qvp.19.1606162496039; Mon, 23 Nov 2020 12:14:56 -0800 (PST)
Date:   Mon, 23 Nov 2020 21:14:31 +0100
In-Reply-To: <cover.1606162397.git.andreyknvl@google.com>
Message-Id: <312d0a3ef92cc6dc4fa5452cbc1714f9393ca239.1606162397.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1606162397.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH mm v4 01/19] kasan: simplify quarantine_put call site
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

Move get_free_info() call into quarantine_put() to simplify the call site.

No functional changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Reviewed-by: Marco Elver <elver@google.com>
Link: https://linux-review.googlesource.com/id/Iab0f04e7ebf8d83247024b7190c67c3c34c7940f
---
 mm/kasan/common.c     | 2 +-
 mm/kasan/kasan.h      | 5 ++---
 mm/kasan/quarantine.c | 3 ++-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 998aede4d172..e11fac2ee30c 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -317,7 +317,7 @@ static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
 
 	kasan_set_free_info(cache, object, tag);
 
-	quarantine_put(get_free_info(cache, object), cache);
+	quarantine_put(cache, object);
 
 	return IS_ENABLED(CONFIG_KASAN_GENERIC);
 }
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 64560cc71191..13c511e85d5f 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -216,12 +216,11 @@ struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
 
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
2.29.2.454.gaff20da3a2-goog

