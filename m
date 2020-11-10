Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A662AE2DD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732892AbgKJWM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732876AbgKJWM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:12:26 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716D6C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:12:26 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id u16so165795qkm.22
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=l253EjoD9wZWKjcMl+HZL7Y/RWdoQT2M7P8mMLYHCko=;
        b=iJj1JmG/+/LGQYBNxNKzKQSzUcZ/JvHFynshxI+fvd2EdRizy6Qruvz5HpH1X+pS2s
         LmwzJtSEuxZdNM7E2Nh5KEEPhIUj0FyXndlJuLIyOmLIMLeKdsSwkG1Ct+kgofaJE2mE
         LkVwEUc0Kkd1419uEP7R6z+ZVqVv0rJnF59wCeuOwXWdzBVUoLHnajXG92tvPzyD3K0S
         Oo7dS5WPI9J3BbjlgBgEidOIyQbj6780q3v4oMiKj3CA3JSuCe1SQRDACZorbENHyR/m
         233ANeiPkEhvGx/q1i/g7j4xUA2tRRuVUGpwN1JL+ziEL/Qu/TvjT58cy3lJpe58JfLH
         /zsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=l253EjoD9wZWKjcMl+HZL7Y/RWdoQT2M7P8mMLYHCko=;
        b=faX3OTaYoOIRjkHwFys0+0BgZGS1qxc1bVOxkDXnVlndXPRitMzbQlF8u3kNwL5Qk0
         HC0pCvq5cON324ewXTNKZgxXhepD/kZUkVgHcgzWz/UVzk8ACG87Ls32wKDTfAPUOy2L
         OUpikA9pCtYN97+OYGTzhdQrzdC3Hndlj2QTTASAgzyEO2EXAY3MJMPONmvDbVT9SXEN
         nHhFYR5kvIE7R12KHABz8yJxdL5rT9olFjB5JVQuuvkHWvSdSP+QSPPytQWGh43ccmTQ
         FN5kiO+Al2EZ+Hk57v9eHSYT5aITJt2TXuGUCo/oG1EmgRTIQ423DuyHc7rQpiVrNcrL
         KVsQ==
X-Gm-Message-State: AOAM532NPmAlTNw3xJUgdPMimC3toOFjDQ6ulaldXFggQiqO2wCrGtwD
        c1CO0jPw5nboi3bdj5X7cEBX9PyHGknv1jdX
X-Google-Smtp-Source: ABdhPJxokFbxfHNUyx6ne+LPZby1L6L3HSAB4pfI6nXjJC22jzllXP35wpy1FIYaxIucTW79eSxVCqU7onN0ujaX
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:aa8f:: with SMTP id
 f15mr20403403qvb.46.1605046345539; Tue, 10 Nov 2020 14:12:25 -0800 (PST)
Date:   Tue, 10 Nov 2020 23:10:30 +0100
In-Reply-To: <cover.1605046192.git.andreyknvl@google.com>
Message-Id: <c9b863d85d5a22af9b7a294b99ea98e1fe47d7a9.1605046192.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v9 33/44] kasan, mm: untag page address in free_reserved_area
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

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

free_reserved_area() memsets the pages belonging to a given memory area.
As that memory hasn't been allocated via page_alloc, the KASAN tags that
those pages have are 0x00. As the result the memset might result in a tag
mismatch.

Untag the address to avoid spurious faults.

Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
Change-Id: If12b4944383575b8bbd7d971decbd7f04be6748b
---
 mm/page_alloc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 23f5066bd4a5..24b45261e2bd 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7593,6 +7593,11 @@ unsigned long free_reserved_area(void *start, void *end, int poison, const char
 		 * alias for the memset().
 		 */
 		direct_map_addr = page_address(page);
+		/*
+		 * Perform a kasan-unchecked memset() since this memory
+		 * has not been initialized.
+		 */
+		direct_map_addr = kasan_reset_tag(direct_map_addr);
 		if ((unsigned int)poison <= 0xFF)
 			memset(direct_map_addr, poison, PAGE_SIZE);
 
-- 
2.29.2.222.g5d2a92d10f8-goog

