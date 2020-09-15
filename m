Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3623526AFFB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 23:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgIOVxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 17:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbgIOVaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 17:30:16 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE44C061355
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:17:00 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id n4so1792559edo.20
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=LA/JoGm8S/g3KI3imjTGafEDoL5GY8vPZ9zGXBZ3JZQ=;
        b=pe/gphJlmzAMPX95VYWAWtz0vwnZxs6ztYU65lG5adc1Tsk5t16qxRObv0Fj78BTSJ
         iwSptltcdPvW3+OF4mGCnZhaEWg+JrGEY7fltofc/Uvy170czTjYtmpTqrQxeO5cTors
         DUkW54UUWrIAkCn04SZt8YY9jW5LRnUzG6pS5MQwXXQTAk0P0ailXdGkYLXtFL+GcfEX
         gb8feGkSX2iuI9vchI2EWoWLx66sPY4tCZaZrM1jB2aASttRsRkr5F41mNUodOkeEiRD
         1rp0p3F3AskTrLyn7OweXmv7p8Y7CNrOic+Q1tm4c8J7xWeFzo5nr9q/+g2CvECOo/2D
         7Ydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LA/JoGm8S/g3KI3imjTGafEDoL5GY8vPZ9zGXBZ3JZQ=;
        b=XO2RXvgu+OtiQjkbqx/xlD3nlNScNT1DeHAiaPxnYYTuaxblPQf4UxjlxvpomBh2J+
         rZsDIyOne2engkvxOMjEY1KsoFrOwXCwEdIB5shDeQC3O4lDAjdM6lz1hutE6qu5BoFO
         OdXG1XJDIKNYOAOHzYBT/7+IycxlDk6TCdM5EEeQmQvQkUyvhV07b9haupUzXFQcExSW
         nAY3VyV6olifjfA1u3z+8jFYeW2ZaET1/YqFjw7oVE354B6ANzS6h5DDcIGN8El6H5yM
         DXN1lrxoIba4pjW8DSts6jbbeAY2veXepgEPcZyBgSYkC48nB1kgp6oxm8wtKlGeHkXp
         zYqw==
X-Gm-Message-State: AOAM533mTOsEQ2F4NUf6klyJf0n95LDPCQcQbCH8gfxWJta6XUMgr24Y
        198iURuDE161sSgcIPjy1oUsUEJjMZ+cOMc3
X-Google-Smtp-Source: ABdhPJzHKloR/2nKSDoHn+YLky9R8AWO2YdB/ozJDPuL7EOFOdEaeBg49qPy/gRjjmd0lXtFLrzQSULF0gOQ3rhU
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:aa7:d30b:: with SMTP id
 p11mr24645433edq.80.1600204619159; Tue, 15 Sep 2020 14:16:59 -0700 (PDT)
Date:   Tue, 15 Sep 2020 23:15:57 +0200
In-Reply-To: <cover.1600204505.git.andreyknvl@google.com>
Message-Id: <edf6404ca39b224c93ed2b3b27a2b94dfc62fd7d.1600204505.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1600204505.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH v2 15/37] kasan: rename print_shadow_for_address to print_memory_metadata
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
Sender: linux-kernel-owner@vger.kernel.org
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
index ada3cfb43764..8ad1ced1607d 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -255,7 +255,7 @@ static int shadow_pointer_offset(const void *row, const void *shadow)
 		(shadow - row) / SHADOW_BYTES_PER_BLOCK + 1;
 }
 
-static void print_shadow_for_address(const void *addr)
+static void print_memory_metadata(const void *addr)
 {
 	int i;
 	const void *shadow = kasan_mem_to_shadow(addr);
@@ -316,7 +316,7 @@ void kasan_report_invalid_free(void *object, unsigned long ip)
 	pr_err("\n");
 	print_address_description(object, tag);
 	pr_err("\n");
-	print_shadow_for_address(object);
+	print_memory_metadata(object);
 	end_report(&flags);
 }
 
@@ -352,7 +352,7 @@ static void __kasan_report(unsigned long addr, size_t size, bool is_write,
 	if (addr_has_metadata(untagged_addr)) {
 		print_address_description(untagged_addr, get_tag(tagged_addr));
 		pr_err("\n");
-		print_shadow_for_address(info.first_bad_addr);
+		print_memory_metadata(info.first_bad_addr);
 	} else {
 		dump_stack();
 	}
-- 
2.28.0.618.gf4bc123cb7-goog

