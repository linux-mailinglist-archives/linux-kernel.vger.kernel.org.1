Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10593270268
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 18:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgIRQl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 12:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgIRQlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 12:41:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64084C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 09:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=0M3Bwf+Fb1Uh7qm3wAuaVRN1o0EMdwv1eVJjgWvN6Uc=; b=Iq9tLT7sl2PJmy70EuMRI0ETk5
        AxqfF3KpbrXnO3sdWxyMXtjg6vmzVCUPIgJp1PSBRrtnNOt3URpzFx9nyVuPRqWYeJnC17qyzs/z5
        r2xIF0XeLnAmttZMZUlNGMV3+tk4fJ+I7T+qKlfm9t7OTQRBVkjJdVN57/aEvs1nMsevMyEWyxJcz
        73GEsGdAPgxx8H2hE4bVixZ3yMqWygz6wjfxib8AEillkuqZu/7D5PDkAQKxqxmg5Xbz7aJVTkLaG
        2HQQUGmzaqsYj6cL46N9t5baeaLoYffCnXjIDHDf+rnba1z93sjGeb1AZUoCKhiGuvlkKaiBP6c/G
        9S1pG1bg==;
Received: from 089144214092.atnat0023.highway.a1.net ([89.144.214.92] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJJSE-0007Ec-4t; Fri, 18 Sep 2020 16:41:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>, x86@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-mm@kvack.org
Subject: [PATCH 1/6] zsmalloc: switch from alloc_vm_area to get_vm_area
Date:   Fri, 18 Sep 2020 18:37:19 +0200
Message-Id: <20200918163724.2511-2-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200918163724.2511-1-hch@lst.de>
References: <20200918163724.2511-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no obvious reason why zsmalloc needs to pre-fault the PTEs
given that it later uses map_kernel_range to just like vmap().

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/zsmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index c36fdff9a37131..3e4fe3259612fd 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1122,7 +1122,7 @@ static inline int __zs_cpu_up(struct mapping_area *area)
 	 */
 	if (area->vm)
 		return 0;
-	area->vm = alloc_vm_area(PAGE_SIZE * 2, NULL);
+	area->vm = get_vm_area(PAGE_SIZE * 2, 0);
 	if (!area->vm)
 		return -ENOMEM;
 	return 0;
-- 
2.28.0

