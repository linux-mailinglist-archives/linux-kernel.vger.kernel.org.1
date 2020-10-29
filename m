Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F2929F50C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 20:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgJ2T1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 15:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgJ2T1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:27:12 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4820DC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:27:12 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id t11so1685376wrv.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=96T+1f9i/jCV3zB6gHtRoH9MAYIWASsGc4o7euuXITQ=;
        b=tJOGLhLJo/NqHD/71ViDLNriFuBgqAfaBX50uN+gDPVLY9EhR9jFkCdXVZLGpLa89D
         pCxjumJU1b+1KZ4w/LYX820n8cwzToqtUuRYOKOnOX1pso5M2u/DtJ6Q0grxhdwERIhp
         EVnO0TcUAmRO78BnOw14ehkgbVQOBz5DXzJioKgglSmR4XAwKzu190Rfbw8qnQ73PRAZ
         6o/kI/8vCXZzyIe3m7KSHonC5mwKXef19iRjb5qhwlzYt3GIA9l8BzxmFmc0okU0zbxV
         zqRZwI+5c7eKuclhHNcCeqVDR5naj6ERrUQkZ0w1ZSHtlmTYenidY6vh4buMhRERB8pR
         fqWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=96T+1f9i/jCV3zB6gHtRoH9MAYIWASsGc4o7euuXITQ=;
        b=V0nuHQsI1plMWVVlMe188sKC/XqIcO/UZjLH1OyshFD17fHb3mvxc1rF2AbcunboiH
         0oJVUEheIRJjfPeGNLIuSigg+nSc9D/LJhSjSKBeHYAVUj9HMSA1EDDjBUVhgwuiMoaA
         IdzMF5VK2qc5EiARzUXNBaBtg90e97RRKj7HHTdm2vY7vCf25shY9yYMVTVEobn8zZ/k
         XXjIQ6DwPjbIASvD+lPyml646MuEcKI9OLIdp8peCzLr+hnTIJRaeljMvqBHGV2BVEKR
         wC5yz+N0SFZWIl6KzY3f3nk8BfPiwj/8P1KLd05I37uxhEwkDeK1C74Yb1+EJpvzeirv
         8e9g==
X-Gm-Message-State: AOAM533q4fPfsc//Aj2nWev7kyN3PD7BhNw6609YsAlxHHgI4s9J/LDK
        JC665ZK7H6FL/zoW7V2WDiAkGzS7tGGazhC2
X-Google-Smtp-Source: ABdhPJz4LeK6qoiHBAtJpFwXYYAFbEQhLpwU5GRYe7Th77YTJijuksDPP3x85BEGMq5HFnuUBGmKT7FJdVHArboS
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:600c:2246:: with SMTP id
 a6mr723387wmm.135.1603999630912; Thu, 29 Oct 2020 12:27:10 -0700 (PDT)
Date:   Thu, 29 Oct 2020 20:25:47 +0100
In-Reply-To: <cover.1603999489.git.andreyknvl@google.com>
Message-Id: <29aedfa17e38384b43560d89742b1c9f61b3d0ca.1603999489.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1603999489.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v6 26/40] kasan: rename print_shadow_for_address to print_memory_metadata
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

