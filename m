Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 790EF2A2F41
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 17:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbgKBQGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 11:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbgKBQGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:06:02 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE2AC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 08:06:01 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id q19so3568609qvs.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 08:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=hKqfeGmJU17yqcBnh9EcbhWo2RSZMPrdWdsmZezW6Y0=;
        b=lP+3S3PAzOk6QdimSCuz5M6/IFR3Lhc/8CgzmPNy3gXZxSsqS7FiT0qHNrN/FhKFY3
         BOHfpSa799ZIHJUaTgolcBa+mV5zTRePgeYB80W3znS/E9DP/P95MUzfUz8AbjCbw8HR
         AA/ZnlGfgcE+ZnM7gMltS9luzbhl7RGW4Zrl8nucaxu+/3Z94S68qzAO0gmoXQ9CjSRK
         n+5pex0bZkyamEfjoPuVcKdfOZipfRRZejPSlM+5xKfiCpO2hjcp3Rea2ZVhe1TicJey
         AdVf8bv352T7PwSWdfOdg/LKs0GEAHIcHPbe+Ss08L1DhWO94AbTmHFZxk3sjZVaYMuY
         ztLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hKqfeGmJU17yqcBnh9EcbhWo2RSZMPrdWdsmZezW6Y0=;
        b=G1rD+D97z0yeDPtrBsUG25hFGRQcAkoWt50kMqXAQautDa5Smj8kglksZsfHeLiP3e
         ME/6TzgRoYYa/JYnbUNdJ8REgSxjQK7EdI5DMhY4AsxI0MEKjiEl/NLOhj1LuOQVNI+H
         igSkiWv6k8zu6QuFSkYzS8YKRfvKKwY+WFxXjva29+3dT8u8S/5Ntgoi+tZyv3tMiJeb
         gujg2Dp7Yg67pHx45PcXvUbVow/voSjeB3spDlUs+UaIPxfcZ/Qu7TuHjwvagR/rT/FP
         365DeHy+qE7yboX9YBmSa1cRExhi1J8edvWHWIB6Cp1VGrkfoxn46PrXlW1r3goR4ru2
         wTCQ==
X-Gm-Message-State: AOAM530s+LsO4BKHOiK2k1fXIscekVky81zzSo3TCO3ZjjiVkN+cML7D
        Jx4/CkQxkUtemt78O0nJhCrmhTCqF8cK3Pyf
X-Google-Smtp-Source: ABdhPJzbstwFvRivoWcDQ4DEVDj0GLFJDiXzeQimRnIEvXLMunhy4dHuyU7oKElTXpWHII0LyqM/Pu+a1fwp9xaM
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:cdc2:: with SMTP id
 a2mr6570448qvn.16.1604333160936; Mon, 02 Nov 2020 08:06:00 -0800 (PST)
Date:   Mon,  2 Nov 2020 17:04:19 +0100
In-Reply-To: <cover.1604333009.git.andreyknvl@google.com>
Message-Id: <4cd13fcf68a4b69ccdef7d8bf8e483a9a9abe244.1604333009.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604333009.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v7 39/41] kasan, arm64: enable CONFIG_KASAN_HW_TAGS
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

