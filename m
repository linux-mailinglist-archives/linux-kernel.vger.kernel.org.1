Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD29428E806
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 22:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389211AbgJNUpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 16:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388766AbgJNUpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 16:45:02 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AD4C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 13:45:02 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id d197so403073wmd.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 13:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=y/nVmKw0+obzUSPYrpDLElf69GpBMgys1Kxk8lAQxBs=;
        b=XvQbYOsIKhEqKl23IuK1fXA2y07SX18RUP95UhAhaY6RWyGfkovCCcGQ7zTV2CIJGI
         hCnJaXWytthbkfikmWJxhHeen7rDgDnPKfBUOiIA3ZemYDk+nnxjaHECNDaK1i74BtlA
         0eMRhJl5f7B0p7cuaJEYMAsSy886arR89DkzAruWmzt8KxJv2wHeLXmiLgr4azQQxsUR
         Z1A9flLjPDvV9ikD8eYXBbabBN4wWoO6BCux2PPScbAqBHuol3N6aE3ZqydFPVR1t03q
         32trNbUMIyH6C2ZHmAuFUHJmyMeoz9zPQ1pvNsvSKD73a2WRSWwAOMj+p8N5v2N+73Qt
         tPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=y/nVmKw0+obzUSPYrpDLElf69GpBMgys1Kxk8lAQxBs=;
        b=VezT8njCDyUNgojpu1KesV63weri8FwAWHdH4Ka/1Obe0nMvoiE43+H4fwDMkJkn1g
         ORtl8iW5CToqWbIe168XSz+funHHIbykXbsNUAV88rdxJXhFb8pC+5LKKNNVeuBSYpgJ
         qvGw1cAT2aTn5EuW5kNeAUxASqKoKItWL/av6UZKY+Ulnf8zg9lTebqC0o5FlqIaDjag
         QoRXr53BfZKuEbqLCby9hXrVqj3xYkssKVDL3NQZ4tl5y5v+R8htlBsQ7mDZkpWjgBSG
         q5tB+f22BibIdR9XQap7u+VRcEMwtXTuVsncX4dUOMnrOLv7UDip5qDoxvQ/jYJSGdUI
         yf0A==
X-Gm-Message-State: AOAM532yTGj7Urj411YyipWBLfvOnZOkq5wl4f+H1zQP+5UUGLA6wbf5
        s8ZFCG2H7pVTj+G7rgJZ+SHj0qXXecgFvp4p
X-Google-Smtp-Source: ABdhPJx+U4Ceh8C4YkS4Sb82SzzYUfF+N5JOdKmPBRbx92Phx19w4/9rl54paVWg9NkmBz3jWKT7ME4GLv0Ql5L4
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a7b:c181:: with SMTP id
 y1mr616036wmi.58.1602708300850; Wed, 14 Oct 2020 13:45:00 -0700 (PDT)
Date:   Wed, 14 Oct 2020 22:44:35 +0200
In-Reply-To: <cover.1602708025.git.andreyknvl@google.com>
Message-Id: <001de82050c77c5b49aab8ce2adcc7ed7d93e7ad.1602708025.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1602708025.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH RFC 7/8] arm64: kasan: Add system_supports_tags helper
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
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

Add a helper that exposes information about whether the system supports
memory tagging to be called in generic code.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Link: https://linux-review.googlesource.com/id/Ib4b56a42c57c6293df29a0cdfee334c3ca7bdab4
---
 arch/arm64/include/asm/memory.h | 1 +
 mm/kasan/kasan.h                | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index b5d6b824c21c..6d2b7c54780e 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -232,6 +232,7 @@ static inline const void *__tag_set(const void *addr, u8 tag)
 }
 
 #ifdef CONFIG_KASAN_HW_TAGS
+#define arch_system_supports_tags()		system_supports_mte()
 #define arch_init_tags(max_tag)			mte_init_tags(max_tag)
 #define arch_get_random_tag()			mte_get_random_tag()
 #define arch_get_mem_tag(addr)			mte_get_mem_tag(addr)
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index e5b8367a07f2..47d6074c7958 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -257,6 +257,9 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
 #define reset_tag(addr)		((void *)arch_kasan_reset_tag(addr))
 #define get_tag(addr)		arch_kasan_get_tag(addr)
 
+#ifndef arch_system_supports_tags
+#define arch_system_supports_tags() (false)
+#endif
 #ifndef arch_init_tags
 #define arch_init_tags(max_tag)
 #endif
@@ -270,6 +273,7 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
 #define arch_set_mem_tag_range(addr, size, tag) ((void *)(addr))
 #endif
 
+#define system_supports_tags()			arch_system_supports_tags()
 #define init_tags(max_tag)			arch_init_tags(max_tag)
 #define get_random_tag()			arch_get_random_tag()
 #define get_mem_tag(addr)			arch_get_mem_tag(addr)
-- 
2.28.0.1011.ga647a8990f-goog

