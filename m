Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4DD7303D02
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 13:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404346AbhAZKog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732105AbhAZCF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:05:56 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2812C061794
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 16:21:24 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id r9so11101628qtp.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 16:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=SfDON/fUCN5vFNGlJEHUAmiQAgyTytVUuGLA7le4ocM=;
        b=mSZW3JK/Da4DVr3IZcAFoxoVE7UG+SuxF8iBsqITb47a5eBC8PyfK2V6JQY2utEpAT
         JG6Gv2A0SUZQQYOrdvzzA+Yc49fE61MVHXktyqWI9s/rhUBoWjAuTX94iPtfuZ8F67pn
         DQt9L1KP+N3jt1bLc5CImvPJYQQi0FBZPpjnLBGPQIY+VhqnZcdql/JfIrubItmNTcIg
         kV3+ap9sa4XCdE5tSszIb3KE0muhNP65czQrkiYVGSjvYoYmI8/WUAKPFcFX9vOSuYja
         2kxjh+Vs183WUO1vQquTmxnAeQUPpgsQX91bjMG5U3UbXpRknd6Erz7lA2WP3yX30rea
         +XEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SfDON/fUCN5vFNGlJEHUAmiQAgyTytVUuGLA7le4ocM=;
        b=PhUz9VwcY9M2/sesEODQy+N4H7tIPctwu6wRxRwGjI9c9KOxhd6EAF2JZ1E3ZmcwSh
         am+66VFPZC/fhp7xRmyRceM3KjmkRbHPupzqhZgCgp9oJSMkPrX6OWkEUCVQYbwNm9r2
         beka6cnYBW1yudA0UUL4FIePzW4WYj8E1urLDNvyKVhPRFIM2ryX4flbGp282iuyVMhM
         7HQiZiVxgByLLaPfzLiU6yPB7uRPeeWFnUkicgL1SeZBo6UTUMUQYpY1GkmRTGGOF7tS
         jru2OtRzrz/9/1Qss+sNu/NZ56EXUiLXezZZcxw9k5V3aLtQ+ersA8e2Pduw3gPRCXDe
         v/Rg==
X-Gm-Message-State: AOAM533Lpw/NDdDbvXZtssARgWndR0lsup8qc4YoBNEJXlkaF8HDTOqt
        tiHsTNSG3zMi6k2rS+VO6ZP8lg==
X-Google-Smtp-Source: ABdhPJySDX+/2vGo1QOlrTbm8VvGmucVBi2YsKjIRMCnCSaEx7I60Syypvewljmz+IN5nmbdwYExgw==
X-Received: by 2002:ac8:6d34:: with SMTP id r20mr2969876qtu.299.1611620483853;
        Mon, 25 Jan 2021 16:21:23 -0800 (PST)
