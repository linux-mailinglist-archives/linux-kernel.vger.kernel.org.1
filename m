Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF43727F0C7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 19:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731574AbgI3RwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 13:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731495AbgI3Rv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 13:51:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B170C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 10:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=/d6+Dk3KKsbjd+NK9IaRJO1MZ62p/5JmeyWovJ8r20c=; b=YkJ+uCPtqA1Td8zeKp//6WB4ex
        2L7PhMeNNVChodci0VbKBYP/+QMdhLPZmUoFLFcWhehk7/nZO4O/VTTSj/QJlXD0APsmA6FpQr4K0
        tySIUrS8BaaMaf2oLTkKi08nizfzKbfYWDmfJuahykiGnY6uF1SWzgQhXSGFIrEcoECNAmcOt43oz
        6M55bJ9RMrTV6WBCPR+ciE5DFex6s6zi/bRyqqcbzrY4leTjDRFayj4JdF7yAaOvbAQ7YEkqfeI/W
        PkxY3VTS6b0FSlKz4CAebXcFshlnG6UuA9qZWLczS1dJqPlXeEZkAYKr+VvP9KJpwM8OvPSsRsxpP
        lPs56omQ==;
Received: from [2001:4bb8:180:7b62:c70:4a89:bc61:4] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNgGS-0001C3-Jg; Wed, 30 Sep 2020 17:51:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nitin Gupta <ngupta@vflare.org>, x86@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-mm@kvack.org
Subject: [PATCH 04/10] mm: allow a NULL fn callback in apply_to_page_range
Date:   Wed, 30 Sep 2020 19:51:27 +0200
Message-Id: <20200930175133.1252382-5-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930175133.1252382-1-hch@lst.de>
References: <20200930175133.1252382-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Besides calling the callback on each page, apply_to_page_range also has
the effect of pre-faulting all PTEs for the range.  To support callers
that only need the pre-faulting, make the callback optional.

Based on a patch from Minchan Kim <minchan@kernel.org>.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/memory.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index fcfc4ca36eba80..dcf2bb69fbf847 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2420,13 +2420,15 @@ static int apply_to_pte_range(struct mm_struct *mm, pmd_t *pmd,
 
 	arch_enter_lazy_mmu_mode();
 
-	do {
-		if (create || !pte_none(*pte)) {
-			err = fn(pte++, addr, data);
-			if (err)
-				break;
-		}
-	} while (addr += PAGE_SIZE, addr != end);
+	if (fn) {
+		do {
+			if (create || !pte_none(*pte)) {
+				err = fn(pte++, addr, data);
+				if (err)
+					break;
+			}
+		} while (addr += PAGE_SIZE, addr != end);
+	}
 	*mask |= PGTBL_PTE_MODIFIED;
 
 	arch_leave_lazy_mmu_mode();
-- 
2.28.0

