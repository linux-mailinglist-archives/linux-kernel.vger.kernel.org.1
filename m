Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE9B2B281D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgKMWRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgKMWRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:17:01 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65485C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:17:01 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id 60so432133qvb.15
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=nOCTDQ2//vgboByM6FE0MupdQKKhq84DcRt/L5d/bIU=;
        b=pUJ0TD71SNEkUOHJeTjjBfzEM8gR3vF6yLGkhb/LGE1RQ6XREtfpEFbvqyJTi6UhiP
         UtxslOoetmpW1a5g2b+sdhGhaBGp0RYD2+4IAOcdnDY6uN3SkwUTIkXDW+t3WLz4Zaun
         utzi3Mc8b1amh3TpprE8m/R82X/YaETzQ9STrGv5x3gYZJtTbOIpC+tBf6PX5OyNt8zm
         eNx1aZwyJce6efFgsvI5hKYK69bDVlM8ztK21jCQdg42tnVqB/lEdoZFYZtxh9szA6yH
         7EoqE3SP3D46FuEbksoyuKPqfbc+9axbWagrOF2Da/mpwWZFuwc1LG0QM8IzGx1zCJsA
         UWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nOCTDQ2//vgboByM6FE0MupdQKKhq84DcRt/L5d/bIU=;
        b=IyWiqTSZjrvZuWEKUUXBsYKV2PzORCqneXs+x5BciHsyFdAw3SpAZsbykUvCb4xV0n
         n2Ow87dU07qrhOi0XKdUllDsaJxHOX8knKThW+/m0XXqtW6UnbVOFjbGO13fDdMdoj5h
         5MTxl076XPByfg20d28/Nye2Pw+EMHKV6fVkC0Ri1mo8RcRFUz/ntfepIGOOQAZ44fHz
         WAHdty2PyYN8xAdHwiiCbvQsW61J5IYKUB5EoVtJ8bvl2Np0q6X5uwxERm+ZveSNr3vn
         3rkrTBroTa6u3pzMG+OMTw7tEP6JcEzq6u4kg3pPyNqpmKL2vDl84ktfKKpFplFXG27D
         B+7g==
X-Gm-Message-State: AOAM531UemXu57epXimJUFwKfk4muU+In9u3ueZ3Z055VeArVsLJXy2e
        6VqU00Qk0LzU7QrSLKS3OgedinI4EEUYDiPV
X-Google-Smtp-Source: ABdhPJwGq3taGnv+tMdZUqUhQYyJtlfq6IIl2c2wR89qSzm0PXGktkQLorogdBCr4tZLWF5palX037Ak2mx5t9Lv
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:c2ce:: with SMTP id
 c14mr4724618qvi.20.1605305820567; Fri, 13 Nov 2020 14:17:00 -0800 (PST)
Date:   Fri, 13 Nov 2020 23:15:47 +0100
In-Reply-To: <cover.1605305705.git.andreyknvl@google.com>
Message-Id: <4bc8a39b683988a2c672a0d99df12eee1e3c85cd.1605305705.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605305705.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH mm v10 19/42] kasan: rename print_shadow_for_address to print_memory_metadata
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

This is a preparatory commit for the upcoming addition of a new hardware
tag-based (MTE-based) KASAN mode.

Hardware tag-based KASAN won't be using shadow memory, but will reuse
this function. Rename "shadow" to implementation-neutral "metadata".

No functional changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
---
Change-Id: I18397dddbed6bc6d365ddcaf063a83948e1150a5
---
 mm/kasan/report.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 2990ca34abaf..5d5733831ad7 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -252,7 +252,7 @@ static int shadow_pointer_offset(const void *row, const void *shadow)
 		(shadow - row) / SHADOW_BYTES_PER_BLOCK + 1;
 }
 
-static void print_shadow_for_address(const void *addr)
+static void print_memory_metadata(const void *addr)
 {
 	int i;
 	const void *shadow = kasan_mem_to_shadow(addr);
@@ -338,7 +338,7 @@ void kasan_report_invalid_free(void *object, unsigned long ip)
 	pr_err("\n");
 	print_address_description(object, tag);
 	pr_err("\n");
-	print_shadow_for_address(object);
+	print_memory_metadata(object);
 	end_report(&flags);
 }
 
@@ -379,7 +379,7 @@ static void __kasan_report(unsigned long addr, size_t size, bool is_write,
 	if (addr_has_metadata(untagged_addr)) {
 		print_address_description(untagged_addr, get_tag(tagged_addr));
 		pr_err("\n");
-		print_shadow_for_address(info.first_bad_addr);
+		print_memory_metadata(info.first_bad_addr);
 	} else {
 		dump_stack();
 	}
-- 
2.29.2.299.gdc1121823c-goog

