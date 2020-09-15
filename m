Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D6026B023
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 00:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgIOWCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 18:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbgIOV1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 17:27:52 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E4EC06121D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:17:09 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id 139so4075851qkl.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=mh8O150eeMuxxMH0jStzmqkyZ8vLujB12mmwVNwjeBw=;
        b=ETreXfWqm2ORqdMXEMxCL+KWztT+SunXDBq3Z8Y5/Ta9DUNYpbGEq+rfeJBjq3TwOi
         bDvSLCjukG2rPbXHHVN5lgj+ngjup+3ad42VnPwe0Wbs1Kd861h1wkjrCAFCKMeLiJd6
         f83l8FT2dSaGmHBbiVpnJXzd1AyYGbBMVhJkngqxDMtOP50ghNzSQkovTErdD50IYAYL
         ize0dUMXPLYQkEezeC4pjaFj8IIAua6feAl1B4mMmYaE+AguzMo11v21qwJ3LE/KV/ZR
         xoAphSZl10RGs5gC4IhwNE/WKHefh12mj/++rdP85rI3078p9dLncrqeXcd6owNyoBaM
         eD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mh8O150eeMuxxMH0jStzmqkyZ8vLujB12mmwVNwjeBw=;
        b=I4P1jBq3X3M1tlglU8/3g1H46x+ady6FuLFt3BR3Ck5Ix1M329a9GFccF2NGOkmEcx
         6jj29P0s5/JOVMj4RH9pEH23xof2toI5OLJngmjpNHFgSGGu7O3o4Ema6S1Dq9ZnEAwJ
         B+5MVG/u2y58mg3SR0F1+K3GFHGR3vagO8uNY7sTKz/TCJir0OEENj/o5CkGK0D8UYXF
         ClDk/ebevGiBrQethrLXitJFy7UHWzfgUr3WAUy5jCJAdsvHJfV6iSCPvQgTtXvQYEB9
         J1RX7AsZs4LNqw7tQVrVN1N0UagD3SpvrZRoRSkrzTEPrpHtKAKNUMBcpKr7W7GdWJlO
         Gh5A==
X-Gm-Message-State: AOAM531NMcPGT0gvBJQ/js26YQnjjW0eElSXW1PpbhG9OpTnqufN1AWn
        1D8zlOmHmzQFdTlifNyUgja1cZHC8o1ZpQNO
X-Google-Smtp-Source: ABdhPJw8kuypKDjq36m+5MWDEBM2m2sdKvtM6e8W1eHE1KXnLuswMPPxAtQrR0GbHR2xbkTzUQB3mGa+9I5iKj5Y
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:f2c1:: with SMTP id
 c1mr11709701qvm.30.1600204628690; Tue, 15 Sep 2020 14:17:08 -0700 (PDT)
Date:   Tue, 15 Sep 2020 23:16:01 +0200
In-Reply-To: <cover.1600204505.git.andreyknvl@google.com>
Message-Id: <42f25c11d97aa8497ee3851ee3531b379d6a922e.1600204505.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1600204505.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH v2 19/37] kasan: don't allow SW_TAGS with ARM64_MTE
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

Software tag-based KASAN provides its own tag checking machinery that
can conflict with MTE. Don't allow enabling software tag-based KASAN
when MTE is enabled.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
Change-Id: Icd29bd0c6b1d3d7a0ee3d50c20490f404d34fc97
---
 arch/arm64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e7450fbd0aa7..e875db8e1c86 100644
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
2.28.0.618.gf4bc123cb7-goog

