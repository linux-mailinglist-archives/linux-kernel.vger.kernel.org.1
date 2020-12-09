Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8822D48EC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 19:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732967AbgLISZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 13:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732952AbgLISZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 13:25:09 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F61C061793
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 10:24:29 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id a68so1715462qke.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 10:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=u1bxfC07ZuZBOWsTyyUWqPiXaJQ6KPVo7f7CpicouQI=;
        b=jtZIxOGhOaY8oAUb8BvD+E79MIfynRleHrjdAsL7FWljVpVMiW+9Os1KVux0owqEVe
         kMtJVVMUdf40DWsrihpEssIeQvMKLCF7OFDI5UN+uL+0VG3PlWmY+CXC0qOxGNfPMgbB
         NfRJVSkGoC/wzm3y/97pFIYkMUwMSxktEWQ+N/D0jQWx9QJsSB7gzjwQLCUSeH/FmSJe
         dh8Qe7dcOeX2MgbUWfd9W9mQlAGniesJc4ri3yHSy+ZogRa9j74wYqIyVNcD5OVEUMnZ
         aBoOQ8V14gfhZObvQwUWgtENIiXQrwT5r9VXz94S/1UsAeJCHm6UagGVBZFv53XqMazv
         R2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=u1bxfC07ZuZBOWsTyyUWqPiXaJQ6KPVo7f7CpicouQI=;
        b=KnKmWrVy1cBW8gNVjqCPD2iHrv6SU9KXgh3fQJuizqG37HydNT5DXa8Q5FxLOn7wns
         8+08DzuaNFM+vkV5+U2Dldw0+EyOnkto1QI3TUkMHFve/08xOw0/2Q1zsKOkSSvXTwbi
         b+bFtXzqmg1TLnzBWi7EPLaM+PTXmtuxMHoPxbFS7WzEuXx+Bjc61yWgsP5Mwi/rXI3E
         IkHu0m4qgG2RzLtKtA38XdOpFhyYQYj5C1D5JDYdhnGrzl9J6HItONS4b6j1ybVieWQK
         j7LpF9g8v2O2Exhs6nv5d4CZ0tu/BTasdnSVAivZ7UKiJ2OJuWSb35VfroQ2cuAV9gS8
         55hw==
X-Gm-Message-State: AOAM533rJEOaRwh6NbjCSjvEaEf69BKEQ8YmSzdZ7kKrQYY5JMJ6/CQu
        h3vZe5AYEBF7QACjz136wwSjM+KHmBIvbe1Y
X-Google-Smtp-Source: ABdhPJxjO35UNSehkB4BGFZLOWZ+ziczwvX3GKaWDtrA9OavTleg8eROATOV1foJb2L/aZPp+CXzNseKMOST5KYg
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:47c4:: with SMTP id
 p4mr4509202qvw.23.1607538268306; Wed, 09 Dec 2020 10:24:28 -0800 (PST)
Date:   Wed,  9 Dec 2020 19:24:16 +0100
In-Reply-To: <cover.1607537948.git.andreyknvl@google.com>
Message-Id: <a6287f2b9836ba88132341766d85810096e27b8e.1607537948.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1607537948.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH mm 2/2] Revert "kasan, arm64: don't allow SW_TAGS with ARM64_MTE"
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

This reverts "kasan, arm64: don't allow SW_TAGS with ARM64_MTE".

In earlier versions on the hardware tag-based KASAN patchset in-kernel
MTE used to be always enabled when CONFIG_ARM64_MTE is on. This caused
conflicts with the software tag-based KASAN mode.

This is no logner the case: in-kernel MTE is never enabled unless the
CONFIG_KASAN_HW_TAGS is enabled, so there are no more conflicts with
CONFIG_KASAN_SW_TAGS.

Allow CONFIG_KASAN_SW_TAGS to be enabled even when CONFIG_ARM64_MTE is
enabled.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6fefab9041d8..62a7668976a2 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -135,7 +135,7 @@ config ARM64
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
-	select HAVE_ARCH_KASAN_SW_TAGS if (HAVE_ARCH_KASAN && !ARM64_MTE)
+	select HAVE_ARCH_KASAN_SW_TAGS if HAVE_ARCH_KASAN
 	select HAVE_ARCH_KASAN_HW_TAGS if (HAVE_ARCH_KASAN && ARM64_MTE)
 	select HAVE_ARCH_KFENCE
 	select HAVE_ARCH_KGDB
-- 
2.29.2.576.ga3fc446d84-goog

