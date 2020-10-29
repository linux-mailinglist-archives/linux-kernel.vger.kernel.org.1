Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 264A729F522
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 20:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgJ2T1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 15:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbgJ2T1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:27:43 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4BCC0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:27:41 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id z12so2543734qto.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=MHApnVByS02AaUFkjSPlRVvJbIWzt6+ubFG4VCT8Rro=;
        b=Iz5mJR5PqhmkHUT0aIs8eo8ftNrDikxU6bvYYSNS+LEdSA5xnW4j96V1aULCndYOK2
         AIwuwrdLJLB8r5Md2fGM6Dyq66Hy5crAVut7cXT6nm3LDtI5hmmuZxMIdGZinFl7EAgG
         /QlM2x4QPDQZa6YKblEMH0PJKzQqLCYZsaHviwf/5tXgQ3uFYj0neT5k4601cev4tPZo
         Gx5ICTggkcSuAs+M2gloBgHc9hB9nf+IrrSSrsKsZzZwB0ajkxyUnevFOdV1PhlOZvc5
         3afLGNu2mGFxb6V16IA5m1pcBe7lgeVJuueaLwiqAaZWZ4EA6Mp0paJC/tfgmhQYM+Xs
         EZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MHApnVByS02AaUFkjSPlRVvJbIWzt6+ubFG4VCT8Rro=;
        b=pxkTCiUTIIumEIaG1I+9gCLkqkIpItphtqzEs1O5NHzF4B6NMh8OOJ72IgXFtGAJF9
         WN6KE1nuTbA2ROSVKiZgfbskDW+QzeH40/hTqu/WMEpAYFZV7thBEq2aw1kdYcs0V/n9
         4GUvG5pnmtVWEnVe6BhQk7KchRh0d5C4gUDihZHHMAW6rQd/ZQk3iWTOmrAUwe2tMRcT
         4sk4jilw1aKHdzpLt0lQiTmO5pnOMgvtvBAEyg9Fnbkr5bI7IROYkSHbwfko6+tsHmiD
         HyizGcxplmlQVkbTVzwSty7qYp2l/Iv1abp8BWnUVqdbGzPPVCoXWPMGTBHSoDNFGhtO
         TIBg==
X-Gm-Message-State: AOAM5304hOOkVg+MlLZmBeJe2bAlnkAMuqtyLXSjdpAM6phaI51YCL37
        6/G+Cq2sHXwFlyfIX5UcXljxbUWeH2L+NcjG
X-Google-Smtp-Source: ABdhPJxxqrJN0aA9z32HEdy82VjAfQUCq1ejEhww5o+OXWRnVGPFqqjPQR7HjtNyyCOq1zhvJB5das6mq3rwSr+J
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:4512:: with SMTP id
 k18mr5677286qvu.5.1603999660819; Thu, 29 Oct 2020 12:27:40 -0700 (PDT)
Date:   Thu, 29 Oct 2020 20:25:59 +0100
In-Reply-To: <cover.1603999489.git.andreyknvl@google.com>
Message-Id: <61a81b0d782fcf0581c8c20a0cad4df38aec0954.1603999489.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1603999489.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v6 38/40] kasan, arm64: enable CONFIG_KASAN_HW_TAGS
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
index 11dbd880e6c0..50e4ac389e85 100644
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

