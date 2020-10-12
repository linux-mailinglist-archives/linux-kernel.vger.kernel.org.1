Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBBB628C33E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 22:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731527AbgJLUro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 16:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729424AbgJLUp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 16:45:56 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AAAC0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 13:45:56 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id g71so2023019wmg.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 13:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=S/2LUWRyeXcI4N86DAnzB0X2oSlP65kDJMRv67ks5r0=;
        b=LMXIiTVU8pr3US3jVmLe+5EXivqjswBgOr2p0q+9zHj6jEz1lrBaR+xS+wnaJhRV+J
         p5v4Qo1Kd4s2hcvq9AhHh0lh7aAyMS5uKRQNCsgnrxdzO72F/Ai8vi8NVWa4NxSRCFH3
         gq5cokjNhkMZLqwDI6XyFCLSqhlkdS+mH2CExVqc2IqvizH9DKT2xX6WrLQvczANHaW4
         5SAcWTY9HJzIISiSo+NDA2FtnRqsRJFfp/B1BAJQBDBRk9wWd5XOF8QcsrXmO/S+MX7m
         0hik6wNWSV87QGR19dX/RpdBCJR+cFY15p8saW4WnskSLt3k2Riefrwmh9PIwOtnGsvj
         1tvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=S/2LUWRyeXcI4N86DAnzB0X2oSlP65kDJMRv67ks5r0=;
        b=ITDheFfwDjVru9P2ni574UUaY+TW02xjodNchqPlfU26X361UNwsrQFbJAGLQ4AVDr
         GBKgrcpS/2TKvvBNY0pgdJL3cH42tmSaajDygZ8QLrbnrBr397DM8eVwFYJEGa/+a/bX
         Q2GrzyEcW/uyLiqJL0ARlYysWcJkMttA6klFO7G6qmXDASkBwoVgkYKitU5FhFdVmLcy
         Ywghv6YGMr08AhGJExozyJZGIxyW8ojqMGbd9KlCjj6AUY5MJn9tmo44590wIP4dUyUn
         Jz+RZyfkF9GdQjFNJru7KTSU8MvDNWre7wg6yz7krS2ISL1PDQ9W5jyeBEypjziCWmY4
         joJA==
X-Gm-Message-State: AOAM533B+KARPEpWwmHPKnaLn852aCBMOt2xPsq7wE+jWIQvFXpBG7l2
        TvLABE9fN/pgwElJAubESEjRxNOO5/WdDwnM
X-Google-Smtp-Source: ABdhPJyaaUJBV33k7jraXKsC5zSTqxoIFxlhOE8AvXXgC1ndYfFy1ZgduOHQep+ph+ZCLsYh74FaYVUeLbhorKWO
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:bb84:: with SMTP id
 l126mr13064242wmf.159.1602535555003; Mon, 12 Oct 2020 13:45:55 -0700 (PDT)
Date:   Mon, 12 Oct 2020 22:44:32 +0200
In-Reply-To: <cover.1602535397.git.andreyknvl@google.com>
Message-Id: <f939797ef5a3991d6d32eea46c847b5d42be5c1d.1602535397.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1602535397.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v5 26/40] kasan: rename print_shadow_for_address to print_memory_metadata
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
Change-Id: I18397dddbed6bc6d365ddcaf063a83948e1150a5
---
 mm/kasan/report.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 145b966f8f4d..9e4d539d62f4 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -250,7 +250,7 @@ static int shadow_pointer_offset(const void *row, const void *shadow)
 		(shadow - row) / SHADOW_BYTES_PER_BLOCK + 1;
 }
 
-static void print_shadow_for_address(const void *addr)
+static void print_memory_metadata(const void *addr)
 {
 	int i;
 	const void *shadow = kasan_mem_to_shadow(addr);
@@ -311,7 +311,7 @@ void kasan_report_invalid_free(void *object, unsigned long ip)
 	pr_err("\n");
 	print_address_description(object, tag);
 	pr_err("\n");
-	print_shadow_for_address(object);
+	print_memory_metadata(object);
 	end_report(&flags);
 }
 
@@ -347,7 +347,7 @@ static void __kasan_report(unsigned long addr, size_t size, bool is_write,
 	if (addr_has_metadata(untagged_addr)) {
 		print_address_description(untagged_addr, get_tag(tagged_addr));
 		pr_err("\n");
-		print_shadow_for_address(info.first_bad_addr);
+		print_memory_metadata(info.first_bad_addr);
 	} else {
 		dump_stack();
 	}
-- 
2.28.0.1011.ga647a8990f-goog