Received: from [192.168.1.195] (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id d1sm13115293qkf.102.2021.01.25.16.21.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 16:21:23 -0800 (PST)
Subject: Re: [PATCH v10 16/18] arm64: kexec: configure trans_pgd page table
 for kexec
To:     jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com,
        steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de,
        selindag@gmail.com, tyhicks@linux.microsoft.com
References: <20210125191923.1060122-1-pasha.tatashin@soleen.com>
 <20210125191923.1060122-17-pasha.tatashin@soleen.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Message-ID: <d5b91732-1985-4d90-89a1-4873deaa5592@soleen.com>
Date:   Mon, 25 Jan 2021 19:21:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210125191923.1060122-17-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I forgot to make changes to arch/arm64/Kconfig. The correct patch is
below.

---

From a2bc374320d7c7efd3c40644ad3d6d59a024b301 Mon Sep 17 00:00:00 2001
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 29 Jul 2019 21:24:25 -0400
Subject: [PATCH v10 16/18] arm64: kexec: configure trans_pgd page table for
 kexec

Configure a page table located in kexec-safe memory that has
the following mappings:

1. identity mapping for text of relocation function with executable
   permission.
2. va mappings for all source ranges
3. va mappings for all destination ranges.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/Kconfig                |  2 +-
 arch/arm64/include/asm/kexec.h    | 12 ++++
 arch/arm64/kernel/asm-offsets.c   |  6 ++
 arch/arm64/kernel/machine_kexec.c | 91 ++++++++++++++++++++++++++++++-
 4 files changed, 109 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fc0ed9d6e011..440abd0c0ee1 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1134,7 +1134,7 @@ config CRASH_DUMP
 
 config TRANS_TABLE
 	def_bool y
-	depends on HIBERNATION
+	depends on HIBERNATION || KEXEC_CORE
 
 config XEN_DOM0
 	def_bool y
diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index b96d8a6aac80..049cde429b1b 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -105,6 +105,12 @@ extern const char arm64_kexec_el2_vectors[];
  * el2_vector	If present means that relocation routine will go to EL1
  *		from EL2 to do the copy, and then back to EL2 to do the jump
  *		to new world.
+ * trans_ttbr0	idmap for relocation function and its argument
+ * trans_ttbr1	map for source/destination addresses.
+ * trans_t0sz	t0sz for idmap page in trans_ttbr0
+ * src_addr	start address for source pages.
+ * dst_addr	start address for destination pages.
+ * copy_len	Number of bytes that need to be copied
  */
 struct kern_reloc_arg {
 	phys_addr_t head;
@@ -114,6 +120,12 @@ struct kern_reloc_arg {
 	phys_addr_t kern_arg2;
 	phys_addr_t kern_arg3;
 	phys_addr_t el2_vector;
+	phys_addr_t trans_ttbr0;
+	phys_addr_t trans_ttbr1;
+	unsigned long trans_t0sz;
+	unsigned long src_addr;
+	unsigned long dst_addr;
+	unsigned long copy_len;
 };
 
 #define ARCH_HAS_KIMAGE_ARCH
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 8a9475be1b62..06278611451d 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -160,6 +160,12 @@ int main(void)
   DEFINE(KEXEC_KRELOC_KERN_ARG2,	offsetof(struct kern_reloc_arg, kern_arg2));
   DEFINE(KEXEC_KRELOC_KERN_ARG3,	offsetof(struct kern_reloc_arg, kern_arg3));
   DEFINE(KEXEC_KRELOC_EL2_VECTOR,	offsetof(struct kern_reloc_arg, el2_vector));
+  DEFINE(KEXEC_KRELOC_TRANS_TTBR0,	offsetof(struct kern_reloc_arg, trans_ttbr0));
+  DEFINE(KEXEC_KRELOC_TRANS_TTBR1,	offsetof(struct kern_reloc_arg, trans_ttbr1));
+  DEFINE(KEXEC_KRELOC_TRANS_T0SZ,	offsetof(struct kern_reloc_arg, trans_t0sz));
+  DEFINE(KEXEC_KRELOC_SRC_ADDR,	offsetof(struct kern_reloc_arg, src_addr));
+  DEFINE(KEXEC_KRELOC_DST_ADDR,	offsetof(struct kern_reloc_arg, dst_addr));
+  DEFINE(KEXEC_KRELOC_COPY_LEN,	offsetof(struct kern_reloc_arg, copy_len));
 #endif
   return 0;
 }
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 41d1e3ca13f8..dc1b7e5a54fb 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -21,6 +21,7 @@
 #include <asm/mmu_context.h>
 #include <asm/page.h>
 #include <asm/sections.h>
+#include <asm/trans_pgd.h>
 
 #include "cpu-reset.h"
 
@@ -71,11 +72,91 @@ static void *kexec_page_alloc(void *arg)
 	return page_address(page);
 }
 
