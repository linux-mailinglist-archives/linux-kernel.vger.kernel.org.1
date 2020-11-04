Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFCA2A713D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 00:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732790AbgKDXUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 18:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732729AbgKDXUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 18:20:07 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADD7C0613D2
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 15:20:05 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id m4so30707wrq.23
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 15:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ePhrCN9LvFC2NG8TKNxFN+Gj7X1gzwcPp9/mgeUcqHQ=;
        b=C+OLyB6Sff9JLLtKbp0uDfc/GKA28DIw6lwW0MLPBglUk4VKzX0PB63iCo0IiN2hmg
         Mj6O+jer6KakCOqcH4wXBtYO4pzh0TtpF/fJCUzQ+fkDX0DOGsMFTcUhH5WxF8QWgOXj
         O8dOWG9gSyD0OSZ+jV/oRcGiDs+CLC//f+/v+wBA/hhgb5hrR5J3DpYBpqVcu8GBmKoq
         lsiMxJfHcMagNgkCypOcmEaDQUCN+NphYLTOeFQjCnEJYK/kcahrCm9/6nYgj++T8xL2
         Ci2c3EY0IAEjFDMWhZEd7NkatmoEbTjirFKTYtRZa7adSi3wz6ZVctDX99kVZFTABUQK
         ONeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ePhrCN9LvFC2NG8TKNxFN+Gj7X1gzwcPp9/mgeUcqHQ=;
        b=EfLuNcxRcAZjN5pq7OE8vjyNaQsVlkL5H2MuqZ0IPQhFyeJXmtwxqkODZeOysu5TvN
         dH74WdXSFEZNHggGs+moIMpxiWT64frlyfMh8gtPIJgsQuyefEPoKgFVvUXKJ/pyc8kC
         bJfMB1F1dgdue9l9HfH6KD/5t2l8yXKphvmIa5KMae3QYP2hAGhU25pl4n91XezkCt1Y
         ykaXD5pZRWFNBCkXKAyE+GMHTVN7HYwDoHmgeeYx/4r+dFEfoXSjSs55td217vvcg8UY
         l3O0Zui8A/dt7VZ0aL8J2N4yU2U3q/D87t8YuMw0jeB+0GalbPrpzTlIOf6+fTBnW4n5
         rPUA==
X-Gm-Message-State: AOAM533sPrE6in3/d8W3kwAW417fbl8kvZ4MMSiEOSbz2X7LdM5Ep3eV
        WzNl+FkTMNQjEWuN7j095XTS9K93zwBxheEC
X-Google-Smtp-Source: ABdhPJwu6we4Z5OBZuGmSUCzF9eUS+7TnL8YtWz4qN7FahMt/MMmSKJRmtsqvh+Dt+lv/3AlAqthZAPUUb6e/BYZ
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:600c:216:: with SMTP id
 22mr50135wmi.149.1604532004186; Wed, 04 Nov 2020 15:20:04 -0800 (PST)
Date:   Thu,  5 Nov 2020 00:18:39 +0100
In-Reply-To: <cover.1604531793.git.andreyknvl@google.com>
Message-Id: <c7401464c398ae353f996e2e7af5892578cfc932.1604531793.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604531793.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v8 24/43] kasan, arm64: don't allow SW_TAGS with ARM64_MTE
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
index 1d466addb078..d58b4dcc6d44 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -134,7 +134,7 @@ config ARM64
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
-	select HAVE_ARCH_KASAN_SW_TAGS if HAVE_ARCH_KASAN
+	select HAVE_ARCH_KASAN_SW_TAGS if (HAVE_ARCH_KASAN && !ARM64_MTE)
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
-- 
2.29.1.341.ge80a0c044ae-goog

