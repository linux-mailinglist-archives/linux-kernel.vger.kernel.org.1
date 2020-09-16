Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7D826C62C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 19:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbgIPRgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 13:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbgIPRfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:35:22 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A237DC06121C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 10:34:58 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z4so7804014wrr.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 10:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jm9txujGRbU+DIE5pQGENaBdVyNjHKuT2OQRoaKu5mk=;
        b=qo4UjMaG+LBmqizh/dguDo/1ZgFI6RSCpgvcu7UWxVpteEpYt6NHNQhs2cLgolyhud
         x3Ot+cX0Sp2hdxCGGm2R7QvodsCr54yNugnLPLPt6pSz/0vqaUvUP1vkJImvPJavE1JU
         /KWaXjiMd2VyyjXhCcJVrjDOEZ7J/mXd9xq5tVPX0hBQl/hG2W1oMc+sNcdIQEjaEbyg
         P5irBhmyRSSZ3oYyYC65aFW/vOXx2S2ACJsVISa0BOHj761vLtFGseGu2WvmEE1bh+RI
         4Uivcqab87R5WzqTKUqjgCu6wND91b07/46tLA512z6Ayp8j0YmNjO6b4dewhw1zZG7S
         pKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jm9txujGRbU+DIE5pQGENaBdVyNjHKuT2OQRoaKu5mk=;
        b=Jb4XxWlWJEtSPJdFLVxr39rB2oK//ChS1+XUjJAz95fIfUM4mB+K3guKYmk2NZKaNn
         7f3mf3AyjevgSBxJeIPnOEUfKm9RfSuIRAJmHi1i8pPO3195JPKJslZamafN8wyemlho
         FShGARv0wy1UEZaMZffMhUWUFZ/R0g58dwZJyU6DhZfCpcxnBfiI3VrsUHZfGKkf3OhQ
         vnz8OlUxf+j4v5Tbcysj1spgQlX5CdgBL980GHX2FV76GxirD8Rn7GQcLz6mDX8FYDrM
         6Ll28pzSwkBJiP4XJZpMFq6i0kYRTNyUFWzPpIzf21TVD8iw/vULJN2BSW7C/7IF7GnM
         s1RA==
X-Gm-Message-State: AOAM530LlpuZwKXszUuFdi8khH39sMGkOvM17WUOjxcgDR/Xb2ErnkdS
        xV2tB+BNFCUwYNfO+vdMueCxUg==
X-Google-Smtp-Source: ABdhPJwU4kbhpWG5C/yjfJonDHsb6tdTDo9eAoD2gMl5GCOkrw+z409Io9EwIzx1e93E00CEZFWrkw==
X-Received: by 2002:a05:6000:118a:: with SMTP id g10mr28697445wrx.67.1600277697172;
        Wed, 16 Sep 2020 10:34:57 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:e49d:f6be:d31b:ad3c])
        by smtp.gmail.com with ESMTPSA id v204sm6596978wmg.20.2020.09.16.10.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2020 10:34:56 -0700 (PDT)
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
Subject: [PATCH v3 06/11] kvm: arm64: Add helpers for accessing nVHE hyp per-cpu vars
Date:   Wed, 16 Sep 2020 18:34:34 +0100
Message-Id: <20200916173439.32265-7-dbrazdil@google.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200916173439.32265-1-dbrazdil@google.com>
References: <20200916173439.32265-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Defining a per-CPU variable in hyp/nvhe will result in its name being
prefixed with __kvm_nvhe_. Add helpers for declaring these variables
in kernel proper and accessing them with this_cpu_ptr and per_cpu_ptr.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_asm.h | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index cf9456663289..abc03f386b40 100644
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
 
+#define this_cpu_ptr_nvhe(sym)		this_cpu_ptr(&kvm_nvhe_sym(sym))
+#define per_cpu_ptr_nvhe(sym, cpu)	per_cpu_ptr(&kvm_nvhe_sym(sym), cpu)
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
+#define this_cpu_ptr_hyp(sym)		(is_kernel_in_hyp_mode()	\
+					   ? this_cpu_ptr(&sym)		\
+					   : this_cpu_ptr_nvhe(sym))
+#define per_cpu_ptr_hyp(sym, cpu)	(is_kernel_in_hyp_mode()	\
+					   ? per_cpu_ptr(&sym, cpu)	\
+					   : per_cpu_ptr_nvhe(sym, cpu))
 #else
 /* The nVHE hypervisor shouldn't even try to access anything */
 extern void *__nvhe_undefined_symbol;
-#define CHOOSE_HYP_SYM(sym)	__nvhe_undefined_symbol
+#define CHOOSE_HYP_SYM(sym)		__nvhe_undefined_symbol
+#define this_cpu_ptr_hyp(sym)		(&__nvhe_undefined_symbol)
+#define per_cpu_ptr_hyp(sym, cpu)	(&__nvhe_undefined_symbol)
 #endif
 
 /* Translate a kernel address @ptr into its equivalent linear mapping */
-- 
2.28.0.618.gf4bc123cb7-goog

