Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68BEC28C33F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 22:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731552AbgJLUrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 16:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgJLUpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 16:45:54 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24C1C0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 13:45:53 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id k14so9098767wrd.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 13:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=HoLd9axH/k8QQMpteaotxwKQuIlysE8DbXq7dK1Bu7s=;
        b=XY3o8GYcVeXTWJxSYYcN4Tq0Qf6Dd4npKRj6tPkEfKejjRbkBXsH9dNK2QKkbNfSAP
         3wGO1VWMBhaRsZ0pALaWHCnbCA/93SIzJPuFN0+Avvz00Owwu9GNbzAf9SLPpQX0yuNn
         urbEXjcvana0wWM/s+yU+ZkNa4f3DyBSqCHrBlwiDZcc0YKWyOdwoIyckOzdKJbY5ByM
         AFfAKk8sKgzzUI1SRnOqljsyd8d/NXAAfeJ8vsoBwdW7zzIforlmjFN1APpMhG6JuKg1
         vUwy1nWtaID5P1gswqnxgwTYgMHlw1RQ1f9b4U++iLRs7O7gQjwI6vPgmUE1tA5AFapH
         ghDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HoLd9axH/k8QQMpteaotxwKQuIlysE8DbXq7dK1Bu7s=;
        b=baUZ5LwITdC47C7ZJrODSpGHcg6CB3cyybuvNaWrYjEi+1cOZCn2hvS9FGcrddU7U8
         GHSqbOi8LWcDVt5J1cB9/Nr699eFpAuDeWO+0Zp4rCwdFKRfkT/yYfQivQagokffWz4v
         UczFVBgmaKeaBUU2RDcL6ezhXarNjp2VS23X7RT9wtsvbxHICCgAxQPVit+IDIHHW5+R
         FJmUxSoQYGZJVC0/nRokHROFqOvL2lUvXt0Z9+TX3RpoxvsLxRFgKN9+PO4QgrYvul4p
         GkeHpO15HemmGyTXyvWjwnLh89MWKLiAhNTs4gsm8wS+mAwXQ/Rh+jPvGVzRbNmbM0bL
         90fg==
X-Gm-Message-State: AOAM531TWENWlQJKPsi8E1fhmIPcVVhnmmhF7oHHVMD6H0sH0/0ZJNYh
        6hPT344NHwVx4g4V0dzbDHmxtPpbOhLQFlNk
X-Google-Smtp-Source: ABdhPJw2nSU3hWlZtLeQVa82TF5eU/yQ0RYpKi0b/RntwI/o/Z+SH09IR4jADBKzL1OGj1qsky0/sraUZlTxC5Ku
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:6488:: with SMTP id
 y130mr12073548wmb.94.1602535552445; Mon, 12 Oct 2020 13:45:52 -0700 (PDT)
Date:   Mon, 12 Oct 2020 22:44:31 +0200
In-Reply-To: <cover.1602535397.git.andreyknvl@google.com>
Message-Id: <21b75a558884793bd6fe13dc1e0a263381b2cf82.1602535397.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1602535397.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v5 25/40] kasan: rename addr_has_shadow to addr_has_metadata
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
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
---
Change-Id: I03706fe34b38da7860c39aa0968e00001a7d1873
---
 mm/kasan/kasan.h          | 2 +-
 mm/kasan/report.c         | 6 +++---
 mm/kasan/report_generic.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 5a69472eb132..420638225c13 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -146,7 +146,7 @@ static inline const void *kasan_shadow_to_mem(const void *shadow_addr)
 		<< KASAN_SHADOW_SCALE_SHIFT);
 }
 
-static inline bool addr_has_shadow(const void *addr)
+static inline bool addr_has_metadata(const void *addr)
 {
 	return (addr >= kasan_shadow_to_mem((void *)KASAN_SHADOW_START));
 }
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 91b869673148..145b966f8f4d 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -329,7 +329,7 @@ static void __kasan_report(unsigned long addr, size_t size, bool is_write,
 	untagged_addr = reset_tag(tagged_addr);
 
 	info.access_addr = tagged_addr;
-	if (addr_has_shadow(untagged_addr))
+	if (addr_has_metadata(untagged_addr))
 		info.first_bad_addr = find_first_bad_addr(tagged_addr, size);
 	else
 		info.first_bad_addr = untagged_addr;
@@ -340,11 +340,11 @@ static void __kasan_report(unsigned long addr, size_t size, bool is_write,
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
index 42b2b5791733..ff067071cd28 100644
--- a/mm/kasan/report_generic.c
+++ b/mm/kasan/report_generic.c
@@ -117,7 +117,7 @@ const char *get_bug_type(struct kasan_access_info *info)
 	if (info->access_addr + info->access_size < info->access_addr)
 		return "out-of-bounds";
 
-	if (addr_has_shadow(info->access_addr))
+	if (addr_has_metadata(info->access_addr))
 		return get_shadow_bug_type(info);
 	return get_wild_bug_type(info);
 }
-- 
2.28.0.1011.ga647a8990f-goog

