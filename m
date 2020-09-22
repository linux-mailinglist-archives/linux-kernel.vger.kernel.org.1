Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA061274A5E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 22:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgIVUtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 16:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbgIVUtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 16:49:24 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D25FC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 13:49:24 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id y15so4748956wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 13:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1lIItytl4uaajAuc4uwjjecDrxF8pHsYAvzuoqJkgTQ=;
        b=h91v9QY6L9oWSaDPJHFteU/oL4xg7PilB7f/6CYc07qQVjY5g5BXNxK79cDfXKdf7z
         w91Gm+c8CoiF+WxxSPQFzZyKEdxVg1k9zFI3I8JKv0GngbjFQCHWIrUmL7skJlMS89Le
         YrnWmM/lupsZAknwvzYKorwsy6vAmiFNdypuKNRisxOq7ERbbC9zH5/htix+dlV7IFle
         mv39K4QMWiI4yFj8FbV4iW+8WAX+bDPdunOlrgzd5wfIjG77A38Bt5PS+LD0+1S/ktTW
         Y0sq2MOJtkH9XDHtzgcfvpqtt86pwVJKPrYkxv63eSUN940SvFv6/K4cxdNwwf5rRg9t
         4glw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1lIItytl4uaajAuc4uwjjecDrxF8pHsYAvzuoqJkgTQ=;
        b=ZB74URCo69e1+uYlin97u+tEXMWu10eolWIFWU+3sI5LMP6wv+Wz9Orj2kLr8qwRTE
         0Oiy7hx1VAW/O9jBGkTT/NVQovKo9mbVFWqEmlYOVvveYA64bUwqu3WNVvTG3oYFeEFA
         Xxi3fgiPTUYN0zcuDmB17Zk5LMpUmPubjNCZECBrjm/S9WeoGev5sce2fH2Y2W+Va+wo
         u4eT/aayJkreU0vdrsNoGOVgkJmmRpacqrfwOWVFH/iiotJ24lEPB41ILpdFWSP2ZuD+
         HLSbV4O4tO4POfdLRMGH+zyiEu4cKKo7/sXPrLkOrdkcIovxa5PZV17Rbku+p8U1xx8X
         pPyw==
X-Gm-Message-State: AOAM532a+9nxY38TAWh7B+uBNrzmLasuS1nB19ImNRGmrgEs1OnO05yq
        RG3EYXvV2v+tGWjbf2n12a1Pzw==
X-Google-Smtp-Source: ABdhPJzic7hX1yo72NPyqxIktIR3nBzaVEb/nfU/OsgI1VH33QpC01Aoy+b0MmzoIP/ac4TNW3Ye2Q==
X-Received: by 2002:a7b:ce0d:: with SMTP id m13mr3028538wmc.83.1600807762992;
        Tue, 22 Sep 2020 13:49:22 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:1105:630f:e990:272f])
        by smtp.gmail.com with ESMTPSA id z11sm27827857wru.88.2020.09.22.13.49.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 13:49:22 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH v4 06/10] kvm: arm64: Add helpers for accessing nVHE hyp per-cpu vars
Date:   Tue, 22 Sep 2020 21:49:06 +0100
Message-Id: <20200922204910.7265-7-dbrazdil@google.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922204910.7265-1-dbrazdil@google.com>
References: <20200922204910.7265-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Defining a per-CPU variable in hyp/nvhe will result in its name being
prefixed with __kvm_nvhe_. Add helpers for declaring these variables
in kernel proper and accessing them with this_cpu_ptr and per_cpu_ptr.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_asm.h | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index cf9456663289..911d91787fa0 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -54,9 +54,21 @@
 	DECLARE_KVM_VHE_SYM(sym);		\
 	DECLARE_KVM_NVHE_SYM(sym)
 
+#define DECLARE_KVM_VHE_PER_CPU(type, sym)	\
+	DECLARE_PER_CPU(type, sym)
+#define DECLARE_KVM_NVHE_PER_CPU(type, sym)	\
+	DECLARE_PER_CPU(type, kvm_nvhe_sym(sym))
+
+#define DECLARE_KVM_HYP_PER_CPU(type, sym)	\
+	DECLARE_KVM_VHE_PER_CPU(type, sym);	\
+	DECLARE_KVM_NVHE_PER_CPU(type, sym)
+
 #define CHOOSE_VHE_SYM(sym)	sym
 #define CHOOSE_NVHE_SYM(sym)	kvm_nvhe_sym(sym)
 
+#define this_cpu_ptr_nvhe_sym(sym)	this_cpu_ptr(&kvm_nvhe_sym(sym))
+#define per_cpu_ptr_nvhe_sym(sym, cpu)	per_cpu_ptr(&kvm_nvhe_sym(sym), cpu)
+
 #ifndef __KVM_NVHE_HYPERVISOR__
 /*
  * BIG FAT WARNINGS:
@@ -69,12 +81,21 @@
  * - Don't let the nVHE hypervisor have access to this, as it will
  *   pick the *wrong* symbol (yes, it runs at EL2...).
  */
-#define CHOOSE_HYP_SYM(sym)	(is_kernel_in_hyp_mode() ? CHOOSE_VHE_SYM(sym) \
+#define CHOOSE_HYP_SYM(sym)		(is_kernel_in_hyp_mode()	\
+					   ? CHOOSE_VHE_SYM(sym)	\
 					   : CHOOSE_NVHE_SYM(sym))
+#define this_cpu_ptr_hyp_sym(sym)	(is_kernel_in_hyp_mode()	\
+					   ? this_cpu_ptr(&sym)		\
+					   : this_cpu_ptr_nvhe_sym(sym))
+#define per_cpu_ptr_hyp_sym(sym, cpu)	(is_kernel_in_hyp_mode()	\
+					   ? per_cpu_ptr(&sym, cpu)	\
+					   : per_cpu_ptr_nvhe_sym(sym, cpu))
 #else
 /* The nVHE hypervisor shouldn't even try to access anything */
 extern void *__nvhe_undefined_symbol;
-#define CHOOSE_HYP_SYM(sym)	__nvhe_undefined_symbol
+#define CHOOSE_HYP_SYM(sym)		__nvhe_undefined_symbol
+#define this_cpu_ptr_hyp_sym(sym)	(&__nvhe_undefined_symbol)
+#define per_cpu_ptr_hyp_sym(sym, cpu)	(&__nvhe_undefined_symbol)
 #endif
 
 /* Translate a kernel address @ptr into its equivalent linear mapping */
-- 
2.28.0.681.g6f77f65b4e-goog

