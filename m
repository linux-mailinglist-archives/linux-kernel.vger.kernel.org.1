Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCF128BEFB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 19:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404059AbgJLRYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 13:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389613AbgJLRYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 13:24:19 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B604C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 10:24:19 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id h24so24283796ejg.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 10:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=s96wWdP8Gy6mDWJE59ekt3h9lH5U6GnCxVVz0dzYpPM=;
        b=ErMFXoZbZW3e2sDxrRNFkXrCQCgzcD+zDiSFr0pZd0kc7OZo5zS9CXYp3wj5qbQ089
         UX6YG7zBoagIjhJfH6r/hV8q9PNUh4jEleUHK/WFI8vTmsJZQzquyAAGjgoemgjFk0oM
         ysObOaJvOLt1uWdDSFAUMc0VSMtf6KpUzflcMaAUHOWrGrP3ggasroqEDhSnqhFcsNHg
         JgvObUGUk59uCwXlSjbGzNOLvfvHheV+pPdBYVttFwDAOXAxDlPNyrjxIisQk1n9Pxlv
         iyk0nYZ8zAo8Id1qSAHKq5j9oK6xeNyw822jJNFavotWea6D+3kuvFWUvqkrjkt1LUzN
         ibHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=s96wWdP8Gy6mDWJE59ekt3h9lH5U6GnCxVVz0dzYpPM=;
        b=Ly/FGW7KEby37e/BzKXdFEvF1XWDpTJk0qpncZIy+sq+Fx2hfc6ppHfbokg4z+7Rz0
         GTQXLh42cay6AaAZfStIRWfCH1fzK4F+2FV1IWpGcKNq1fkm5OChUFJPbZP0he7HTPIL
         NCN3kQGp1+KhVqi63yvO2OXSOV41OLzbR2ve4E8uuKWUm3Wby4aniPBNF8GZwQuEgDHN
         cmrlSqiKOJlovWfq+hl8Y5qyoCfHnhAgk7ndjL2xGAWLEQQI5VO26pJ/8yDLlM9c1qO7
         fixsB+zB3VXWnOGJqljSjr/EwUUVuX4YTPtvSyHCassVITdywX+eeEXpmiRkE4/GzXCw
         8sDA==
X-Gm-Message-State: AOAM533Tg6akqWtHTNk+EAb6mxGvyN6PC8hNDXnInJKixfFs/iQAazrH
        S2WJJxexn0ecdEhdFYJp1gWnyNioyzs=
X-Google-Smtp-Source: ABdhPJykB0E3hWMNAuhwI/BkqblzMxp63EZyyTWYSuyD7ec7Js938Fix9EtFEyoOyMfz9ms09471nA==
X-Received: by 2002:a17:906:e949:: with SMTP id jw9mr28865983ejb.109.1602523458098;
        Mon, 12 Oct 2020 10:24:18 -0700 (PDT)
Received: from gmail.com (563B81C8.dsl.pool.telekom.hu. [86.59.129.200])
        by smtp.gmail.com with ESMTPSA id t3sm10767772edv.59.2020.10.12.10.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 10:24:17 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 12 Oct 2020 19:24:15 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/mm changes for v5.10
Message-ID: <20201012172415.GA2962950@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/mm git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-2020-10-12

   # HEAD: 7a27ef5e83089090f3a4073a9157c862ef00acfc x86/mm/64: Update comment in preallocate_vmalloc_pages()

Do not sync vmalloc/ioremap mappings on x86-64 kernels.

Hopefully now without the bugs!

 Thanks,

	Ingo

------------------>
Joerg Roedel (2):
      x86/mm/64: Do not sync vmalloc/ioremap mappings
      x86/mm/64: Update comment in preallocate_vmalloc_pages()


 arch/x86/include/asm/pgtable_64_types.h |  2 --
 arch/x86/mm/init_64.c                   | 20 ++++++++++----------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 8f63efb2a2cc..52e5f5f2240d 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -159,6 +159,4 @@ extern unsigned int ptrs_per_p4d;
 
 #define PGD_KERNEL_START	((PAGE_SIZE / 2) / sizeof(pgd_t))
 
-#define ARCH_PAGE_TABLE_SYNC_MASK	(pgtable_l5_enabled() ?	PGTBL_PGD_MODIFIED : PGTBL_P4D_MODIFIED)
-
 #endif /* _ASM_X86_PGTABLE_64_DEFS_H */
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index a4ac13cc3fdc..b5a3fa4033d3 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -217,11 +217,6 @@ static void sync_global_pgds(unsigned long start, unsigned long end)
 		sync_global_pgds_l4(start, end);
 }
 
-void arch_sync_kernel_mappings(unsigned long start, unsigned long end)
-{
-	sync_global_pgds(start, end);
-}
-
 /*
  * NOTE: This function is marked __ref because it calls __init function
  * (alloc_bootmem_pages). It's safe to do it ONLY when after_bootmem == 0.
@@ -1257,14 +1252,19 @@ static void __init preallocate_vmalloc_pages(void)
 		if (!p4d)
 			goto failed;
 
-		/*
-		 * With 5-level paging the P4D level is not folded. So the PGDs
-		 * are now populated and there is no need to walk down to the
-		 * PUD level.
-		 */
 		if (pgtable_l5_enabled())
 			continue;
 
+		/*
+		 * The goal here is to allocate all possibly required
+		 * hardware page tables pointed to by the top hardware
+		 * level.
+		 *
+		 * On 4-level systems, the P4D layer is folded away and
+		 * the above code does no preallocation.  Below, go down
+		 * to the pud _software_ level to ensure the second
+		 * hardware level is allocated on 4-level systems too.
+		 */
 		lvl = "pud";
 		pud = pud_alloc(&init_mm, p4d, addr);
 		if (!pud)
