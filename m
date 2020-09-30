Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE25927F0D8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 19:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730764AbgI3Rv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 13:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbgI3Rv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 13:51:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B66C0613D0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 10:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ggovDsPrY2tPPXwEEhp2BvATO0PndCnAzmG0yva7UFo=; b=M3Tbb4QDvZEB1jbyEf0zJWIKkr
        nsFTLnSIZqI8QYGmIiSkEVuDgyTbX11zpin6j4Xj4PAlzHD6EPbIFh4MYGfKcFDXGaIq9esb38glz
        BfxJg0Xoz/e4RdpmmFDnE5RCczkS/ME5mvb2gDl9n8kUi1sdaXtqZ5hZECsmk7hMidHWB9u0habxP
        bp5hPzRBRk4x3Rr8nBHcLZRwnezNOP5GK53mekiKxs7AbqdDPINnDba35L2IW+Wwca7AuUcGDzHpx
        WSaLvg3gVpyU3iVkbJPZCTDRLYwL+qFsKIZaO3/DfALtS7c3FigAmDk7P1enBSi89Kh7QrWQmC7C8
        lvDZP1tA==;
Received: from [2001:4bb8:180:7b62:c70:4a89:bc61:4] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNgGT-0001CE-Ri; Wed, 30 Sep 2020 17:51:42 +0000
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
Subject: [PATCH 05/10] zsmalloc: switch from alloc_vm_area to get_vm_area
Date:   Wed, 30 Sep 2020 19:51:28 +0200
Message-Id: <20200930175133.1252382-6-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930175133.1252382-1-hch@lst.de>
References: <20200930175133.1252382-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just manually pre-fault the PTEs using apply_to_page_range.

Co-developed-by: Minchan Kim <minchan@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/zsmalloc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index c36fdff9a37131..918c7b019b3d78 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1122,10 +1122,16 @@ static inline int __zs_cpu_up(struct mapping_area *area)
 	 */
 	if (area->vm)
 		return 0;
-	area->vm = alloc_vm_area(PAGE_SIZE * 2, NULL);
+	area->vm = get_vm_area(PAGE_SIZE * 2, 0);
 	if (!area->vm)
 		return -ENOMEM;
-	return 0;
+
+	/*
+	 * Populate ptes in advance to avoid pte allocation with GFP_KERNEL
+	 * in non-preemtible context of zs_map_object.
+	 */
+	return apply_to_page_range(&init_mm, (unsigned long)area->vm->addr,
+			PAGE_SIZE * 2, NULL, NULL);
 }
 
 static inline void __zs_cpu_down(struct mapping_area *area)
-- 
2.28.0

