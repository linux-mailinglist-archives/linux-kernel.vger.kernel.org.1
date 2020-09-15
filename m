Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A52926B010
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 23:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgIOV6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 17:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728099AbgIOV3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 17:29:24 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC997C061223
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:17:24 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id m24so1813388ejx.22
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=pBsGqTIqbR91modi76ePsvmJJRuaBk1hVSkVG5VFwBQ=;
        b=p2QNOStDgd3DtDO2HMju2iMROSw8FGR9GwRtHaoapNRKPL7jpItd7Nvrv9ZUMnx5Q9
         8omi9isnPo7q0hA0GQq1Gb/n+Qtd3gOUgcadRA63YAzQ5c7yW5bSifPYsUlu3RfXsOhw
         bKib5qq1Nz/zAypPDCWC6iYRJGxZO7ltEPxS+e+VLmx2xbYqSyangq+OO1QbSjCtxQfg
         nbiluYCPKo4yVY4Rm0yu2q7JTG14E6A9ir3gafO3HGJ6NORNnkxFV3omQs5MUN8mRZxp
         +p6amVva7PebyyovbInJ7KY0jaCFmoG0p9bHmALDzXjrJgSelm+GhpxYd0+OQ6a5kx4m
         v76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pBsGqTIqbR91modi76ePsvmJJRuaBk1hVSkVG5VFwBQ=;
        b=o0+MrWVhTgizPnihK1KKtcJ+WSMlTzm++Zn+dq54h3HGWM1YP1uhZ/LI0FAOiJV2l4
         ZgMsHARkfGPp1tf7obKn2GDEyhH+4pyT/zT9PxyPNMz8oGTOYBmdCn9MR65gX1MbbUR4
         kSvIGRpZsEhGCyklccupZiFL1qRJVCnUvr8QR/V1QSda0YARnyfMW50VRcFT6UWlZH1l
         Hc5jqiIXm5pq26d7BS7oNkYVdlOr27Q6E67s+0dmaQLFtAYWwJrVxyDZFJRPvNUGojz+
         TfVqYQ6l/WUJyjGWRL18RjzJi0zQqZlRDpi492cQTwg89KGVhpgs0VLjVx70PRgBia3m
         alcg==
X-Gm-Message-State: AOAM531PEiqR2VifRQKLjV7Ga4BahCosxhOeY6lmk4hYlaE0yJJT/GTz
        Fq5sXoofZf/FLnRLEmxh0vXtRo/CjrKPi76V
X-Google-Smtp-Source: ABdhPJw8M8WWCio4qpRA1ZXyUA8Var1LZEn3zoWxmx7gA98yPdjDztcJ9EMI1/V5rg5Qsem0Jb9eVOShbM9zEULm
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a17:906:8559:: with SMTP id
 h25mr21784179ejy.536.1600204643277; Tue, 15 Sep 2020 14:17:23 -0700 (PDT)
Date:   Tue, 15 Sep 2020 23:16:07 +0200
In-Reply-To: <cover.1600204505.git.andreyknvl@google.com>
Message-Id: <859111cf1d862ce26f094cf14511461c372e5bbc.1600204505.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1600204505.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH v2 25/37] arm64: kasan: Enable in-kernel MTE
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

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

Hardware tag-based KASAN relies on Memory Tagging Extension (MTE)
feature and requires it to be enabled.

The Tag Checking operation causes a synchronous data abort as
a consequence of a tag check fault when MTE is configured in
synchronous mode.

Enable MTE in Synchronous mode in EL1 to provide a more immediate
way of tag check failure detection in the kernel.

As part of this change enable match-all tag for EL1 to allow the
kernel to access user pages without faulting. This is required because
the kernel does not have knowledge of the tags set by the user in a
page.

Note: For MTE, the TCF bit field in SCTLR_EL1 affects only EL1 in a
similar way as TCF0 affects EL0.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
Change-Id: I4d67497268bb7f0c2fc5dcacefa1e273df4af71d
---
 arch/arm64/kernel/cpufeature.c |  7 +++++++
 arch/arm64/mm/proc.S           | 13 +++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index add9da5d8ea3..eca06b8c74db 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1718,6 +1718,13 @@ static void cpu_enable_mte(struct arm64_cpu_capabilities const *cap)
 		cleared_zero_page = true;
 		mte_clear_page_tags(lm_alias(empty_zero_page));
 	}
+
+	/* Enable in-kernel MTE only if KASAN_HW_TAGS is enabled */
+	if (IS_ENABLED(CONFIG_KASAN_HW_TAGS)) {
+		/* Enable MTE Sync Mode for EL1 */
+		sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, SCTLR_ELx_TCF_SYNC);
+		isb();
+	}
 }
 #endif /* CONFIG_ARM64_MTE */
 
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 23c326a06b2d..5ba7ac5e9c77 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -427,6 +427,10 @@ SYM_FUNC_START(__cpu_setup)
 	 */
 	mov_q	x5, MAIR_EL1_SET
 #ifdef CONFIG_ARM64_MTE
+	mte_present	.req	x20
+
+	mov	mte_present, #0
+
 	/*
 	 * Update MAIR_EL1, GCR_EL1 and TFSR*_EL1 if MTE is supported
 	 * (ID_AA64PFR1_EL1[11:8] > 1).
@@ -447,6 +451,8 @@ SYM_FUNC_START(__cpu_setup)
 	/* clear any pending tag check faults in TFSR*_EL1 */
 	msr_s	SYS_TFSR_EL1, xzr
 	msr_s	SYS_TFSRE0_EL1, xzr
+
+	mov	mte_present, #1
 1:
 #endif
 	msr	mair_el1, x5
@@ -485,6 +491,13 @@ SYM_FUNC_START(__cpu_setup)
 	orr	x10, x10, #TCR_HA		// hardware Access flag update
 1:
 #endif	/* CONFIG_ARM64_HW_AFDBM */
+#ifdef CONFIG_ARM64_MTE
+	/* Update TCR_EL1 if MTE is supported (ID_AA64PFR1_EL1[11:8] > 1) */
+	cbz	mte_present, 1f
+	orr	x10, x10, #SYS_TCR_EL1_TCMA1
+1:
+	.unreq	mte_present
+#endif
 	msr	tcr_el1, x10
 	/*
 	 * Prepare SCTLR
-- 
2.28.0.618.gf4bc123cb7-goog

