Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32FB82B6CED
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 19:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730947AbgKQSQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 13:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730913AbgKQSQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 13:16:53 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C19FC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 10:16:53 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id w6so13337943wrk.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 10:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=F6/Ku+z/rldXTKyTjaRYVBv4lFiTA1v23xAOFYW1znk=;
        b=ZN7TMzWcg2kpOSqffDoVhtCt8uuThETRtG/2q52T5qCUyS9wVVeqC8DLp9GHUxjPzl
         aRJom2yDGA29gjrTZrqqST+sCuyxUep0AcG3zyv30IblaP/4C9KEnPFKrtG+ZDCaIltz
         G1DBpjrBArDifkZHj2qKeMp5ucykr8vNPn9d5SaiPvot0qDGmYdqV7hchxuHrIYBK3Yt
         zQezM/vBty6xeYGG3xPKCMDP12KKhXP5Pcw3ErAA+STpsQVaYQ62FE6TFa2w6PAZc4YJ
         a7cIVY5OSaYEJLpdXMS0djxudcoIzYtYFsaSPvip1YOmJbhIujEddKb27SQvDMsnNhfF
         PBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=F6/Ku+z/rldXTKyTjaRYVBv4lFiTA1v23xAOFYW1znk=;
        b=Grs7lLi4nqZVZzjwOhOgInEGrPBuVwyV9bKomMexsW2sHhzlZfl2bNO04n3LSDgCrN
         aXnJYkCDpcQW0V2IqJq1lkdruvqFd/nmMiAmn0wcc4qJ7/dBHKE8Il7J/pT7w78/sWBr
         FMXy1pCV/fojiu4xqimlMEZJvuitMEwgZc/jPjpRlSAramilrcO3UV9OovdF2mk0QaGF
         3PoL24tvWMWm1Og4t/J7xiMM75TF00DtF47coWYc8cLJlKrKNvqROAkb9gqwx1DY+ya9
         yOEC6SMCgtkwM48JnZqFYO2aLMz3lIFk4RVflPrVZSBHqYzGiL8SeScU3sWUfQYS6G/V
         2wFg==
X-Gm-Message-State: AOAM533C8MdEsTTOWBVofU/e/WpIIGaM/T/3ylMlzVoIIndjOECV/VI8
        B8mr/HiM6zkGT0i9IazmAZELaWvEmtvy
X-Google-Smtp-Source: ABdhPJxPq5M30rdGbubfNCRpT9hqgInad/1CQDFyjy/L+083VvfB25t4bfYqH1wKxMY1b6mlTwrfv3eLZu9/
Sender: "qperret via sendgmr" <qperret@luke.lon.corp.google.com>
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
 (user=qperret job=sendgmr) by 2002:adf:82f5:: with SMTP id
 108mr804663wrc.269.1605637011993; Tue, 17 Nov 2020 10:16:51 -0800 (PST)
Date:   Tue, 17 Nov 2020 18:15:54 +0000
In-Reply-To: <20201117181607.1761516-1-qperret@google.com>
Message-Id: <20201117181607.1761516-15-qperret@google.com>
Mime-Version: 1.0
References: <20201117181607.1761516-1-qperret@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH 14/27] KVM: arm64: Factor out vector address calculation
From:   Quentin Perret <qperret@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" 
        <kvmarm@lists.cs.columbia.edu>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>, kernel-team@android.com,
        android-kvm@google.com, Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to re-map the guest vectors at EL2 when pKVM is enabled,
refactor __kvm_vector_slot2idx() and kvm_init_vector_slot() to move all
the address calculation logic in a static inline function.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_mmu.h | 8 ++++++++
 arch/arm64/kvm/arm.c             | 9 +--------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 5168a0c516ae..cb104443d8e4 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -171,6 +171,14 @@ phys_addr_t kvm_mmu_get_httbr(void);
 phys_addr_t kvm_get_idmap_vector(void);
 int kvm_mmu_init(void);
 
+static inline void *__kvm_vector_slot2addr(void *base,
+					   enum arm64_hyp_spectre_vector slot)
+{
+	int idx = slot - (slot != HYP_VECTOR_DIRECT);
+
+	return base + (idx * SZ_2K);
+}
+
 struct kvm;
 
 #define kvm_flush_dcache_to_poc(a,l)	__flush_dcache_area((a), (l))
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index c7f8fca97202..b1e1747e4bbf 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1318,16 +1318,9 @@ static unsigned long nvhe_percpu_order(void)
 /* A lookup table holding the hypervisor VA for each vector slot */
 static void *hyp_spectre_vector_selector[BP_HARDEN_EL2_SLOTS];
 
-static int __kvm_vector_slot2idx(enum arm64_hyp_spectre_vector slot)
-{
-	return slot - (slot != HYP_VECTOR_DIRECT);
-}
-
 static void kvm_init_vector_slot(void *base, enum arm64_hyp_spectre_vector slot)
 {
-	int idx = __kvm_vector_slot2idx(slot);
-
-	hyp_spectre_vector_selector[slot] = base + (idx * SZ_2K);
+	hyp_spectre_vector_selector[slot] = __kvm_vector_slot2addr(base, slot);
 }
 
 static int kvm_init_vector_slots(void)
-- 
2.29.2.299.gdc1121823c-goog

