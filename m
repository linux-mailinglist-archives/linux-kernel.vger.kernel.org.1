Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5ED12C15DF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 21:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730976AbgKWUJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 15:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730908AbgKWUJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 15:09:08 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F23C061A4D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:09:07 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id s10so109961wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=a0i3AqOqSlN3mSBa2/h8s/3PQOlnMPwV+np3TVLmk30=;
        b=HCFwctjLT762qsWSFnyCoceQR1WwjqODXCAB4DXKVtoXdhRkxuq4HIhodNj6AHwwsK
         ASQfwf/znzdG9tsQQEbN8/zSWjfzuSpt9Q8F7+5EZQQOpi6f5nnF0ZRMew0fyQ1FtPPH
         g2YbOcXtSSdFjbXpyd3VmVi/ne0woFCwhlKt45TQhH62b2Ws3jcqTtTRb7YkowmDqA1o
         27zUgsUxdFaOU7dKQarCgo0RdxamvCdnA+APaDxNrGZZCRBYp978FFnbLRqZvIV7IyuY
         s6pepICM5x0UM5D/sMcgrw7z0aUsANisZ9YQaoK9N0hUJOlOa2+zu9iOWOYetR4vkbYp
         Bn3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=a0i3AqOqSlN3mSBa2/h8s/3PQOlnMPwV+np3TVLmk30=;
        b=gZL//DB90sgio1WwwcQYzodPlsJeqz+12DCVYZ+AVFJ+gCqWDJS40JoZERrEIfw958
         XEqEemJafnJzYZT7NvW+u5FiwPIB3SeRQXI2/KnAz/g98uYXeLOwUOm0O+HuZAA3uiIp
         ZP3JyOSepAI9nz1ulDvpWHLdqjiVRVcozxmvQCrY4eBH1OZj330z+LSrO09WfFhbsuK5
         KKy9KF8c696QoHjFC7yACBYmSQbUdQk6IXsJ/Qnuu2bsupt8TWotqzdrn11UXA7gEYP4
         rIIGITecXCsCuk4aSwbDea4skPsFpFNIVhtZFvHWGpanRq3kWYTJyXLBfw2uSXIWWtIt
         g7Yg==
X-Gm-Message-State: AOAM533kePktU+T7j2HB5Jp1XDq2mvCrBlOBfD5QK2CH9IyH6hOfXcIR
        r0J9zV5r7lmedXdTl2lv7tnml0fIcw9etbrb
X-Google-Smtp-Source: ABdhPJyocb4hAm3ir2t8Dure7BSo4y6ote2SX75mLc33oEVsWpbUztBS/p2ERVSjCbuUqjDba4gjyIC15du3F/Ki
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a7b:c1cc:: with SMTP id
 a12mr202256wmj.0.1606162145370; Mon, 23 Nov 2020 12:09:05 -0800 (PST)
Date:   Mon, 23 Nov 2020 21:07:43 +0100
In-Reply-To: <cover.1606161801.git.andreyknvl@google.com>
Message-Id: <dd955c5aadaee16aef451a6189d19172166a23f5.1606161801.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1606161801.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH mm v11 19/42] kasan: rename print_shadow_for_address to print_memory_metadata
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
2.29.2.454.gaff20da3a2-goog

