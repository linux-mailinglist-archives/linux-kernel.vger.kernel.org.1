Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0EF128C32C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 22:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731433AbgJLUqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 16:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388126AbgJLUpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 16:45:10 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD908C0613D8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 13:45:03 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id d22so3068433qtn.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 13:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=hYhPlgHhKognLzO8gXB6+9AazEuqabRApbqRCWki1UM=;
        b=s25bdqcYuN60xhUpV4XtCFxvAN0pCYTKYluuxwYunvQ+FEmuKFQVb4BVZJgzT4dNqK
         kP70sljL9BWm2A4+vdc8+3rnXLWi4kOwepJdFpWeVPcvGv/fZ7ypAiEnSRPxYJRHphgf
         bm5fEoXjkJWWWJ4ZrgWQrDMS5eJ73PV2xUwmYWX1UDm2Rbcwg+QfiuqBe4RjT4Shs/0H
         W7TZMrIYW0p1GgwzQ0GnB5PvJAzUfLqH0XyoFh6NZXaNSn9c/2XhRaeCR7Y8bwd/TnsY
         H0pDIzxwHDeGgLY87KQ0pyCJkxykFsfwL8n1+5e6TCQS1uqIRo72cmSPiwYg9OriHuWJ
         07lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hYhPlgHhKognLzO8gXB6+9AazEuqabRApbqRCWki1UM=;
        b=VtiOXdoP6mkybEtteJA4nKc11Lv06JJDA1PNimuzOUdED/R/uZJEXHMoYhhoApir2C
         cbaWm79z/A0Cli55o7nzEhZjH3hluHA6IIi+p2zLPmXvCZKD8BvP+8lEVDjgkBTbx3Lx
         xXaze9VqHMlnE3zDK9t21gIfiwujERyo9fXcxjYL72/gHNZt2PBaqbrm3NvnG37sX1yu
         dKJLjA2KCW7CzLBdgYDOhnpATsk0ufnPE/2aVTKrKgxb1w5C8WZXIkIFogCAC3fxUR0B
         e0xKIytasPSOaYXpxF3IwPn3CL7yzk/4LjG2GOEXbVPKSA4wajstok78H5hY1ETN++4n
         BKCg==
X-Gm-Message-State: AOAM532QxdL3SxwDaMRAnIze8gHdYqTdOHOPwr7pdIrraLTOzw7ucTZn
        hFF4feLnfEJz+8tjH/JGaH5YQ8+2vs56xG9f
X-Google-Smtp-Source: ABdhPJwaNPlpGwmYfdHdyKnOCq/sXjOWuYfg2aFhvTEyA/j3nqhKbHErhH63rc7rG9/iYi3j0PjOMCkrqD8Br81f
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:4150:: with SMTP id
 z16mr21553789qvp.50.1602535502842; Mon, 12 Oct 2020 13:45:02 -0700 (PDT)
Date:   Mon, 12 Oct 2020 22:44:10 +0200
In-Reply-To: <cover.1602535397.git.andreyknvl@google.com>
Message-Id: <c4ff07654478c1ba427b0366122a1ebee3f46387.1602535397.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1602535397.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v5 04/40] arm64: kasan: Add arch layer for memory tagging helpers
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
 mm/kasan/kasan.h                | 18 ++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index e424fc3a68cb..268a3b6cebd2 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -231,6 +231,14 @@ static inline const void *__tag_set(const void *addr, u8 tag)
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
index ac499456740f..633f8902e5e2 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -224,6 +224,24 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
 #define reset_tag(addr)		((void *)arch_kasan_reset_tag(addr))
 #define get_tag(addr)		arch_kasan_get_tag(addr)
 
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
+#define init_tags(max_tag)			arch_init_tags(max_tag)
+#define get_random_tag()			arch_get_random_tag()
+#define get_mem_tag(addr)			arch_get_mem_tag(addr)
+#define set_mem_tag_range(addr, size, tag)	arch_set_mem_tag_range((addr), (size), (tag))
+
 /*
  * Exported functions for interfaces called from assembly or from generated
  * code. Declarations here to avoid warning about missing declarations.
-- 
2.28.0.1011.ga647a8990f-goog

