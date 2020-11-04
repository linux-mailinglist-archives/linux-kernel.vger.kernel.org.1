Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5792A7138
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 00:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732767AbgKDXUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 18:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732694AbgKDXT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 18:19:57 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7D2C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 15:19:55 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id t63so1569212qke.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 15:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=96T+1f9i/jCV3zB6gHtRoH9MAYIWASsGc4o7euuXITQ=;
        b=MHsAFWSNNNsmPyRuCRBRe5S5UJlJTgrmBZO2ihBxvYR0I9yYigF63VwzzPho62nZs2
         VLtTKG/brXnczBsTg/i2aly4WyjggyM4qk5OgjEXTMS6woyfj8oUQLECz4dnR7CYmlCK
         P2hAhriFaidiECgnMceqscf76Xp8o3bbo8VrPcMQFeLKrXv1UFPRc6fihUk7uiYivJRY
         /Psb2wdAmwOpskpJVZWh95yRjI1C5Gce+azuH8yjGwSerALSKQTYVjqWvilB6QagDvv7
         yNsYVvfeAHhc4rqWuseztMtgbrSeVVBL0ZtROar7FPeVqCV0fj2xagBhvbamoTlcYhxm
         Ntrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=96T+1f9i/jCV3zB6gHtRoH9MAYIWASsGc4o7euuXITQ=;
        b=pwWVsgBmNGm/E36QhEkolkG+rZGbfsJUXCSwFnQgLXVIt1P5Sp6q9zKxvmiYszigWA
         vWdSV1wHWk3SNLM36D2s6QMVbEQctDTDHbZ3PasR528r670WM/NLi/2om4oVmX4H+Owl
         FtWLA5RWQ8nMc4XNg6tyPUhSzcwiNj1p2dFGi/nL15WiazCb/90wCcBkbfxaoyePi16I
         mwp1ZUIBwL9iX4EjC5QTmsSzES5SUwbIMc4zvqjqiIftrn+oP8VSdvXmGa/4sXbDwJSw
         IZ2MV1cdD5uowtrmpZMNvppbIvKRKux53Pko6XWkcTtxaig52X5GvIlTenllzNsJ1nPI
         5tgQ==
X-Gm-Message-State: AOAM530wCgl1q9bMBPMj14oqlWi7ZDvH77htHhO2E7c30YNZb+Y3JDGK
        phMWto2tQ5ohpLnJk9zNNMTwtzY9Ux8V6Lom
X-Google-Smtp-Source: ABdhPJyY4vYywqcrGkIXWcGHdEVetd/tg0ubApwhK74pxGohLkeevkUn1OS+r+BUFIBRiQwZoc1eeXrnVoZyf101
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:a2a6:: with SMTP id
 g35mr293187qva.4.1604531994786; Wed, 04 Nov 2020 15:19:54 -0800 (PST)
Date:   Thu,  5 Nov 2020 00:18:35 +0100
In-Reply-To: <cover.1604531793.git.andreyknvl@google.com>
Message-Id: <ed664e371a31c5e0dad63cf8b67c61efa0d08409.1604531793.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604531793.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v8 20/43] kasan: rename print_shadow_for_address to print_memory_metadata
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
2.29.1.341.ge80a0c044ae-goog

