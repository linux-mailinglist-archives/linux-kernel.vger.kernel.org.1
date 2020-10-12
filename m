Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE8528C333
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 22:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388329AbgJLUrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 16:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731449AbgJLUqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 16:46:46 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56B4C0613E0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 13:46:24 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id 2so660662wrd.14
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 13:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=WBTykbiiMY/bXp2oeCyvW80uwSDd64COK/UOrsDrX9o=;
        b=mFABbiV5aYwrHRDOu0TrHXbTnBMoLHOQL9feMYJDVlikRG6iilg7ocOWNyP5ZbWdOj
         9VsUn/87jd9YHs+AvFhJQMj4BRghXJJq6JytSnf94tLBA5Atf+uf3P+ue2KS2q3yq6zU
         F02qDvxQYzGu2IRCOb5TCcxj9c4mC+w7sGW2lpPqHnQBnYJK6aFvSdUAmpz9a+77+lzO
         1Ocf9tDe0A87S2hRQhGWyeAXYeRMQ462UNektIv+BZfvj7NcUunxRQTvliYXK3/p445e
         2VV1jmNRs3Dk3Ie3qZVpMnd5xy+o+drpXOiYUn0Kmi4HMP//5p+whcGgdRuTpo4ArFsB
         qmiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WBTykbiiMY/bXp2oeCyvW80uwSDd64COK/UOrsDrX9o=;
        b=q66qATA5llxRsKicey//tWV7Cwqa1NMm14BQ0X+3MTV+m5qtXxriOtdmuA9A1Oy2w6
         zSrFn48w2n/WowzBLOKvtasRNSj9vEpnVIL+Q/JgMGOvQS+fAtMjK+/qoQrbSinqNyCG
         9915JLQVxiFD2BmZAp6X5Gjf6EOZ0iFFgpoFcLEhAA3fYNVEjr7N8yvjn1rHREoj2im1
         v/84celWchng6u5YukZ76X10dS/t9JB7TRKRiTWNUtICzoWYN2aWBmnUpNw0SEpjn9uH
         JssAk0Tq6b/xuX9JnN9mWkAVN9dfqX2QQGcve/Cbh9VrEr3/2tgNwoPjJxkykh3y/LHM
         PgWA==
X-Gm-Message-State: AOAM532AwgjQ/zYOLN2Kk+L0etYfcting6kYqbVdFiCS/qBNWyEGsQ0s
        kJQit9j6XHPm3uBS3Oer2I59/Tds3hV9q8Df
X-Google-Smtp-Source: ABdhPJxhAo7enPE2aHLTh0tkHfVuB8jvZg/foifsSHNow2wYf8N/mDArYqeshL3v2mf7ZaDmbpgjXc9qAXQl9nE5
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a5d:6a51:: with SMTP id
 t17mr15497106wrw.80.1602535583350; Mon, 12 Oct 2020 13:46:23 -0700 (PDT)
Date:   Mon, 12 Oct 2020 22:44:44 +0200
In-Reply-To: <cover.1602535397.git.andreyknvl@google.com>
Message-Id: <5dd7ecbd021ea23e92eacb251578896497314076.1602535397.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1602535397.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v5 38/40] kasan, arm64: enable CONFIG_KASAN_HW_TAGS
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
2.28.0.1011.ga647a8990f-goog

