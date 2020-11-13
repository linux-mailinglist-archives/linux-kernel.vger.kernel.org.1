Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A032C2B281F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgKMWRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgKMWRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:17:00 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C2EC0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:16:59 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id k128so4702676wme.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=yKCkBgNRmvI+VGlyeWsyI6UJ3UVry+X9WEXdpst8yJw=;
        b=gwWZ+UhQgwYktvhlG4qpSBtTFaMzJ7o4XlB5VEfUEE1f+1HjShk26V1631xYBFfdHO
         /td2rp4X3Bv6JmEbwASkafhRKUH6DosZ9i+MlQ71NyC91JqnRm2EOG330qQlw/ssKaP6
         f1Xg3Ub31XAjR2TvHFWoC88Zo3OQi7rDWXq0W29NlbSQ5Sf1PK7Ns/OYkyDHiNaGhobG
         lqEwe19V+E4X4XqVzZhn8HEtK03oEvgD0I+eV8w8Z3VNh+3da1QxZeWl+4yr2/XJS9kQ
         v1Nikq509qf7sQ7VAYVGOFRqpH6yFXdRxfxzeQezbWOunFNGQb2TmkLAqlwBQC5IEbnC
         ga3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yKCkBgNRmvI+VGlyeWsyI6UJ3UVry+X9WEXdpst8yJw=;
        b=GJO9jy8AXHgBQpdC32JaFP7FARUUoGaNmt4lVsWi93dmrIWpr1fDevTUAWEajb9Q0a
         LW7pW/iol0MiAllzsfyIyNDbLaXUUq6XsXbm/jBS+lE+0Z1kwX+7mgrdPvp0udkpZOjK
         QGaMylbjLuRNWEABdHhgys05M6DE2ZF2IxOy4HaKd/iJyYbcLYdMINkFnv9fIfosQhE1
         c4unBhcOjFj/OT6/RhjOCrifkyewDWsLSIxR7KxJIh7Ko6aDgT3Fa20J6MEnfuq9+Mzz
         KkNGDDOLXkl4o1IA1WKpjM+f8hC3WNujmcYkMtzVhoDFn8Wov0qWOrQToxbulXvT6O6g
         8Vdg==
X-Gm-Message-State: AOAM531SCcBVTnlzLW6+L7I+ioqHtCbJNBs3Nz+G4o5A5J/w5cCG5WF+
        qD8pMoNNmFnKe1ms2zX2RgjWCvdQMkJ3huD4
X-Google-Smtp-Source: ABdhPJxTGFZn+HmhpVYxkUxA1FolU4F5i9ZeKo7HnjvUcq40VAGfn7HX29/N3wqXI9g41qb8PFeb+JyorOolwZ4Y
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:adf:e284:: with SMTP id
 v4mr6412618wri.271.1605305818271; Fri, 13 Nov 2020 14:16:58 -0800 (PST)
Date:   Fri, 13 Nov 2020 23:15:46 +0100
In-Reply-To: <cover.1605305705.git.andreyknvl@google.com>
Message-Id: <ec80ee52d741da81e4e2c08a09c3dff5feab5260.1605305705.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605305705.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH mm v10 18/42] kasan: rename addr_has_shadow to addr_has_metadata
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
Change-Id: I03706fe34b38da7860c39aa0968e00001a7d1873
---
 mm/kasan/kasan.h          | 2 +-
 mm/kasan/report.c         | 6 +++---
 mm/kasan/report_generic.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 488ca1ff5979..c79d30c6fcdb 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -147,7 +147,7 @@ static inline const void *kasan_shadow_to_mem(const void *shadow_addr)
 		<< KASAN_SHADOW_SCALE_SHIFT);
 }
 
-static inline bool addr_has_shadow(const void *addr)
+static inline bool addr_has_metadata(const void *addr)
 {
 	return (addr >= kasan_shadow_to_mem((void *)KASAN_SHADOW_START));
 }
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index af9138ea54ad..2990ca34abaf 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -361,7 +361,7 @@ static void __kasan_report(unsigned long addr, size_t size, bool is_write,
 	untagged_addr = reset_tag(tagged_addr);
 
 	info.access_addr = tagged_addr;
-	if (addr_has_shadow(untagged_addr))
+	if (addr_has_metadata(untagged_addr))
 		info.first_bad_addr = find_first_bad_addr(tagged_addr, size);
 	else
 		info.first_bad_addr = untagged_addr;
@@ -372,11 +372,11 @@ static void __kasan_report(unsigned long addr, size_t size, bool is_write,
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
index b543a1ed6078..16ed550850e9 100644
--- a/mm/kasan/report_generic.c
+++ b/mm/kasan/report_generic.c
@@ -118,7 +118,7 @@ const char *get_bug_type(struct kasan_access_info *info)
 	if (info->access_addr + info->access_size < info->access_addr)
 		return "out-of-bounds";
 
-	if (addr_has_shadow(info->access_addr))
+	if (addr_has_metadata(info->access_addr))
 		return get_shadow_bug_type(info);
 	return get_wild_bug_type(info);
 }
-- 
2.29.2.299.gdc1121823c-goog

