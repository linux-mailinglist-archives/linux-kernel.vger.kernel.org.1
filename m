Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931AD2B287A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgKMWWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgKMWUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:20:20 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3625C0617A6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:20:18 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id 14so4721218wmg.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=yJWxegPyzZmdx3tmzwd/mzW6YwRRuhTO52iQtSKYSdE=;
        b=sv8Z/Kpl8DPqS1Sq+9LSV8BzlnIXBEtlOFEuhbGnHPOXO55RZ0oPEEP5JKnN7fT+Ak
         fKVXOWxiDqG1juvq/4nEvVop/KyMwRKCDawX2Wcfc9QLjTsbEjqvJ47W3sld96b2x+Ku
         u4CNde58Ko+XriUl+s1iPD2ydInydYVLqXLRBCG2enfSsNWyw21fJAJrOdEDsYO2Z8HX
         hR3X4h0AllRSuOJUSwRLDw1SY8aOm1MsvLgNxcz27AOTj51eguTLz0FmMKiIK5CCEf+t
         gYZjbtRgH58KjocgQo0Ok1aEKIWTwfTFJND37dE2bp/Fxk5hMPsf96NpO4P7Pkn2t4Xo
         V2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yJWxegPyzZmdx3tmzwd/mzW6YwRRuhTO52iQtSKYSdE=;
        b=CQ57PLELIj41r5oUOe4eptxCUT1LBtXGBZ4aHNTPX4MNJpLpT5GklUVpejS9xVo8zX
         GPjuTTO3rUDUJ8KHIgM18ZzuHyW5jTVKRGiLkIdiyQp0P8Mf2zMfH6pdEvfmpAwMYrCn
         agVgDXlplP4CzrthjNhvvlm5dXyH5I8HA5sBSsjg0ouBCp2HhTubh5TYgn4MXxpTFXi0
         n/LmNdMgVw8mSJGtWEMnqwaNBgKLI7MRa1eH1lQzPMS6k2OmZu2WJSOahn/PQIb2VZi8
         8ow3sEOqc/uqfuFFNzLdEaHCI8UxiO0YVYoB07DV9TpIu44Vj7JPU2swXgJFUPt+S4k/
         k2NA==
X-Gm-Message-State: AOAM5339XNFMyXOi7t+IXliZaOY0Zl1qtwx0vyenF8KSwgiiqHMQeP+3
        ai4htCbKsrPiSisc337NTLZldLWtZF/GckS7
X-Google-Smtp-Source: ABdhPJztvZOjYQgEdQq2vWkh9fZERHuoYj0nV+zcLr3AnX/+IEHgi9Qpjls1gxC875+5jFe6XwSJ/NKXDEkUQdd4
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:658b:: with SMTP id
 z133mr4378653wmb.1.1605306017372; Fri, 13 Nov 2020 14:20:17 -0800 (PST)
Date:   Fri, 13 Nov 2020 23:19:51 +0100
In-Reply-To: <cover.1605305978.git.andreyknvl@google.com>
Message-Id: <0eeeec8ecbf877e526ea43808e40e9062550217b.1605305978.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605305978.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH mm v3 01/19] kasan: simplify quarantine_put call site
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
2.29.2.299.gdc1121823c-goog

