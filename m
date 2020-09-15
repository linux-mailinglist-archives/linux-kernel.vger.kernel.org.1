Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0C526AFFD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 23:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgIOVxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 17:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbgIOVaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 17:30:16 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A75C061224
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:17:26 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id c19so4066454qkk.20
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=LoMLrgCJ4NCLa6lDkl4/AfQRlbckNXKPTR9s0h+8nto=;
        b=OPHSGMgyTOEYfNPCqFtxP8N6XSZ6nxthp788gfaQ6LZK88+NP4G9p8EfPPO64vxsMI
         1Vp+LwO8Ch8ajFcrNwd8R/XStc+zaNO399CyV8mmtSNtCE9oUIixxEu685oh+92ui+x0
         KbAP5RApmPxXLCNI3A/nPLpPQafWdGNAXJPXruFJ68rI+OQej/eb3gAUyXcc/NurYUOQ
         9r0CIjJc6n5UatLdS8F96jkE+QhbQcVnS+6Q6PA6qsVY8mpL1iUib6dCdh79f60Vi7t5
         u7KNZOzWlUTFEIH80ecHOhmW0gkQgt0jqxCSW8AtwiJLtXVHpndqXBWyDQeJvuen3TFn
         f+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LoMLrgCJ4NCLa6lDkl4/AfQRlbckNXKPTR9s0h+8nto=;
        b=beo3Qz/IC3Vgz7x0W8inkrGZRGd01Cv04Qbr80i3YPYJxvUN3V1vikFdsP4OuF8E2h
         WDRKJAKvML0cmxomSPmwBW7U77eTZ4VC9u8jIXI0y0Edloql7P26azKxTdZDiNiwk5A3
         P8dUNJby0WXu19VgRlx050rjlG7kH1ZbnemkHidFPTJCFEA8yaZeGIdu9EONKE8iH38g
         Gx1M+NpMMKOZFzQkKaXrrUP+RDZnlDtUVE5QD16tq2WYs4pGKvo+MEdCuvBfHrJSpVR+
         4duuKrRV6UGIwa/kBHh7ri0WJg5LOw8zgEgITAQHV80X69Y5Tng0WOwJ9myQLIk6hBe1
         Lk4Q==
X-Gm-Message-State: AOAM532UIezY54xi1HqLr6nvzqBn9LqemWzQzAbNHFgHJea4YmwvOUBJ
        qBO/gNckamA+MshjQVM2pYCGdNilG1pzpZBw
X-Google-Smtp-Source: ABdhPJxmY0qJcpgV1DP7goE8DV5QQTLm7VX7KUqDAy2WnXdtmug7VK++0MBCbCzt8X4HcHNViflvrcMh5ai1FDcA
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:b21b:: with SMTP id
 x27mr20134857qvd.12.1600204645596; Tue, 15 Sep 2020 14:17:25 -0700 (PDT)
Date:   Tue, 15 Sep 2020 23:16:08 +0200
In-Reply-To: <cover.1600204505.git.andreyknvl@google.com>
Message-Id: <dbe7d509102cbbefe0bafb38e9367b5b323bfebd.1600204505.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1600204505.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH v2 26/37] arm64: mte: Convert gcr_user into an exclude mask
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

The gcr_user mask is a per thread mask that represents the tags that are
excluded from random generation when the Memory Tagging Extension is
present and an 'irg' instruction is invoked.

gcr_user affects the behavior on EL0 only.

Currently that mask is an include mask and it is controlled by the user
via prctl() while GCR_EL1 accepts an exclude mask.

Convert the include mask into an exclude one to make it easier the
register setting.

Note: This change will affect gcr_kernel (for EL1) introduced with a
future patch.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
Change-Id: Id15c0b47582fb51594bb26fb8353d78c7d0953c1
---
 arch/arm64/include/asm/processor.h |  2 +-
 arch/arm64/kernel/mte.c            | 29 +++++++++++++++--------------
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index fec204d28fce..ed9efa5be8eb 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -153,7 +153,7 @@ struct thread_struct {
 #endif
 #ifdef CONFIG_ARM64_MTE
 	u64			sctlr_tcf0;
-	u64			gcr_user_incl;
+	u64			gcr_user_excl;
 #endif
 };
 
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index e238ffde2679..858e75cfcaa0 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -140,23 +140,22 @@ static void set_sctlr_el1_tcf0(u64 tcf0)
 	preempt_enable();
 }
 
