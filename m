Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3192A7391
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 01:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387622AbgKEADK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 19:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387443AbgKEADI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 19:03:08 -0500
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68D0C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 16:03:07 -0800 (PST)
Received: by mail-ed1-x549.google.com with SMTP id b16so60909edn.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 16:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=BMZ/M+WrZmZXK8ABsLpLLUMO5suYjkxoKy6+yIMHKNI=;
        b=U8jhak8MkkwTo4VVA2S4aMMc3rysJoG7VHeplDyb4fXuf1THbqycXNlTuCEhZq1ndK
         AhCyWSIEEOYjSrqyLHpxcdGv3yzV87WfK1+ghuNzSnULiKfdJVOxe6sUUQd7sxT+81Pm
         6XhrLx6kwXsOktWPr/cM0ZinyJvTm5jvezSnFF3iKwjECgARv++K8S8XZ4/9MBv984h3
         M3fq09VNCB+Bg+9rcUoAMcvxXA54/qhwAgrNEF7lkW3u5fOaa5RoV0kgdWx3fxww+s6M
         Ria7FGAAeatBPhxai7ZCgPgRfE1vFFHs7XGihw6Ux0UtxsTqIWhVPGuecdGyuf1tCe/W
         JiOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BMZ/M+WrZmZXK8ABsLpLLUMO5suYjkxoKy6+yIMHKNI=;
        b=ryDzxssjqk9C5Z1B5Y+/ORy/dh7RUseUXlUsKZspAzbQGzQdvGDr/foo38WVK98dOb
         sxU6mGEDC3xIbS6zL9czefPuVybnt3A4DDdIsl2aEqYDp3ahs9RkUtuoEUqfKdPiNS8u
         ISWSkVSxcW//O19tFLkuGTjv6cpAohy6ETcde3Eo6McjHBF7vU7r4Ll1RAaiT0SUVdja
         V3kDk/dlRv+sy/GZHfw48a8OyJB5R4n4ZbO2gDcc7IHDQImNC4DQziDk2askQCLZB163
         JUjf/i8+RVXbBl+Hq074A/B3o08HwuajNGYsPmfpKmdMFNcVDfeMozaEgnPFXHHgFCVR
         0FCQ==
X-Gm-Message-State: AOAM532f9wyc7MN40pEXjYanci27nLsMz1ylb/B+zWTi7iwjZMMpEpbg
        m4bTWFEHZSAbS3s9tSKlGmhHiunnNZq1NWqy
X-Google-Smtp-Source: ABdhPJweTaJkd6b3wl4vljsjzSaHEeYVHgfBL2uu8wiqY4d4DlmNQcw7W5IBJIWQpkZx+af/OCfJ+MPWnW+0Gr4h
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a17:906:134e:: with SMTP id
 x14mr575217ejb.173.1604534586349; Wed, 04 Nov 2020 16:03:06 -0800 (PST)
Date:   Thu,  5 Nov 2020 01:02:23 +0100
In-Reply-To: <cover.1604534322.git.andreyknvl@google.com>
Message-Id: <d21347b0bdbae6f0afe95b5015fcf9ea8aefb64c.1604534322.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604534322.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH 13/20] kasan: simplify kasan_poison_kfree
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

kasan_poison_kfree() is currently only called for mempool allocations
that are backed by either kmem_cache_alloc() or kmalloc(). Therefore, the
page passed to kasan_poison_kfree() is always PageSlab() and there's no
need to do the check. Remove it.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Link: https://linux-review.googlesource.com/id/If31f88726745da8744c6bea96fb32584e6c2778c
---
 mm/kasan/common.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 385863eaec2c..819403548f2e 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -432,16 +432,7 @@ void __kasan_poison_kfree(void *ptr, unsigned long ip)
 	struct page *page;
 
 	page = virt_to_head_page(ptr);
-
-	if (unlikely(!PageSlab(page))) {
-		if (ptr != page_address(page)) {
-			kasan_report_invalid_free(ptr, ip);
-			return;
-		}
-		kasan_poison_memory(ptr, page_size(page), KASAN_FREE_PAGE);
-	} else {
-		____kasan_slab_free(page->slab_cache, ptr, ip, false);
-	}
+	____kasan_slab_free(page->slab_cache, ptr, ip, false);
 }
 
 void __kasan_kfree_large(void *ptr, unsigned long ip)
-- 
2.29.1.341.ge80a0c044ae-goog

