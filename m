Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0A627B3E6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 20:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgI1SBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 14:01:21 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:48141 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726504AbgI1SBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:01:18 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id A510ED92;
        Mon, 28 Sep 2020 13:55:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 28 Sep 2020 13:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=01LYlc5bDzp3u
        qzR9xxfv49dl40Bp54QbYMpQqXO/5E=; b=M7xV7Ip4pSaGpM8FfuydMwvO0fCGH
        zGTwAaxetq6YCSXCJaFSXSMVVRR+7XCaxRwCXRNyRgvbA5OkFS4xogt5/hq8aGYa
        MHoGtx1bA1WnF8b1xTkDW7Ozxs5jJlm3jvzV18BudEsGJL5oftAXPw+S4KWTtOa+
        ovNUwCbq0Z297HcQvaS9OMmRr61NfYe0mPj34A6XZYUdqj33OuZabIA3X/lIm5qQ
        kX+IBv9LpobNgSBad6u3/iWfsrSjSDi8ew4QriaIGvIoLvOauOwfwhX2VX8S5Wyq
        gk0kHZMz/uIBJSr+E9lyAVIwyGqfLzsFSpuNhRNBwF23CHHOmpaJEZDTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=01LYlc5bDzp3uqzR9xxfv49dl40Bp54QbYMpQqXO/5E=; b=ioPd4MMV
        55cAG7caB4GzPpNXV6YKinZBo+9I1F6vWb8/o0eJAAfr3y6pUAy0AW00miyueaiy
        uPXAnW+LNFyjleTU/zBsseynT4nAp/OCozX+lBRzBW0SHY14dH4GdjoGXVOOa8m9
        CJRkCP/+uVXmAIF6BqGx1g0ZHQvlXbqYlhxI7voWYfMnU5yr9RVGWfs8TOMCpiM4
        OW78uxueiVgxYaCNA8vMEwcuM3vB/BsiKaZDTBjBrxqJ+s5nvGYLo7U8+zrZr4Tt
        jPemCbUCIf0eR/gfG50NExHXRqqQas2NLOVkJIr/x5hOkBP1qm/gIiTlHk7K7kAw
        IZ7i+fSPvMZL+Q==
X-ME-Sender: <xms:jCNyXzLMWxfCOqAa1uWMKjHl_DlvN6LE8G6el-riw_ks-mi_LFxX_A>
    <xme:jCNyX3L5mE3ux-2OnlKMNXNQdVgabyk-8i7h-4ILb_agi-Wg4T5AumJmijnSXXbZf
    zC2aOEHu-WMPI2nVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeigdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeduhfffve
    ektdduhfdutdfgtdekkedvhfetuedufedtgffgvdevleehheevjefgtdenucfkphepuddv
    rdegiedruddtiedrudeigeenucevlhhushhtvghrufhiiigvpeduvdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:jCNyX7v5tkIDX3eaTgYOPxaDdLeZSrsOOa-CwR2fmU6DgOJvy-FqMw>
    <xmx:jCNyX8bCjXPv8GujQnxBO03FvTJIf5fdcFiqQcrowoC4pmPbqEGRkg>
    <xmx:jCNyX6aWJQ_yFGpUrOMhmdx5DxdkM1myAHoLzX3yqYrU1fuw4RPZvg>
    <xmx:jCNyXwy1OANFJdy20Zpup9yLCO0CJFn8aVWp2ggsgLbEu_BftbXf_j8cRJY>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id BE8013064688;
        Mon, 28 Sep 2020 13:55:23 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH v2 16/30] mm: debug: adapt dump_page to PUD THP.
Date:   Mon, 28 Sep 2020 13:54:14 -0400
Message-Id: <20200928175428.4110504-17-zi.yan@sent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928175428.4110504-1-zi.yan@sent.com>
References: <20200928175428.4110504-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

Since the order of a PUD THP is greater than MAX_ORDER, do not consider
its tail pages corrupted. Also print sub_compound_mapcount when dumping
a PMDPageInPUD.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/debug.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/debug.c b/mm/debug.c
index ccca576b2899..f5b035dc620d 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -68,7 +68,9 @@ void __dump_page(struct page *page, const char *reason)
 		goto hex_only;
 	}
 
-	if (page < head || (page >= head + MAX_ORDER_NR_PAGES)) {
+	if (page < head ||
+	    (page >= head + max_t(unsigned long, compound_nr(head),
+				  (unsigned long)MAX_ORDER_NR_PAGES))) {
 		/*
 		 * Corrupt page, so we cannot call page_mapping. Instead, do a
 		 * safe subset of the steps that page_mapping() does. Caution:
@@ -109,6 +111,8 @@ void __dump_page(struct page *page, const char *reason)
 					head, compound_order(head),
 					head_compound_mapcount(head));
 		}
+		if (compound_order(head) == HPAGE_PUD_ORDER && PMDPageInPUD(page))
+			pr_warn("sub_compound_mapcount:%d\n", sub_compound_mapcount(page));
 	}
 	if (PageKsm(page))
 		type = "ksm ";
-- 
2.28.0

