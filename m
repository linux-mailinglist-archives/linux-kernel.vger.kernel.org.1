Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED20B2AE322
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731997AbgKJWUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbgKJWUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:20:33 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC05C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:20:32 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id y1so1868173wma.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=SMV12gvgXWyti1wWozncOBF2sC/NzCwG5tM1W9vYuH4=;
        b=B6QwfVBAz7pkQ6yN3GQqARn2ii4rZdYmih8xg6h0+kbT6exEYUg4pd4Iohk94eyM1c
         mfyXHR7Pxl38SAXC+UEdfwWOGQNZDQyHqw0WxKX+1aldC5Nh33y9y1wUbwjCW1D0yajz
         82APgf+BpR2WC3RpKvYiDkV8kFzJxpoXE7CFk42ZB+MpjTlBxJm0XvKG7IxF4CW0/YAU
         G5dkj7NUrzW4l90Z8ZrgBn308BRtQCP8KJTgZyqtc9ySrVSwXbVeMNlFKR3/b04gGUiT
         bClkE+hnLWgDfQGY229UlKDA4DC0pu/Iq0yDc0SmjQZcRbEmjzC5MnBcn/JR/TO1dWNI
         M5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SMV12gvgXWyti1wWozncOBF2sC/NzCwG5tM1W9vYuH4=;
        b=cvSbbpl4zAMSLedbwYtcU53l6KAwbhdv7W4El/a3bsrRDYN9+SknazYfMAnP7O7exf
         xkg7zix7Lju2ISXwVlmajoTRXEeTJxfFEulZ4YIU2FuShJMt7KNkMA3GWWzxwIpMTyEo
         lwpNAeyTqXvPQL/R9w9hBKShjo/wVvQfbRfhgs0zVVLhfAJ+74f6eBJbf/sWDmcK4V0K
         5nz7OYnBT46gdtFh/dNn/GHF3oPH9D0VvrOfCi/ptlscfwRC4RitpbAS0oog3r+TwWBX
         I4S1TrXM09uWjUGB3fpRJJzX3lKNjEOFklUTRpr1wBjJuQKGE+siIPS9RMo1fJVQ+l9B
         mFUA==
X-Gm-Message-State: AOAM531FbK5M4oVTXGvTAxVLS9KxM/GKjJrh0LDbEGGzqNPIj0p60BWi
        +fg2055SL42puIxl43tPSmiDzXBsAQxVy8QQ
X-Google-Smtp-Source: ABdhPJxOgxlfhZQUpHjQ0Geh6GQq8dMdva8blwAYkX9VCtBB6RV5i3/j12u3n9DxhI2tM3WRQFA2yXCA2IHyyaf/
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:5f45:: with SMTP id
 t66mr315013wmb.20.1605046831528; Tue, 10 Nov 2020 14:20:31 -0800 (PST)
Date:   Tue, 10 Nov 2020 23:20:05 +0100
In-Reply-To: <cover.1605046662.git.andreyknvl@google.com>
Message-Id: <d7182392511522e5b3ab7b0c1c0933b4f5963ce0.1605046662.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605046662.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v2 01/20] kasan: simplify quarantine_put call site
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
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
index 21fe75c66f26..c2c40ec1544d 100644
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
2.29.2.222.g5d2a92d10f8-goog

