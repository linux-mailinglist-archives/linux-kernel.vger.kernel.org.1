Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17ED2A6CDE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 19:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732471AbgKDSg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 13:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732452AbgKDSgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 13:36:52 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973B7C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 10:36:52 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id h62so3286497wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 10:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/4FeYdmn3iB0IXLNt/H1CXu0UQ9fwGLnFLDS+u9FzHI=;
        b=pwS+yO9awK8oUBpQAVkLJuj63BH/WHRSAh1203sKJMLPgu/Z7WrtlqDJagBVCYrBaf
         EOF4SKuIVhlxAqijYs3lo1YFAo8JMGNuT2vGkFPRX2iSDKwMvMACiSGWDwM6hRJ50W30
         rsJicMhiC6OYQ/2/CIUPbdAdRQpWJXMwejJYSsKhgwDaIDaZLSG1v9QGvqOLA1ErGg9d
         Iq0FStkmxGam8BquTREXKbmimi0koGzmcK9fr4eliQyQiNZJD/2xQZ2zt3TcJYss/+q2
         PU8oK7Fyq8/xDdNN+GYMONZ2wzMa7EPpgD5F7CCcwZhZwvFOGbR9o6UrjPcEJN2uVbhb
         VRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/4FeYdmn3iB0IXLNt/H1CXu0UQ9fwGLnFLDS+u9FzHI=;
        b=APshf1+UoJCBkbRZ/bjGH/wZTrGahGNYSZM+TWPDheOviyKvsQxkHMvYqO1RlKssIh
         S/+pvEGH0IyWw5KV8BdKGw+QhG9lKOA+K0BMyaaitHIBPiyuq51HP1qanogYY8X7zoU9
         aJFtp72DTJdCtZmXqwCqW92CrkIMOfvrHx3MFKr5JI4t0dgkyXzU430+9Rv35wah4JiH
         TTxCcoJXDHbSxECMhjtY8567FnN91nTfrfGYNtbx7UluH4Vi8MCEummiOE6kyYvsT3Tu
         TG0EQW7Pa5rzGDNtcLwh60y7qll2oQ+Afyu5BiHAwHMwKcBUd4fihF9XCSPb+73QDOz3
         +2rw==
X-Gm-Message-State: AOAM533KXe6QLtinXuJaWivf/ItYvWqZ8/TmcItWRJ9N1U4nox16ndws
        WdvROLSYhg37/7I5NCnKKfH9Dg==
X-Google-Smtp-Source: ABdhPJx/hiCAz8Legoa47eblx4WAapjkBFpTOjmMETdF/oVexGY9XgUxpPgGgIkrhHQJMAw0LEe2bA==
X-Received: by 2002:a05:600c:4147:: with SMTP id h7mr5966082wmm.186.1604515011165;
        Wed, 04 Nov 2020 10:36:51 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:c8d2:30f2:53c6:bc2])
        by smtp.gmail.com with ESMTPSA id e25sm4070787wra.71.2020.11.04.10.36.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 10:36:50 -0800 (PST)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Quentin Perret <qperret@google.com>,
        Andrew Scull <ascull@google.com>, kernel-team@android.com,
        David Brazdil <dbrazdil@google.com>
Subject: [RFC PATCH 06/26] kvm: arm64: Add .hyp.data ELF section
Date:   Wed,  4 Nov 2020 18:36:10 +0000
Message-Id: <20201104183630.27513-7-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201104183630.27513-1-dbrazdil@google.com>
References: <20201104183630.27513-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add rules for renaming a .data ELF section in KVM nVHE object files to
.hyp.data, linking it into the kernel and mapping it in hyp at runtime.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/sections.h |  1 +
 arch/arm64/kernel/vmlinux.lds.S   | 10 ++++++++++
 arch/arm64/kvm/arm.c              |  7 +++++++
 arch/arm64/kvm/hyp/nvhe/hyp.lds.S |  3 +++
 4 files changed, 21 insertions(+)

diff --git a/arch/arm64/include/asm/sections.h b/arch/arm64/include/asm/sections.h
index 3994169985ef..255f76f592d7 100644
--- a/arch/arm64/include/asm/sections.h
+++ b/arch/arm64/include/asm/sections.h
@@ -11,6 +11,7 @@ extern char __alt_instructions[], __alt_instructions_end[];
 extern char __hibernate_exit_text_start[], __hibernate_exit_text_end[];
 extern char __hyp_idmap_text_start[], __hyp_idmap_text_end[];
 extern char __hyp_text_start[], __hyp_text_end[];
+extern char __hyp_data_start[], __hyp_data_end[];
 extern char __idmap_text_start[], __idmap_text_end[];
 extern char __initdata_begin[], __initdata_end[];
 extern char __inittext_begin[], __inittext_end[];
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 1bda604f4c70..a9a1612c084f 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -30,6 +30,13 @@ jiffies = jiffies_64;
 	*(__kvm_ex_table)					\
 	__stop___kvm_ex_table = .;
 
+#define HYPERVISOR_DATA_SECTION					\
+	HYP_SECTION_NAME(.data) : {				\
+		__hyp_data_start = .;				\
+		*(HYP_SECTION_NAME(.data))			\
+		__hyp_data_end = .;				\
+	}
+
 #define HYPERVISOR_PERCPU_SECTION				\
 	. = ALIGN(PAGE_SIZE);					\
 	HYP_SECTION_NAME(.data..percpu) : {			\
@@ -37,6 +44,7 @@ jiffies = jiffies_64;
 	}
 #else /* CONFIG_KVM */
 #define HYPERVISOR_EXTABLE
+#define HYPERVISOR_DATA_SECTION
 #define HYPERVISOR_PERCPU_SECTION
 #endif
 
@@ -207,6 +215,8 @@ SECTIONS
 		EXIT_DATA
 	}
 
+	HYPERVISOR_DATA_SECTION
+
 	PERCPU_SECTION(L1_CACHE_BYTES)
 	HYPERVISOR_PERCPU_SECTION
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 5750ec34960e..8bb9fffe2a8f 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1602,6 +1602,13 @@ static int init_hyp_mode(void)
 		goto out_err;
 	}
 
+	err = create_hyp_mappings(kvm_ksym_ref(__hyp_data_start),
+				  kvm_ksym_ref(__hyp_data_end), PAGE_HYP);
+	if (err) {
+		kvm_err("Cannot map hyp data section\n");
+		goto out_err;
+	}
+
 	err = create_hyp_mappings(kvm_ksym_ref(__start_rodata),
 				  kvm_ksym_ref(__end_rodata), PAGE_HYP_RO);
 	if (err) {
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp.lds.S b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
index bb2d986ff696..bc1664d365a9 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
@@ -16,4 +16,7 @@ SECTIONS {
 	HYP_SECTION_NAME(.data..percpu) : {
 		PERCPU_INPUT(L1_CACHE_BYTES)
 	}
+
+	/* Put after '.data..percpu' because its name matches the same regex. */
+	HYP_SECTION(.data)
 }
-- 
2.29.1.341.ge80a0c044ae-goog

