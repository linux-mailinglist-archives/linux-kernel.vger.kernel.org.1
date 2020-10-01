Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31423280B34
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 01:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387698AbgJAXMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 19:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387562AbgJAXMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 19:12:16 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FAAC0613E5
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 16:12:16 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id r128so48003qkc.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 16:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=SUeSNLKjsRu2tdmPXnlbC/OTs32hqr/cgOt2tHXYw8w=;
        b=gkLinJWdW4OQGmrJqZvyBr1bxlvMfgVRWfI5151EVDHnHPJcQxO/HDUkl4xH8jBPMC
         JZA/y2MHs9ZctrxIweemJUI3hP/xYStLfvR6lrXcuyF3YK9tOveww9wy/FaN92/M2zI8
         O3ot1IXz9g5UC6iO3w3OxbMBqgzY0BSoK4IkDtZwE7JWDVYzat2itgoC2460/t+SVYHC
         wD5DaOqVhukBMoJTH4Wop3nZJWARRmc+288o2kXeMCmGRj3+yPsRbMx2tB9VNRv0KZdm
         U4ibqHBflIfPHA9laZGND13EHVEckISLudOyjCjJJlOFc3sAdFRVRxRN3S5qihfVqo5H
         TiPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SUeSNLKjsRu2tdmPXnlbC/OTs32hqr/cgOt2tHXYw8w=;
        b=T0kA/XXKHzFqycaTLIuQnRyYJtapOhF3YMo9WhkyFcsM4rNKiTaY+oAa73zXuhZmLY
         iAxgDkkJajLJ/yWetCsQH/XsE9rpD5w5rpUbtdP0jJiXN2FK4xitd1CtPBfiblyVG4D4
         PYnTRlB59q3Qw2TZR7WpNc/8ryFVV3wS0bmLfKXwa7DdRAghDw00xppOxBzhLfnYC0HU
         eArw/ZRpZXL882sPeeh6mj6iFybAqET1HgvAfhaoy7EAWO2NjhbRwZsGJsjiIg024N7o
         a0BGe5Mt9BGF+tBI93fRIecgHJSTG1iicObz3b9xAgKvsbPlNj4tXzkMX4HC8W4Hx8Mb
         tUpQ==
X-Gm-Message-State: AOAM530QK2aUjHpckE1YtUq/D033YKnlyVfiXOuYA89CmtFrY0UEzn9S
        OycUb69cIg2J0X49EEnNqx0K/8kQXflSugO0
X-Google-Smtp-Source: ABdhPJyTGzs+noR5sELc7wg2WvS7YkSYbq4czFxW0gWDK1PNGRSuha/qIkfCQUb9DVbtYJboSCe4j8IfBmBH9sk2
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:b915:: with SMTP id
 u21mr10296666qvf.0.1601593935127; Thu, 01 Oct 2020 16:12:15 -0700 (PDT)
Date:   Fri,  2 Oct 2020 01:10:39 +0200
In-Reply-To: <cover.1601593784.git.andreyknvl@google.com>
Message-Id: <fc672945b196a56bdfbba3cfece6db46ab21d22e.1601593784.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1601593784.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 38/39] kasan, arm64: enable CONFIG_KASAN_HW_TAGS
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
index e28d49cc1400..8d139c68343e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -132,6 +132,7 @@ config ARM64
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
 	select HAVE_ARCH_KASAN_SW_TAGS if (HAVE_ARCH_KASAN && !ARM64_MTE)
+	select HAVE_ARCH_KASAN_HW_TAGS if (HAVE_ARCH_KASAN && ARM64_MTE)
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
-- 
2.28.0.709.gb0816b6eb0-goog

