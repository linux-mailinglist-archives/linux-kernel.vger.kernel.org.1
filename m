Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34FAC2EB20C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 19:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730720AbhAESGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 13:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbhAESGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 13:06:39 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BC5C06179E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 10:05:58 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id 91so86551wrj.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 10:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S3/rPCJUnMLfjD3b25qof1oX2WveJLOvFQJdod0fSPo=;
        b=Iwu0pUa0YSXjcvx3quDZYpB77l41vCMGRFORqWy3mdOa/tYLkPf0sYx8kmz5igXrc7
         EU4nEErd4MlRE7fB6nlJW5P0YzdkYZgSeU0/6oFYl1RkFEgd5P2jgpY0Bgyi1Fz0ZcM3
         DPF9ufE5GKcJX4cQ6HaVMXL+Cd41KOf50op+JJLWKpkUVUftEcZ5E0WpIhzQYaLFsGpZ
         hb0Xnie++//B0InrE4yYVNC/mCGpc7VnwmkMxk5lVpfIcEjuqfoc2E5yz/6UiMtwXJXV
         Aus9iwVc3FY9zZDo4Uyr9qzGwb0Afu4A/A9qUAxXw0wMoNQBbY9obdMD/rifda0qwk3k
         cJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S3/rPCJUnMLfjD3b25qof1oX2WveJLOvFQJdod0fSPo=;
        b=Fd0T24OrXYr6VrB7BjrcUPiSKA+HGrzCmWFDjz7zPLAUjUfpGjnBjkoN9nJs14qs3k
         sD7Zb35aRlt5iqkv/T1zs2dq0p29rDXVvtSf6CnAjtFGfzZtF3EKqPpTy08z2Mt6aYZt
         Z7WYuaQ2gjJztvkXz7e56MWG6nfU0BL5Qo9Yi2z/8rAavYQjTogr0mxFe1gw8EAIwfdx
         px1gqKIyT8dSc7VsOjFuJ8tEc6ihL4mLIVCgiLabQec5jfBOhoUwGl6RMlLYV2hiYbjq
         /COESYpxa5yoL5xrYdQBpZg0MgVxSOoNtYHLjMDoDX0fRQJCFHLFvN08QLtD/657sF6G
         Ml1A==
X-Gm-Message-State: AOAM533FYa+ZRbif9227jGMtjS+gTWkjsg4XvxvkaNQu8m4rg6RMvirN
        sxC+3QTmaAKJ7XwkOPw3CMua3g==
X-Google-Smtp-Source: ABdhPJxc3qALx98DUhQZ7KCR6QZnBSsyO826Znz8Ic7DBsq+bseW6pwLsZMIeo64NXrlmnDKkKvMzQ==
X-Received: by 2002:adf:83a6:: with SMTP id 35mr751393wre.274.1609869957580;
        Tue, 05 Jan 2021 10:05:57 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:4957:71a5:7b5c:c94f])
        by smtp.gmail.com with ESMTPSA id z3sm830263wrn.59.2021.01.05.10.05.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 10:05:56 -0800 (PST)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Brazdil <dbrazdil@google.com>
Subject: [PATCH v2 2/8] KVM: arm64: Set up .hyp.rodata ELF section
Date:   Tue,  5 Jan 2021 18:05:35 +0000
Message-Id: <20210105180541.65031-3-dbrazdil@google.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210105180541.65031-1-dbrazdil@google.com>
References: <20210105180541.65031-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will need to recognize pointers in .rodata specific to hyp, so
establish a .hyp.rodata ELF section. Merge it with the existing
.hyp.data..ro_after_init as they are treated the same at runtime.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/sections.h | 2 +-
 arch/arm64/kernel/vmlinux.lds.S   | 7 ++++---
 arch/arm64/kvm/arm.c              | 7 +++----
 arch/arm64/kvm/hyp/nvhe/hyp.lds.S | 4 +++-
 4 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/sections.h b/arch/arm64/include/asm/sections.h
index 8ff579361731..a6f3557d1ab2 100644
--- a/arch/arm64/include/asm/sections.h
+++ b/arch/arm64/include/asm/sections.h
@@ -11,7 +11,7 @@ extern char __alt_instructions[], __alt_instructions_end[];
 extern char __hibernate_exit_text_start[], __hibernate_exit_text_end[];
 extern char __hyp_idmap_text_start[], __hyp_idmap_text_end[];
 extern char __hyp_text_start[], __hyp_text_end[];
-extern char __hyp_data_ro_after_init_start[], __hyp_data_ro_after_init_end[];
+extern char __hyp_rodata_start[], __hyp_rodata_end[];
 extern char __idmap_text_start[], __idmap_text_end[];
 extern char __initdata_begin[], __initdata_end[];
 extern char __inittext_begin[], __inittext_end[];
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 4c0b0c89ad59..9672b54bba7c 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -31,10 +31,11 @@ jiffies = jiffies_64;
 	__stop___kvm_ex_table = .;
 
 #define HYPERVISOR_DATA_SECTIONS				\
-	HYP_SECTION_NAME(.data..ro_after_init) : {		\
-		__hyp_data_ro_after_init_start = .;		\
+	HYP_SECTION_NAME(.rodata) : {				\
+		__hyp_rodata_start = .;				\
 		*(HYP_SECTION_NAME(.data..ro_after_init))	\
-		__hyp_data_ro_after_init_end = .;		\
+		*(HYP_SECTION_NAME(.rodata))			\
+		__hyp_rodata_end = .;				\
 	}
 
 #define HYPERVISOR_PERCPU_SECTION				\
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 04c44853b103..de1af4052780 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1749,11 +1749,10 @@ static int init_hyp_mode(void)
 		goto out_err;
 	}
 
-	err = create_hyp_mappings(kvm_ksym_ref(__hyp_data_ro_after_init_start),
-				  kvm_ksym_ref(__hyp_data_ro_after_init_end),
-				  PAGE_HYP_RO);
+	err = create_hyp_mappings(kvm_ksym_ref(__hyp_rodata_start),
+				  kvm_ksym_ref(__hyp_rodata_end), PAGE_HYP_RO);
 	if (err) {
-		kvm_err("Cannot map .hyp.data..ro_after_init section\n");
+		kvm_err("Cannot map .hyp.rodata section\n");
 		goto out_err;
 	}
 
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp.lds.S b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
index 70ac48ccede7..cfdc59b4329b 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
@@ -14,6 +14,9 @@
 SECTIONS {
 	HYP_SECTION(.idmap.text)
 	HYP_SECTION(.text)
+	HYP_SECTION(.data..ro_after_init)
+	HYP_SECTION(.rodata)
+
 	/*
 	 * .hyp..data..percpu needs to be page aligned to maintain the same
 	 * alignment for when linking into vmlinux.
@@ -22,5 +25,4 @@ SECTIONS {
 	HYP_SECTION_NAME(.data..percpu) : {
 		PERCPU_INPUT(L1_CACHE_BYTES)
 	}
-	HYP_SECTION(.data..ro_after_init)
 }
-- 
2.29.2.729.g45daf8777d-goog

