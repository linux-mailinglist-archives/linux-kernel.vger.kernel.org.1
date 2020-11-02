Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6377F2A2F3A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 17:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbgKBQFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 11:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbgKBQFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:05:44 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805B7C061A04
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 08:05:42 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id u28so2021023qtv.20
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 08:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=JhJQu0u6kYZyiKQdNOdQHHgHHQ9cOF6OLpbU2DNOxmQ=;
        b=Iwa/zJ6Om1UAR8kwXuqqPWXH7rZbO1N7okU6okQg6AvAwhAy2xQuJBUSFPiMrZzrww
         NT1EH30QaleRvwXROCT7Yj+I0f0sfWVUEY4NWr2KD39lYY74FBiPeGpteJ1cQNqGeL53
         5xiYFlEgAtfon1/7VOT21kHoQ2MZgiujAWy50U9dQI/KzkLM4lFlYgYZyXWcpSovRGy7
         FXe0TUx3dGbOMTr9M+WVizjuOoKpiF2JsR6s0LuOsnl9lpRHeOkbfOeC20TFiPsjwEss
         yT3n6yMJakyr4Vvavgrn53Wc8i2tLax+kfbIyDx3kS1xpy1Gr7WQs5T/YavrBUOhyQFW
         tT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JhJQu0u6kYZyiKQdNOdQHHgHHQ9cOF6OLpbU2DNOxmQ=;
        b=tlD1YgntBw25A7ACzYiH3t/RpYzhy2ZZ6qwllZJbn8Bq5RXFrVCkOM6EiJPnVbxOqB
         ShWTTMB4eAgehDnQ19aJPRgDlk02x7YmvmyRhKZU6kBUi7o9EJ3CaHU53cBt4v4w8IDb
         ur3fOiCqjkiJdvBIf1NO0N0mKM5Mgps8YxGsr9SD2XTNMuH1kkXmzqPuqf5bvYTEqAsZ
         xqKRIrN1gYX5XabdQH8NhOTLRYc/iG23NkVKN+hHWzRG9QeJ9/oE6Z+MMHdplvySeu+R
         lvbgs84sqe8N7CFmKZK9/4P+yI/sOXO4O51iTGwxPKkG30PRfcsfbyrmu3LNhtD0UUZ2
         iT3g==
X-Gm-Message-State: AOAM530cZ/w8kepwUwPnHeqY7I2vdh2uKxX1pKtKU2EPd/E9tb3FC0Kv
        3lxUqIIsFb4/cZEYwJ2QBYdhf4a+zSSe+pZM
X-Google-Smtp-Source: ABdhPJyJY3gCiXTBB22SjlDvx/Ydn28lsNNt39U9OWOjGrdJ6LjFKPrvUmJx7BJSr6uwj6I++8czBpu2QuQiWSIS
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:45b4:: with SMTP id
 y20mr1778243qvu.46.1604333141655; Mon, 02 Nov 2020 08:05:41 -0800 (PST)
Date:   Mon,  2 Nov 2020 17:04:11 +0100
In-Reply-To: <cover.1604333009.git.andreyknvl@google.com>
Message-Id: <939e8bc7da624a0923d5f3346b4ef5a9b5e7b208.1604333009.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604333009.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v7 31/41] kasan, arm64: don't allow SW_TAGS with ARM64_MTE
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
index fddb48d35f0f..cebbd07ba27c 100644
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

