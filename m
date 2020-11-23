Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D662C164F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 21:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387460AbgKWUPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 15:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731771AbgKWUP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 15:15:29 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1387AC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:15:28 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id y21so106628wma.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=FZtWTAUkAvRQTA+AtFREJR6Qo+0tQ7KPae8j2grwXDU=;
        b=K9aATwYZ9UoO7zi/mRajdIf64nFoB/xPUhE6qD8yIYqaNAhTqY64x7uB+K9m3QJ40A
         ytw4vCig7iAtvBjCXfs40hqcTLm7Odl0kKeDucZE+W5LxAe8giB5ELA+GiXmWkoyVfTR
         8VWXey3Y9t3qeFOVBmJkyXECHO8rV15eIPpddIiFLLU/qlDLV5HqtrwPJh0+UH2Ygph5
         Z6/bnnanhSfmK5redsl/WVUEpIGIXuFJacmnkiW+gJbrNQFApiGz7xK8SCrztmwn+Cvh
         vx+a8m9boaO+qlJC/KyajQBs38ioorzXUmsspg2Z4ytFIwtAzknXZ1YxVcYgrBWWv60L
         fiZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FZtWTAUkAvRQTA+AtFREJR6Qo+0tQ7KPae8j2grwXDU=;
        b=Mmb2wODT0ptb43v1VVYcnhd8AsD/qQEmHiIHmumeLBxCh8/bz0kw2w5OB/zxupt+/A
         7lnzmji0MDERWUPXRmT5tcXjFJBHbEWLjyJ0Wz2O/0TY3nkYKJjt5jtk+UdaqYu+cRV1
         i1GQefqaN/eyxWitK6W5rJg31PNaKLh83P/LPGP7yIpRDAQuc4OoARjGokB3H3t/NFKp
         7n+wYD8yIDeUUvo68tC8iWFiSoThI/aP8kHKzpy/qveYDCM9rIrDN4jP2FZPAEUHKp8p
         blWCBYR5WrvgKYpv56OETtjQdnVEO8MKrl+iYtz9iGmHDP7n/6tKAfwXzMXupy2rNHl6
         AmtA==
X-Gm-Message-State: AOAM532mmMkBb7uP71dpjBNx52llbDS79Nl0Sf47o+bEDdCBXAnTyO09
        qvt94LLsSrf8xsLgeJBmrTvCG7kPTxrteIsk
X-Google-Smtp-Source: ABdhPJx1M4yjerM84Av5uMxcUmZm/oWpySCuetBAnvpXA3hwdyiT7m0HNDW+S1RL2PjXZJhTMRp0/KP7cR2W8hs1
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:adf:ed02:: with SMTP id
 a2mr1480549wro.81.1606162526631; Mon, 23 Nov 2020 12:15:26 -0800 (PST)
Date:   Mon, 23 Nov 2020 21:14:44 +0100
In-Reply-To: <cover.1606162397.git.andreyknvl@google.com>
Message-Id: <47b232474f1f89dc072aeda0fa58daa6efade377.1606162397.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1606162397.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH mm v4 14/19] kasan: don't round_up too much
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

For hardware tag-based mode kasan_poison_memory() already rounds up the
size. Do the same for software modes and remove round_up() from the common
code.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Reviewed-by: Marco Elver <elver@google.com>
Link: https://linux-review.googlesource.com/id/Ib397128fac6eba874008662b4964d65352db4aa4
---
 mm/kasan/common.c | 8 ++------
 mm/kasan/shadow.c | 1 +
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 1205faac90bd..1a88e4005181 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -214,9 +214,7 @@ void __kasan_unpoison_object_data(struct kmem_cache *cache, void *object)
 
 void __kasan_poison_object_data(struct kmem_cache *cache, void *object)
 {
-	poison_range(object,
-			round_up(cache->object_size, KASAN_GRANULE_SIZE),
-			KASAN_KMALLOC_REDZONE);
+	poison_range(object, cache->object_size, KASAN_KMALLOC_REDZONE);
 }
 
 /*
@@ -289,7 +287,6 @@ static bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
 {
 	u8 tag;
 	void *tagged_object;
-	unsigned long rounded_up_size;
 
 	tag = get_tag(object);
 	tagged_object = object;
@@ -313,8 +310,7 @@ static bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
 		return true;
 	}
 
-	rounded_up_size = round_up(cache->object_size, KASAN_GRANULE_SIZE);
-	poison_range(object, rounded_up_size, KASAN_KMALLOC_FREE);
+	poison_range(object, cache->object_size, KASAN_KMALLOC_FREE);
 
 	if (!kasan_stack_collection_enabled())
 		return false;
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index 37153bd1c126..e9efe88f7679 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -83,6 +83,7 @@ void poison_range(const void *address, size_t size, u8 value)
 	 * addresses to this function.
 	 */
 	address = kasan_reset_tag(address);
+	size = round_up(size, KASAN_GRANULE_SIZE);
 
 	/* Skip KFENCE memory if called explicitly outside of sl*b. */
 	if (is_kfence_address(address))
-- 
2.29.2.454.gaff20da3a2-goog

