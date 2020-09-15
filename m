Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB1B26B01F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 00:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgIOWBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 18:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728072AbgIOV1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 17:27:52 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDCEC0611C0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:17:34 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id hh10so1835474ejb.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=TX70ilGdAcdyg1YBqmaSz5QEacCDiTB+zVlfonsPQRU=;
        b=ejaRrNgwlp8ys+4BQrnEIRa6JCD1DMaKcBwnb6OubgjCfWn7NE3QbT78QsJNlgYl8X
         uM2iLdYkRCRZVwVQWIM0JNTTlqRSByOm+y9tVhjfylzf2VSM6Txz24Jfwoj9xuRUu5eq
         XSk5LuejKSujNUpLhSZYHYDVvGikaSYVQ8zW8/c8swLI3F17HrPWXWe1JnzbayOYXV6i
         +h8vg0HiS72Ql8kaieke3o6g5BZgc9WxK8gmLJsv1NXIvY/KTPaiJiBAX2UrbUTN4O2f
         VmRLgpabm/mNCrvMiI/7bDXbGRB3zjFVqbCyJv7JAbUl4unwvVSbE53x8P7LPnXJYDCT
         /dfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TX70ilGdAcdyg1YBqmaSz5QEacCDiTB+zVlfonsPQRU=;
        b=pFpo6KXiTdxNlImeYceBhtfTIbT95154t0EaJns1rz6BRYKf76k/s5sO04rTaC8jtj
         CVSiBqe4gcl6OHmup3mXJ1Ue8548Xvu8WfvYKAfRYVCgNRxS6U6oK6uEWLoqMReJCAhs
         3LWQVmHEf7ZT3s2KlJU1vyxPj8lOMSRP2Wft8P6777QWluf/j84jICJ5RHrBh33pY0Qh
         itDJw1UfGdH7dAqaKNSZNIlMILYtexZqM41VyqhJ9GjP6cMJnjfflERgtxv/ObAIvghl
         v1yBdLsilo64LwXiT7Oi3R8GJn7uFIyQ7FLpNhGe4uWr0a7HlKVe1vsIuUKZ6izKXLMC
         MjGQ==
X-Gm-Message-State: AOAM532TBoVCBauJq/f9f6qRoKg+rvY7xMgnhis/N1U8h2IkX6mKuhLH
        rXigLSWTmeW2UkAVZNPzYwH2q21UMj8aJKyI
X-Google-Smtp-Source: ABdhPJzXD5k/cAT+QhVmJFoutrziWlgaMN8QxqxV/HqrCs5L8f197jAYO7cCyYNJOGv6gz2W5knXALPYvJNw370q
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a17:906:4902:: with SMTP id
 b2mr21685991ejq.208.1600204653213; Tue, 15 Sep 2020 14:17:33 -0700 (PDT)
Date:   Tue, 15 Sep 2020 23:16:11 +0200
In-Reply-To: <cover.1600204505.git.andreyknvl@google.com>
Message-Id: <0845668a82ddd3eeb3f652712597ffd056f97504.1600204505.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1600204505.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH v2 29/37] arm64: kasan: Align allocations for HW_TAGS
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

Hardware tag-based KASAN uses the memory tagging approach, which requires
all allocations to be aligned to the memory granule size. Align the
allocations to MTE_GRANULE_SIZE via ARCH_SLAB_MINALIGN when
CONFIG_KASAN_HW_TAGS is enabled.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
Change-Id: I51ebd3f9645e6330e5a92973bf7c86b62d632c2b
---
 arch/arm64/include/asm/cache.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
index a4d1b5f771f6..acf6a5097cce 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -6,6 +6,7 @@
 #define __ASM_CACHE_H
 
 #include <asm/cputype.h>
+#include <asm/mte-helpers.h>
 
 #define CTR_L1IP_SHIFT		14
 #define CTR_L1IP_MASK		3
@@ -50,6 +51,8 @@
 
 #ifdef CONFIG_KASAN_SW_TAGS
 #define ARCH_SLAB_MINALIGN	(1ULL << KASAN_SHADOW_SCALE_SHIFT)
+#elif defined(CONFIG_KASAN_HW_TAGS)
+#define ARCH_SLAB_MINALIGN	MTE_GRANULE_SIZE
 #endif
 
 #ifndef __ASSEMBLY__
-- 
2.28.0.618.gf4bc123cb7-goog

