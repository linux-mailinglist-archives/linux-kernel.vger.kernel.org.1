Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E67E28E7F8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 22:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388015AbgJNUos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 16:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387427AbgJNUor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 16:44:47 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93444C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 13:44:47 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id es11so303310qvb.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 13:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=CjGwVkjALHWoxnEpXUV5lg0pURyX1Lwjm/IxKYecvEk=;
        b=EBGrD6RN6xliNU79AWfmLo4aIDWh5aG3DjFXT7Waz6MK39WO/qU2QVR37uIkOel0tB
         cN48b+GW2inj2ip2t4+zE3AIkYKWxMgEHGr3qGt+grT8H8/Y2EWjYQxWAD2oXhQCFmNh
         PlYeiBPPS9e0yVQHBR9HqgahZtloF9KNLBICgjCL1pkgbhhwwmF+xwiZg27iJbeeEFYa
         yfq/yPLL003ZMrPNucEYvSiLFxctu0jqT7e9juN8tPhII9usBsXGfhzX/nvEp5dgmuf9
         5DreMenxc/NfqbdxjxRzGYuXFlLPlKcp9EjLKimG4q8Y2miP/H4LaWSNJS1LM4kyEwqu
         7ZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CjGwVkjALHWoxnEpXUV5lg0pURyX1Lwjm/IxKYecvEk=;
        b=qRGDJpOPvIWDS4XLKJIC3WhUueXBDibT0luRVkO/ZVFnvRO+203D4qQzJ/AiKRF0vL
         3/c6U21G6/BU0QWWKvbMh2tRIJgzxT0NHznjJDax4Ms0KtfugOvF5PD9woHGu1S17E6m
         1cg10ACwLz5CJhxuK0wBtmCCWAtgx/mDpJCpJATJEtHFPyIYgIYdLByhmfh2Kq/OMd0I
         2NBM6M/n+S2gtXAFJF5PS9tRKZqt3QWy1mxd2AaQvqt8GIGHZVFkfoeWi/6d9OlM5NX/
         +xTHTUc5ZqrryLy8Xozg2QnVzD1LjMwLci3r8IkUJFNNJ9xi5KV9JUwalPmkyJFKZgmp
         40QQ==
X-Gm-Message-State: AOAM531ux84FaXqTk9olunEHwg4SIjoiPRGwMZE2IU0SyLpBzVpPAelz
        7LYCRJ1qwMZwgKRyQpUa4iGikvqqeavmwstW
X-Google-Smtp-Source: ABdhPJyPS70k0bCBzAHZh7jQMEEFG1g2Nv/DzdUR14lOKVf0hYkMYkuYAvdtNuFtwtJnHpBjo+xyl45FSh1Jk4UO
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:5547:: with SMTP id
 v7mr1394100qvy.9.1602708286682; Wed, 14 Oct 2020 13:44:46 -0700 (PDT)
Date:   Wed, 14 Oct 2020 22:44:29 +0200
In-Reply-To: <cover.1602708025.git.andreyknvl@google.com>
Message-Id: <42f809a3f36e9ca5b62e6a5b13c90e664d6e2933.1602708025.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1602708025.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH RFC 1/8] kasan: simplify quarantine_put call
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
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
index 32ddb18541e3..a3bf60ceb5e1 100644
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
2.28.0.1011.ga647a8990f-goog

