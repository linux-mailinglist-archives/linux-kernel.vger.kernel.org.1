Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041992C835B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 12:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbgK3LjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 06:39:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728860AbgK3LjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 06:39:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E78C0613D4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 03:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=UiVGVeFLRq7zVPo40bMLNVgAJoLSCFMPhHigNy3P9ck=; b=su+36IVymoYyHjztNNWkljSkgM
        +0Crf3dx2ZnLdzrBXvO0ylXLyyl72BD55GrGQA1gkGoDBQy3e4fswH/PgmwajJNNXKEsgGM8MwCRe
        NuejYRToqRn3+BQINeTsw44xll9bOLVTWw8iQqEXF5aKJ3MOzZjXgSrnYIWBapz4ySRJ+/zgofBJL
        xVXbGyWYrRs7mTgev5RRdc9ROcTavZtbfJ56v7j3gIehKdJNjwaLeaTPoiT72+7ORYvYiVkK5OBYb
        EjCOGasOe2zX5Kpcn4vb2ZTQF6ceB9GIusmHZOoUNpebQQtLH2sImbfg7LwSA6cTAn6V/lfi1AIy4
        M9n1SfQQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kjhVc-0007Qr-5Z; Mon, 30 Nov 2020 11:38:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3508530769C;
        Mon, 30 Nov 2020 12:38:18 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E46F42B84F9C3; Mon, 30 Nov 2020 12:38:17 +0100 (CET)
Message-ID: <20201130113603.145310991@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 30 Nov 2020 12:27:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, willy@infradead.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        aarcange@redhat.com, kirill.shutemov@linux.intel.com,
        jroedel@suse.de, peterz@infradead.org
Subject: [RFC][PATCH 6/9] mm/gup: Fix the lockless walkers
References: <20201130112705.900705277@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On architectures where the PTE/PMD is larger than the native word size
(i386-PAE for example), READ_ONCE() can do the wrong thing. Use
pmdp_get_lockless() just like we use ptep_get_lockless().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |    2 +-
 mm/gup.c             |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7041,7 +7041,7 @@ static u64 perf_get_pgtable_size(struct
 		return pud_leaf_size(pud);
 
 	pmdp = pmd_offset_lockless(pudp, pud, addr);
-	pmd = READ_ONCE(*pmdp);
+	pmd = pmdp_get_lockless(pmdp);
 	if (!pmd_present(pmd))
 		return 0;
 
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2467,7 +2467,7 @@ static int gup_pmd_range(pud_t *pudp, pu
 
 	pmdp = pmd_offset_lockless(pudp, pud, addr);
 	do {
-		pmd_t pmd = READ_ONCE(*pmdp);
+		pmd_t pmd = pmdp_get_lockless(pmdp);
 
 		next = pmd_addr_end(addr, end);
 		if (!pmd_present(pmd))


