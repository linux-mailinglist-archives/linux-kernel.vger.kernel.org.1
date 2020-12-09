Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 794D02D4313
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 14:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732304AbgLINSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 08:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732239AbgLINSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 08:18:40 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC06FC06179C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 05:17:59 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id v14so1452233wml.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 05:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1ZeZvh+Y/5GhqSEze9JV4PDzqUs6TgMApcSFco5AbC8=;
        b=FSv0XsPfA6t0nU+P8LEUQP0tv0hSw7PcN78XgG+fOiyTmrIZsXkOpEb6lrmGaeXIac
         A7LoODo6KlWtNVNCtHJMeRB5YtnDXbwXILbLgoPcp9yrkSGDrWJr6zQJ1Zz/9k6w/o2/
         m7MPV/g+eUqmVdskv7+Bj5LRzZt1V1cqdJlLlZ9TypxfYszydTO37FmVk7alAZSWCILM
         Pvzt0D0eeNv/KhxW1CbNgh0s4SACLOu+kP+NBHG8gsiDH/2tA8ezrIpogJ1e38XC3wYr
         +/mEZJ2kxdrxADV+SiyFvqLXlubb0CDfu1J35+gPzN4lowUTKo2vnwK3b7PkeDyroIf/
         vr9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1ZeZvh+Y/5GhqSEze9JV4PDzqUs6TgMApcSFco5AbC8=;
        b=eE3vzV9OP2u9tSB8uqe5UHbaLzH86bPYq9UlYnWX0nHtlbV3SOZfp1JYoZrLXVIfu4
         7zSSwXH7U+7fD4Lvmf0K+hUimLCnen7We2QqzkJNmSNBwxsYbc93vL8esyvfHYzx+IPZ
         AsJVMl1PqW5rqWTMlX7DC/hzbU3BoVeV56HR8Yb6F2J4e++GdWG+vZ1UAK1ShhaaZoWh
         KqQJwsEHGGVydAYxZIP5vE+/fult+A1XfivsAn83QbmQYDrb9t1jWbbW9FHbrMXJ/vWk
         QqPc/35msGvNNnyZ247wf0udh2XiwSBpuwYWGl4LimNsJrL5oS8YAtxkp1j/FwmdPcZI
         T4BQ==
X-Gm-Message-State: AOAM5339F4odIzDF2qVqesEg2bVC/6bX8mbecndJd89oa+iQDcDX43lQ
        mHBiotbViNdfE3Vl1Zge7WKQfQ==
X-Google-Smtp-Source: ABdhPJwBw6fUgCRvWYXkUr8RF5AcTIkAYAGAsL4FDkvYjYFMccPRebZNbR1xN6emEzWHsqOjDqACIA==
X-Received: by 2002:a7b:c406:: with SMTP id k6mr2792910wmi.90.1607519878533;
        Wed, 09 Dec 2020 05:17:58 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:9d1b:d0eb:db43:6cd2])
        by smtp.gmail.com with ESMTPSA id j7sm3159281wmb.40.2020.12.09.05.17.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 05:17:57 -0800 (PST)
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
Subject: [PATCH 4/9] KVM: arm64: Add symbol at the beginning of each hyp section
Date:   Wed,  9 Dec 2020 13:17:41 +0000
Message-Id: <20201209131746.85622-5-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209131746.85622-1-dbrazdil@google.com>
References: <20201209131746.85622-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generating hyp relocations will require referencing positions at a given
offset from the beginning of hyp sections. Since the final layout will
not be determined until the linking of `vmlinux`, modify the hyp linker
script to insert a symbol at the first byte of each hyp section to use
as an anchor. The linker of `vmlinux` will place the symbols together
with the sections.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/hyp_image.h | 29 +++++++++++++++++++++++++++--
 arch/arm64/kvm/hyp/nvhe/hyp.lds.S  |  4 ++--
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/hyp_image.h b/arch/arm64/include/asm/hyp_image.h
index daa1a1da539e..65e8008da932 100644
--- a/arch/arm64/include/asm/hyp_image.h
+++ b/arch/arm64/include/asm/hyp_image.h
@@ -7,6 +7,9 @@
 #ifndef __ARM64_HYP_IMAGE_H__
 #define __ARM64_HYP_IMAGE_H__
 
+#define HYP_CONCAT(a, b)	__HYP_CONCAT(a, b)
+#define __HYP_CONCAT(a, b)	a ## b
+
 /*
  * KVM nVHE code has its own symbol namespace prefixed with __kvm_nvhe_,
  * to separate it from the kernel proper.
@@ -21,9 +24,31 @@
  */
 #define HYP_SECTION_NAME(NAME)	.hyp##NAME
 
+/* Symbol defined at the beginning of each hyp section. */
+#define HYP_SECTION_SYMBOL_NAME(NAME) \
+	HYP_CONCAT(__hyp_section_, HYP_SECTION_NAME(NAME))
+
+/*
+ * Helper to generate linker script statements starting a hyp section.
+ *
+ * A symbol with a well-known name is defined at the first byte. This
+ * is used as a base for hyp relocations (see gen-hyprel.c). It must
+ * be defined inside the section so the linker of `vmlinux` cannot
+ * separate it from the section data.
+ */
+#define BEGIN_HYP_SECTION(NAME) 			\
+	HYP_SECTION_NAME(NAME) : {			\
+		HYP_SECTION_SYMBOL_NAME(NAME) = .;
+
+/* Helper to generate linker script statements ending a hyp section. */
+#define END_HYP_SECTION					\
+	}
+
 /* Defines an ELF hyp section from input section @NAME and its subsections. */
-#define HYP_SECTION(NAME) \
-	HYP_SECTION_NAME(NAME) : { *(NAME NAME##.*) }
+#define HYP_SECTION(NAME)			\
+	BEGIN_HYP_SECTION(NAME)			\
+		*(NAME NAME##.*)		\
+	END_HYP_SECTION
 
 /*
  * Defines a linker script alias of a kernel-proper symbol referenced by
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp.lds.S b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
index cfdc59b4329b..cd119d82d8e3 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
@@ -22,7 +22,7 @@ SECTIONS {
 	 * alignment for when linking into vmlinux.
 	 */
 	. = ALIGN(PAGE_SIZE);
-	HYP_SECTION_NAME(.data..percpu) : {
+	BEGIN_HYP_SECTION(.data..percpu)
 		PERCPU_INPUT(L1_CACHE_BYTES)
-	}
+	END_HYP_SECTION
 }
-- 
2.29.2.576.ga3fc446d84-goog

