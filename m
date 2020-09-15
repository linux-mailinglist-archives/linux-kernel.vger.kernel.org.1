Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C2326B011
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 00:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgIOV7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 17:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728096AbgIOV3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 17:29:24 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF49C0611BE
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:17:52 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id c3so1794350edm.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=t8rdfVrdLyxTAYdMt/4LR6Ye4IfbP7qoWzC6FDGTZkw=;
        b=vpddWMvoyUB7iZMxqEeVRHqhIXDBQTU4Z6/ORGC/5trX/+UsDGo+9vpvpHW+Js/9m2
         CR1wMVEWu/JeDwzOLYfrKBKObhRCu0BplW0f+6Rt5HsHIpeMC+iNwPL6Rx2whOtgTcHP
         OSp6chdIi2Ys4lJn8rkKzxv/5NeJF3ZwPECH4lmK6VPyN82su3s1u/4bx2Q9c0AiWt7d
         wSoTpJhrzNg5FZaYQWIa6/6ghxmqgrvoqtKxR0FwFjsrYmEGNSdRQj0femL5Mv17DK9O
         X5QTS3CEm+DYpCJmf5nCf9NjsdTf1HSrtvIekVR9X/i4ct13defwoCxykK9g43C+/LBj
         EZ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=t8rdfVrdLyxTAYdMt/4LR6Ye4IfbP7qoWzC6FDGTZkw=;
        b=TqSpW7XqS1WNyZ572L0FNEpKF1tEgh1oxeowqQB014BhZ+aN1jF3HAaQFYCTK9OBNp
         3VLPjcTkQ+Cr4oLOZWDKQVEijnkUKzfserHeLaog8mc9EvRSIKKoGFm9jc90j2Pi5oP0
         2XU4EyU2ran7CJhjihcBxIhhoBPSkvX3qk8MBiyAT9pBtDgm1VEsdj+aheFrfgacNGrm
         rswbgT11GEnB7LP4nuTcgSYx9axV4a6DVnNLfzFLKETpLYBPSMiKoxjAnwSE3MmSSyxK
         yfOCtxlfsOoeD4+c+hiKFTmM1oRGtg9bwEY1Gnbm8+W7/YySrOuOr5FmpYjopU8w7Vob
         s/RQ==
X-Gm-Message-State: AOAM531K1KyfCZf48l1FUviEXFX3WIBjGXu7mrZ9dVNBferCJB3xf2Yi
        /BnNSkvR+s96lHVCA/iI+p9Rls+m9GOHK/eI
X-Google-Smtp-Source: ABdhPJxZO/za0DL/aaj/l3gIS/p97WdkPtBAB72fw5melIRWH5aX1Fyw0VwE4wOIs6/dgKwajS0HAVcZKzJ52Im5
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a17:906:60d5:: with SMTP id
 f21mr21975308ejk.94.1600204670609; Tue, 15 Sep 2020 14:17:50 -0700 (PDT)
Date:   Tue, 15 Sep 2020 23:16:18 +0200
In-Reply-To: <cover.1600204505.git.andreyknvl@google.com>
Message-Id: <d5705790ba42513fdc302f679bf420cf86fbadb6.1600204505.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1600204505.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH v2 36/37] kasan, arm64: enable CONFIG_KASAN_HW_TAGS
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware tag-based KASAN is now ready, enable the configuration option.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
Change-Id: I6eb1eea770e6b61ad71c701231b8d815a7ccc853
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c8e45870e993..afeb5dde437d 100644
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
2.28.0.618.gf4bc123cb7-goog