-static void update_gcr_el1_excl(u64 incl)
+static void update_gcr_el1_excl(u64 excl)
 {
-	u64 excl = ~incl & SYS_GCR_EL1_EXCL_MASK;
 
 	/*
-	 * Note that 'incl' is an include mask (controlled by the user via
-	 * prctl()) while GCR_EL1 accepts an exclude mask.
+	 * Note that the mask controlled by the user via prctl() is an
+	 * include while GCR_EL1 accepts an exclude mask.
 	 * No need for ISB since this only affects EL0 currently, implicit
 	 * with ERET.
 	 */
 	sysreg_clear_set_s(SYS_GCR_EL1, SYS_GCR_EL1_EXCL_MASK, excl);
 }
 
-static void set_gcr_el1_excl(u64 incl)
+static void set_gcr_el1_excl(u64 excl)
 {
-	current->thread.gcr_user_incl = incl;
-	update_gcr_el1_excl(incl);
+	current->thread.gcr_user_excl = excl;
+	update_gcr_el1_excl(excl);
 }
 
 void flush_mte_state(void)
@@ -171,7 +170,7 @@ void flush_mte_state(void)
 	/* disable tag checking */
 	set_sctlr_el1_tcf0(SCTLR_EL1_TCF0_NONE);
 	/* reset tag generation mask */
-	set_gcr_el1_excl(0);
+	set_gcr_el1_excl(SYS_GCR_EL1_EXCL_MASK);
 }
 
 void mte_thread_switch(struct task_struct *next)
@@ -182,7 +181,7 @@ void mte_thread_switch(struct task_struct *next)
 	/* avoid expensive SCTLR_EL1 accesses if no change */
 	if (current->thread.sctlr_tcf0 != next->thread.sctlr_tcf0)
 		update_sctlr_el1_tcf0(next->thread.sctlr_tcf0);
-	update_gcr_el1_excl(next->thread.gcr_user_incl);
+	update_gcr_el1_excl(next->thread.gcr_user_excl);
 }
 
 void mte_suspend_exit(void)
@@ -190,13 +189,14 @@ void mte_suspend_exit(void)
 	if (!system_supports_mte())
 		return;
 
-	update_gcr_el1_excl(current->thread.gcr_user_incl);
+	update_gcr_el1_excl(current->thread.gcr_user_excl);
 }
 
 long set_mte_ctrl(struct task_struct *task, unsigned long arg)
 {
 	u64 tcf0;
-	u64 gcr_incl = (arg & PR_MTE_TAG_MASK) >> PR_MTE_TAG_SHIFT;
+	u64 gcr_excl = ~((arg & PR_MTE_TAG_MASK) >> PR_MTE_TAG_SHIFT) &
+		       SYS_GCR_EL1_EXCL_MASK;
 
 	if (!system_supports_mte())
 		return 0;
@@ -217,10 +217,10 @@ long set_mte_ctrl(struct task_struct *task, unsigned long arg)
 
 	if (task != current) {
 		task->thread.sctlr_tcf0 = tcf0;
-		task->thread.gcr_user_incl = gcr_incl;
+		task->thread.gcr_user_excl = gcr_excl;
 	} else {
 		set_sctlr_el1_tcf0(tcf0);
-		set_gcr_el1_excl(gcr_incl);
+		set_gcr_el1_excl(gcr_excl);
 	}
 
 	return 0;
@@ -229,11 +229,12 @@ long set_mte_ctrl(struct task_struct *task, unsigned long arg)
 long get_mte_ctrl(struct task_struct *task)
 {
 	unsigned long ret;
+	u64 incl = ~task->thread.gcr_user_excl & SYS_GCR_EL1_EXCL_MASK;
 
 	if (!system_supports_mte())
 		return 0;
 
-	ret = task->thread.gcr_user_incl << PR_MTE_TAG_SHIFT;
+	ret = incl << PR_MTE_TAG_SHIFT;
 
 	switch (task->thread.sctlr_tcf0) {
 	case SCTLR_EL1_TCF0_NONE:
-- 
2.28.0.618.gf4bc123cb7-goog

