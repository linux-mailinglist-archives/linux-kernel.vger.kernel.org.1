Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64422D4314
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 14:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732297AbgLINSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 08:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732237AbgLINSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 08:18:38 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48EEC061794
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 05:17:57 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id g185so1638164wmf.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 05:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eC3dfrduk9N3bItne4Bt2OJ3xFC82tVD26IiWD/PAzc=;
        b=ZhdHHWTrxybOS3ckjtAmTjfzvZosyvpJGZcwcPadU5OeCIPFNwt1A3F29cIGChqQBi
         5+cQAEs0QKUeKAH+f6I3IbNBTY+dZ6M6X2DC4cxNXVKRlCLMUyoGV/iIJJQ++TGYt7cN
         HWQ+ttLyL29Ckl0l8dhFUEMOYLBhF9H7F62yggNGMq9+pE6vz7cxq3JDXBa2owu7dv4q
         Fek1uPRomzQ3VbhTcMdLcgYbIayHaX/zgPY0yjxJGjH8qB7QIFZfIrOdceHWn3ldY3Zg
         lbhHMVOb92NEJeoEnF/6sQXRszqVs+xGV8veUIdFoDvVQ0ts2N+ory1Vz2SwyYpZ+x2n
         csmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eC3dfrduk9N3bItne4Bt2OJ3xFC82tVD26IiWD/PAzc=;
        b=W40GpTQNrlHfLi+0FaNmcIamibW1RRHrBz8bzAi4cYJcL1IdBoi767wk8/uqLpPpTM
         ra9TQoaSBbCuz1FhX5RjdIzOz3hV6kTYDnX/FDGkV4+UnLScy14a+P0WdhN77swEAOH/
         PNzXsWggB8ctX1T5JzkkkhyH7wMzOTpQa9UgrdqPbGb4RMo9LRhZKAaXI1lkgl69BP73
         G+VQSQROzYZpw9kQZwbPl70VzBqHD+RNw97VlwIECoMsWFm5bcZITF2aMKpgd4Hc7RPc
         hjAE9Hl1DkZEdUmuGLbeITAQLcqYvWypp4QocoD0boXwam9IQErW3M+KwVpJlYQGFl43
         Zo0Q==
X-Gm-Message-State: AOAM5329UZLtapEgcqW50frsBXEpmGGoT9fPk0rLpGNwAF8isM2FxRh/
        +acf3fwQNyorWj9NIgFJgp5pkQ==
X-Google-Smtp-Source: ABdhPJyJlAdG9Q2cJj2wx1wE7lWFVUjh7hiYEXBuQsKX5NFis+JOymoWzsrCIbt9tGIBYhRtb6nAqw==
X-Received: by 2002:a1c:2c4:: with SMTP id 187mr2810150wmc.187.1607519876443;
        Wed, 09 Dec 2020 05:17:56 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:9d1b:d0eb:db43:6cd2])
        by smtp.gmail.com with ESMTPSA id d8sm3211263wrp.44.2020.12.09.05.17.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 05:17:55 -0800 (PST)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH 3/9] KVM: arm64: Set up .hyp.rodata ELF section
Date:   Wed,  9 Dec 2020 13:17:40 +0000
Message-Id: <20201209131746.85622-4-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209131746.85622-1-dbrazdil@google.com>
References: <20201209131746.85622-1-dbrazdil@google.com>
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
index 43af13968dfd..f294f2048955 100644
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
index 6e637d2b4cfb..c244e57f9cd9 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1745,11 +1745,10 @@ static int init_hyp_mode(void)
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
2.29.2.576.ga3fc446d84-goog

