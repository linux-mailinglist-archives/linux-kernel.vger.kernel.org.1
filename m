Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF0C280B20
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 01:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387582AbgJAXLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 19:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387531AbgJAXL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 19:11:29 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F0BC0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 16:11:27 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id v5so134045wrr.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 16:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Cbv+CjmfjBTD0ICXD0e117ENri0Oo47gp+rha6sXLiY=;
        b=kEegrqMjE/rmbif0QT8HpdGK1og0tnKqb/4vLJF75Hh/9zhuquq0RqxzuydOrABk9R
         gfUGOYkDKCxV3RHW52+e3QNmV1fKc4i9kuVEcW2jTlEXiGJJ9X0tgRWrKiIlN+WcNORJ
         x30G6iL6Y8bU7RifoQxzvDR25opKbivS1X6cpFkN8C7oY6iL47ECW6IHGMQqZvvPdxn2
         Yn+pzqY1h5dnutBrXZ9bDmV90e6jL93HITauGS8av717da0DtxFuF71VPxhUVgPFIj1j
         hiQEuoazcel5FO4owIafSJyBiccpIExIHcUuy7Mh0yKldoF0v60gdnPGvoplxqKGbzwU
         KxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Cbv+CjmfjBTD0ICXD0e117ENri0Oo47gp+rha6sXLiY=;
        b=fZpJ7Quh128sIjR0hcSJyQIyAdmtu0sqXJFMEAaidJa8CARw5NyKAJGJD6E/2AwVO3
         7m8PsTV9bmGBCQqVgaFzv00+lLetM3lgtS0yNVJwiTbM0FxFXbcgCiz/z8WfLmGxnW8k
         5nEPHuydy28RJD44RsX26EmACDLqnduBWRfEtQN//pJE6IzCuk+8vdGtGQ6Ims5N/Ips
         DhbUGxaL6NU54nVzWE/xP9ZiQtauDQdPyZcoh/SMsJhmwLpUsPp2XiRVqVh570dzwsgH
         CfObBoBcfZ2mg9WhzlFxrBHRyASDFcWQ+fmP2AAkZ/EaBtfqbBKe9DfiAyPhXm6zk91W
         A6qQ==
X-Gm-Message-State: AOAM5332Ei7U8SPj06SMW7ytWxcqMvO/2/k6OjUy7una3Im13noLlc3w
        bZ7mUex6rT4VYokhy3nExwLLwCRyZDaOjvlh
X-Google-Smtp-Source: ABdhPJyQmcKv1rTtykvb4HzS+EceDkHHldLGIM/BRNlbuM79P3QogadqhP/7bWTWHMNPxTGlPR9N3tNzMuzxV1xI
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a7b:c14f:: with SMTP id
 z15mr1323wmi.1.1601593885526; Thu, 01 Oct 2020 16:11:25 -0700 (PDT)
Date:   Fri,  2 Oct 2020 01:10:18 +0200
In-Reply-To: <cover.1601593784.git.andreyknvl@google.com>
Message-Id: <0786198b08625bef6402ba298930bb26f4a567ee.1601593784.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1601593784.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 17/39] kasan: rename print_shadow_for_address to print_memory_metadata
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
2.28.0.709.gb0816b6eb0-goog

