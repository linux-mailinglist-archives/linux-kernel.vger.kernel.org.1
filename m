Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932842B6CC9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 19:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730824AbgKQSQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 13:16:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730747AbgKQSQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 13:16:37 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DB0C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 10:16:36 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id w17so13200096wrp.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 10:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ku0UFgVufHs9v1IJuu4Ni7X8qoCAXYV3NVQ1AKXoaAA=;
        b=H5BJeQDNLb++2xZvg4tH88cc0a517Nx1EBbTKeYIiv7k2xmQWwSp58eVZTiebUdyMG
         +g9ZeTElu3osA0nWOAV/aPjF1sobwPu1mjr/Dc4ZR36cFV5rLKkzslvkaXdW4CLYUChE
         nsu09uy4ADkg28f4TLlCpZGieLbT7PYoNhrfsiVb3HuoZcGEbh4XzBqyFM2bwNG3qIfY
         hH/rYe/JYRFiC/HTk4i7mRnSpAofJBPD+hamGi87aZT+MwV5MFfE4MgTO4nNxijcnPew
         C0S1hc2bUUhl2BBBC+fbW8SxHu46dT+sn/YDa0tekeckiqLhsPvIgfkzwciINYE0N9jK
         cxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ku0UFgVufHs9v1IJuu4Ni7X8qoCAXYV3NVQ1AKXoaAA=;
        b=mHU+20f+w51NxoRrRs3Ga5rmWM5mFauLvDGQ45AC2yLwOaWxkbGWH8UV/swTtDp/ci
         GA8ir1VoP/ZXlfbYsP3WfSfXSALUAIh7XxjB4lG3DxFk6oh9vIUrj4un3b/fSvdUIj5F
         qrJC7m0uubhQXczX3TOw7nmUWBIORRuPKNOkDJqYoRfb/l3XiPBrgZw/aD1payYjWp9D
         meJuM1hYck1TvxTRD2I5BKSpAz/PKRUSoMaCDd5nmndBuY/NqMQrHAEiukntlQIbn27e
         q8aJfeq/otxlol/I27VDvNOC8oO2cmZl5EHHh/2vRW4mndTRgvXWyoEVomgnAeoIY/Lo
         w7Ag==
X-Gm-Message-State: AOAM530PyyWyzDbZndth2f1nMJf2fQz+MuR+75cyD2rJuvqdGze/Fwaz
        iXNYKt8sM+lRj3JxilaSUiMfrKYtdRdA
X-Google-Smtp-Source: ABdhPJxGgMTS1HY9eY7+MyhEXSMxE4MyyZGir1Tn8gNiQHb8pv7qDl59xEr1Ob0B7Wzc6Bbww1Gn9i2dBo1H
Sender: "qperret via sendgmr" <qperret@luke.lon.corp.google.com>
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
 (user=qperret job=sendgmr) by 2002:a1c:398a:: with SMTP id
 g132mr368672wma.51.1605636995303; Tue, 17 Nov 2020 10:16:35 -0800 (PST)
Date:   Tue, 17 Nov 2020 18:15:47 +0000
In-Reply-To: <20201117181607.1761516-1-qperret@google.com>
Message-Id: <20201117181607.1761516-8-qperret@google.com>
Mime-Version: 1.0
References: <20201117181607.1761516-1-qperret@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH 07/27] KVM: arm64: Introduce a BSS section for use at Hyp
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

Currently, the hyp code cannot make full use of a bss, as the kernel
section is mapped read-only.

While this mapping could simply be changed to read-write, it would
intermingle even more the hyp and kernel state than they currently are.
Instead, introduce a __hyp_bss section, that uses reserved pages, and
create the appropriate RW hyp mappings during KVM init.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/sections.h |  1 +
 arch/arm64/kernel/vmlinux.lds.S   |  7 +++++++
 arch/arm64/kvm/arm.c              | 11 +++++++++++
 arch/arm64/kvm/hyp/nvhe/hyp.lds.S |  1 +
 4 files changed, 20 insertions(+)

diff --git a/arch/arm64/include/asm/sections.h b/arch/arm64/include/asm/sections.h
index 8ff579361731..f58cf493de16 100644
--- a/arch/arm64/include/asm/sections.h
+++ b/arch/arm64/include/asm/sections.h
@@ -12,6 +12,7 @@ extern char __hibernate_exit_text_start[], __hibernate_exit_text_end[];
 extern char __hyp_idmap_text_start[], __hyp_idmap_text_end[];
 extern char __hyp_text_start[], __hyp_text_end[];
 extern char __hyp_data_ro_after_init_start[], __hyp_data_ro_after_init_end[];
+extern char __hyp_bss_start[], __hyp_bss_end[];
 extern char __idmap_text_start[], __idmap_text_end[];
 extern char __initdata_begin[], __initdata_end[];
 extern char __inittext_begin[], __inittext_end[];
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 4382b5d0645d..ded78a25365d 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -8,6 +8,13 @@
 #define RO_EXCEPTION_TABLE_ALIGN	8
 #define RUNTIME_DISCARD_EXIT
 
+#define BSS_FIRST_SECTIONS				\
+	. = ALIGN(PAGE_SIZE);				\
+	__hyp_bss_start = .;				\
+	*(.hyp.bss)					\
+	. = ALIGN(PAGE_SIZE);				\
+	__hyp_bss_end = .;
+
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/cache.h>
 #include <asm/hyp_image.h>
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 7335eb4fb0bd..882eb383bd75 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1709,7 +1709,18 @@ static int init_hyp_mode(void)
 		goto out_err;
 	}
 
+	/*
+	 * .hyp.bss is placed at the beginning of the .bss section, so map that
+	 * part RW, and the rest RO as the hyp shouldn't be touching it.
+	 */
 	err = create_hyp_mappings(kvm_ksym_ref(__bss_start),
+				  kvm_ksym_ref(__hyp_bss_end), PAGE_HYP);
+	if (err) {
+		kvm_err("Cannot map hyp bss section: %d\n", err);
+		goto out_err;
+	}
+
+	err = create_hyp_mappings(kvm_ksym_ref(__hyp_bss_end),
 				  kvm_ksym_ref(__bss_stop), PAGE_HYP_RO);
 	if (err) {
 		kvm_err("Cannot map bss section\n");
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp.lds.S b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
index 5d76ff2ba63e..dc281d90063e 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
@@ -17,4 +17,5 @@ SECTIONS {
 		PERCPU_INPUT(L1_CACHE_BYTES)
 	}
 	HYP_SECTION(.data..ro_after_init)
+	HYP_SECTION(.bss)
 }
-- 
2.29.2.299.gdc1121823c-goog

