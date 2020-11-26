Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7867F2C58BA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 16:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391458AbgKZPyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 10:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730602AbgKZPyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 10:54:51 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AA0C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 07:54:49 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id r3so2657402wrt.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 07:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zq7DkfhPMt/JJAro9r54YdZwfFGg+H4Ku0Elb+CBars=;
        b=ZDpOoP1cUv9qcC6WeUnajZTpE2pk/DfIPjgnDHP1fSPmAHBlDq+tp+3dCwFK+NJoSr
         hujy8nJ43XQNnsV6cOfw8ctviAy9sGNJVkSRJMX25MSifUgsKx0JqZWoK34cRAEjjQ1j
         Z6qDRdtenNCZJxV46aR/54uPoXGkfFoG4+yEHJ++Syy9+9pHem+bmkxmhqda652EE7S1
         +eswk4U8GtrZyc+BYM5rcEq/0NXbBghplq25uRrB7pbqznAVmNGH4OLOidKj/2iH3U9n
         d4lLTs7kksxsNfuC/Q/AivMiyhMEf/WffyHvuIB2rPexIjJF0P2j2YmJ9S1ES/Mo+6XH
         NF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zq7DkfhPMt/JJAro9r54YdZwfFGg+H4Ku0Elb+CBars=;
        b=SzkvLzxMm90hABP53cDJqIgrw6k7OtI6q0CrwbukMEVP6PTIB+X8Pf6nhy3l6LDFcR
         Nu8Zsu1d+wqAMEeQsJKWvb/GqRvvX5AA/R/WHBsq5BJQz7QD+lpPsbtWtLg62ZMiY+rQ
         eLpObLSlwiCgLvKT+TfGjkj7US46O1PnwBjRc80y2jPwTsbtxWgbSd4xgVx0t7edgYHz
         bp+8jZ0/MeXsXfHTpDdZqV5KG8ToMbvfhMcG4BxRg3kkLN3+Iq2Ofp9YT0R2l0NoGGMX
         8CNUZE86dz6lYGV7elx7PDbbYJJ7Mb3NnA2zICxbcN9jBy5DYobJsBjLV2OEx1MgdKGu
         VP+g==
X-Gm-Message-State: AOAM533Z6yI5KlFQS985ghq8TDvMA6YsCoHfSqg87X4vlEgh9TlFkfap
        lHxxX/r4vxZmD9HlFXnpgSgkBg==
X-Google-Smtp-Source: ABdhPJzLv6ad9C+3TJ+xMYmPjbmsjNfbGyokblFmNlEuroXWUirX+UtceeJ4SEAb0WLZLPCge9tRfA==
X-Received: by 2002:adf:e912:: with SMTP id f18mr4537063wrm.79.1606406087914;
        Thu, 26 Nov 2020 07:54:47 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:f008:704d:8d4b:9951])
        by smtp.gmail.com with ESMTPSA id v8sm9686147wmg.28.2020.11.26.07.54.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2020 07:54:46 -0800 (PST)
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
Subject: [PATCH v3 10/23] kvm: arm64: Add .hyp.data..ro_after_init ELF section
Date:   Thu, 26 Nov 2020 15:54:08 +0000
Message-Id: <20201126155421.14901-11-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201126155421.14901-1-dbrazdil@google.com>
References: <20201126155421.14901-1-dbrazdil@google.com>
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
index 7b718c6c6c52..bb07f0401c68 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1652,6 +1652,14 @@ static int init_hyp_mode(void)
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

