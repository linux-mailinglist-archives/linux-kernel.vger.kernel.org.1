Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36CB126AFAB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 23:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbgIOVhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 17:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbgIOV2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 17:28:09 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2991CC06178C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:16:58 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id p20so233078wmg.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=NFU27GtWbL95WCt8F/LRedzvWo/LtApbnjc66sNmtks=;
        b=LidLdQlyti52eZWrhFHwUDuJizCaKRW6hyaJQDPEh27JNL1d+0SqlmcdF2NYGQzQTj
         8OmpJEhJfeBEK+B+bvCO4r45A6t+VdFYb/W5Yl9uh3fbjCL1YPof98V406NWsKQbngiv
         fcL/GZ7KtxfdSHcYClU5y8Hdw2j+sPyP8HmJq/MYUC9y1HZTu7MT4ivkE1G5+ln/A2ir
         2LMRHdmZxtC2INIfJmAdFUjD5w1Yw+zYrZAZXUuxQcB6fjznILZzEieeiixnMw+S8F/l
         DP5W0iRnd5/4Sjl8Ye0p4BbDkF9pmZ48GHG7sBUL+6Bdz7/AFgNBjuMWvzR3goJmJgl+
         buwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NFU27GtWbL95WCt8F/LRedzvWo/LtApbnjc66sNmtks=;
        b=MI/RyXLekTwbUTIJrJRpu3Akxw3nc06ssTDPvnlkYv3vOFkhcV66oJOOB/+0LY75V8
         JWAx1jPwzdZOW73tu9l5w+rKoBzsPZx3O3l0b38uEo1PcasnorUneh9aC2mDguU9pPXR
         j+Czj0NKf/XziSkOCDhihMd/N9ZJvGaHAvrxnjj32ly2rUGQ3zPc6c1uljfbe97VLqDO
         3zvxdztviKE3w5ek7yuAhSaB54GeKNi5t5m6RbC9n/bulNMWZY4KOMMb1NxwLMsl4SPv
         SDXr4Gt+2SC7fJO09dDcu534dtO/dZX1m9JoQR/bI4yrdNsNjBlum7PqTSgLJ6eA4W/h
         En0w==
X-Gm-Message-State: AOAM531/2scRQTZztnJhqBZOu9B0FBYGP5NtgcbgohF8gQULbT56sh7T
        nAFVu3MOk4zzLCi61tniVDJFWrG4AVW8+TeA
X-Google-Smtp-Source: ABdhPJymDPmDOkSNHrHOdoAiOAhuUVRheTqBJLYFZ0ONbNVc2apw1tqvXIMsxB8eYidBcUGd0R+qoYr0kPN/EPVS
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:adf:9c93:: with SMTP id
 d19mr23867458wre.275.1600204616832; Tue, 15 Sep 2020 14:16:56 -0700 (PDT)
Date:   Tue, 15 Sep 2020 23:15:56 +0200
In-Reply-To: <cover.1600204505.git.andreyknvl@google.com>
Message-Id: <b48d1be05f393b9148874115844625ab4a07ee8f.1600204505.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1600204505.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH v2 14/37] kasan: rename addr_has_shadow to addr_has_metadata
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev@googlegroups.com
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
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
---
Change-Id: I03706fe34b38da7860c39aa0968e00001a7d1873
---
 mm/kasan/kasan.h          | 2 +-
 mm/kasan/report.c         | 6 +++---
 mm/kasan/report_generic.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 15cf3e0018ae..38fa4c202e9a 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -145,7 +145,7 @@ static inline const void *kasan_shadow_to_mem(const void *shadow_addr)
 		<< KASAN_SHADOW_SCALE_SHIFT);
 }
 
-static inline bool addr_has_shadow(const void *addr)
+static inline bool addr_has_metadata(const void *addr)
 {
 	return (addr >= kasan_shadow_to_mem((void *)KASAN_SHADOW_START));
 }
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 8463e35b489f..ada3cfb43764 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -334,7 +334,7 @@ static void __kasan_report(unsigned long addr, size_t size, bool is_write,
 	untagged_addr = reset_tag(tagged_addr);
 
 	info.access_addr = tagged_addr;
-	if (addr_has_shadow(untagged_addr))
+	if (addr_has_metadata(untagged_addr))
 		info.first_bad_addr = find_first_bad_addr(tagged_addr, size);
 	else
 		info.first_bad_addr = untagged_addr;
@@ -345,11 +345,11 @@ static void __kasan_report(unsigned long addr, size_t size, bool is_write,
 	start_report(&flags);
 
 	print_error_description(&info);
-	if (addr_has_shadow(untagged_addr))
+	if (addr_has_metadata(untagged_addr))
 		print_tags(get_tag(tagged_addr), info.first_bad_addr);
 	pr_err("\n");
 
-	if (addr_has_shadow(untagged_addr)) {
+	if (addr_has_metadata(untagged_addr)) {
 		print_address_description(untagged_addr, get_tag(tagged_addr));
 		pr_err("\n");
 		print_shadow_for_address(info.first_bad_addr);
diff --git a/mm/kasan/report_generic.c b/mm/kasan/report_generic.c
index 427f4ac80cca..29d30fae9421 100644
--- a/mm/kasan/report_generic.c
+++ b/mm/kasan/report_generic.c
@@ -122,7 +122,7 @@ const char *get_bug_type(struct kasan_access_info *info)
 	if (info->access_addr + info->access_size < info->access_addr)
 		return "out-of-bounds";
 
-	if (addr_has_shadow(info->access_addr))
+	if (addr_has_metadata(info->access_addr))
 		return get_shadow_bug_type(info);
 	return get_wild_bug_type(info);
 }
-- 
2.28.0.618.gf4bc123cb7-goog

