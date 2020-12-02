Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A782CC596
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 19:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389451AbgLBSnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 13:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389366AbgLBSnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:43:07 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FFCC08E861
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 10:41:55 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id f190so11189478wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 10:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FbhNL96u68QqM7Q1rkLQfNYMQNpyFncRvPJJEVMReqU=;
        b=aFE7s/N+LJ2214UmKW0aNWOqdMUPnXoa+EPsqwgnoGGxb8gEhdDmTcErY0lO7VX/of
         Pl4LzHwCPIYUm5h24H+uF+GVjDF8jfobBT3gBZqMIo6DJhMVbKU7Tear3xnCtVJhTA5Z
         H8UdHSoYKkI3GbRtMA+e9t2FLeHRS1USlflwgf2iXaGNryzWx/cGxM/H1WIW7F0TzFQm
         kUYSeVPW0o7VN8rQmnKCZzuQhKnOlQdi0fKh13kN7DNpfC847bpT3mlXKhcpfipcvWLM
         zXmrrrlzQf8R9QP/5CcjD6TobUxbU4+VxaXnueeA5C4NZSfWnZQsKClVCGz391574KZb
         MG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FbhNL96u68QqM7Q1rkLQfNYMQNpyFncRvPJJEVMReqU=;
        b=THh3o1zpJweR47UJnpSOMQ6zH8He5f1GEBhh5fO2lunn3V4NnbrKp+SJdw/ffXybcR
         RxZVJRvI+exHvD9Uxvcu14RXLnmCQNHaiTH6b74T5y+iCRKtOEwW2UtpMI9n7wmvIntc
         d6PN25Z9SUBkpiCkRUHPymPlbVMBTbn3DF7G2Mbpo3ea6m9L4JBj2uxiZIcDfd/XOFQl
         +w5pbw3Xz0oFjXysSxhEWYrh9TWGBl2/QDhG1xWawHpZTTfw89AvnNtJHbKhZ77G+ktx
         mpqloNH+7REIHj5l1wPhTIVOF6l5Tb7GvjEoF02trClEJLrjNrYHXZWPt6c36i4PvPvq
         M2yA==
X-Gm-Message-State: AOAM533cqJ8+FgkBdtZtqOGoIw93sVsDEO8kx7QgnhVkLhOMNddfRvkK
        AAnBf2vYSBs8+CLuXh1omO4/nw==
X-Google-Smtp-Source: ABdhPJzDonMAoe1/LUSeGrzjO/oX6VvyeXOfTR80+KWmzVofsLNtAQuxbUf5v7Ho6BG2owrCpnDifw==
X-Received: by 2002:a05:600c:2306:: with SMTP id 6mr4532227wmo.53.1606934514097;
        Wed, 02 Dec 2020 10:41:54 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:5ddd:b7c5:e3c9:e87a])
        by smtp.gmail.com with ESMTPSA id z140sm573266wmc.30.2020.12.02.10.41.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 10:41:52 -0800 (PST)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH v4 12/26] kvm: arm64: Add .hyp.data..ro_after_init ELF section
Date:   Wed,  2 Dec 2020 18:41:08 +0000
Message-Id: <20201202184122.26046-13-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201202184122.26046-1-dbrazdil@google.com>
References: <20201202184122.26046-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add rules for renaming the .data..ro_after_init ELF section in KVM nVHE
object files to .hyp.data..ro_after_init, linking it into the kernel
and mapping it in hyp at runtime.

The section is RW to the host, then mapped RO in hyp. The expectation is
that the host populates the variables in the section and they are never
changed by hyp afterwards.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/sections.h |  1 +
 arch/arm64/kernel/vmlinux.lds.S   | 10 ++++++++++
 arch/arm64/kvm/arm.c              |  8 ++++++++
 arch/arm64/kvm/hyp/nvhe/hyp.lds.S |  1 +
 4 files changed, 20 insertions(+)

diff --git a/arch/arm64/include/asm/sections.h b/arch/arm64/include/asm/sections.h
index 3994169985ef..8ff579361731 100644
--- a/arch/arm64/include/asm/sections.h
+++ b/arch/arm64/include/asm/sections.h
@@ -11,6 +11,7 @@ extern char __alt_instructions[], __alt_instructions_end[];
 extern char __hibernate_exit_text_start[], __hibernate_exit_text_end[];
 extern char __hyp_idmap_text_start[], __hyp_idmap_text_end[];
 extern char __hyp_text_start[], __hyp_text_end[];
+extern char __hyp_data_ro_after_init_start[], __hyp_data_ro_after_init_end[];
 extern char __idmap_text_start[], __idmap_text_end[];
 extern char __initdata_begin[], __initdata_end[];
 extern char __inittext_begin[], __inittext_end[];
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 1bda604f4c70..4382b5d0645d 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -30,6 +30,13 @@ jiffies = jiffies_64;
 	*(__kvm_ex_table)					\
 	__stop___kvm_ex_table = .;
 
+#define HYPERVISOR_DATA_SECTIONS				\
+	HYP_SECTION_NAME(.data..ro_after_init) : {		\
+		__hyp_data_ro_after_init_start = .;		\
+		*(HYP_SECTION_NAME(.data..ro_after_init))	\
+		__hyp_data_ro_after_init_end = .;		\
+	}
+
 #define HYPERVISOR_PERCPU_SECTION				\
 	. = ALIGN(PAGE_SIZE);					\
 	HYP_SECTION_NAME(.data..percpu) : {			\
@@ -37,6 +44,7 @@ jiffies = jiffies_64;
 	}
 #else /* CONFIG_KVM */
 #define HYPERVISOR_EXTABLE
+#define HYPERVISOR_DATA_SECTIONS
 #define HYPERVISOR_PERCPU_SECTION
 #endif
 
@@ -234,6 +242,8 @@ SECTIONS
 	_sdata = .;
 	RW_DATA(L1_CACHE_BYTES, PAGE_SIZE, THREAD_ALIGN)
 
+	HYPERVISOR_DATA_SECTIONS
+
 	/*
 	 * Data written with the MMU off but read with the MMU on requires
 	 * cache lines to be invalidated, discarding up to a Cache Writeback
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 6c8594378865..40857cbed3d1 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1705,6 +1705,14 @@ static int init_hyp_mode(void)
 		goto out_err;
 	}
 
+	err = create_hyp_mappings(kvm_ksym_ref(__hyp_data_ro_after_init_start),
+				  kvm_ksym_ref(__hyp_data_ro_after_init_end),
+				  PAGE_HYP_RO);
+	if (err) {
+		kvm_err("Cannot map .hyp.data..ro_after_init section\n");
+		goto out_err;
+	}
+
 	err = create_hyp_mappings(kvm_ksym_ref(__start_rodata),
 				  kvm_ksym_ref(__end_rodata), PAGE_HYP_RO);
 	if (err) {
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp.lds.S b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
index bb2d986ff696..5d76ff2ba63e 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
@@ -16,4 +16,5 @@ SECTIONS {
 	HYP_SECTION_NAME(.data..percpu) : {
 		PERCPU_INPUT(L1_CACHE_BYTES)
 	}
+	HYP_SECTION(.data..ro_after_init)
 }
-- 
2.29.2.454.gaff20da3a2-goog

