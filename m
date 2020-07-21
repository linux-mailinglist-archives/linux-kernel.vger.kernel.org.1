Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8807227C57
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 12:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbgGUKAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 06:00:18 -0400
Received: from 8bytes.org ([81.169.241.247]:58364 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729030AbgGUKAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 06:00:09 -0400
Received: from cap.home.8bytes.org (p5b006776.dip0.t-ipconnect.de [91.0.103.118])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id 678D044A;
        Tue, 21 Jul 2020 12:00:07 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     x86@kernel.org
Cc:     hpa@zytor.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Joerg Roedel <jroedel@suse.de>, joro@8bytes.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] x86/mm/64: Make sync_global_pgds() static
Date:   Tue, 21 Jul 2020 11:59:53 +0200
Message-Id: <20200721095953.6218-4-joro@8bytes.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200721095953.6218-1-joro@8bytes.org>
References: <20200721095953.6218-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The function is only called from within init_64.c and can be static.
Also remove it from pgtable_64.h.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/pgtable_64.h | 2 --
 arch/x86/mm/init_64.c             | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index 1b68d24dc6a0..95ac911b1a30 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -168,8 +168,6 @@ static inline void native_pgd_clear(pgd_t *pgd)
 	native_set_pgd(pgd, native_make_pgd(0));
 }
 
-extern void sync_global_pgds(unsigned long start, unsigned long end);
-
 /*
  * Conversion functions: convert a page and protection to a page entry,
  * and a page entry and page directory to the page they refer to.
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index e0cd2dfd333d..e65b96f381a7 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -209,7 +209,7 @@ static void sync_global_pgds_l4(unsigned long start, unsigned long end)
  * When memory was added make sure all the processes MM have
  * suitable PGD entries in the local PGD level page.
  */
-void sync_global_pgds(unsigned long start, unsigned long end)
+static void sync_global_pgds(unsigned long start, unsigned long end)
 {
 	if (pgtable_l5_enabled())
 		sync_global_pgds_l5(start, end);
-- 
2.27.0

