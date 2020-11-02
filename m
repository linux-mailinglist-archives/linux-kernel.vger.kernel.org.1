Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF802A2F36
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 17:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbgKBQFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 11:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgKBQFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:05:33 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB64C061A4A
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 08:05:32 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id 2so6640332wrd.14
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 08:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=96T+1f9i/jCV3zB6gHtRoH9MAYIWASsGc4o7euuXITQ=;
        b=jW4TR/kD0Gk4k2wdBuNEPB+r6ROZb4+/ETtDZ2hkgbo2o3QWFGdN08jY0Z+OmN1Hke
         X4fhFHbo57T+zxKvTaxtA8k6ZEvgSlJR8skMwZL8Rcta10r5wPvMulit+SFNlv/qhGiY
         q9KYiLeaXE/yGFNdqnNefWKGclL9WLnMYu5jrPJPjZSUIOgY1DidIczwuhQ8wc3SpyGL
         3uu2GmlYO9LOoqZIHx+As5zPsRhdpmBI6estqr5FWSPfgLFRu/uxPvWmQ//DEFYJDORr
         xKsM8FGBtOdKEolE2I7oQfGBs9lQao1kovGlk/AiX6McGON+GtrneyGuDmGO/g15+G+j
         EfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=96T+1f9i/jCV3zB6gHtRoH9MAYIWASsGc4o7euuXITQ=;
        b=eu5RGD1Y14KdPyDhbP6YpHF+nJOHFkFBddbD+icJOePevXTTrca2Qu6RdV9nwzeHfx
         /Nrkaed6wu7qLH6AUo6l4JI5stgzDWdYrghSaIzC4+o1KYVT585UfnP8QNobPf8NS5Yz
         v7jip/d3YLz76dy2X5rID+ccmTc8lV9bzMxc9DUv9R0f5E6VmUW51qsl54FYRYOH84UY
         0zVULDzGSI1Ai3UQlqo2Tn0m/BiyPkDyHWrZiFcPRBLRYgK7wAJHXm/qqO5mdLKfrrpP
         tVnlrqQF12K7p1sUmZkygOPGvZp+3fiu7xUWWwQhViROYCisKhePQKHwgPEscVgOdNY2
         z5aw==
X-Gm-Message-State: AOAM5335eKD7ogKdrnBEdzo+y/N5KAWrPj6CPLDEaqTKFV2Z7kv4MFW6
        kc8H4VGRVazMBzG0nPkTs7D04Rbmj38of8Dl
X-Google-Smtp-Source: ABdhPJzspIe0SD7XXTTTwvqFjpbgeWqe5VktIJdGU3UKySRafWujQV1bq+adBycOHqVppCTtFqWGEjUXe10mF//O
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:3d54:: with SMTP id
 k81mr19445547wma.144.1604333131167; Mon, 02 Nov 2020 08:05:31 -0800 (PST)
Date:   Mon,  2 Nov 2020 17:04:07 +0100
In-Reply-To: <cover.1604333009.git.andreyknvl@google.com>
Message-Id: <ad03e58d10744e418b4a457a4ca9e1d088394b46.1604333009.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604333009.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v7 27/41] kasan: rename print_shadow_for_address to print_memory_metadata
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
2.29.1.341.ge80a0c044ae-goog

