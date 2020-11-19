Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C592B97D5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgKSQZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 11:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbgKSQZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 11:25:51 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373E4C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 08:25:51 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id f20so8745665ejz.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 08:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hj90LCz0D+DQiieyZ6toGkopYRcCnDLmGJUIDeGa0Ro=;
        b=cjerCYQSC57p+Bb2G3ff0Nn0PFg450gFtjyx3NZBzKsAR7gMmdHvvsG4FqIdx/iKn4
         kXd5blgYmionqHxOpYneiVaatHmPngI7+YQzlp4XdB37ModkveOIq7cfC+ScplzfdFfW
         aFxC01KkfYRrppR4b2m5+csRKOx34cUbLsTN3uYQo+sOQCz7Qevc4p+dN38FjJ29fwZU
         M3zFyvj8FGRBTzXS3ZgIHbXCTJ2eHhCqrqjOh+87TLipwgFUEWF6KwrDBAAts8DJmwd/
         VRBOK/tlrVlGeJ/GexMBc9mY3PRbmDnCcGteZilDTPgnRpkltW5O+2s5wwbcGjOL8e5s
         NhNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hj90LCz0D+DQiieyZ6toGkopYRcCnDLmGJUIDeGa0Ro=;
        b=a2RpWbHGQPdDS4gUgnstn5hVUe9JM2kiwJhD/r+Q3fvAEam2sWKbdbfXG+CT4A2BOA
         OB07dN6sMDOGKDSMUyuXWD+qFyNBIFjzDAxHT6ohd0U/CUndK2YotgIhFxx8p0uCM0tA
         P+s4p3IVJEO2lVjjBjHLoWTEMDj9MmyloRPvYZEJ2uy//B+FiJ3FD6g0ZmZqr5suus7g
         6l40XZan2tBB2uZDXVbsv8sDdGbd0AVWNTW2RxbfpyiXIF6YyBPPr3gDpgiYiIyAxyRQ
         fG4lYqPYRVbo+7qWabRCDVR+0orcwAv8bBptRcCFmtEh6kJiphipzTTdvj8DcWI5o6vi
         VeCQ==
X-Gm-Message-State: AOAM532qalftXYR2MQUDV8gHBnpu4bsFqABAgJDZhZplFKb9RslUmTth
        wB67p7a16Lip+55+yJGKfybrcw==
X-Google-Smtp-Source: ABdhPJy3FuEcXWKGxYGEsU2f9+i0XPWJ/SKtOYB+LMp3R8UV2UUxvy5sHXw+rpJ6SPZ9fF73+2ZgfQ==
X-Received: by 2002:a17:906:85c9:: with SMTP id i9mr2600538ejy.487.1605803149723;
        Thu, 19 Nov 2020 08:25:49 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:9843:cd3f:f36b:d55c])
        by smtp.gmail.com with ESMTPSA id j6sm15435631edy.87.2020.11.19.08.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 08:25:48 -0800 (PST)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Scull <ascull@google.com>,
        Ard Biesheuvel <ardb@kernel.org>, kernel-team@android.com,
        David Brazdil <dbrazdil@google.com>
Subject: [RFC PATCH 1/6] kvm: arm64: Set up .hyp.rodata ELF section
Date:   Thu, 19 Nov 2020 16:25:38 +0000
Message-Id: <20201119162543.78001-2-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201119162543.78001-1-dbrazdil@google.com>
References: <20201119162543.78001-1-dbrazdil@google.com>
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
 arch/arm64/kvm/hyp/nvhe/hyp.lds.S | 1 +
 4 files changed, 9 insertions(+), 8 deletions(-)

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
index 4382b5d0645d..6f2fd9734d63 100644
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
index d6d5211653b7..119c97e8900a 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1688,11 +1688,10 @@ static int init_hyp_mode(void)
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
index 5d76ff2ba63e..b0789183d49d 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
@@ -17,4 +17,5 @@ SECTIONS {
 		PERCPU_INPUT(L1_CACHE_BYTES)
 	}
 	HYP_SECTION(.data..ro_after_init)
+	HYP_SECTION(.rodata)
 }
-- 
2.29.2.299.gdc1121823c-goog

