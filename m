Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEFE280B0E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 01:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387544AbgJAXLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 19:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387502AbgJAXL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 19:11:27 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EA6C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 16:11:24 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id 33so121253wrk.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 16:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=RtCJwMgIYvelzx6W+VqX6CCQBYnpjAVMkxalLwUkkpk=;
        b=I2c3loWOHM7SCVXcrY7+bGT77nii/87DX8jc1/GMxpKG7sNQrXxoxNxZnKSFeiEdtV
         ehsiMifoImgUAmhIjINxdqV3n1eNoaETV682/tjXrnaehPH1MzP0MUZ7NaMkMjEpGR9b
         ejVUbZQXU/9xJd2mdB/KY1vsi5qfcwIBIfv07/g0rFNXBycH2w8dSEEpVxthy+iRrywd
         2Aq+Rk4eTYog2daU0ip0eDIh5GqXxhTXJ3X+/vdeg27gFSpxtnf31QGt85k2BZGod4kT
         wQ77Cjb7KHtejYudt6uEOpEwCia2se1D1EEoK2/9EyPQcYYeMQ60KuDEWASVcvxawmMV
         jdhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RtCJwMgIYvelzx6W+VqX6CCQBYnpjAVMkxalLwUkkpk=;
        b=Ylr4zaUKqDiQxu+HH/1IoAsoJNrga7sT7OONThXYTu1tjzsJBDNdpdu225CxNcguYT
         rUsdLL8RkD+ZpqMxkdEVdbhFlP7qF784ucYEwh2eUvw93sf/DjeTFfqC+1g/lBF9JWzM
         04xn2Cx3e2E1B+5iOMX8J8+z/ngCrWay2WnhwTsrYM3U5TaNVr/9JWkL6r6ccWSjVuRH
         HLTnLaOq0BAmCVxFb1rYtkJuoc7ykshbdlxe2vx+jvxRCbaRD5iUg9Sqs4s35NaEest2
         8k8ua8jt1sKGzpUbFkR9k6oxKsmpqVpHVue6UtQLym1yOredlNkHqaqdr+QaXydOF2nz
         Encg==
X-Gm-Message-State: AOAM532geBkwrfLGnzLz+CMgXUR3MIKUn/N5sPzviTLeXfZ0cuJQayJC
        9zikuUNgd6pRlRo0R87/Zq5fFTa+ljHrzdAu
X-Google-Smtp-Source: ABdhPJzi73jCUfp6OLDpNOLLkF/C9fX4ruuBC+EQr1mjbwdiCBE+pTPfBCbXwWRaFmOgLV4vAkoudzQEnl6eInTn
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:9d82:: with SMTP id
 g124mr2345719wme.4.1601593883158; Thu, 01 Oct 2020 16:11:23 -0700 (PDT)
Date:   Fri,  2 Oct 2020 01:10:17 +0200
In-Reply-To: <cover.1601593784.git.andreyknvl@google.com>
Message-Id: <c89a70b8b83467442ce2212f98ee3af9dc7af956.1601593784.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1601593784.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 16/39] kasan: rename addr_has_shadow to addr_has_metadata
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
Reviewed-by: Marco Elver <elver@google.com>
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
2.28.0.709.gb0816b6eb0-goog

