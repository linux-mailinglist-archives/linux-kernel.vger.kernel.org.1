Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06501277BE9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 00:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgIXWvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 18:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgIXWve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 18:51:34 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2934C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 15:51:33 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id y15so401572edq.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 15:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=BftCDXbWjL9wnLQzbXlcogs3AIdXjMmm0RTraZ8+u5E=;
        b=Gw9zXNxHUJwkXArVIbaPkoqJ5hLcOpWLVEz8aGVLUhX/OlP2SdXtXlH1782kNb/tyt
         ZCY0yH4lt22mOyS5iES2K2zb3N/S/AnRE9Ypumme7bdnPiBFfPJ1dNk+go9Qrld1YFoy
         mw07kTnsiUYIDp7lEw3JAj/uV1Q3vJjt87RK4uSinefGVEBoSYFLqMZt0kLHR2NnnmAh
         Y1UaoAGKT/iOrm5Qq5n9yHjHSozcxEwQAqtlBURN5pn15vix9+RtdOJJUn9pPFcIaXLI
         VwNS9mSYVnZc7vm1Z2fB/3pH05UJT+u3kel1GFbnluAPvr6ZozowrUcsG3EnAS7lM8pu
         Bvjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BftCDXbWjL9wnLQzbXlcogs3AIdXjMmm0RTraZ8+u5E=;
        b=jPZnMQucyF19ecKZsmbeBTTXfIZHPUHKqOkbl0/uTI9PABVknOycopRNEVkxzSLMWj
         VuDqc9CBInCDKgHiej4OQhhR3Q1Fo4TDb9fERcciHVpriKURmVyJQDZnoW/LALShIx5l
         qymUdtxPr97FJSOHVWjH/FoRusDzstOrW78CUo0Dn/ygUqz8wHcy9/MPiNA2DYxRDLrk
         RR2NwhzFrzOcpa6GXDOji0ZGGavrBbngpB51c1wZhwZzg8t+wzpmf+y8empBOkVf1PmL
         yEYVkPyYtPhIhuzY2hX0ETdeEuLFwgJPHJNtNvrOeFUqO4UtF3cShjCsI5/K6ySptKmI
         CxmA==
X-Gm-Message-State: AOAM532vqrbrh9P5Ix8+yfEHYDUgAK/ShQ50g975azWQTVbkt3m21VA9
        HPbfI3jzSBWDNHXpTN9J5QUJDdWItLaVu47m
X-Google-Smtp-Source: ABdhPJw8iA/oUEzJjarEM4Oipxo+x/ZrAqI7GoXnog6wVz7hR/0CPnhLYc0k+ZLPCEmeXeTQjdWWH+TMP1StZ0jG
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:6402:1c1b:: with SMTP id
 ck27mr1066322edb.12.1600987892214; Thu, 24 Sep 2020 15:51:32 -0700 (PDT)
Date:   Fri, 25 Sep 2020 00:50:24 +0200
In-Reply-To: <cover.1600987622.git.andreyknvl@google.com>
Message-Id: <8580d4945df57614053084eee8f318edb64712d3.1600987622.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1600987622.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3 17/39] kasan: rename print_shadow_for_address to print_memory_metadata
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
2.28.0.681.g6f77f65b4e-goog

