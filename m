Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5D729F507
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 20:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgJ2T07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 15:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgJ2T05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:26:57 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA85C0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:26:57 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id dd7so2389848qvb.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=n8TE6VLWWv4zp+ZnErvJoE/L5oOe+Pde/aeeJYIsZf4=;
        b=O/kauqeWNY0r84lS7RPHmlpaDP/mmCBXEzf8XgWD3KGlQrNQmBfLa4txgoYD7Zh6rS
         mIE6CKlfbMZtbBFE8xohCrCv7dwvAJbrRGCxi3rfcrMqaBiDWbS9j0C+nGrJZqBeIX7d
         jBWCVzbQR7PXrYGX+ZLKFx1i0gbyxVVxKTdO1lL70yMgFJdB5dprM1CkOAjpNeq3NMSx
         8RA2H3qlB5MDxHjGmIevZXRRcNvMK05sYW5nPl2nOdsSLuiTwYu8wqfbrKhku+356arz
         Z2pJs0ucc0o2Gh+tsuNjicmUbykEkiOdG06qASqjn5+YaTaYapEaZkpX02mMQu9/2DXc
         dmug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=n8TE6VLWWv4zp+ZnErvJoE/L5oOe+Pde/aeeJYIsZf4=;
        b=VkzbNh9H4aoM/Oy0XRQjGSzwkETq01F4lOfqxC39ATOJqYkoYHP6Vkg1x1Ypp1Reod
         VMPqWnf4pgDUrKw/CBEz/yIfKw92+g1Yz5pfW6fM6sjtQh53F5Y/6wOEreDwn6cUJXr8
         N94XAWGakk0kbkw8cctMT0RHi8CQivqBrhyi0Npk/CZTu//7Hpd0ZszL0eVb5neE8RWA
         a/LONcmAHov27TnU5fyLojHWJY/u5crpDRgRwUU3kOZTQJtSE2PU3shxQ1t9GDeZIzEE
         rvIbH4PIjv/CDaUFV3e4Nt9/sa8WGWEBYZXiGA59NvGi80KKr7MHTWOKKNigyB2cl3UC
         2t6A==
X-Gm-Message-State: AOAM530d5nrpdHoTlzOaR0hJE5TXE08eJwzyauKER2vK3yoww/f1W5X1
        39QNqs9XGdak39cedKQGsEBFDpdIunOHzIfd
X-Google-Smtp-Source: ABdhPJw1jx4wC13gVTfBQQYxOOayngDKS5CnqcrRcKt6xwjo5/eh1aWaZ/ASIoxlU/6FhJt3I/4WtwnzHWOVyQ24
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:9e0e:: with SMTP id
 p14mr5468422qve.25.1603999616340; Thu, 29 Oct 2020 12:26:56 -0700 (PDT)
Date:   Thu, 29 Oct 2020 20:25:41 +0100
In-Reply-To: <cover.1603999489.git.andreyknvl@google.com>
Message-Id: <9f139555e8b9c10d120c3ee8da96973920476cfd.1603999489.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1603999489.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v6 20/40] kasan: don't duplicate config dependencies
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

Both KASAN_GENERIC and KASAN_SW_TAGS have common dependencies, move
those to KASAN.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Marco Elver <elver@google.com>
---
Change-Id: I77e475802e8f1750b9154fe4a6e6da4456054fcd
---
 lib/Kconfig.kasan | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index 8f0742a0f23e..ec59a0e26d09 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -24,6 +24,8 @@ menuconfig KASAN
 		   (HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS)
 	depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
 	depends on CC_HAS_WORKING_NOSANITIZE_ADDRESS
+	select CONSTRUCTORS
+	select STACKDEPOT
 	help
 	  Enables KASAN (KernelAddressSANitizer) - runtime memory debugger,
 	  designed to find out-of-bounds accesses and use-after-free bugs.
@@ -46,10 +48,7 @@ choice
 config KASAN_GENERIC
 	bool "Generic mode"
 	depends on HAVE_ARCH_KASAN && CC_HAS_KASAN_GENERIC
-	depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
 	select SLUB_DEBUG if SLUB
-	select CONSTRUCTORS
-	select STACKDEPOT
 	help
 	  Enables generic KASAN mode.
 
@@ -70,10 +69,7 @@ config KASAN_GENERIC
 config KASAN_SW_TAGS
 	bool "Software tag-based mode"
 	depends on HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS
-	depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
 	select SLUB_DEBUG if SLUB
-	select CONSTRUCTORS
-	select STACKDEPOT
 	help
 	  Enables software tag-based KASAN mode.
 
-- 
2.29.1.341.ge80a0c044ae-goog

