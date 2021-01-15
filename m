Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 411A52F7471
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 09:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730774AbhAOIeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 03:34:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:57396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730201AbhAOIeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 03:34:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B4B6E23436;
        Fri, 15 Jan 2021 08:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610699610;
        bh=StoT2zp79sznIPfcRkkmD1yMT7cGVvKLETHGz0Lwr3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AZMzuYEacN0wqIbOJ5wTWm5r6t/pKWqQzWZKUM6+sW2j61F1dxN1ZSm2o0RtLNwty
         ZhBXIqRNtG4Cy346zt8KEHMhL3WhQ7m21aoEcmpmNLv2IET4NRUsqjZx0GnTih8CoT
         5mWAzUGd9KbCX/Xs/uTpu+/EfpZEuz0lYaeZBhBti6lGoRlmCkbNUqukoaYZBviMGT
         +P4ENiB2ZHA86/GJVUzzcIMePKKm7rME+Lv5T8sUsqW3NcLs+r8I5MBNxA6jzDb1kQ
         G4C9+GRZxRqDMw60BeBUQXjnn+eT17lK8qB5cR91eTBnqQOa5BDaK3whZ7zu4rGa+C
         1w75MLZUsFE1g==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
        David Hildenbrand <david@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: [PATCH 2/2] x86/setup: merge several reservations of start of the memory
Date:   Fri, 15 Jan 2021 10:32:55 +0200
Message-Id: <20210115083255.12744-3-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210115083255.12744-1-rppt@kernel.org>
References: <20210115083255.12744-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Currently the first several pages are reserved both to avoid leaking their
contents on systems with L1TF and to avoid corrupting BIOS memory.

Merge the two memory reservations.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/x86/kernel/setup.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 32cd2e790a0a..3f2fd67240f8 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -715,20 +715,6 @@ static int __init parse_reservelow(char *p)
 
 early_param("reservelow", parse_reservelow);
 
-static void __init trim_low_memory_range(void)
-{
-	/*
-	 * A special case is the first 4Kb of memory;
-	 * This is a BIOS owned area, not kernel ram, but generally
-	 * not listed as such in the E820 table.
-	 *
-	 * This typically reserves additional memory (64KiB by default)
-	 * since some BIOSes are known to corrupt low memory.  See the
-	 * Kconfig help text for X86_RESERVE_LOW.
-	 */
-	memblock_reserve(0, ALIGN(reserve_low, PAGE_SIZE));
-}
-
 static void __init early_reserve_memory(void)
 {
 	/*
@@ -741,10 +727,18 @@ static void __init early_reserve_memory(void)
 			 (unsigned long)__end_of_kernel_reserve - (unsigned long)_text);
 
 	/*
-	 * Make sure page 0 is always reserved because on systems with
-	 * L1TF its contents can be leaked to user processes.
+	 * The first 4Kb of memory is a BIOS owned area, but generally it is
+	 * not listed as such in the E820 table.
+	 *
+	 * Reserve the first memory page and typically some additional
+	 * memory (64KiB by default) since some BIOSes are known to corrupt
+	 * low memory. See the Kconfig help text for X86_RESERVE_LOW.
+	 *
+	 * In addition, we must make sure page 0 is always reserved because
+	 * on systems with L1TF its contents can be leaked to user
+	 * processes.
 	 */
-	memblock_reserve(0, PAGE_SIZE);
+	memblock_reserve(0, ALIGN(reserve_low, PAGE_SIZE));
 
 	early_reserve_initrd();
 
@@ -757,7 +751,6 @@ static void __init early_reserve_memory(void)
 	reserve_bios_regions();
 
 	trim_platform_memory_ranges();
-	trim_low_memory_range();
 }
 
 /*
-- 
2.28.0

