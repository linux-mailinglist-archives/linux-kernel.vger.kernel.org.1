Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC5E303118
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 02:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731708AbhAYTko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 14:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731714AbhAYTVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:21:03 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F8CC061351
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:19:54 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id dj6so6732944qvb.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kuMkw7AdZybvslqmQltvC+V+qU5cLv31NDZ09K7EBEg=;
        b=oK64oKKQQBz3eN6h0+/Lx2yuanWsQs+hJCSPz+vyh29OFbeOFLT5Xe23Rr5vqAqqia
         hDdfTHUDsxKiPIVXSKssSWesBy0Uj4Qrv5NzWGtsu6VF0JIydxN9h37COcwJgenkEPlX
         dcq43hTSCusUMFWUgStPOoOET5G5vjjE0m/ScUoGS8mk88VVfb5cpkQpKS/hAsZ/9UoD
         v3LhLDNenT8aU7UnkW00YTObUx9CivESou5K9WMYZNr0kwf7BTb3869wXyfYMYY5rXJK
         7qtuD6Bqxy7QIAS+LN3Lh374x141W+2qVud+Q21sZ79atN4ep8n8Gb9f0uzb6Q+S6fDP
         Omfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kuMkw7AdZybvslqmQltvC+V+qU5cLv31NDZ09K7EBEg=;
        b=s9H73c5O8RulBGMxy9uORQV9j1jCGhtnOFd96OusDdaQoVwvpBNcrIyFoq8hMxB1nZ
         ExFwKfuF0BIS6+gN49GJqr/LTfWoAwf9v9LRfSERcE3tUqYMXw9rwYXFU5H568iw6rIa
         cNUrDzp8EYleNwMmAQZMghcVFVGlwDEZU8eOHMeonhhzJXOTTr07AVTdIqkHMOg2N2oi
         aDyStKyUkeuyJmCICb5kKlVR61lq11RF10IGG7jBaUu0PXFYJL1kIf2lyseaEI4duDz9
         GZ21YJBciACti7f+kpQ8+qlbkVpp2WotgHCLcLDpc39RlzjBdEFW0uw9Mx+ffJjN8XKl
         /V9g==
X-Gm-Message-State: AOAM531k1QpWNLNy28d7A1DqYcNjjlAFs0m+zJbLpN2RLZOea4j0xH29
        nPS0YeOnWwnwufxzK45gPhyzgA==
X-Google-Smtp-Source: ABdhPJy1zPtPtrFKvie4dKIh/MK1P7SzhxNpMb4yTYY+AVvRu6RGBMRFYJn03biHv9W5Chg441JPkw==
X-Received: by 2002:a0c:fcca:: with SMTP id i10mr2068628qvq.38.1611602393196;
        Mon, 25 Jan 2021 11:19:53 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id s6sm9047638qtx.63.2021.01.25.11.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 11:19:49 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com,
        steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de,
        selindag@gmail.com, tyhicks@linux.microsoft.com
Subject: [PATCH v10 16/18] arm64: kexec: configure trans_pgd page table for kexec
Date:   Mon, 25 Jan 2021 14:19:21 -0500
Message-Id: <20210125191923.1060122-17-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210125191923.1060122-1-pasha.tatashin@soleen.com>
References: <20210125191923.1060122-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure a page table located in kexec-safe memory that has
the following mappings:

1. identity mapping for text of relocation function with executable
   permission.
2. va mappings for all source ranges
3. va mappings for all destination ranges.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/kexec.h    | 12 ++++
 arch/arm64/kernel/asm-offsets.c   |  6 ++
 arch/arm64/kernel/machine_kexec.c | 91 ++++++++++++++++++++++++++++++-
 3 files changed, 108 insertions(+), 1 deletion(-)

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

