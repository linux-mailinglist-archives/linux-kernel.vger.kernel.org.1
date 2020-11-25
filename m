Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E102C37C6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 05:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbgKYDrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 22:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgKYDrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 22:47:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3670C0613D4;
        Tue, 24 Nov 2020 19:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=J1UiKPrr/8+P5aZ4gZtZajuWCSG9DfbwTn4Phofujgs=; b=ALPcWGlR8P/1FykZVFRmz3vcFz
        nBGB0hnWOZWyV07ZYluhFOsA5/vXhi+JDpiY3ZX3gi15gQU0bRWK8tfZUBSElsdRJE0iHLa28cV6D
        yERLNmcBTFIplJT/NUd8+NrZb/IyRMpkey4AiBUmES0zpDwkLfj1YyxmNRx+dw55S8WWo7rDMnwmy
        YkHt2wToGxA2Bep7FEEqsNgxgbs3I1pl/Ei2xVBdUVYwakkTsCbrudfvYRCWDGR8dl6fiE4uTFafX
        b2wt1U1tjpYFAjfW5MbMXhz9PVsFs6StauQ3r14jkgZiz9HlXVznT030xmxafxJM5D7fpNMN0SH5S
        1R4PTkgQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khllg-0007E4-Mm; Wed, 25 Nov 2020 03:46:57 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        davem@davemloft.net, rppt@kernel.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 1/2] sparc: Fix handling of page table constructor failure
Date:   Wed, 25 Nov 2020 03:46:54 +0000
Message-Id: <20201125034655.27687-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The page has just been allocated, so its refcount is 1.  free_unref_page()
is for use on pages which have a zero refcount.  Use __free_page()
like the other implementations of pte_alloc_one().

Fixes: 1ae9ae5f7df7 ("sparc: handle pgtable_page_ctor() fail")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/sparc/mm/init_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 96edf64d4fb3..182bb7bdaa0a 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2894,7 +2894,7 @@ pgtable_t pte_alloc_one(struct mm_struct *mm)
 	if (!page)
 		return NULL;
 	if (!pgtable_pte_page_ctor(page)) {
-		free_unref_page(page);
+		__free_page(page);
 		return NULL;
 	}
 	return (pte_t *) page_address(page);
-- 
2.29.2

