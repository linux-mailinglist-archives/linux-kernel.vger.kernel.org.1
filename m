Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFA02D485E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 18:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgLIRwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 12:52:03 -0500
Received: from mail.skyhub.de ([5.9.137.197]:48176 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726683AbgLIRvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 12:51:53 -0500
Received: from zn.tnic (p200300ec2f0f48002886e3d4aa9fa8a9.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:4800:2886:e3d4:aa9f:a8a9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 343B61EC052C;
        Wed,  9 Dec 2020 18:51:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1607536269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=SqLsTB+jBfUerRTD1ncHboNmrjmJD1pgp2YgpBiEDhI=;
        b=AiWKKUxJFSlsTzbKpB42rFhjf1ag//PejAKkOvdOXAQgZbu8csYSAIo5c1mN5mZ0nsFCDC
        I7CAbUiLPdoajKHfM3VXLCG3a2DZR0VYtAF5uIYIcCuACoV5RzGRWNMyCXgzovhei4gdWG
        oJNa0uQ/C2AE/tbxThUKPL/ShBwEdZQ=
Date:   Wed, 9 Dec 2020 18:51:05 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ashish Kalra <ashish.kalra@amd.com>
Cc:     konrad.wilk@oracle.com, hch@lst.de, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, luto@kernel.org,
        peterz@infradead.org, dave.hansen@linux-intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        brijesh.singh@amd.com, Thomas.Lendacky@amd.com, Jon.Grimm@amd.com,
        rientjes@google.com
Subject: Re: [PATCH v8] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20201209175105.GD18203@zn.tnic>
References: <20201207231057.26403-1-Ashish.Kalra@amd.com>
 <20201209110115.GA18203@zn.tnic>
 <20201209122907.GA6258@ashkalra_ubuntu_server>
 <20201209125442.GC18203@zn.tnic>
 <20201209131946.GA6495@ashkalra_ubuntu_server>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201209131946.GA6495@ashkalra_ubuntu_server>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 01:19:46PM +0000, Ashish Kalra wrote:
> reserve_crashkernel() calls swiotlb_size_or_default() to get SWIOTLB
...

Thanks for explaining.

> There is a need to introduce an architecture specific callback
> for swiotlb_adjust() because of the following reason :

So what your version currently does is:

1. from arch code, call generic code - swiotlb_adjust

2. in generic code, call back into arch code - arch_swiotlb_adjust

But that's twice the work needed to get you where you wanna go.

What you wanna do is, from arch code, call into swiotlb generic code.
That's it, no more.

Just like mem_encrypt.c calls swiotlb_update_mem_attributes(), for
example.

And other architectures can simply do the same thing and you have it all
solved and other architectures don't even need to refactor - they simply
copy what x86 does.

IOW, something like this:

---
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 2f62bbdd9d12..31c4df123aa0 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -37,6 +37,7 @@ void __init sme_map_bootdata(char *real_mode_data);
 void __init sme_unmap_bootdata(char *real_mode_data);
 
 void __init sme_early_init(void);
+void __init sev_setup_arch(void);
 
 void __init sme_encrypt_kernel(struct boot_params *bp);
 void __init sme_enable(struct boot_params *bp);
@@ -69,6 +70,7 @@ static inline void __init sme_map_bootdata(char *real_mode_data) { }
 static inline void __init sme_unmap_bootdata(char *real_mode_data) { }
 
 static inline void __init sme_early_init(void) { }
+static inline void __init sev_setup_arch(void) { }
 
 static inline void __init sme_encrypt_kernel(struct boot_params *bp) { }
 static inline void __init sme_enable(struct boot_params *bp) { }
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index a23130c86bdd..740f3bdb3f61 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1049,6 +1049,12 @@ void __init setup_arch(char **cmdline_p)
 	memblock_set_current_limit(ISA_END_ADDRESS);
 	e820__memblock_setup();
 
+	/*
+	 * Needs to run after memblock setup because it needs the physical
+	 * memory size.
+	 */
+	sev_setup_arch();
+
 	reserve_bios_regions();
 
 	efi_fake_memmap();
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index bc0833713be9..f3db85673eae 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -198,6 +198,37 @@ void __init sme_early_init(void)
 		swiotlb_force = SWIOTLB_FORCE;
 }
 
+void __init sev_setup_arch(void)
+{
+	phys_addr_t total_mem = memblock_phys_mem_size();
+	unsigned long size;
+
+	if (!sev_active())
+		return;
+
+	/*
+	 * For SEV, all DMA has to occur via shared/unencrypted pages.
+	 * SEV uses SWOTLB to make this happen without changing device
+	 * drivers. However, depending on the workload being run, the
+	 * default 64MB of SWIOTLB may not be enough and`SWIOTLB may
+	 * run out of buffers for DMA, resulting in I/O errors and/or
+	 * performance degradation especially with high I/O workloads.
+	 *
+	 * Adjust the default size of SWIOTLB for SEV guests using
+	 * a percentage of guest memory for SWIOTLB buffers.
+	 * Also as the SWIOTLB bounce buffer memory is allocated
+	 * from low memory, ensure that the adjusted size is within
+	 * the limits of low available memory.
+	 *
+	 * The percentage of guest memory used here for SWIOTLB buffers
+	 * is more of an approximation of the static adjustment which
+	 * 64MB for <1G, and ~128M to 256M for 1G-to-4G, i.e., the 6%
+	 */
+	size = total_mem * 6 / 100;
+	size = clamp_val(size, IO_TLB_DEFAULT_SIZE, SZ_1G);
+	swiotlb_adjust_size(size);
+}
+
 static void __init __set_clr_pte_enc(pte_t *kpte, int level, bool enc)
 {
 	pgprot_t old_prot, new_prot;
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index fbdc65782195..7aa94e2f99c6 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -30,6 +30,9 @@ enum swiotlb_force {
  */
 #define IO_TLB_SHIFT 11
 
+/* default to 64MB */
+#define IO_TLB_DEFAULT_SIZE (64UL<<20)
+
 extern void swiotlb_init(int verbose);
 int swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose);
 extern unsigned long swiotlb_nr_tbl(void);
@@ -78,6 +81,7 @@ void __init swiotlb_exit(void);
 unsigned int swiotlb_max_segment(void);
 size_t swiotlb_max_mapping_size(struct device *dev);
 bool is_swiotlb_active(void);
+void __init swiotlb_adjust_size(unsigned long new_size);
 #else
 #define swiotlb_force SWIOTLB_NO_FORCE
 static inline bool is_swiotlb_buffer(phys_addr_t paddr)
@@ -100,6 +104,10 @@ static inline bool is_swiotlb_active(void)
 {
 	return false;
 }
+
+static void swiotlb_adjust_size(unsigned long new_size)
+{
+}
 #endif /* CONFIG_SWIOTLB */
 
 extern void swiotlb_print_info(void);
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 781b9dca197c..7c42df6e6100 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -152,8 +152,6 @@ void swiotlb_set_max_segment(unsigned int val)
 		max_segment = rounddown(val, PAGE_SIZE);
 }
 
-/* default to 64MB */
-#define IO_TLB_DEFAULT_SIZE (64UL<<20)
 unsigned long swiotlb_size_or_default(void)
 {
 	unsigned long size;
@@ -163,6 +161,24 @@ unsigned long swiotlb_size_or_default(void)
 	return size ? size : (IO_TLB_DEFAULT_SIZE);
 }
 
+void __init swiotlb_adjust_size(unsigned long new_size)
+{
+	unsigned long size;
+
+	/*
+	 * If swiotlb parameter has not been specified, give a chance to
+	 * architectures such as those supporting memory encryption to
+	 * adjust/expand SWIOTLB size for their use.
+	 */
+	if (!io_tlb_nslabs) {
+		size = ALIGN(new_size, 1 << IO_TLB_SHIFT);
+		io_tlb_nslabs = size >> IO_TLB_SHIFT;
+		io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
+
+		pr_info("SWIOTLB bounce buffer size adjusted to %luMB", size >> 20);
+	}
+}
+
 void swiotlb_print_info(void)
 {
 	unsigned long bytes = io_tlb_nslabs << IO_TLB_SHIFT;

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
