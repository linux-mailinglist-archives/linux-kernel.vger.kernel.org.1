Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375DC2A7135
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 00:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732734AbgKDXTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 18:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732702AbgKDXTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 18:19:53 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761FAC0613D2
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 15:19:53 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id d5so14471391qkg.16
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 15:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=71dDjA4AvorvAoOL9VJG2R9YWEBiYEDCkHWbAxU+l2Y=;
        b=FBI115kSl/HZmIpkt1WXy79Z+i//PiEltj41xVsYSu3pxfB6uvCPMeCRU+oAq02d/D
         7LIPPK8wd3GJK76/Z+BDYn+b9//x+1d+6CNuvFjeZjdgGSu/oC1EPweJd3+Lzxv5glTp
         KParHjDWpvGcnPVF8ALnFfigLvYM0k4RQEq4SKir4DLZLItEIrydCxau2ueZFsuk5ey1
         wFCmkxmn6P3xvclIkvvcuQ3QgGEOPklAf2B20ejqU0W5hrst28zkEu9Q97OeWYM2+gcZ
         nKFW6GSy5kAaylxfNizKlF6ufym23h7ZX8sxFQMxH2b9geM9FZ7JUDhzyBe8014S3GZ3
         8e4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=71dDjA4AvorvAoOL9VJG2R9YWEBiYEDCkHWbAxU+l2Y=;
        b=NsDI7yhzb6vswTHDSPxsD8oHxhNzsvtdDbzYx4Q1q4ppKKRtfkjhQXKpt9Hfx2pPSJ
         mJXjzbV0xZ6a45USQSevhTzwGiJMLLM7mfL9KjtaExeBsC38MrZmhH3alJHwS541pvqd
         TDiNgaxzaAYXZCqXvB0nzeKYQuE0tUIKuVhF978ZDlFk3SutW/92qJi5gBpq0F8Pl6ex
         VYky2NZkJTgq3a+pGuKxfw9y3FPfYsl4MC60KYPr4CHq+9GECuEUngO00Fj6gxd0j6kI
         DLmSyYlKpsLMHxFW0nee969Qif1i5J58l2w3DtfvsK8CnUKMPSRM6f+cKhMuLH+bGXIr
         xtpQ==
X-Gm-Message-State: AOAM533/F5fshdcNdnWLnFb5jDWYlTk0LL+VPRr9nkVgfslDUZqBDbKb
        CvHOKeqlqnqFI0a68cOTqSmEID9EgOHM/cXh
X-Google-Smtp-Source: ABdhPJxOZwIeUmqI/nV1niN8m+2CkK4H9VN0saYIPGqBloq1ama2UCKlYbsmmzphZXOZDPNwTMjB/REABxyDqsNS
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:4512:: with SMTP id
 k18mr256501qvu.5.1604531992636; Wed, 04 Nov 2020 15:19:52 -0800 (PST)
Date:   Thu,  5 Nov 2020 00:18:34 +0100
In-Reply-To: <cover.1604531793.git.andreyknvl@google.com>
Message-Id: <a2c72de4f882e748698bebc25e45f08b03ea0de2.1604531793.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604531793.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v8 19/43] kasan: rename addr_has_shadow to addr_has_metadata
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
2.29.1.341.ge80a0c044ae-goog

