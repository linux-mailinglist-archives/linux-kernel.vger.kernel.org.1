Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A89F12AE33E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732667AbgKJWVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732589AbgKJWVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:21:06 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3575FC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:21:06 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id a19so1147789wmb.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=pq+zpW/Hw4XDGIR7N3eqf6sjflzq5qp4Op5FmJmOOa8=;
        b=uANlXR3CSpy0OVPmNQ73PxY92qov20UVaMIwXUyPX+fAIprSkZe9uSPL4bQVMEC/m/
         t6wBvgClC8i+jwTY287EzT22FDgFPZZShu17Fwwgr+vWpgadpDkWYTs9vdSp0HV+9VZq
         Kx+M2yf4bagD7qpj2zf7ge0r5Zz+1FN0ycJy5Vu0t8QfpOdv9cijYOOLD8Vq/+Peju7k
         u3843665kwiM52RAxyenrbPXVhQuJ48TUwhSG4+Wo05tfFV9dEDRxFmFk0olCq4CS7+H
         zj5ZcfrDTG76qZOUCtww5kQJxsH6bWa0hEpqDIpxqTvvTx3BnIhmBpX9ELGPzultfHVR
         wsDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pq+zpW/Hw4XDGIR7N3eqf6sjflzq5qp4Op5FmJmOOa8=;
        b=oBZxeECv4lXPeg5dvgD23pXPHtDrRqKYaDybQs/eGmIHeTDKNXksPcRva4EFPFpnRn
         NgmUBToiGpFl3nq1CpsueKOMHbuHDnj8CHTUnG8Z1gPxIhOEwx98tDK+YrRnsv6XVtwe
         Glc/+9o4Pw5FPXYL0k0vChNOUhRMxoclB+sd5pA3Qh2L6hF28UJMCep/iY2X4lQbs86U
         nWSD+GKvyi/cBaQ6kzsnPo/fVF7QAAw9lNahDAsN/uFyLLdRBtXfXDhtXF/35dV+FzmE
         ACa+T+bwhugZ2mdRdG+pc5xbvyFxNIa42zvQQdsar2Pqxi3NKv6/NrKCV4+v85/qEtXP
         wcVg==
X-Gm-Message-State: AOAM530/zjpR23OQ6nVgHejOY9zwCIgX1rjP54giRHKBG/UlN1+nMoPM
        KsoC2GHaQ74YTTgrDNsU86mmFNVx+e507GTW
X-Google-Smtp-Source: ABdhPJww9dm2MDRGqKJLg0tAFFPdHdF+3n5YlkqvRFYDl3KYCnu7Zb3EA2VEUW1wWZgN/7f9Jq+e6O9RKx82b94E
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:b387:: with SMTP id
 c129mr303876wmf.58.1605046864904; Tue, 10 Nov 2020 14:21:04 -0800 (PST)
Date:   Tue, 10 Nov 2020 23:20:19 +0100
In-Reply-To: <cover.1605046662.git.andreyknvl@google.com>
Message-Id: <b11824e1cb87c75c4def2b3ac592abb409cebf82.1605046662.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605046662.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v2 15/20] kasan: don't round_up too much
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
2.29.2.222.g5d2a92d10f8-goog

