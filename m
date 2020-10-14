Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C522728E800
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 22:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388732AbgJNUpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 16:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387427AbgJNUoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 16:44:54 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2123AC061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 13:44:53 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id v5so263212wrr.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 13:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=7WKioc0F5nnoW2jvJmr0weBuEa6v4Kil5DUIEGSTVOk=;
        b=muFweiHYXv+gMPyiT7uaX4jvJ8gMYxQNuNVjODMtNI+83vDFZNY3z3Sdo9dkBxqwTv
         WqASfkRC6TMYpMzpjQYzoQtMEq+VZywMgWgOiqnq9m6RQ+HUYsumU6RHIrwjE3r1JA0j
         Sxs4ghgEVN7T3SoeK7kekwozXLHlxEQFwCxZOmjk54vCGBxvmNeKovY4ynv8YUNyLV8E
         UFhCfwVM+rE73rLDZU4u6Y4eHKTDVxfEsnlgRKoROhKzVG46wfNB7AdVuToujWAXZPl0
         Eb3guWfpP2vQjirwfaWM/u9aeyuMO7ofVIYP0C6/cRNkvYSe1U58GTGuNXwg8NzpS5YZ
         rDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7WKioc0F5nnoW2jvJmr0weBuEa6v4Kil5DUIEGSTVOk=;
        b=Bk/P3+88HLPBZOH0aPEDDj12hukJp2Lqj0uoBKrm4FoWB0rO2GdJrLtbvYQRIVCEx1
         u/uJVLPExkSA3wdaJPVrOLiplIUDnjEipkJUC08KgS1zo+nbMckW6XfOPI82LJtoIJmS
         iWeWCosZjQ9VR+6HkpeDMt5ijbvayMARH4VJa8cxbg0kzHugXCL7vY9mgvpUmS1mEC7Y
         x2v4oJN6g8IbA88Qq/+EWukdyKheUHZ3G3H/UlnOnJ1rbpm1+cmBy9/Zx4wMeEvaNGGc
         uxRDnC4ELM8R4C4pS+ozdu/4JMhmabdQrswDdiel3FS1H8p3bddOxOpHAhbCxQAVUA3B
         yO0Q==
X-Gm-Message-State: AOAM531q+uFUO1w0JbHLUREeNOE0Qr9NPTcrX1ppgWPZ8NAO3qSRfZGT
        DaeNiV5iRxQCUFx5szIDylRuRQilhl5BImnK
X-Google-Smtp-Source: ABdhPJxhKXKbXhJzKdYszjSgl90zyo0RlvRwLwrE/1dsncswUvyValSoS9m1K6XSomniP88/tEy1KuujP0ZSV800
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:35c7:: with SMTP id
 c190mr568356wma.7.1602708291670; Wed, 14 Oct 2020 13:44:51 -0700 (PDT)
Date:   Wed, 14 Oct 2020 22:44:31 +0200
In-Reply-To: <cover.1602708025.git.andreyknvl@google.com>
Message-Id: <407a7ff9d88cb484870507dbef6c5de833102556.1602708025.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1602708025.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH RFC 3/8] kasan: introduce set_alloc_info
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

Add set_alloc_info() helper and move kasan_set_track() into it. This will
simplify the code for one of the upcoming changes.

No functional changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Link: https://linux-review.googlesource.com/id/I0316193cbb4ecc9b87b7c2eee0dd79f8ec908c1a
---
 mm/kasan/common.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 8fd04415d8f4..a880e5a547ed 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -318,6 +318,11 @@ bool kasan_slab_free(struct kmem_cache *cache, void *object, unsigned long ip)
 	return __kasan_slab_free(cache, object, ip, true);
 }
 
+static void set_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
+{
+	kasan_set_track(&kasan_get_alloc_meta(cache, object)->alloc_track, flags);
+}
+
 static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
 				size_t size, gfp_t flags, bool keep_tag)
 {
@@ -345,7 +350,7 @@ static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
 		KASAN_KMALLOC_REDZONE);
 
 	if (cache->flags & SLAB_KASAN)
-		kasan_set_track(&kasan_get_alloc_meta(cache, object)->alloc_track, flags);
+		set_alloc_info(cache, (void *)object, flags);
 
 	return set_tag(object, tag);
 }
-- 
2.28.0.1011.ga647a8990f-goog

