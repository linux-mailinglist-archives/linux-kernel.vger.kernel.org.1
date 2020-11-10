Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 107E02AE32B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732020AbgKJWUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732087AbgKJWUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:20:38 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2DDC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:20:37 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id r16so6159342wrw.22
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=gNopVjIT8PLD1roCXuMREiwLLvujReoC9+pcOjj05mE=;
        b=lCftT4m06a6889qXGQTef3H4ubHV8kKj9dGlz5f67eoPKWdz/PHnNnYEjABMQLk8d9
         KObCel4cnvyGAfTLT3glV7CaPrDc0oVmARZammV+1pVoZ/2jSlMDKbk5t8ghqy2BrnAQ
         6wiA3BXXhqVlgixBVMEYRnob8fIiyC/M+a6xp4u0aNMUCSSJaunS7d4ecvp+s9fgBTTl
         ILcUALwdqyXB6pkQZeuRw2BZ9ehON8RQWBZCFPbVG5/Tjjcf9C/MjxhSUXZvdV4Wx2sm
         tXxLD2ziia9ZukMCBDzC8zBSj5kuUeYjuML+1LS3YfaqORZ/tW8RY/g6NyBPCfrCuo0E
         RgsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gNopVjIT8PLD1roCXuMREiwLLvujReoC9+pcOjj05mE=;
        b=LKc3j2I8i5rYmCxotRLTRATaE5TjJZOvgEU+OByLKal27e3msMCRZFUn8KbikArAcu
         CIlSRyfB4fZdtLeUEsnpvs9V7I1p52IMNtE31pxZj4UooWxXR5AbZn2nxC8hLfM67YHT
         oIyiebZ8FnkC1KbCKHck44dOiGxoa8uYecH2m/ILXUuBjRaFw8+ttoG29dmaBTFfPW7L
         WYmn8VZ4xPdjS1BNimkE89TSLSXnpDLg/O/cEt/iIVwRIHyDKyYTokGOIkpwV5W0S4t8
         +7/YJK4mcyr63NsJ8upNqvvgz2s0saDu7L48k++tI0o5ANa6coteh+oJ7NgQxBWlhwj6
         jV5w==
X-Gm-Message-State: AOAM530Iv5fWnbLU6zmkYxTX6dm54mNfUmaUP9ihG46XhdDpjwg/jMS6
        QJ5dpSN8/42LTGMnP+n/CdpJG+KtBeAB8cVm
X-Google-Smtp-Source: ABdhPJywHqOrMb83vobFQz6uQH+1U+IiE7bFzlSvWOmiu58rv8s7DM6ShUb7PXTFUABDWl/FwVrflkCpjtBdifZz
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:3803:: with SMTP id
 f3mr304885wma.14.1605046836014; Tue, 10 Nov 2020 14:20:36 -0800 (PST)
Date:   Tue, 10 Nov 2020 23:20:07 +0100
In-Reply-To: <cover.1605046662.git.andreyknvl@google.com>
Message-Id: <5302e6d48429465259bd0868a7dc357290a2e8a5.1605046662.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605046662.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v2 03/20] kasan: introduce set_alloc_info
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

Add set_alloc_info() helper and move kasan_set_track() into it. This will
simplify the code for one of the upcoming changes.

No functional changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
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
2.29.2.222.g5d2a92d10f8-goog

