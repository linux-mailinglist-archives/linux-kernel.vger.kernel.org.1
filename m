Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79A12AE2F5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732620AbgKJWME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732556AbgKJWLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:11:53 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B116C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:11:53 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id l5so1659247wrn.18
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=f+E/U7KjS3eO8ZHDl6v4LSa9uLmsgT0jRyLIgabh0JI=;
        b=X7YjSmgDgqw/GkR1lRrxq4ovWrU12ui5KYT7RQigdLleKzs3agIiKQA8S0UX/pfOTv
         fFXzdJtzRSEnaE8zcnIU91PxCq4+8mq1wvwz2GCDbmUiR2JOkIEbDOfEsszMz3WUR1vM
         Zb4m3V7CdtBtZFoZ1WuV/LYlJ6BAmV7RY1lwBLT5MxkYs/KbVV6kZYBpQu5S7QdQuVIm
         YyUu4xi6ET0N8RnOxHdQIKmxFbYjGmlu4OlHOg5Wk7MDoBqupPdhroimN8NNRQ0JzZr1
         qeshPt5bunj4WBxX+rDuqWRjGbEphczywT15/j3E21j469Ax/hVf5pdggblQgax2ymHt
         Dszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=f+E/U7KjS3eO8ZHDl6v4LSa9uLmsgT0jRyLIgabh0JI=;
        b=ta396uU4iPn6dFRRaX8sziTURu5DRb0Dxchmg135XD0ZN9c1Sy4hb81RXxI+fOxz45
         RjNh/ymr0ZCiuXaTjVSbR+MHbSCy+6jNcfYrBodNJ7cLBA0g8+yN1SN/7kq5+gJhlz9g
         c4u9WtxhQ+r41xRgVWWoz78cRMeNKhzQT+biyTp83bHxVisiMKkuGp8BT7ce7BtY1PAw
         PBqDxpA2qPSWIKfXfScK2zNiovduDPQaH3dUR1LIAWgiZtsKcOQpHVBiXgEm0fwiS73/
         sxX/OdifIAcV0FEagkwbDv/MZ8DblWAnOt20sqG9MzbKzUdViT8DBrvfFi5UT26ZbUFn
         DFjw==
X-Gm-Message-State: AOAM5316771KXxawCGeQSJcJnWQIDUrjBE71ayEjAN3r/6b3fVFpMm+U
        mjyrP2sS4ZBMHVpgMJ1b3WPkEVNRm0e5TDQE
X-Google-Smtp-Source: ABdhPJwbVtcgj+xi/Fz4l7oVykIlMjQWukNzC5AJLtbBDxGuK7HJnhq7/szbmS7dFWsufi9txYoAQR1MH5W01KgZ
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a5d:530c:: with SMTP id
 e12mr20014512wrv.355.1605046312145; Tue, 10 Nov 2020 14:11:52 -0800 (PST)
Date:   Tue, 10 Nov 2020 23:10:16 +0100
In-Reply-To: <cover.1605046192.git.andreyknvl@google.com>
Message-Id: <1034f823921727b3c5819f6d2cdfc64251476862.1605046192.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v9 19/44] kasan: rename addr_has_shadow to addr_has_metadata
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
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
index d0cf61d4d70d..f9366dfd94c9 100644
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
2.29.2.222.g5d2a92d10f8-goog

