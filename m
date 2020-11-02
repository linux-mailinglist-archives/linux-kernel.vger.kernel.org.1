Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F8C2A2F52
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 17:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgKBQHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 11:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbgKBQEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:04:39 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638EBC061A04
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 08:04:37 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id x34so8474237qvx.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 08:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=1lgjgRBViJ2FbMeVeB4B/ij4auA2e+RgHcIDFXlMEDw=;
        b=eTcXtcdfMvy+WyRtuvyCepkwJ6ocKrkM/ieC4IXk8mo02+7bgRtXbnpPS1nnrK4MPu
         jYDSZZBx2ojnnb8RSUPjQttkhA0yMtUHxrV0JfStvjLzl/Ock8CHF6cOpqK46YMtJjwd
         +v7644SuBx4yl2tYa+1nFY1X0iesetVgFBiG3iPcxKcnTqEydGRQIvmnbdmav46A1qbh
         lgEW9LSIvtCsvgb7FQADBiZLxy7DG5MBupKCzPeL19NWko5Yk4XipowXC6PSQQ6WRH6P
         EXlg1OKIPJLhYh17zpZiovtKMzy+GiJMsYQvdRH/4dWCqVI6mem5vvDbt2gkTqoCuP0B
         RLAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1lgjgRBViJ2FbMeVeB4B/ij4auA2e+RgHcIDFXlMEDw=;
        b=jc7wpb5QCCAI/0o7+POIwsaZDdnusEw6r2CMxLs+41syc6OkUdY3urw4VEgGFPyja6
         Ixj+DR61kynlSrRxXgm46OG2Btc0h7hKM3ClLUR+5m8U7kY1Oeid00USCxWhJ84hw96v
         372cbt7KYbXhP/NFwQPxzVEU3oDK5mbFc+DxAkdIhWb5RjvkjQh50Q1USEafYWiBJZaU
         cRJKwoTsuhNRw019P6q83RXbvskkhcZ41BU/eLL9Tt3bxUrB5lNkac1t+OvePLtMZpJq
         1ACf/3GCoSMluALW/kzfLmRCFXkCjJkivrypkBxmk3BkZKy9XxyRGEozd3Jlok990fal
         KGOw==
X-Gm-Message-State: AOAM532+Q8lqyVAvHBDp7gw+kvGZaeP/2mju63QWb97VG0ZRyDK//Q/6
        t+/eUhS7kLY72AkIHcpikPQJvs0Tf78ToXnl
X-Google-Smtp-Source: ABdhPJyVr13ENFyTmUBYq3AfGMq6rXuKCfjybVY7GxJsx9eviaTcVoWJD27K8DdccUef3MIgT/vUdvhG7bdx1RZk
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:6214:162f:: with SMTP id
 e15mr23073972qvw.32.1604333076511; Mon, 02 Nov 2020 08:04:36 -0800 (PST)
Date:   Mon,  2 Nov 2020 17:03:44 +0100
In-Reply-To: <cover.1604333009.git.andreyknvl@google.com>
Message-Id: <0fa21264ea32a5820bc6ba2ea2049ccd513cd016.1604333009.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604333009.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v7 04/41] arm64: kasan: Add arch layer for memory tagging helpers
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
index ac499456740f..a4db457a9023 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -224,6 +224,28 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
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

