Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22EFB2AE2E4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732974AbgKJWMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732605AbgKJWMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:12:35 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E614C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:12:33 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id t64so201629qkd.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=OeZS4n3Ve5zgesVM2BV3JwByX9ZOkMptVCR7dAgVH0s=;
        b=rDfcg4Wv2g9oelKYJtIo74+QZQJvkXr2eyG74tpDpGIIE/EcmbjOAPtX/pQwkEHRuj
         BrCX2StKdYe2KLGS3AyewCxMyYzjUrIBIaojlYHYUZpFm7dlrCuv1e7HfC4N2a+Xx5fb
         wNqOlk2zNERGUBf16vUClQ5xVSxrjGg8IgN32tRtLu3qzRGJDakA2qf24U8DqMZdo1Gd
         WNY/KYVfFZnP//IiQpk3aMBcUUltYaxOkK8RGjkUEliN9ZP1f/07IhHmFeRCuleMifS0
         zHTpWtkv+CH5eufxa8biZ2zUX/a22tHkvHV2F3di61fM88xR0LHtqLBVWv1NsQJ5czkr
         iH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OeZS4n3Ve5zgesVM2BV3JwByX9ZOkMptVCR7dAgVH0s=;
        b=neWv97O29goZAbZjNm/YctOW0QPMYEZ3V2KyJ5gUroWLG+cxr4FYAEv0GoPdpR1hDR
         8OSlTGyOE6j7nraH7R0Ba9yM8HkpE1Bs0sAV2hTusHOd+3RZgNdJE2hqAq+vgMk/iFyN
         ZFOUt9659edY77vbOIbgsM/nSVu6dpYXACJG8ObSOgzKD6MLWQOMwaDyZG60MtoBzkEY
         Cek+KUWqheziyf748vE/e3xdPGIWMZL3pHxYlZGSH6WzksQ6C3QJXBn5eI0atZT36vmv
         CTUSCDjwMxo/8/8rrxZs9U8MYJu1nfTXBdPwap3S37k63XaIAQTuCtXN16YZiLTXNrhs
         N+Ew==
X-Gm-Message-State: AOAM530Zxldm8ELf++Jp6HJMoCYgaeIFl6tcEiOChJOvuEIDyxZcDYWq
        18dexgrOVw9axQaK41kTds6TobqqbRgZOkHw
X-Google-Smtp-Source: ABdhPJyBxa8GZp4LuIt2JvLFO10gSTwXZsLMfIN1bZSlGLMd2BqGN3ai4Lxd8KeGS0BNXEUCdT8lDH+43Gzco7DI
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:9719:: with SMTP id
 k25mr19774260qvd.42.1605046352358; Tue, 10 Nov 2020 14:12:32 -0800 (PST)
Date:   Tue, 10 Nov 2020 23:10:33 +0100
In-Reply-To: <cover.1605046192.git.andreyknvl@google.com>
Message-Id: <71fcf23cd66d690afce1d80dc2f4659b2342152c.1605046192.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v9 36/44] kasan: define KASAN_GRANULE_SIZE for HW_TAGS
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

Hardware tag-based KASAN has granules of MTE_GRANULE_SIZE. Define
KASAN_GRANULE_SIZE to MTE_GRANULE_SIZE for CONFIG_KASAN_HW_TAGS.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Marco Elver <elver@google.com>
---
Change-Id: I5d1117e6a991cbca00d2cfb4ba66e8ae2d8f513a
---
 mm/kasan/kasan.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index ae7def3b725b..d745a78745dd 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -5,7 +5,13 @@
 #include <linux/kasan.h>
 #include <linux/stackdepot.h>
 
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 #define KASAN_GRANULE_SIZE	(1UL << KASAN_SHADOW_SCALE_SHIFT)
+#else
+#include <asm/mte-kasan.h>
+#define KASAN_GRANULE_SIZE	MTE_GRANULE_SIZE
+#endif
+
 #define KASAN_GRANULE_MASK	(KASAN_GRANULE_SIZE - 1)
 #define KASAN_GRANULE_PAGE	(KASAN_GRANULE_SIZE << PAGE_SHIFT)
 
-- 
2.29.2.222.g5d2a92d10f8-goog

