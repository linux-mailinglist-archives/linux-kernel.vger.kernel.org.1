Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 994FD277BF6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 00:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgIXWwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 18:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgIXWv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 18:51:59 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288BCC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 15:51:59 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id 23so272517wmk.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 15:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=aeL0Vc4/BKzUgRM3E0S3wSW/q500Qn2N9aeyIxmwibc=;
        b=blC6/eUXqJVXihQ9uz1k7kKGqoJ0B1FmvKJ2QjfyVmYT2qze33KgIBMTcDf61h7PQe
         5OGdAQZC1LVwv3i6fYyw+8Q8qKnRHiANFhxrP/INUSoGpSPLLfGTyjUfrJ3mZ7EEV0WA
         ceKgprsT1GZ0ZLo35ZsneCMe3yqqDHyDRyWQ51cYdz75fuI5Ux1R7MPIp6O+Yvv26FKQ
         vBcIdhre7SeGevx0PtdmQhrho09xKqNTU6SuVPfz4rukCQsGX9ZGlbiRk8D7Fk54pO1d
         cAZug2zyyj01m/OVwZQ8SxfRBk3yoHnLR7mMhNgBXgccQU+xrXNRjcAYst/b0LS9iXZv
         vDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aeL0Vc4/BKzUgRM3E0S3wSW/q500Qn2N9aeyIxmwibc=;
        b=e2fhYhoZPv0hSp0JWjeNpXw3IFzMFfxEyDKJSReBY90WhVhWnrSwJ/FF6L/8IH/Peb
         j+eoEQKeVBGiSP2k5C6nLojKMpPr4Vyj9Rr+zeqC+KZu8FtuDXU17NqX3Y2+ja/f+bru
         GRBMWlTA5/zEANpeMF8Aa5ZhqIms66GRZoNsL1aBXF32IC3TftO5mww8J5dqXiU6SdBt
         L9EE/IwoNzNoQpfwf4gS4iwKCF/bgGxF5ngmvozU9kG/BrXXj5NmVhb4fAFXmWgfTLcc
         ebj5SnC+DxZTCzDdz3kCxzsrAI+76Cx7IkxOVvcNosVMBEs3yxImjl2ZvfpLjuZdB8xA
         7Zsw==
X-Gm-Message-State: AOAM530f4p97fTJUZ/GTJZVJR5AS1IaZ3SzsLxWOdhdIJ9sGyD3Tb4bK
        7u5YntO3Z/7F8lOvWbp3KrrDme4C0oQepxJ4
X-Google-Smtp-Source: ABdhPJyYl9N+lA13EyJ7kaYvdEP+/Po8XLCm6aG41E8kGgp5S8/Rs9EaZbuvB2nsBxlh+3UakVA0gRUXMfqgKHW1
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:adf:8b1d:: with SMTP id
 n29mr1105331wra.383.1600987917635; Thu, 24 Sep 2020 15:51:57 -0700 (PDT)
Date:   Fri, 25 Sep 2020 00:50:34 +0200
In-Reply-To: <cover.1600987622.git.andreyknvl@google.com>
Message-Id: <20326c060cd1535b15a0df43d1b9627a329f2277.1600987622.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1600987622.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3 27/39] arm64: kasan: Enable in-kernel MTE
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
 arch/arm64/mm/proc.S           | 11 +++++++++++
 2 files changed, 18 insertions(+)

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
index 23c326a06b2d..12ba98bc3b3f 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -427,6 +427,10 @@ SYM_FUNC_START(__cpu_setup)
 	 */
 	mov_q	x5, MAIR_EL1_SET
 #ifdef CONFIG_ARM64_MTE
+	mte_tcr	.req	x20
+
+	mov	mte_tcr, #0
+
 	/*
 	 * Update MAIR_EL1, GCR_EL1 and TFSR*_EL1 if MTE is supported
 	 * (ID_AA64PFR1_EL1[11:8] > 1).
@@ -447,6 +451,9 @@ SYM_FUNC_START(__cpu_setup)
 	/* clear any pending tag check faults in TFSR*_EL1 */
 	msr_s	SYS_TFSR_EL1, xzr
 	msr_s	SYS_TFSRE0_EL1, xzr
+
+	/* set the TCR_EL1 bits */
+	orr	mte_tcr, mte_tcr, #SYS_TCR_EL1_TCMA1
 1:
 #endif
 	msr	mair_el1, x5
@@ -457,6 +464,10 @@ SYM_FUNC_START(__cpu_setup)
 	mov_q	x10, TCR_TxSZ(VA_BITS) | TCR_CACHE_FLAGS | TCR_SMP_FLAGS | \
 			TCR_TG_FLAGS | TCR_KASLR_FLAGS | TCR_ASID16 | \
 			TCR_TBI0 | TCR_A1 | TCR_KASAN_FLAGS
+#ifdef CONFIG_ARM64_MTE
+	orr	x10, x10, mte_tcr
+	.unreq	mte_tcr
+#endif
 	tcr_clear_errata_bits x10, x9, x5
 
 #ifdef CONFIG_ARM64_VA_BITS_52
-- 
2.28.0.681.g6f77f65b4e-goog

