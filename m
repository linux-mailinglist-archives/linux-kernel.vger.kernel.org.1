Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 489AA2AE304
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732287AbgKJWMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730254AbgKJWL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:11:59 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6261C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:11:57 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id v134so173074qka.19
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=5uhZzkc7GaVITot0FsuHIhcvnz4Kwzzg7fDog44yjpY=;
        b=CLSgr8f8FTIZg6bMIyxaGVeeEcFOrWMDPbZPAvZT1MfB4z8Suhe5boRMsumGyvFNk1
         LjKKm50iHbXfmNRu6XUs4UoHXQGDFig39TSyU2sHd0hIZ2EmrYhkxzXr8U4p+VkIwgdM
         2IMyJ+g9REJj6rC5asdtdPRqDTIWpdnLuyBD3ISr476SrLsl4NF2QxsJYt1ycv9Li3MH
         c9uWYFVeV0cpoffBVtKxcgpoC5/H2MqBNHloRHtFwiFpBpQmj6raqt5/JRE4I92gqqWy
         iMqrQ8YQcXmy5elG+vxv2r33iGPpMhXlwcHnNfP58dfpYMKVCKC1qKG9aVX4wbq0hppg
         wL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5uhZzkc7GaVITot0FsuHIhcvnz4Kwzzg7fDog44yjpY=;
        b=fC6UUqjkkz9OPwjGWjEArfK8MjaDoPbJbl3XTS1FkxKmfaZnzmRqaTxRMg7k6scBck
         zdkn1+5oy0qD9Xd8pN+6BTZbgUfu2Sn/mEJ5Ws0z3BbcvLoe83MnyqcQ9b0LN9ZtuRVT
         uORIl+V6VLXN8B66RpYbjnx7Dp4fotUr9La82x4I7SiH+f6AuTFC5t1RvES5XN0HZ+2E
         d2lZvFpL70oEVc6EBsot5EX04quInJzHfnB0QUqKNT7an1BvGRWPJ9zeEWp3AnNa4Nnz
         yJNPnsLUOT6esn3xAX8OYepItNTvfvw8Ejuiu7Txj9XUoQ4KUPJVCA7SLFYD4kBCPq9P
         boCw==
X-Gm-Message-State: AOAM532kcoJHkIq9ZGvkcCAgXripWjkU+wMLSmMAbPEDR9VVVIFQTabb
        PX03Tpe/tvJ6IYvUlOKE+1m8CQNlKHcQJAxa
X-Google-Smtp-Source: ABdhPJxlGUcHEC0cFkjY++xEGK8kde6sgJxy5/dNx6kc2EDZ6TfPWJDPwJEgMWeFJJ/BNXjkc/AzCq+AKE2M2FFw
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:47b0:: with SMTP id
 a16mr21217064qvz.22.1605046316972; Tue, 10 Nov 2020 14:11:56 -0800 (PST)
Date:   Tue, 10 Nov 2020 23:10:18 +0100
In-Reply-To: <cover.1605046192.git.andreyknvl@google.com>
Message-Id: <49f7f2c12b0d5805f9a7b7092b986bbc2dd077a1.1605046192.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v9 21/44] kasan: kasan_non_canonical_hook only for software modes
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

kasan_non_canonical_hook() is only applicable to KASAN modes that use
shadow memory, and won't be needed for hardware tag-based KASAN.

No functional changes for software modes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Marco Elver <elver@google.com>
---
Change-Id: Icc9f5ef100a2e86f3a4214a0c3131a68266181b2
---
 mm/kasan/report.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 5d5733831ad7..594bad2a3a5e 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -403,7 +403,8 @@ bool kasan_report(unsigned long addr, size_t size, bool is_write,
 	return ret;
 }
 
-#ifdef CONFIG_KASAN_INLINE
+#if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) && \
+	defined(CONFIG_KASAN_INLINE)
 /*
  * With CONFIG_KASAN_INLINE, accesses to bogus pointers (outside the high
  * canonical half of the address space) cause out-of-bounds shadow memory reads
-- 
2.29.2.222.g5d2a92d10f8-goog

