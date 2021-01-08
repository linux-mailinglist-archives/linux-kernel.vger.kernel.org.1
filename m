Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866B72EF243
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 13:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbhAHMRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 07:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727461AbhAHMRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 07:17:03 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098D1C0612A1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 04:15:42 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id b24so3221682qtt.22
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 04:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=U7Ezu9BWvQQl3+odVqPz50z5xQDmhHP5/rCWfk/q+sQ=;
        b=JHhFj4U2WS5haunZ3iuTJrcTb98S1QwYxWw5N+fvVur6ZGQbm7UhHohf61X1JkhbvN
         ut1SdfYZaSpOoVkcidF1ynuHx36dawwj2Gbagonl4g9CuoJhsoZx83BLUtCuoSSj79Nq
         0CHi+rHOysdgysr2eOTDf8XaTtXlVmnwQ9nexay8EII07X792gzrdWracJ7x6cF1lEby
         g7tzoDCqDeBWnKLlXPYVbZdtqmn+8mMCzYFdIVDyl9nXxq8RoWXQWYk4umkpgEsfawg4
         DO6ggtYvRaWrEpyavTe+Zl2yBGcF3nwhiM43yVnP5jQt/iX8hnpGBGEStyzwV2zwYtRt
         E94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=U7Ezu9BWvQQl3+odVqPz50z5xQDmhHP5/rCWfk/q+sQ=;
        b=ezYG+f/gmxELp1TScJWE2cvCwW3ioQqAHb2V8KqOFClL2d6yxdGnO8jsifbckH7IPO
         oeFipOX7W9HdpiZ6jZkeK9GT69R/GQx5A1bTv6c/6xZRRzJu8e+ZzU/nqNRX2W5Jv02F
         RXriKdIxNUJj2pdKh6XSvTWNrfnvWvPgCWX5Pk3JYZjdvfUZo6SRXC9FyTFLLmMH71EK
         KpgOV7S4l2Qb3pbWuguxxA7ckMh1Wg+BSHwncPzn9WLSm16+TdF0oxO6gacizSHDGZ5M
         155fbQqVhYwkMrcbO5CU7cX51irtYjxlrYFdX5Hvtp/6yi7mvcl7V9+55EFn86VuaVeM
         H3vw==
X-Gm-Message-State: AOAM5303OWjuCGSECLo6AOvq+5TlNGp9AgKsw29EBGi7oG2EHANqloGv
        /98tkNr7bwAvcLaNM0L68gjK6+a9Pi23
X-Google-Smtp-Source: ABdhPJw/4cr8P48R7RVf1xArteNINTq8P74DXyz+B4OUiC/ZzBFlkO7kRqbd09zSVKPjQ4dVKp1TcQnazFJK
Sender: "qperret via sendgmr" <qperret@r2d2-qp.c.googlers.com>
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a0c:ea34:: with SMTP id
 t20mr3195107qvp.5.1610108141217; Fri, 08 Jan 2021 04:15:41 -0800 (PST)
Date:   Fri,  8 Jan 2021 12:15:05 +0000
In-Reply-To: <20210108121524.656872-1-qperret@google.com>
Message-Id: <20210108121524.656872-8-qperret@google.com>
Mime-Version: 1.0
References: <20210108121524.656872-1-qperret@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [RFC PATCH v2 07/26] KVM: arm64: Introduce a BSS section for use at Hyp
From:   Quentin Perret <qperret@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, android-kvm@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Fuad Tabba <tabba@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>
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
index 43af13968dfd..3eca35d5a7cf 100644
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
index 3ac0f3425833..51b53ca36dc5 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1770,7 +1770,18 @@ static int init_hyp_mode(void)
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
2.30.0.284.gd98b1dd5eaa7-goog

