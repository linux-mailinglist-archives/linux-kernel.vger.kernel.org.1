Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9281C2C15F9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 21:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731813AbgKWUKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 15:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730112AbgKWUKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 15:10:04 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A421C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:10:03 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id g72so149253wme.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=1oyed09tnLn/236j8JDGEir64Vx4l4zK2tXQ+JJGy2k=;
        b=g6p3MpVRFNugh2L7hizN06zIIfIYyEjGqmufxVc6I/VCfN3xjEtWhmXXw/t7UMDWmU
         2R9j6wg3HYP35okiu7IAw9kV6/d7bfRwWgxNOP4xMswqENS3P1YaN2LeqTY4FAxIYvZh
         bV9HKcDXdW1JaRnBpe4+0cekqMESTZPo2kqBkXPoznLe3yLSGHhrRPSeCkapNm1K8v84
         YngfX/g1nYL8YVTEb+Uh6+isjIfu3aUsAvUW3H2Y4Ifg+36q3i1vJAnQIy0yxYPYiivE
         HmlQLeHuoB1Ok8V+FO/Zls0hxLKCWmhbYDH5Y96nsJ7VibSYKzEdHfB6E26Pihu9nJRy
         NNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1oyed09tnLn/236j8JDGEir64Vx4l4zK2tXQ+JJGy2k=;
        b=ar8FKUXs85D7UFfElJ3ljpMPnHyPpyPGHUD6OZLCqPUk0ilmp5uoz4jklBMJUsN/P9
         qwVATOfJpqAvRF/AsSEyj/OLTr4DL02ie7uC4dK3AM59G5owM3CixatYcHw/pMCcK1ar
         yoTHo8LscFplz5WyAsx5+s49Ltjj/LPEz3ddEWbxtKSK1gnYGEQphhwu66b+YpCmwMoj
         BhHdapPgtPTPT3+xWNPZ193gOYweW9SE0/GRldoHS98ANI6bRM58iA8aGiWMaCtMtFX0
         l4SHqskACteuuhOcySrlH2i6vftuWySNVtkgkX5LAvOtCImD4y2q2L2/60kibWGG3wkz
         pOUA==
X-Gm-Message-State: AOAM533m+s6oYX86R+CV+HAw5mXNBH5t1cyOFlcfFYwlUp/G7BBn7ty2
        mIJL6H3u4L2poHZyCB0Jnb66Qs3BMlM7mOPQ
X-Google-Smtp-Source: ABdhPJyu98ta+zlqR5Nfx7KItzrdWn82jpVjdunNQKNKXzdi8aeJFMArebrtwrSgUc54b8ojcy1YG4LsdpG6QrXl
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:600c:d1:: with SMTP id
 u17mr606599wmm.38.1606162201852; Mon, 23 Nov 2020 12:10:01 -0800 (PST)
Date:   Mon, 23 Nov 2020 21:08:04 +0100
In-Reply-To: <cover.1606161801.git.andreyknvl@google.com>
Message-Id: <a6fa50d3bb6b318e05c6389a44095be96442b8b0.1606161801.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1606161801.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH mm v11 40/42] kasan, arm64: enable CONFIG_KASAN_HW_TAGS
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
index 434247e14814..6fefab9041d8 100644
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
2.29.2.454.gaff20da3a2-goog

