Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC4F252F2D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 15:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbgHZNBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 09:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730122AbgHZNBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 09:01:08 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6FBC061756
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 06:01:07 -0700 (PDT)
Received: from ramsan ([84.195.186.194])
        by andre.telenet-ops.be with bizsmtp
        id LD142300V4C55Sk01D14Ge; Wed, 26 Aug 2020 15:01:04 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1kAv32-0008Ah-Ke; Wed, 26 Aug 2020 15:01:04 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1kAv32-0006c8-Ib; Wed, 26 Aug 2020 15:01:04 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: mm: Use PAGE_ALIGNED() helper
Date:   Wed, 26 Aug 2020 15:01:03 +0200
Message-Id: <20200826130103.25381-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the existing PAGE_ALIGNED() helper instead of open-coding the same
operation.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/mm/motorola.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
index 2bb006bdc31cd644..a9bdde54ca350197 100644
--- a/arch/m68k/mm/motorola.c
+++ b/arch/m68k/mm/motorola.c
@@ -226,7 +226,7 @@ static pte_t * __init kernel_page_table(void)
 {
 	pte_t *pte_table = last_pte_table;
 
-	if (((unsigned long)last_pte_table & ~PAGE_MASK) == 0) {
+	if (PAGE_ALIGNED(last_pte_table)) {
 		pte_table = (pte_t *)memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
 		if (!pte_table) {
 			panic("%s: Failed to allocate %lu bytes align=%lx\n",
@@ -274,7 +274,7 @@ static pmd_t * __init kernel_ptr_table(void)
 	}
 
 	last_pmd_table += PTRS_PER_PMD;
-	if (((unsigned long)last_pmd_table & ~PAGE_MASK) == 0) {
+	if (PAGE_ALIGNED(last_pmd_table)) {
 		last_pmd_table = (pmd_t *)memblock_alloc_low(PAGE_SIZE,
 							   PAGE_SIZE);
 		if (!last_pmd_table)
-- 
2.17.1

