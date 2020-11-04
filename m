Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2692A715E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 00:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732972AbgKDXVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 18:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732857AbgKDXUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 18:20:32 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566A3C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 15:20:30 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id m4so31190wrq.23
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 15:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=VwB+r0G+nQxE1tuBjegw7DUOaY0AiMb9tMmTZBhg6+8=;
        b=MDmPTXJQevl3NQ6pPgEvXpSSQtSuvY2cTzhAh3FiI69d33h3RwvxrJF8DhF4f9ozzW
         38bGuVV/PLZ/cPT/AlhSH3FfbpQN9mZJ58knWztbqd6E7JMGFYQ7XWAqQyJfnNNNGDFw
         d5rl22jSmqJvbLqs0mPj/8hYcvCcQFMBIfiWQyKhKZRnxiW4bT/I5A56UDSnrNFCF/vA
         P6FRc3aJRnfbADBibKj/h59pLcE+PT8sseLnPTzIatx6eW/X7jX8BiGJ6FrffbHcc4/Z
         58x0qGiCyUk2TeU4RU2RgD61GpjPYNjkeeQTO/N9ew2p8fegRjyWCv//Rs5tIMfLiwRu
         GxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VwB+r0G+nQxE1tuBjegw7DUOaY0AiMb9tMmTZBhg6+8=;
        b=pxpot20lJ5ihiATbSe+V02S+rw44Fk44XhcWvg+ycecZ/W11nn8dvN3RCaD+YFuNRm
         8aepDiD3b5jYblhJsxW4IKjp6fHQDJfZOyPxiypi7KaI7WDhneLf+D9ytiUXmKWvrcup
         FcCXjWFJeEySDJO6p0p5ynXiZGo70IKx5CnxxOjFvzkWo58XE9dvwddGrDzEf8FFau/X
         U8oOVsUVAO4oTkSETGvenogUbur3yNdmVeFvYKz7yt02Uwurjt8B/Nobpw95xrWtkYTi
         k9rth7RhHNmDcHh5ziQPtXRdEKUnuzFAbeF6SFljw7ozcV2J4vVae1SqEYiDBJsqTsOC
         G/7g==
X-Gm-Message-State: AOAM5313pUfvFEajsGexBspXYomd1jzKts0duhrGIYU+pb/niHEIPEgx
        rEb3bWQS4013aYmZ0nWc+ixg7xRLwRcWT7pg
X-Google-Smtp-Source: ABdhPJxroHsqJ2INmWm39MqryU/d9TuUcrDwnrdfUwfCHfE74IyGC4tjThzYCtzqtdPk9orQeLHnvF6nrHhjcgxf
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a7b:c101:: with SMTP id
 w1mr80924wmi.170.1604532028927; Wed, 04 Nov 2020 15:20:28 -0800 (PST)
Date:   Thu,  5 Nov 2020 00:18:49 +0100
In-Reply-To: <cover.1604531793.git.andreyknvl@google.com>
Message-Id: <b223b35fb4ae833ca0ae579de37c6b9f0aa828c3.1604531793.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604531793.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v8 34/43] arm64: kasan: Add arch layer for memory tagging helpers
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

This patch add a set of arch_*() memory tagging helpers currently only
defined for arm64 when hardware tag-based KASAN is enabled. These helpers
will be used by KASAN runtime to implement the hardware tag-based mode.

The arch-level indirection level is introduced to simplify adding hardware
tag-based KASAN support for other architectures in the future by defining
the appropriate arch_*() macros.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Co-developed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
Change-Id: I42b0795a28067872f8308e00c6f0195bca435c2a
---
 arch/arm64/include/asm/memory.h |  8 ++++++++
 mm/kasan/kasan.h                | 22 ++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index cd61239bae8c..580d6ef17079 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -230,6 +230,14 @@ static inline const void *__tag_set(const void *addr, u8 tag)
 	return (const void *)(__addr | __tag_shifted(tag));
 }
 
+#ifdef CONFIG_KASAN_HW_TAGS
+#define arch_init_tags(max_tag)			mte_init_tags(max_tag)
+#define arch_get_random_tag()			mte_get_random_tag()
+#define arch_get_mem_tag(addr)			mte_get_mem_tag(addr)
+#define arch_set_mem_tag_range(addr, size, tag)	\
+			mte_set_mem_tag_range((addr), (size), (tag))
+#endif /* CONFIG_KASAN_HW_TAGS */
+
 /*
  * Physical vs virtual RAM address space conversion.  These are
  * private definitions which should NOT be used outside memory.h
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index b5b00bff358f..e3cd6a3d2b23 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -241,6 +241,28 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
 #define reset_tag(addr)		((void *)arch_kasan_reset_tag(addr))
 #define get_tag(addr)		arch_kasan_get_tag(addr)
 
+#ifdef CONFIG_KASAN_HW_TAGS
+
+#ifndef arch_init_tags
+#define arch_init_tags(max_tag)
+#endif
+#ifndef arch_get_random_tag
+#define arch_get_random_tag()	(0xFF)
+#endif
+#ifndef arch_get_mem_tag
+#define arch_get_mem_tag(addr)	(0xFF)
+#endif
+#ifndef arch_set_mem_tag_range
+#define arch_set_mem_tag_range(addr, size, tag) ((void *)(addr))
+#endif
+
+#define hw_init_tags(max_tag)			arch_init_tags(max_tag)
+#define hw_get_random_tag()			arch_get_random_tag()
+#define hw_get_mem_tag(addr)			arch_get_mem_tag(addr)
+#define hw_set_mem_tag_range(addr, size, tag)	arch_set_mem_tag_range((addr), (size), (tag))
+
+#endif /* CONFIG_KASAN_HW_TAGS */
+
 /*
  * Exported functions for interfaces called from assembly or from generated
  * code. Declarations here to avoid warning about missing declarations.
-- 
2.29.1.341.ge80a0c044ae-goog

