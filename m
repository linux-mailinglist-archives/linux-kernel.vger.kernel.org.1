Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D84295FA9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 15:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899505AbgJVNT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 09:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2899491AbgJVNT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:19:27 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8E8C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:19:27 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id b12so1017759qte.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=QY0XewM9lnHnRQ+vj0Qh7qias3TYU7mjlYARUV896zo=;
        b=OYz3Uex6U9uSOKmG8dnKe2ZRNBbSFCOO8PB9YiKoIPfAkmOkaw/6ymyo6N2z4rUFFK
         QA/R6DztoEC8wcxd06AE0Bius4X7c/Ftvt6G9p3wKYZS1veVqtDD5iASXy1APigHL3J+
         iPYndXoTAgZ7G0g9rm5x9X9FjjfHxmypYlCQgRWErKC2QsF4LajQvOpb31KROOxQ41WK
         OYSFJLOpnhezmpsxyXoOE3KHS48ZEHk9c7FwIQOhHgIDWkyrWkB/S2CxHxacU7GXXy4H
         eD8PMg20cN4OPU93jp7Ur6QA+fOJK9FhytxSh8Jgir/r5sXgfQjHEY6bgN2JrU1G71to
         2UhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QY0XewM9lnHnRQ+vj0Qh7qias3TYU7mjlYARUV896zo=;
        b=cUAIU+LtH+tmwFemtnZRkjpfDSr7Kq5X7ypzBv8pBvP9dGaFU7kyqDVvv3EmyESA7z
         5kjokMSQgU0mm9EkneMSDuKRYQ4ZmZzuJCZT4ED9pidh4sjtUEjSUvvrlmgu/Z18yZrH
         aR7s7Y1FaF9nXa61Ctm37iLlN6wDNeQHbac1DCLg3Iyn9yX2WvzX+4jTgUAt4nroisnG
         fSNjGHT/9PnbPaffn4enSW+Tz0rMCU/Yad9d0stf6g5sjQ+3MsuAq1u8HzvEC5OeJI47
         EqvfKOZVm2qp7dK0AnMhY/szgMoVtxnlfv+BEIZw1WbBLxqi6hfQ84fKkD6yPnrwf8gv
         DCsQ==
X-Gm-Message-State: AOAM530vRWQZifoChGquj6QLj2ApchMDwnUK88njQX7DkjIL7s1YW5SD
        6UfXDBYJpfegtfglm7QTaVjBso5dxrObKEfU
X-Google-Smtp-Source: ABdhPJzQTsBQkJYG3rzMWRXjnKCNjmWERG4WSqKuEEUo0foPivBFc3WoUPPsrk/pqQdQ+K1+Kgc5n7k8hKkkenUW
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:6214:184c:: with SMTP id
 d12mr2385924qvy.11.1603372766736; Thu, 22 Oct 2020 06:19:26 -0700 (PDT)
Date:   Thu, 22 Oct 2020 15:18:53 +0200
In-Reply-To: <cover.1603372719.git.andreyknvl@google.com>
Message-Id: <eaeb053a84e82badf1ade6cf7f9caf6737fcd229.1603372719.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH RFC v2 01/21] kasan: simplify quarantine_put call site
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Serban Constantinescu <serbanc@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
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
index 6850308c798a..5c0116c70579 100644
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
2.29.0.rc1.297.gfa9743e501-goog

