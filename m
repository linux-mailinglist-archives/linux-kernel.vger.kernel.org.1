Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 278712AE2EE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733044AbgKJWMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733033AbgKJWMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:12:49 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE00C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:12:48 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id u207so1858414wmu.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=3bLCl/qn5nElnEm7yzZVsuSSkTputMy9yS6WNazIy+Q=;
        b=RxPazZ62MVEyIS9tp/hkwVNYONZFb2aACfP8EVp0k2dP/9RU3ZzFK5th01dPOaNpPf
         eTv+L9OZayvnQUnXOxxJC31ytnkgbLLR+89xmA8Nwq8hlzsr1XvQtvurXaQxQnWf+Hxy
         vr5GdfV+daNEARU0JdYCgbw+FPJV5vmSDRLUKePjGJeu/3WvsL7N7P/8PU7fnYMngMCW
         r8+ByjG5VD5WXvgmfQGiknwPuipGgyGOSzyZCg+JBtJnGwOPMIduyxCBEjCnbdRGlpGu
         ty4RPieFcqpXfZ1tprTBx0ATS4RA9vaBBYtxN0Oju2QPNJB5Lv1WviCgM2m30Oox35M3
         x9cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3bLCl/qn5nElnEm7yzZVsuSSkTputMy9yS6WNazIy+Q=;
        b=CCwBr7MHGYKDrySpvrPgymlE2YdQDVS56V5TZ3sJWv+/mcxeUaD0lvGZU0tNUG+Dba
         hJyJsl6cgXhcSi/qwC9Dv3yKqmaAYMM/ledrGV/C9MXC3SaUoS/pujs3GTbsTdyfkZZ6
         +wYPPJJIQT+/yqzxO728YXmbuXlXyUDurCwr+G4YYDtew1GtFhKifRm7i0kMFmQsCWv4
         ksZJ0n2eRPfULK2pRjTrBCC1RTx/zk72zQOXbvbeNeRIwQr7EAOe0Pxoq8ZAH2cCMlJT
         aDIhhXOUB30gWo+xfVTlTiUnzEC3/EPe6WORLKVqPud9Q+fJXTUw+eFuRL8ky4nYKHrn
         lXuQ==
X-Gm-Message-State: AOAM530ft1IUGM0aB9H3CIoCeqGOW+1wugGpbsACfCruTEVnAP0AINsV
        r/yA3M7TZXN+lWXAt8+OPlyWpv4tQdZW+zEz
X-Google-Smtp-Source: ABdhPJwZYNd2Nc2CELxuBPZ+tNbfnprXkQHLmvlgSmD4hf1vEWNl7BKUzNHNk5tRRY5yGTtuiEu0fK7/lzwE1DOJ
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a7b:cf1a:: with SMTP id
 l26mr289880wmg.18.1605046367415; Tue, 10 Nov 2020 14:12:47 -0800 (PST)
Date:   Tue, 10 Nov 2020 23:10:39 +0100
In-Reply-To: <cover.1605046192.git.andreyknvl@google.com>
Message-Id: <3d24722ca600b65a186a55ae47777a00a7c9407c.1605046192.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v9 42/44] kasan, arm64: enable CONFIG_KASAN_HW_TAGS
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
index 456741645f01..c35e73efd407 100644
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
2.29.2.222.g5d2a92d10f8-goog

