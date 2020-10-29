Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD8C29F4E9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 20:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgJ2T0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 15:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbgJ2T0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:26:17 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E924C0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:26:17 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id e8so2492972qtp.18
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=H80qO4w/VNIyZFliU/RvriPpJf0TWzdH6o9fbTX/riQ=;
        b=FcdRk45xjuSu511+7QZqV1YehKKYofJq5I1I+jsbFlug5tzG7RjNEqT6z0pRKuaY13
         x7j2MKykt6ZjkU9SSs4GvnUFcPwfnPkT8rAyMYXGC42ravT17unGIsZMtNW22gLI9/B7
         1Tip1oypOKxC+5Yulao0y81UAm+vOeT/lQq7vAwnR/ASI+dNJr8vw+Z7ScNQjcTCa/LA
         1LW1peLgHchKqv16ET5WmzOaHh8a3KUTF6btDYPyJt6OtC/+444lcbXZ0JFqwPNv3zIl
         mZK1/Ikt5LRV2u4A76w67tDem24QUF6RjirAE5je1ELzVfEoJxJzIU2+fX1ae6TRDMwR
         rdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=H80qO4w/VNIyZFliU/RvriPpJf0TWzdH6o9fbTX/riQ=;
        b=ninvabtM0hTlBteE0NqTHyvP8ocRYRKSLsSEbM4LYe2reG6HTAMAE0LvMudRvqy9o9
         TzQnl27OdpBnde3Fo1Ue0PA7opUnGdpleH/jcBVwzocPzhK/lVa5Z5aiMS5aYAkNPGVz
         pN8P5eh7C4xhexbIs7fcho3dPvCOW6Wj8ut1jJPf5FiAfU83xLRM3VH/xWAhO73+O/qP
         WDAtcUIfQQTyuRbaCfferX2DFM/afVBm177N4l2B9epIo4/OW6R+kx8kvL+D04NBh/i6
         demwisWqZT+VDHDtKsYdC/O74fM+K68vFGuz1eGmYOHPi6RNQDLR0/jSZASfTJZxGGhz
         pwbA==
X-Gm-Message-State: AOAM531Qzfkd63LqdQvYUvGCmPOA9Hka2a5LT3VaXgtBSKyqkTYmG6HN
        Qwoi/l1xH6QTH+it58C0GFrFI/zhymk3YXiC
X-Google-Smtp-Source: ABdhPJwIhQZtghJh9vbvgOS2IzWhrQ1kM70OgR4BWqB7lciIN3SnFRHajKW2Oezj0cvs3asRnscK+fhOeDOr5n7E
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:59cf:: with SMTP id
 el15mr6145700qvb.17.1603999576430; Thu, 29 Oct 2020 12:26:16 -0700 (PDT)
Date:   Thu, 29 Oct 2020 20:25:25 +0100
In-Reply-To: <cover.1603999489.git.andreyknvl@google.com>
Message-Id: <cc9e445314fc99b1aeee347c6a9b99f0a6e37d23.1603999489.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1603999489.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v6 04/40] arm64: kasan: Add arch layer for memory tagging helpers
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
2.29.1.341.ge80a0c044ae-goog

