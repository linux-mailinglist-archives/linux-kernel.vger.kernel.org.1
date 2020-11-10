Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0F52AE2CF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732601AbgKJWMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732485AbgKJWL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:11:57 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41070C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:11:55 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id s9so205590qks.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=F7/1KPTvjV1FWBHoCg0P+/y9T50JI9o61TdT17vNWe8=;
        b=oZFYWnksmbuKt9cjAl4A/CzWuDkl+po03Onfce74bBNCj+InqImRtO2/Hbul8fPpCJ
         JXQwiYCyMA3nZoyBNh3rBXbC9UY4jYTQx5Rcl139RMsYNC7vTyicqbXUurc3vyT41Lh2
         x9/CbHX7tiJGkQzYYEMAQRgNJnBQsLSHvpTugGY5jtgC/JbJjnX0AZDQgpfZqcR8MPrV
         SvDTrriyYW9zoVvwDntcJDUI5olNSuwTIKKEao4LZbaS+W0x1bZ8qwXnOZsgHKLwY0re
         aEjAGZrXAk2pkXF1PVd1bXaglyUrrNe4mTO2HFx879k2s4w1MXZthZvtA5v1XAYt3QPY
         Xivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=F7/1KPTvjV1FWBHoCg0P+/y9T50JI9o61TdT17vNWe8=;
        b=aL9BEFTWdpVewgAxaLnXlQzOYaaWNnM+t1baxgSCWLzwzVSwzIAzKnkBcXNH7LCTJE
         Q3DiwEyCKg4HrTvOx5kB5b7kk75SjPm0b7EXEojoOq52ifJcVitdHvKNp5D5OB4iS11g
         G4sXaUaUuWpPDik9NVoq/vJqYi5fDklKUyHLxdzl0LGIR3BPUxbW8LCctfre6JjKqwbu
         BfVTtqqC5Hu7EI1AFNS8DnC+W4mvpfnWfjumlx3Q6aZ0wJK9bsPOn67U0XH9b2UX1pZ3
         KkY4hvvAeKpLvBphaQMTKpwH3H0Pwp3qW+sU2qVjY0HSFb4Iv2LFaYsO+JA4VS/q4YK9
         h/Bg==
X-Gm-Message-State: AOAM532xTYa4E3J7Z2FsT80275S3o9hkl7oHhzGVFDj2DRDUFfy7AgLu
        nkGOMQTmCIh7DaL0t5zQiG8dTYKYl9pYwyib
X-Google-Smtp-Source: ABdhPJxidrVLv1poQn/M8x+CfUunzlye6G/3PAr5ieQaIo40Q12o8lXQcVe+pm9Z0jn83smT15CZLdNIn80gkItf
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:4514:: with SMTP id
 k20mr21206364qvu.1.1605046314408; Tue, 10 Nov 2020 14:11:54 -0800 (PST)
Date:   Tue, 10 Nov 2020 23:10:17 +0100
In-Reply-To: <cover.1605046192.git.andreyknvl@google.com>
Message-Id: <47785f5259ba9ed493d2ac94ec7c2492fa5c1f14.1605046192.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v9 20/44] kasan: rename print_shadow_for_address to print_memory_metadata
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
2.29.2.222.g5d2a92d10f8-goog

