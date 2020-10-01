Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 114E4280B28
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 01:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387631AbgJAXMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 19:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733304AbgJAXLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 19:11:38 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FC1C0613E2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 16:11:36 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id l17so122019wrw.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 16:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=aHaqAGqhe3K0FS7ZJWcfKrDk8FNnWGrH4p9dPgIlLEI=;
        b=swpCHanQu+SIMdswJvXXsZIRikWVSUrn2FQJLU3wNZBPI4HVsaKL3t4VdXVwuVb4fB
         dzkLUJsvjXmQ+/qxCEK+gFX6rqTqAduNE3nDGUWob1pOOCpKnAwLA6x2Kyct2217Q1jJ
         Cf+kzK2wmXXBh8mN14fDhrJr8btdSXRUBN7Evr93IDmIEFp+8qal4NH5zQzRK94hwodO
         A0LVAPrY/rp7eN24CyIidHHJPeoxxXhxHh8XIQRwqHj7Cy/nt9bH3Ko/6lBgHF8P+2k/
         DFHeQQg6d2qHUThzm2rbxYA4j0HFeY9H7eN4p6T/P4ma2r8xbC+HjXGJkUbiXcqYE4x5
         BOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aHaqAGqhe3K0FS7ZJWcfKrDk8FNnWGrH4p9dPgIlLEI=;
        b=BxGjrrNXweb6MObuE6aE/QahNivBqP86IiozfiASzPW/yqZm931nP9L+OQCFY8ZdnI
         viOJ05fg3jJQD/uuqcofZRjV13od2+lWA/v7Hcsr1nkq7VPnZM7zKeLnnDURki9DPM84
         nITDbJpbK1jgL7+Y1DdxDS9itaa2HfiBe1Y96aROxhZJ7XeAWsQ79+xfrQDl2605Oniz
         NnBCVW4JBw98LLReZs/LFG/UMt+j+9PR8gpoQlzUlQR3ZBWZlYCZaPPXtnhqm4kR2kEF
         w/pHPBaDfJfA7mc4ZoTDaUgmCkBRysLKtcoZT6dpzf5L9W8DlofxcDxpukTRDtAM1M0x
         eFxQ==
X-Gm-Message-State: AOAM532nvy6LL6ZhrEgsvqlFCNJ6dpdV4/3nybog4EjnVMyo80WW+gD7
        VuLI86v9wQSlQmB38A58zS3AqFSfFqwfUvxU
X-Google-Smtp-Source: ABdhPJxLHS3PMbQxWIVzTKDBezKc6BJJRo1SnHumrFYMTaLxEK2aJwvkr072kiNzKD7DB3HQx9ZzMqtnLJ81bKYi
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:600c:2053:: with SMTP id
 p19mr2326483wmg.50.1601593895081; Thu, 01 Oct 2020 16:11:35 -0700 (PDT)
Date:   Fri,  2 Oct 2020 01:10:22 +0200
In-Reply-To: <cover.1601593784.git.andreyknvl@google.com>
Message-Id: <a8a68f89df9e516b8a09fe56abbe930b8f3e8a05.1601593784.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1601593784.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 21/39] kasan, arm64: don't allow SW_TAGS with ARM64_MTE
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
2.28.0.709.gb0816b6eb0-goog

