Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62995277BE2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 00:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgIXWvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 18:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbgIXWvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 18:51:33 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DC8C0613D7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 15:51:31 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id b20so306160wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 15:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=hIFfthxFzKDNttx6Iwa15uG/YA2TsOtV5/OtZQz4D6k=;
        b=pSVeZJ+Mo6ZWifAuS+6KCEX5EJxKTmAawvnqmG+62ZIqI8wE8ZOk0hn0O9ns5i2phJ
         s30NK/lLkW4w4L5khmsq9riWXwa4rx2E9xlWXa8+LKwc7CbFbOEN/lADZOIP/YKrXRtn
         YpE/MgV5UV3uzh/LVu6RAIxKaLLhiLAgSHq3qmj+5EjUaE6ZTC1tMHPT5HmfU57+t1gG
         DUEpyJCz72NrVP5uQQDxIChAaeWFPv0hwiQqM1HQAM1FJ8D02vTkVZ8fkZ1YAdVf3Xj6
         eIDapAyz+LWvq5r52TLARW0wYAs5rMBZHmwYG3wFPOXmGb2hAq7rsNvwXd8S6rw9nAKq
         7oqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hIFfthxFzKDNttx6Iwa15uG/YA2TsOtV5/OtZQz4D6k=;
        b=a4PHLN0Hv77GYZBZ4/VyAF2jvYWzFIDfh9EWgBITGrevLiBgW3ZiIcdlvThXWAo4xx
         HCuq3+zpVcEhpmRokKl8Wpecn7VvvnByD7UvA3sYgGwHaWfjVRf/8StUu9IKZGNbzXdn
         wfuDiYcVEcLcidL0PJdIUdkKmJnpLjWbk7k4ff7cYGBXWg5iOnBNCtEeo4EdeLt9NvMy
         lSuqZuF9uPflIqXflvuIA4ws1Tsqa5UgC25Ue8Q9kLNAsn+20Jm6GMFu1GgdqEWW+r8l
         +tmgyhGEFPzSQOI1hFBkLoLjrWdK21tD7ZMlYnSr2ChsOONR8Qy1/nwlHzFldjp9nRdl
         8gGg==
X-Gm-Message-State: AOAM5301UCcgQ6SKbX1wuXVpRRdlj5OTNgjX8PUrJHRrhYffmGz+pF1u
        vAahTfeCnRlxxCBVa+PbMnSaUgAoxnu7IMWY
X-Google-Smtp-Source: ABdhPJy5ULe6GUSQ5xDjMfDpd+cYJ8T54lZ2I/FeR/jw8GWQfUtfFJA8p7zrE57Z9aqLqoVj7Fe2KFlpULY4cs7D
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a5d:60cc:: with SMTP id
 x12mr1196294wrt.84.1600987889651; Thu, 24 Sep 2020 15:51:29 -0700 (PDT)
Date:   Fri, 25 Sep 2020 00:50:23 +0200
In-Reply-To: <cover.1600987622.git.andreyknvl@google.com>
Message-Id: <fd0103571c825317241bfdc43ef19766fd370e4f.1600987622.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1600987622.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3 16/39] kasan: rename addr_has_shadow to addr_has_metadata
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
index 8dfacc0f73ea..0bf669fad345 100644
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
2.28.0.681.g6f77f65b4e-goog

