Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04DD22B2855
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgKMWSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbgKMWRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:17:54 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD2AC061A4D
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:17:51 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id 198so6773533qkj.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=xwfpXyrGyTT8uiupaW5ZYtlwdHToRfd3Od6MwRYYRNc=;
        b=dThXa5FerngU0mzK5hnc4hNOp9d6sdMJYVGelDjfLKkFynnoFewt04JW/YFc4lokrJ
         OMxm+ndEbrspottOGzu7rwJ5aXvDEPwoyUvLE2IcOQhPUHej39ha+/QuoqCUd2TUV8lU
         0YNLaj4dGxVAxxOFV47WwPMFiFfx1UN0JsDLeDnY5EcIV4f2sscr7d0gL17sPmfGZsxm
         CKQVzRCc9/11C+WXA5mEzoSXbnFq/blMywAlSyNwqFj9rY4arXxL4NaZgpT2FjNjD+I8
         dni7JApOWbN6QpMV+mEhNVW0ZEkP5D47rbWMUfWG9urRXT38RSYRUSANnT1CrZbgTIPq
         Fbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xwfpXyrGyTT8uiupaW5ZYtlwdHToRfd3Od6MwRYYRNc=;
        b=UA3v+BqzN8llnsah6lDQfB0eOUF/mE0n9V8PFL+cauO5F9N4BxlIhfK3KDm7LedRCU
         hsyXRIlrdcHUpEIV6CkUo0h2+nzfBBPXleNb+U4q/y2QeY6dl0c2jKgd48/s4Y35KNeh
         pxhXcT+S7CJrH+1OoNbGs7dx6AZxgNTRu3zZKxmNuZRwksKGMM8Ep9CqQj1MTR1NhNlk
         08M0Tb0t0BVpWIcv3PfZO01/mocfA75EZc5VNFjxnGFqxRasfbE8wA7tbrBhWdo0V8ye
         yw0qGSr9aLMiVqR72RCzmnSY/RbjKKWfzDHTuOQmq7LECkuVwbWDN2fY9poIMgsA5ylG
         mCLw==
X-Gm-Message-State: AOAM531F/MAejCiUtuh5yglXy8UHKAUcNOR2OPMYEHs93Bukrj4enR8q
        IbWoH4+vFGp6u7ZSQ1lrUXUheBb+JAHTfyU3
X-Google-Smtp-Source: ABdhPJw9wDwWHihZsgkjKyRpsr/g0tZ4eeqFUDClLdcHjdRakV4N6V1cQajgAL9yKuWdzX7Y269stAeWB5JbxxuQ
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:4d84:: with SMTP id
 cv4mr4852557qvb.14.1605305871168; Fri, 13 Nov 2020 14:17:51 -0800 (PST)
Date:   Fri, 13 Nov 2020 23:16:08 +0100
In-Reply-To: <cover.1605305705.git.andreyknvl@google.com>
Message-Id: <0355e2644c50417c41d3d2da23c95a50e122716b.1605305705.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605305705.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH mm v10 40/42] kasan, arm64: enable CONFIG_KASAN_HW_TAGS
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

Hardware tag-based KASAN is now ready, enable the configuration option.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
---
Change-Id: I6eb1eea770e6b61ad71c701231b8d815a7ccc853
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b732c8280fc1..35e7cd2d7755 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -136,6 +136,7 @@ config ARM64
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
 	select HAVE_ARCH_KASAN_SW_TAGS if (HAVE_ARCH_KASAN && !ARM64_MTE)
+	select HAVE_ARCH_KASAN_HW_TAGS if (HAVE_ARCH_KASAN && ARM64_MTE)
 	select HAVE_ARCH_KFENCE
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS
-- 
2.29.2.299.gdc1121823c-goog

