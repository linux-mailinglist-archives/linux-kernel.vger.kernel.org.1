Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F8529F50B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 20:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgJ2T1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 15:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbgJ2T1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:27:09 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371FFC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:27:09 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id k12so2417308qkj.18
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=MeYcqtBqx2zX9SLBJun3MMNhtoyJ+Q7swKHdtnpeAZI=;
        b=EdQyVtnk5oIdkHXSrYNqXluy+vnS9IpQY3kz74ohd3i/ZHBNLb+B7EssrfgXp+/o61
         ps7KHvD1JWOR3oq4+3O6yw8MF7jwL9MtjwphBS1VkS3Q1qymHbVki0HR5ILCHdBIEoF4
         hvL90JkEXHrWHBHSqNqYdE3Z9841+clUpWYK78N8V9aBJffHzMKVixcu/rqFed8HmRnU
         10LjLEnXCj4yvnzh31J2o6KIQ8p9S21+VfIXC7ClRQuBqdVqMEkZInOYizHPXp1qrZyo
         Qa1MU0C6dgFuXjPsUQQmNeLXnzZtSDD3h0e0qFNMoPACgdyK3k8qehPg/lAGcuhKOx+4
         7nZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MeYcqtBqx2zX9SLBJun3MMNhtoyJ+Q7swKHdtnpeAZI=;
        b=J+xgSX+3fCp7tUBIW0X1xValJpuVPfsdJ1IPrW6Cz4XCOZ3Y52nBL3Jl/BV37aYL7j
         bYI9ACwwrV5CppPc+lp7J3mxGFv9kMSYgs/1fiYZBaicpUVOh+wClWf9rioix0VZinvF
         OpgdWS169EXjvVrKnQ1fUnCNby4eLopD5oQ9ve/pYi5KDPxLIExsNG7/7GA5BnZuWtGO
         rt+Z0PDh50XaJCQq3jf8m8PeS7y4FlBN/eSnS+mhkj2W8+IKQnWjP8DPiDnR3ZDCET29
         /PY5rSUG5ccwk/TFMt+QlDaBSlTxCwmz3ccc5L3Nf+Lto/Z7EG5cqFIMz6UMpDx77RVK
         CCfA==
X-Gm-Message-State: AOAM533+HvawkfGLeT6gixMmDjlTbqb5WzC4WX3Oe1NC/CZzQbve4gN0
        uya3iBYuLjCVKzVt2GbLILO4l/oadkR6xGrF
X-Google-Smtp-Source: ABdhPJyvnzlbDy1/Se0dIgeRIc1atmx2qGfrYuygjD9RIqBwuN5omzxBpg8Ug1XNxDBrisw2tMuwbimwrH6il5JB
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:ffb2:: with SMTP id
 d18mr5644573qvv.44.1603999628350; Thu, 29 Oct 2020 12:27:08 -0700 (PDT)
Date:   Thu, 29 Oct 2020 20:25:46 +0100
In-Reply-To: <cover.1603999489.git.andreyknvl@google.com>
Message-Id: <b40c5b1c9faa43e7647682a3b41107e8d7fb516c.1603999489.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1603999489.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v6 25/40] kasan: rename addr_has_shadow to addr_has_metadata
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
index 2b8ca8f2aed3..139fc52a62ff 100644
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
index 589b1875f5e7..363afde3c409 100644
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
2.29.1.341.ge80a0c044ae-goog

