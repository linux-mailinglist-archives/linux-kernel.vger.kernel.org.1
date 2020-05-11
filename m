Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66C61CE5CE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 22:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731768AbgEKUme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 16:42:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:53978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731635AbgEKUme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:42:34 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D2E72078A;
        Mon, 11 May 2020 20:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589229753;
        bh=f9kbK3Rsp08TfDQGmBgLpryQNbXv77M4lRCA6MvJSAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vaGuC8N5NJuKxnzwfVCqw/RExwET9MrEdt3XHqyjVkze1EcJ1BWbJ9wp8+fykU4Zu
         Dvqkuqtha6VGpjuetHrXik1eR7Avp0Fo8yXqsJXgE5b9UuH22PDysCzEqMDjXmx/MR
         MGmmDTVRrUo6nVqrM+PpMkwIFl9sNXEXDoqdAQbg=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     elver@google.com, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, peterz@infradead.org, will@kernel.org
Subject: [PATCH v5 01/18] sparc32: mm: Fix argument checking in __srmmu_get_nocache()
Date:   Mon, 11 May 2020 21:41:33 +0100
Message-Id: <20200511204150.27858-2-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511204150.27858-1-will@kernel.org>
References: <20200511204150.27858-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'size' argument to __srmmu_get_nocache() is a number of bytes not
a shift value, so fix up the sanity checking to treat it properly.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/sparc/mm/srmmu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index b7c94de70cca..cb9ded8a68b7 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -175,18 +175,18 @@ pte_t *pte_offset_kernel(pmd_t *dir, unsigned long address)
  */
 static void *__srmmu_get_nocache(int size, int align)
 {
-	int offset;
+	int offset, minsz = 1 << SRMMU_NOCACHE_BITMAP_SHIFT;
 	unsigned long addr;
 
-	if (size < SRMMU_NOCACHE_BITMAP_SHIFT) {
+	if (size < minsz) {
 		printk(KERN_ERR "Size 0x%x too small for nocache request\n",
 		       size);
-		size = SRMMU_NOCACHE_BITMAP_SHIFT;
+		size = minsz;
 	}
-	if (size & (SRMMU_NOCACHE_BITMAP_SHIFT - 1)) {
-		printk(KERN_ERR "Size 0x%x unaligned int nocache request\n",
+	if (size & (minsz - 1)) {
+		printk(KERN_ERR "Size 0x%x unaligned in nocache request\n",
 		       size);
-		size += SRMMU_NOCACHE_BITMAP_SHIFT - 1;
+		size += minsz - 1;
 	}
 	BUG_ON(align > SRMMU_NOCACHE_ALIGN_MAX);
 
-- 
2.26.2.645.ge9eca65c58-goog

