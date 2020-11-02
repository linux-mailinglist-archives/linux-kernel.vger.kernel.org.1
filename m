Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53A62A2F4A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 17:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbgKBQGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 11:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbgKBQFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:05:30 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546C7C061A47
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 08:05:30 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id q15so6597351wrw.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 08:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=sVRidbcAWerSUwt2ci/DUHKn4WqZtHdaAQApmenAD58=;
        b=v6ir8TXDrscren7ochiaFCvCeDXF39eitOZaERVNtup9izMuNGdlbt8sIvzSVl9SQ8
         0QGnDvw0+KGgbTxWPEPecDbfjAo+WjedruVADl1G7uYvT4/O20aFm1+KCaEdDGitSTeK
         NQswEXuQL+poPsloGbFTH3mbNtGvIo5Srcxh/ikRSVqrXWIfYZXI1Y83zemqtR5VlW7K
         FpvQIvxkwe/MOmqv9vlG0Py8yGnQMIDwIpaOr4jUyKtJP272qBF6Gb9VZ/vSDt+qBPCr
         bUKSk0dPlYt9Hq+y05dowoPE/PjJSxIWyFiaZOLSCNkCdrcpTdAJ+TNWvP46rwGv29sS
         I0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sVRidbcAWerSUwt2ci/DUHKn4WqZtHdaAQApmenAD58=;
        b=G9VAPezWomh0HMYasHsnTEGSH9owSWYJSTyjuuI6DC7PBXC4yXZGsk0PtGa4At3SQN
         NVuOSLnHtqG8b8BS7KIVe0Zw+1SM3eQQFH8rB3+GSHJwZZuuOpMWDD0P3yrz9ZwnibTO
         cf5D2lURTBg+DUHgxDq7O4xqzSuOza083J90ktqA7jErWGtob7lEf+VWVUWZrTxiE+62
         j3pPx8R0rJbw3BlySUjU1ZX/qu0vh5ECs8lygmfy6a/yZA7UnOLlAMTKy/lqj7LKnqY5
         XCh82NyqCxwY7fSydvTQoNpf9/Bn6t6Ac1EThcERfOnup+QL6nY3ufzHRWgXMtpo6WWl
         CIaA==
X-Gm-Message-State: AOAM532pFtJe3V7MXctmNbZffoihE1IEdG8jX12VPCl/HY+wL87c/rs3
        xsUJ0N3vC3xPiQEQiTn4bG3YsEknfU1jotG/
X-Google-Smtp-Source: ABdhPJyREh+t6Io9PXjdhN+oiI1e4wC2VDxO12r/g8aOXiFkF4OSY7aITzm4LlFjoO0wg88pCsMbIo5Egu4Xqh3B
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:6000:1109:: with SMTP id
 z9mr19417964wrw.388.1604333128982; Mon, 02 Nov 2020 08:05:28 -0800 (PST)
Date:   Mon,  2 Nov 2020 17:04:06 +0100
In-Reply-To: <cover.1604333009.git.andreyknvl@google.com>
Message-Id: <fa10232c2a15097fdb6d8ace41ce3232a4d59536.1604333009.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604333009.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v7 26/41] kasan: rename addr_has_shadow to addr_has_metadata
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
index 54fc3fac9779..ce335009aad0 100644
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

