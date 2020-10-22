Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE14295FCC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 15:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899763AbgJVNU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 09:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2899698AbgJVNUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:20:12 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B6FC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:20:11 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id b6so609584wrn.17
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=YuCr19yY32x7rWFAvs+3N7JOh1jAyp/iY7KfCFpXvOQ=;
        b=ChsOlRrZcpMoNGFYVgPoeVQg4Og5D+L7BbXiRVwpiZdViVq24qE3ZXqD3tQKH1FVJ7
         HPd8FiV4pgtZUpYsxjl4hjAI/chk6N6P7ZOwFJUSMDGqaZlGN3Hx2rCtgiR2Spdsr11A
         3RijHVED0ZEakIzCCu8/+3wIW9zFSUQ1BdGEpmQt/saJo1CR2tEUDMT1zxXdSJBvnLiS
         5+2dw/bqnsJNllMA9jtkCYiE9XPytCZ2yg+rSNEse1oRsbObLdRtoFTJYWV+BND/RPsk
         pbKBGe+3Ar4H6vvSgqCb8RcHo/nToy4mNwHFBvnAXbW5hdwoTVk4JYy0UyQMOuTBOAbB
         3krg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YuCr19yY32x7rWFAvs+3N7JOh1jAyp/iY7KfCFpXvOQ=;
        b=lXKLwUKJYT/FDjNmyes6VJylsW87iE/XCQbTstSDa9Geo+ihonjaxTcSXAZ0MkefOy
         xYwTyP8/t224WW4g5QbjpOcWK1BUaSqPig4m5XM0cjShcmdjDCjTS1pErli7aObj4dzf
         DDJubLTPIbED0rj5nzGyY8b9/mt/nsSYa2QJh+8EHvEAH9536YvzVQfMjsc9QCJsXXqy
         diYJk8n0HKaGVYQxDsuvdVOZ/ZwdKZ7NXp4qfsdreBXqiur5enjfUN5VM4H3Br7ZtE5f
         ILQcAYiS+GS+gwM2SqiaJa/nMx1kTLOnHrXloFqczkamjEdIfBDSItktvcJlanWNuE7v
         d1eQ==
X-Gm-Message-State: AOAM531mTawZZkbTbqKqRkbgXR0RPjcJSqrGFdSvVDOpt9PBs6VIxBxy
        xppvin5GlTlri6NDRE85QyvYqcSRdHxLqdZX
X-Google-Smtp-Source: ABdhPJwWNBYBHEv7lNZy893nJ+RAAVNZlsa6c03VHyI91VlaLfFFNpC5caS3U7BZ/Z95iIq4PIHypm2N0XWIka41
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a7b:c04a:: with SMTP id
 u10mr2667777wmc.83.1603372809904; Thu, 22 Oct 2020 06:20:09 -0700 (PDT)
Date:   Thu, 22 Oct 2020 15:19:11 +0200
In-Reply-To: <cover.1603372719.git.andreyknvl@google.com>
Message-Id: <f48f800933dacfc554d9094d864a01688abcbffd.1603372719.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH RFC v2 19/21] kasan: don't round_up too much
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

For tag-based mode kasan_poison_memory() already rounds up the size. Do
the same for software modes and remove round_up() from common code.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Link: https://linux-review.googlesource.com/id/Ib397128fac6eba874008662b4964d65352db4aa4
---
 mm/kasan/common.c | 8 ++------
 mm/kasan/shadow.c | 1 +
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 5622b0ec0907..983383ebe32a 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -215,9 +215,7 @@ void __kasan_unpoison_object_data(struct kmem_cache *cache, void *object)
 
 void __kasan_poison_object_data(struct kmem_cache *cache, void *object)
 {
-	kasan_poison_memory(object,
-			round_up(cache->object_size, KASAN_GRANULE_SIZE),
-			KASAN_KMALLOC_REDZONE);
+	kasan_poison_memory(object, cache->object_size, KASAN_KMALLOC_REDZONE);
 }
 
 /*
@@ -290,7 +288,6 @@ static bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
 {
 	u8 tag;
 	void *tagged_object;
-	unsigned long rounded_up_size;
 
 	tag = get_tag(object);
 	tagged_object = object;
@@ -311,8 +308,7 @@ static bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
 		return true;
 	}
 
-	rounded_up_size = round_up(cache->object_size, KASAN_GRANULE_SIZE);
-	kasan_poison_memory(object, rounded_up_size, KASAN_KMALLOC_FREE);
+	kasan_poison_memory(object, cache->object_size, KASAN_KMALLOC_FREE);
 
 	if (static_branch_unlikely(&kasan_stack)) {
 		if ((IS_ENABLED(CONFIG_KASAN_GENERIC) && !quarantine) ||
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index 616ac64c4a21..ab1d39c566b9 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -82,6 +82,7 @@ void kasan_poison_memory(const void *address, size_t size, u8 value)
 	 * addresses to this function.
 	 */
 	address = reset_tag(address);
+	size = round_up(size, KASAN_GRANULE_SIZE);
 
 	shadow_start = kasan_mem_to_shadow(address);
 	shadow_end = kasan_mem_to_shadow(address + size);
-- 
2.29.0.rc1.297.gfa9743e501-goog

