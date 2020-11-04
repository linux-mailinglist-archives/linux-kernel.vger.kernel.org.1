Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B90B2A7159
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 00:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732936AbgKDXUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 18:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732851AbgKDXUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 18:20:46 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231DAC0613D2
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 15:20:46 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id t19so50324qta.21
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 15:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=hKqfeGmJU17yqcBnh9EcbhWo2RSZMPrdWdsmZezW6Y0=;
        b=DU5fct66n5Jm+qp7Y3XPj0DiQRgJhNHW8925iNYcwLI2iSfBAGFQonQ69tRIksD3Eo
         3LULKXe1R6fJ8InNE8FCkkmGBHSiiErEJ5eU06/2tlsaiJtpK9poPR2ARandVwj/EslU
         Bv7p0oT0D4iP9QkISKVxHlJSp64gvk4TzuZCBVepJX95QlkDdIBzYsppzFb1p6Ra3oWz
         ZSGWyr93ipcEgwvF/yGbnYWu658KDX30/9Y/7bmBC3VGJbnC9ZGWWZcjuf6xYnza3x1T
         2Uodg8Xeb+rbiyLqUzm0Cd7JaZ+VmkynrQEOoxe0SK7Qa5grYb471sqU44GARExjXzaw
         dLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hKqfeGmJU17yqcBnh9EcbhWo2RSZMPrdWdsmZezW6Y0=;
        b=jbdOruKPEQGKrHnOFCQok7rPFKm3B0cjru84OvjlAJNW/77T4i9hso26hoLuxyt0xq
         qJtJEsoCNs8HrvnicmtV5HyEChHV10Agxk2qwRA4t2cx6m5FNTaO0p9KbIW/qzRh+Ejm
         0JmTrSCQCYf2JzQq0rO5W+rVUteWsawU6XBqUHIJANhGHax9G4QeFEoyWeTQrWdbd/oM
         1o0GoKHzYB2/rIms16YBG2gpMgjHlyJgzbv/6fmqs4KI5z/D1FUkG1ywKifJfjPZAnjC
         /LgaPKf9q3wocmueIM5beGh3y8L4o5FqhyXgzribQhaOxN+8Xt1X6HUv3Kyh/RL0hmEU
         fYNQ==
X-Gm-Message-State: AOAM532mLrvG+KSjhv2xK+rjmq6cal/8F2WoBRZJyMiinMCDBkW7spGs
        USr1T3Zvb4t4Ces4MR2oRRlF5ClBrwLbpfPM
X-Google-Smtp-Source: ABdhPJx+HHvkYwIh6sJ7WWY/Byha2SM4H0CF03j5uewLvlhzz7sNx3WqiWX0omoXFdScFjo7bPiJXDAOM7s7mGPj
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:f3c2:: with SMTP id
 f2mr271968qvm.24.1604532045303; Wed, 04 Nov 2020 15:20:45 -0800 (PST)
Date:   Thu,  5 Nov 2020 00:18:56 +0100
In-Reply-To: <cover.1604531793.git.andreyknvl@google.com>
Message-Id: <c21462b3ea128943b3e7af2788d562aa05a247ae.1604531793.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604531793.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v8 41/43] kasan, arm64: enable CONFIG_KASAN_HW_TAGS
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

Hardware tag-based KASAN is now ready, enable the configuration option.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
Change-Id: I6eb1eea770e6b61ad71c701231b8d815a7ccc853
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 43702780f28c..0996b5d75046 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -135,6 +135,7 @@ config ARM64
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
 	select HAVE_ARCH_KASAN_SW_TAGS if (HAVE_ARCH_KASAN && !ARM64_MTE)
+	select HAVE_ARCH_KASAN_HW_TAGS if (HAVE_ARCH_KASAN && ARM64_MTE)
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
-- 
2.29.1.341.ge80a0c044ae-goog

