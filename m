Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E07D72B2875
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgKMWWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgKMWU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:20:28 -0500
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2AFC061A04
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:20:28 -0800 (PST)
Received: by mail-ej1-x64a.google.com with SMTP id dx19so4892926ejb.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=240iZR3W5frW7OjJkRyo/pFDEniTKiELI7K8tAXDIKI=;
        b=n+QZ43qtzUyU4WD1xwf080S4imk4yVUJ39FqVQaMSbKzWQ1vUS9xJOJ7s9fUUchALN
         Jfhs3F7pt9JDglHOLKlY1vawlOGZiB0bvCey0t3dKR6PvUhqL2jTPJ5r28bbCUYJmjjD
         oqM2PlG8ZS+T6DFa42NZJZZ11NN6A/flIcRnW7bQuT52DHg6F0Qg+zLlyJSc32lyOqEK
         BesN4mhSUaneb6ZqvX7VkXknlff7kAkLZfrRbfPq4TVOk+bRGC951i/ze0YSbDafVUWf
         A7LAIMkwIE40dAHbPLl7O39FAlQh5ICWuDPXIrVHeGUVDZvxrh34y8RXepDucQAOvNfq
         wFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=240iZR3W5frW7OjJkRyo/pFDEniTKiELI7K8tAXDIKI=;
        b=F9g96PiTb9J/h8a6e1t76kv4gmGFgkTkW/rgd5yseBCRr6CvzFofl8FMGGGifEfO3n
         iQnl8DbvBpeQhq6f2udAZI0NI5TApI/eDiLkog2uZTfQmcerkZydfh22bsHcbW/TGv/c
         6WFqZu9JjFT5cj+ZXku5T+JPHm5v/YnO2O6Y2yZbzlBYnXRqBO4ucb//cgfGKziR1SzT
         I8miWpsc+R9N3eG7JrS7fkVwHJCGKswpv4ah6oRpvh+aEgKFAiB5mFnriVBI98eDueCE
         8iYVFmDlAfJQ7gpZ/z7Aw4ZUBg5cXpShKaGIQsapHIQ1sRlkOyZ8fdCkk1FVwEMALSY/
         18tQ==
X-Gm-Message-State: AOAM531F1RwvyGwtPw2yEqeDOZQcx4bbq5cBaZTj4x36Is2tmgJE7Vs9
        IvzPi5igrucLcAp+uzpjgZzCxpYFrQ3l5C9J
X-Google-Smtp-Source: ABdhPJwYKwCfjodYVPcg8DGTSw+yIIvWG6u+2g7e8Io9PpYG0k1E0y52dOywGgbe9Ddkwr0W191sdaasLisaIioe
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a17:906:b043:: with SMTP id
 bj3mr4104115ejb.543.1605306027092; Fri, 13 Nov 2020 14:20:27 -0800 (PST)
Date:   Fri, 13 Nov 2020 23:19:55 +0100
In-Reply-To: <cover.1605305978.git.andreyknvl@google.com>
Message-Id: <89bf275f233121fc0ad695693a072872d4deda5d.1605305978.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605305978.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH mm v3 05/19] kasan: allow VMAP_STACK for HW_TAGS mode
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

Even though hardware tag-based mode currently doesn't support checking
vmalloc allocations, it doesn't use shadow memory and works with
VMAP_STACK as is. Change VMAP_STACK definition accordingly.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Marco Elver <elver@google.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://linux-review.googlesource.com/id/I3552cbc12321dec82cd7372676e9372a2eb452ac
---
 arch/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 9ebdab3d0ca2..546869c3269d 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -921,16 +921,16 @@ config VMAP_STACK
 	default y
 	bool "Use a virtually-mapped stack"
 	depends on HAVE_ARCH_VMAP_STACK
-	depends on !KASAN || KASAN_VMALLOC
+	depends on !KASAN || KASAN_HW_TAGS || KASAN_VMALLOC
 	help
 	  Enable this if you want the use virtually-mapped kernel stacks
 	  with guard pages.  This causes kernel stack overflows to be
 	  caught immediately rather than causing difficult-to-diagnose
 	  corruption.
 
-	  To use this with KASAN, the architecture must support backing
-	  virtual mappings with real shadow memory, and KASAN_VMALLOC must
-	  be enabled.
+	  To use this with software KASAN modes, the architecture must support
+	  backing virtual mappings with real shadow memory, and KASAN_VMALLOC
+	  must be enabled.
 
 config ARCH_OPTIONAL_KERNEL_RWX
 	def_bool n
-- 
2.29.2.299.gdc1121823c-goog