+/*
+ * Map source segments starting from src_va, and map destination
+ * segments starting from dst_va, and return size of copy in
+ * *copy_len argument.
+ * Relocation function essentially needs to do:
+ * memcpy(dst_va, src_va, copy_len);
+ */
+static int map_segments(struct kimage *kimage, pgd_t *pgdp,
+			struct trans_pgd_info *info,
+			unsigned long src_va,
+			unsigned long dst_va,
+			unsigned long *copy_len)
+{
+	unsigned long *ptr = 0;
+	unsigned long dest = 0;
+	unsigned long len = 0;
+	unsigned long entry, addr;
+	int rc;
+
+	for (entry = kimage->head; !(entry & IND_DONE); entry = *ptr++) {
+		addr = entry & PAGE_MASK;
+
+		switch (entry & IND_FLAGS) {
+		case IND_DESTINATION:
+			dest = addr;
+			break;
+		case IND_INDIRECTION:
+			ptr = __va(addr);
+			if (rc)
+				return rc;
+			break;
+		case IND_SOURCE:
+			rc = trans_pgd_map_page(info, pgdp, __va(addr),
+						src_va, PAGE_KERNEL);
+			if (rc)
+				return rc;
+			rc = trans_pgd_map_page(info, pgdp, __va(dest),
+						dst_va, PAGE_KERNEL);
+			if (rc)
+				return rc;
+			dest += PAGE_SIZE;
+			src_va += PAGE_SIZE;
+			dst_va += PAGE_SIZE;
+			len += PAGE_SIZE;
+		}
+	}
+	*copy_len = len;
+
+	return 0;
+}
+
+static int mmu_relocate_setup(struct kimage *kimage, void *reloc_code,
+			      struct kern_reloc_arg *kern_reloc_arg)
+{
+	struct trans_pgd_info info = {
+		.trans_alloc_page	= kexec_page_alloc,
+		.trans_alloc_arg	= kimage,
+	};
+	pgd_t *trans_pgd = kexec_page_alloc(kimage);
+	int rc;
+
+	if (!trans_pgd)
+		return -ENOMEM;
+
+	/* idmap relocation function */
+	rc = trans_pgd_idmap_page(&info, &kern_reloc_arg->trans_ttbr0,
+				  &kern_reloc_arg->trans_t0sz, reloc_code);
+	if (rc)
+		return rc;
+
+	kern_reloc_arg->src_addr = _PAGE_OFFSET(VA_BITS_MIN);
+	kern_reloc_arg->dst_addr = _PAGE_OFFSET(VA_BITS_MIN - 1);
+	kern_reloc_arg->trans_ttbr1 = phys_to_ttbr(__pa(trans_pgd));
+
+	rc = map_segments(kimage, trans_pgd, &info, kern_reloc_arg->src_addr,
+			  kern_reloc_arg->dst_addr, &kern_reloc_arg->copy_len);
+	return rc;
+}
+
 int machine_kexec_post_load(struct kimage *kimage)
 {
 	void *reloc_code = page_to_virt(kimage->control_code_page);
 	struct kern_reloc_arg *kern_reloc_arg = kexec_page_alloc(kimage);
 	long func_offset, vector_offset, reloc_size;
+	int rc = 0;
 
 	if (!kern_reloc_arg)
 		return -ENOMEM;
@@ -95,6 +176,14 @@ int machine_kexec_post_load(struct kimage *kimage)
 	if (is_hyp_mode_available() && !is_kernel_in_hyp_mode())
 		kern_reloc_arg->el2_vector = __pa(reloc_code) + vector_offset;
 
+	/*
+	 * If relocation is not needed, we do not need to enable MMU in
+	 * relocation routine, therefore do not create page tables for
+	 * scenarios such as crash kernel
+	 */
+	if (!(kimage->head & IND_DONE))
+		rc = mmu_relocate_setup(kimage, reloc_code, kern_reloc_arg);
+
 	kexec_image_info(kimage);
 
 	/* Flush the reloc_code in preparation for its execution. */
@@ -103,7 +192,7 @@ int machine_kexec_post_load(struct kimage *kimage)
 			   reloc_size);
 	__flush_dcache_area(kern_reloc_arg, sizeof(struct kern_reloc_arg));
 
-	return 0;
+	return rc;
 }
 
 /**
-- 
2.25.1
