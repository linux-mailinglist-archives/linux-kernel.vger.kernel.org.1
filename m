Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6ACF28C335
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 22:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbgJLUrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 16:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729541AbgJLUqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 16:46:46 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621C9C0613D8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 13:46:06 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id p6so9295805wrm.23
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 13:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=traBQYsXDq59+qKm3sjLr2vdah15OLSAttojnE/4vlo=;
        b=bW93PBWy6nemY2gKKLQnIl0lRZdoml7mRyefWR4721T7HG0oulUbLdoxcevnFAA7kg
         LwHbM5TCY35W8CTjz492p0Y5lDl447wvtP1+/1OQgrLuH3CgugUalCzuEDCXikOnf3oD
         Ok3iKXqjT8LB8NTPQXbmjzl9AtFNcA5gyOQfrdAm1hjP6gv5zVSXe0ShEAsNLq4R8h5D
         rwjFDxToe3PCsHZdwBM+LAPKf4qAsjeN+Y7uBBMSG8ZQD6SyadB2c7RawaFgKYu88cuB
         OCyyItoaODsudu6KJf0h4zJGyxfvaOc5/c6BaX6LpCQ1J576RMgRiFdoi9lfmtNPFoEM
         qimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=traBQYsXDq59+qKm3sjLr2vdah15OLSAttojnE/4vlo=;
        b=dcLSFb92syaccqi23FJPiUbHt5Lto0tc2Ny9JP02LZREO6m21Di1z4YIOlz6pUXDip
         iDaEiYWHwVarK1cSje/3scDX8RqdhWArM41BPB5D51hv2llRlHfE81n/UUVMdBdXuZ5I
         ckSzSuyKZQdpf2+HnlWGnuiewpX/HMZBrP/X7VLY3pfhRYQG3gU4VfyWDq6uChL9xUz1
         ecDgIVFuJzuMHHEAORhnbiKOar07fxMfqq/LhNBDeMAQBUg9kyX+TuT62mYPw9vYLArX
         8vG8qSYnS5W0Gq/naIENEwjBUufN0uNcY9BBp0dMHu28Ge8c7nhYpgk6746TOZCJ0FxJ
         Vyvw==
X-Gm-Message-State: AOAM533Y/wsg+qt2AOgguEei6TtfvVkm7mzJtLlXj909J6d6XBJetrEM
        WMvm+/XrRZvWRqwnPvYeI8vd5IeBsG7gVVvX
X-Google-Smtp-Source: ABdhPJyNk1zfo2KZpql4kYkRkaffcHPcxvd5YlB1ciKfNhyx/rQd/2Jivu4X/alDsFB8bgyWDwncJ4My9B/GEanQ
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:a3c2:: with SMTP id
 m185mr10326465wme.161.1602535565034; Mon, 12 Oct 2020 13:46:05 -0700 (PDT)
Date:   Mon, 12 Oct 2020 22:44:36 +0200
In-Reply-To: <cover.1602535397.git.andreyknvl@google.com>
Message-Id: <38ca7c139b94d2de5152d30496aedb0a193507a8.1602535397.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1602535397.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v5 30/40] kasan, arm64: don't allow SW_TAGS with ARM64_MTE
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

Software tag-based KASAN provides its own tag checking machinery that
can conflict with MTE. Don't allow enabling software tag-based KASAN
when MTE is enabled.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
Change-Id: Icd29bd0c6b1d3d7a0ee3d50c20490f404d34fc97
---
 arch/arm64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index f27297ac70bf..192544fcd1a5 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -131,7 +131,7 @@ config ARM64
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
-	select HAVE_ARCH_KASAN_SW_TAGS if HAVE_ARCH_KASAN
+	select HAVE_ARCH_KASAN_SW_TAGS if (HAVE_ARCH_KASAN && !ARM64_MTE)
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
-- 
2.28.0.1011.ga647a8990f-goog

