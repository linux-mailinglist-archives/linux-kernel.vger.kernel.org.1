Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC512A7385
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 01:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387676AbgKEADO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 19:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387595AbgKEADM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 19:03:12 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F53DC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 16:03:12 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id t201so9429wmt.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 16:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=0USIvWPWD+0X5uGT95blxzhIaksN6b9CBpQaBzMOnSY=;
        b=sFpQqhhEG5gmFI9GQ8viL3pqjWr2ET4+vulUOd3uW9uXSre4REhA33qyv+t4dVSEU7
         w545R8LNs86kAkwY0TXSEvxLnddxzfkbaplqkm43YTr/brE+bJoOY+C2aatYwHPrKd8V
         lyF0Dk29ZIFpFIJ1Og+2xmXpbHGti9zQJ89WmkxMG1/0OCal1u616x08x92MgB7fVD/D
         G69WQShQeI4m/Swv42Hyjt3WeTnoKf7SUs6+1sXJtxjv/UHA5ZAhdSY1gHBAtl08c45b
         vDih+OYOVaIk+p10CXSYtIivWlmHY49fZ1jflJr3KJySxpjBR7RHRbYJf7/j6E5/VucA
         0Etg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0USIvWPWD+0X5uGT95blxzhIaksN6b9CBpQaBzMOnSY=;
        b=qYgk++TvLDpHke3MDO+Ke1lZwcB1X0ZxNghCe+wJPcA7vu1pgAD/B7hm4RFJ+OyWus
         /5b2++L1+uBoIxs7j48DeChDfOksCFzAohscTV1Ynr2N58H27u6WCpL03aaURkn642ft
         /Op+lnrf4QJBg9/CDyZSRfjDcJtDMUlExjYlwqeb/knqjUfay3LDc4bVfCt8c+cR3Zcp
         ePqsfwgX6R/Kp2lg0FL1m2FDRq7KI6/zIqUi6w4DD/4+Y+K9phjWeqIBwkeGEi9jxVCn
         RQrn6ra2KHEray4sVrzwa12XmkIi79bMms+ogfSX1t3TQX8I8V/vNYvzbkUJXee5Fynp
         XoJA==
X-Gm-Message-State: AOAM531ZoMQ7QoxwWP3cyyLVZvdao7v+ReU+3x03j4cErWcdOi+EN+xU
        uCuwtaWE8snQ4LcqVM4cJtUskausPYZWtlF5
X-Google-Smtp-Source: ABdhPJxw/lGpcSbzl86AC+uSuIK+hwvLKzT3r8ACA6Gr0SlWmsWXhA12+uWjp+hh9NvD3Cd9/idF6XWVIRZbxQIj
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a5d:4c4f:: with SMTP id
 n15mr475161wrt.137.1604534591024; Wed, 04 Nov 2020 16:03:11 -0800 (PST)
Date:   Thu,  5 Nov 2020 01:02:25 +0100
In-Reply-To: <cover.1604534322.git.andreyknvl@google.com>
Message-Id: <3a3e6dfe3ad355bb5ffc3cc34769cb97aec650d2.1604534322.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604534322.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH 15/20] kasan: don't round_up too much
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

For hardware tag-based mode kasan_poison_memory() already rounds up the
size. Do the same for software modes and remove round_up() from the common
code.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Link: https://linux-review.googlesource.com/id/Ib397128fac6eba874008662b4964d65352db4aa4
---
 mm/kasan/common.c | 8 ++------
 mm/kasan/shadow.c | 1 +
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 60793f8695a8..69ab880abacc 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -218,9 +218,7 @@ void __kasan_unpoison_object_data(struct kmem_cache *cache, void *object)
 
 void __kasan_poison_object_data(struct kmem_cache *cache, void *object)
 {
-	kasan_poison_memory(object,
-			round_up(cache->object_size, KASAN_GRANULE_SIZE),
-			KASAN_KMALLOC_REDZONE);
+	kasan_poison_memory(object, cache->object_size, KASAN_KMALLOC_REDZONE);
 }
 
 /*
@@ -293,7 +291,6 @@ static bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
 {
 	u8 tag;
 	void *tagged_object;
-	unsigned long rounded_up_size;
 
 	tag = get_tag(object);
 	tagged_object = object;
@@ -314,8 +311,7 @@ static bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
 		return true;
 	}
 
-	rounded_up_size = round_up(cache->object_size, KASAN_GRANULE_SIZE);
-	kasan_poison_memory(object, rounded_up_size, KASAN_KMALLOC_FREE);
+	kasan_poison_memory(object, cache->object_size, KASAN_KMALLOC_FREE);
 
 	if (!kasan_stack_collection_enabled())
 		return false;
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index 8e4fa9157a0b..3f64c9ecbcc0 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -82,6 +82,7 @@ void kasan_poison_memory(const void *address, size_t size, u8 value)
 	 * addresses to this function.
 	 */
 	address = kasan_reset_tag(address);
+	size = round_up(size, KASAN_GRANULE_SIZE);
 
 	shadow_start = kasan_mem_to_shadow(address);
 	shadow_end = kasan_mem_to_shadow(address + size);
-- 
2.29.1.341.ge80a0c044ae-goog

