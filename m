Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A562859AF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 09:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgJGHju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 03:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbgJGHjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 03:39:47 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AE3C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 00:39:45 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id n18so955123wrs.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 00:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2AqrczMzdXJGGwH6lL0y5Ag3MFo0UoYjD20TIbYWHHA=;
        b=Sws+UqMda3na0grxazZ1UlbLBQVvhhiu6dNhWZKXv3enMvB35YibvDyfhFUzaDt6fH
         i0IcU3KgQ/+JRZNtYHZKQOFEEqRWkSitHK6s3Hn0uGwzhpBEdodMRJIy2nHrHWW/zhyo
         TtI31JBWQoMHTf1+EtpmkH1F4qlUT+XnCn4RnGj8k05nmx8HPnOG25OqAoUq++rZ2kk8
         cjhrH8dDIyWOsyUxSfbgXGEgCjFMsJFSfn35N3rrJuYoNMrniggQ7XfrXks1u3x/bXiP
         0H47sRlDULqEKTr8ixihXxBTG4mEL9D2DnN9+xsFIxZnnwVrkiDVrorn1bOx/2yfJhkM
         Dkew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2AqrczMzdXJGGwH6lL0y5Ag3MFo0UoYjD20TIbYWHHA=;
        b=exthe45rNDqZ2I+NNR3TxImpjiny9fiGgdKXFH6yMPlR/1vWfKgb+s2JgC05yQHxqN
         5QdR9YHDrN/tD2IzhiGgaRa+tz8V+wbGr6txfH0vAPLQzkQUVKABdmI5HIaEXYoBTaKJ
         zxGTnD2OuKS6WBrghp5EtwG5mOcJvGaOQCi48B5fPwHgNrJYAtkgDwwuyOYtXznu7l2p
         YTlAGhc9p5v5SE66RydlPW4Kb2+dFccMxbIYBhcyyOxxVQvMKzo2S3fGcq+mWHZSpEK5
         8UMKcQ5qr5n5eE4xax3tZ2SjEoxj9vYPQ2cIAd3HIGqIi/9YSl9x1P0t8RKmOXXo3PUh
         6y6g==
X-Gm-Message-State: AOAM533qpi2GLnanbjDA/4W6OikwMpEVAvYQeDGHg/6+M9aSEEdE1JTg
        0zr/asKmp51eHGJtVNDXJO7G1qYI8D1RTw==
X-Google-Smtp-Source: ABdhPJyjtCm/NSobuXsdsLBXoocPrZ/xctbDGs32ap8XM2d7TqDHBUehkZB/DCIUyDN0Vi/50goJzw==
X-Received: by 2002:adf:fd8c:: with SMTP id d12mr1941981wrr.283.1602056383938;
        Wed, 07 Oct 2020 00:39:43 -0700 (PDT)
Received: from localhost ([2a02:168:96c5:1:55ed:514f:6ad7:5bcc])
        by smtp.gmail.com with ESMTPSA id p9sm1475809wmm.4.2020.10.07.00.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 00:39:43 -0700 (PDT)
From:   Jann Horn <jannh@google.com>
To:     "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Khalid Aziz <khalid.aziz@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] sparc: Check VMA range in sparc_validate_prot()
Date:   Wed,  7 Oct 2020 09:39:32 +0200
Message-Id: <20201007073932.865218-2-jannh@google.com>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
In-Reply-To: <20201007073932.865218-1-jannh@google.com>
References: <20201007073932.865218-1-jannh@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparc_validate_prot() is called from do_mprotect_pkey() as
arch_validate_prot(); it tries to ensure that an mprotect() call can't
enable ADI on incompatible VMAs.
The current implementation only checks that the VMA at the start address
matches the rules for ADI mappings; instead, check all VMAs that will be
affected by mprotect().

(This hook is called before mprotect() makes sure that the specified range
is actually covered by VMAs, and mprotect() returns specific error codes
when that's not the case. In order for mprotect() to still generate the
same error codes for mprotect(<unmapped_ptr>, <len>, ...|PROT_ADI), we need
to *accept* cases where the range is not fully covered by VMAs.)

Cc: stable@vger.kernel.org
Fixes: 74a04967482f ("sparc64: Add support for ADI (Application Data Integrity)")
Signed-off-by: Jann Horn <jannh@google.com>
---
compile-tested only, I don't have a Sparc ADI setup - might be nice if some
Sparc person could test this?

 arch/sparc/include/asm/mman.h | 50 +++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/arch/sparc/include/asm/mman.h b/arch/sparc/include/asm/mman.h
index e85222c76585..6dced75567c3 100644
--- a/arch/sparc/include/asm/mman.h
+++ b/arch/sparc/include/asm/mman.h
@@ -60,31 +60,41 @@ static inline int sparc_validate_prot(unsigned long prot, unsigned long addr,
 	if (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM | PROT_ADI))
 		return 0;
 	if (prot & PROT_ADI) {
+		struct vm_area_struct *vma, *next;
+
 		if (!adi_capable())
 			return 0;
 
-		if (addr) {
-			struct vm_area_struct *vma;
+		vma = find_vma(current->mm, addr);
+		/* if @addr is unmapped, let mprotect() deal with it */
+		if (!vma || vma->vm_start > addr)
+			return 1;
+		while (1) {
+			/* ADI can not be enabled on PFN
+			 * mapped pages
+			 */
+			if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
+				return 0;
 
-			vma = find_vma(current->mm, addr);
-			if (vma) {
-				/* ADI can not be enabled on PFN
-				 * mapped pages
-				 */
-				if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
-					return 0;
+			/* Mergeable pages can become unmergeable
+			 * if ADI is enabled on them even if they
+			 * have identical data on them. This can be
+			 * because ADI enabled pages with identical
+			 * data may still not have identical ADI
+			 * tags on them. Disallow ADI on mergeable
+			 * pages.
+			 */
+			if (vma->vm_flags & VM_MERGEABLE)
+				return 0;
 
-				/* Mergeable pages can become unmergeable
-				 * if ADI is enabled on them even if they
-				 * have identical data on them. This can be
-				 * because ADI enabled pages with identical
-				 * data may still not have identical ADI
-				 * tags on them. Disallow ADI on mergeable
-				 * pages.
-				 */
-				if (vma->vm_flags & VM_MERGEABLE)
-					return 0;
-			}
+			/* reached the end of the range without errors? */
+			if (addr+len <= vma->vm_end)
+				return 1;
+			next = vma->vm_next;
+			/* if a VMA hole follows, let mprotect() deal with it */
+			if (!next || next->vm_start != vma->vm_end)
+				return 1;
+			vma = next;
 		}
 	}
 	return 1;
-- 
2.28.0.806.g8561365e88-goog

