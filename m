Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5922C15F4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 21:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731663AbgKWUJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 15:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731511AbgKWUJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 15:09:46 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21576C061A4E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:09:46 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id b11so5476618qkk.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=xwstu1pRxVcUMTNe9jDo3bBYpkf7yAJWDfxoqoLQsg4=;
        b=uWayMXuKdZWCV1higrGQv2NpqktTtho9GZJFFe0mcghk2JofBBlwlzxFNNAuyBzcnb
         MnSPmOQMzN+Qkemk7HFCiZNXc6G47pikO3FonIsdFF2kYE+L6KGsi31oInZPAPfvtip4
         RzXFmNksxrR6+VTWmHVkR4hON69ypwY4FsbxCbReJ2EjHq+ubye0Meykm6zzeTKy6sRt
         iFCK088RdDgX5Uxti57MUD3MbacQ39860rUPvwy5MGkReRtqCdLzRMJP0OjveVU3sHyn
         fe5RteZeEGu/2stD0UtDYfr8h/fD9c+E1+HBE88f13iohLTiaR0b8aoYISnSbwFAF3OP
         H0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xwstu1pRxVcUMTNe9jDo3bBYpkf7yAJWDfxoqoLQsg4=;
        b=I2CvBlY8T9VkYt3oUpjPqNgT1tAeQ95Sk4xnnLfKdU2jXNAGL1Mzt4Onm25PNGsHZ1
         /C+LiTXQ7SdSUXL0gGa0FekWYwRHFtnnp+JolDCgZjkPbvLjSMI0HR8++cyFY08sNxrd
         K97uyMK/n+rD1BBTfoSX+PG6ttpjGUX1tCHirikPFUZUqUY5FG1SMb9Z3wfGAIaFDuPR
         efXSCb591QF57K1PVa9z9cs6oWSIeE/jM8L1eZk7+gtViCChEvJros93GW7UP2ZCHGBW
         rRfTshUYbP10Rr0sYGB69pBlbZLxPqIuiBdZNNc2+FKKC6KwvdnsVr+vpqaHCqW3ONK/
         k45A==
X-Gm-Message-State: AOAM5312oF1Cs0I09qt4754vtC3dfAztu8Jo9r5yvYq5AT1BCVgquvjk
        oCtxmL+95MTDtQK6OiEvvmhi7NOHdJIDWqOc
X-Google-Smtp-Source: ABdhPJyVCH3aV9RtNeLidfSxwK+YqFC9NJxqna13EKgsEqqpHDv7bbr5p0NI6j2KmS4DiR8SqCIix/ia52phMGBM
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:5621:: with SMTP id
 cb1mr1321441qvb.12.1606162185203; Mon, 23 Nov 2020 12:09:45 -0800 (PST)
Date:   Mon, 23 Nov 2020 21:07:57 +0100
In-Reply-To: <cover.1606161801.git.andreyknvl@google.com>
Message-Id: <fc9e5bb71201c03131a2fc00a74125723568dda9.1606161801.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1606161801.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH mm v11 33/42] arm64: kasan: Add arch layer for memory tagging helpers
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
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
 arch/arm64/include/asm/memory.h |  9 +++++++++
 mm/kasan/kasan.h                | 26 ++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 556cb2d62b5b..3bc08e6cf82e 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -230,6 +230,15 @@ static inline const void *__tag_set(const void *addr, u8 tag)
 	return (const void *)(__addr | __tag_shifted(tag));
 }
 
+#ifdef CONFIG_KASAN_HW_TAGS
+#define arch_enable_tagging()			mte_enable_kernel()
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
index 3b349a6e799d..bc4f28156157 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -243,6 +243,32 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
 #define reset_tag(addr)		((void *)arch_kasan_reset_tag(addr))
 #define get_tag(addr)		arch_kasan_get_tag(addr)
 
+#ifdef CONFIG_KASAN_HW_TAGS
+
+#ifndef arch_enable_tagging
+#define arch_enable_tagging()
+#endif
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
+#define hw_enable_tagging()			arch_enable_tagging()
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
2.29.2.454.gaff20da3a2-goog

