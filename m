Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B15B26B006
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 23:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgIOV4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 17:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728105AbgIOV3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 17:29:24 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470FEC061226
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:17:32 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id a12so1706664wrg.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=gQNZi1xbbNqueATb+Ofst812z+wTX6Uhy5JHBLW29HQ=;
        b=Yy3NAxKGs0090BOPTba/nzO4cFPD9qSiFj0muhX6uXXMpAPGomh/ZDVdoYoyMlJR2H
         lIazQ2HvczoFsJTOWPdKzJYfc2/WOOw9C0hGyRF9UQYgPE3AgqDYVZNtdqTPibhmoXf1
         VMf+YKRB6flrLwpkd/7RoFRlnJ08ZGYvHEW2PcJoF+BsjcFwlCOhxqpdr/MY9g7x5o7R
         VH9u2MeaeqzIdTc+ZxJb27i3vPDxpiSRfNRQmZDcS6TPnaY9a9KOzceh+71b+fUis8/9
         GkMM1tMTE9Ao04l35J6odqEAVgW/k0Ib0q1fXWI+cyy/5MUehNYMowaBVV3WbqukJYDt
         FAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gQNZi1xbbNqueATb+Ofst812z+wTX6Uhy5JHBLW29HQ=;
        b=DrWxgnHPxwIz/6Lj8oL3eu89wQKhc1cWkghbFL3auwMYXDC8IdeWkPhNcpY5MpaLH3
         yiib/GtcQ4EKrOui8i+2tMo8xv39YjsIERKogK26a9lHIlS3ihF/cG7r39GzxBoruv8I
         +B5eioyv4M7UAnanYGpLryTe8OzlMY+IdSPgtS1HevHJAo50AaoWpqlO/UKSmuDjYtxf
         nVTYmCz8nll4xwSn6VqK+tMa0tOfGGKMDkHjMCgtGcrhx6rFBprivQoBw9gEJ9uiq9zJ
         mFoVoegANHM6yS41fY4UEE8RNpjVO46VQBkLDc0tRr8ucnuk9XSob9LDZUt6ZOMD4TEm
         qR2Q==
X-Gm-Message-State: AOAM533rDBzukHJXutywRwhre5NwFYg3QpfJucLO+fHWhTuQTx1TO49U
        DuPlyk7FphDJgfORReZ7JeXwt4+mHvf5iXAn
X-Google-Smtp-Source: ABdhPJxSdz7eZtkr4LcxuG7RUBwuiBQj3nl4wipePG7BDeui7hcx3jwqP/ZGF3lGDPtyJkewnREY16db2QT71g3F
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:adf:dd44:: with SMTP id
 u4mr22386734wrm.22.1600204650809; Tue, 15 Sep 2020 14:17:30 -0700 (PDT)
Date:   Tue, 15 Sep 2020 23:16:10 +0200
In-Reply-To: <cover.1600204505.git.andreyknvl@google.com>
Message-Id: <9ecc27d43a01ca32bcacf44b393a9a100e0dfdb2.1600204505.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1600204505.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH v2 28/37] arm64: kasan: Enable TBI EL1
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

Hardware tag-based KASAN relies on Memory Tagging Extension (MTE) that is
built on top of the Top Byte Ignore (TBI) feature.

Enable in-kernel TBI when CONFIG_KASAN_HW_TAGS is turned on by enabling
the TCR_TBI1 bit in proc.S.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Co-developed-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
Change-Id: I91944903bc9c9c9044f0d50e74bcd6b9971d21ff
---
 arch/arm64/mm/proc.S | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 5ba7ac5e9c77..1687447dee7a 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -40,9 +40,13 @@
 #define TCR_CACHE_FLAGS	TCR_IRGN_WBWA | TCR_ORGN_WBWA
 
 #ifdef CONFIG_KASAN_SW_TAGS
-#define TCR_KASAN_FLAGS TCR_TBI1
+#define TCR_KASAN_SW_FLAGS TCR_TBI1
 #else
-#define TCR_KASAN_FLAGS 0
+#define TCR_KASAN_SW_FLAGS 0
+#endif
+
+#ifdef CONFIG_KASAN_HW_TAGS
+#define TCR_KASAN_HW_FLAGS TCR_TBI1
 #endif
 
 /*
@@ -462,7 +466,7 @@ SYM_FUNC_START(__cpu_setup)
 	 */
 	mov_q	x10, TCR_TxSZ(VA_BITS) | TCR_CACHE_FLAGS | TCR_SMP_FLAGS | \
 			TCR_TG_FLAGS | TCR_KASLR_FLAGS | TCR_ASID16 | \
-			TCR_TBI0 | TCR_A1 | TCR_KASAN_FLAGS
+			TCR_TBI0 | TCR_A1 | TCR_KASAN_SW_FLAGS
 	tcr_clear_errata_bits x10, x9, x5
 
 #ifdef CONFIG_ARM64_VA_BITS_52
@@ -495,6 +499,9 @@ SYM_FUNC_START(__cpu_setup)
 	/* Update TCR_EL1 if MTE is supported (ID_AA64PFR1_EL1[11:8] > 1) */
 	cbz	mte_present, 1f
 	orr	x10, x10, #SYS_TCR_EL1_TCMA1
+#ifdef CONFIG_KASAN_HW_TAGS
+	orr	x10, x10, #TCR_KASAN_HW_FLAGS
+#endif
 1:
 	.unreq	mte_present
 #endif
-- 
2.28.0.618.gf4bc123cb7-goog

