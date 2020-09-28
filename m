Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE7A327B3ED
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 20:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgI1SCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 14:02:03 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:38975 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726830AbgI1SBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:01:20 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 4A58FE33;
        Mon, 28 Sep 2020 13:55:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 28 Sep 2020 13:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=bn+CdI2mzadwD
        3ISILwshyyh0HI8VM1uFL6AVtefXJ4=; b=gog8QY/CSxCjynTpVZ4HAGDug73ke
        xX+kcrWQkb94b5wOhnLbNTiVsR/ruk8Mwbqk8F/EaLhCJPayGmXCWfyspc+ao2eJ
        0C3vNpyaK4saUjBDQF3SdVlZu54ar6WDhOfx5d+9jUl3nwsb+wqiSHH/8WkE0PRV
        hoalI72wNNOumDkz1Mxfn/qi2Lrcj7wmZ3mDCEP/ZlzkNeMf9i+1L3dbY/qehCcQ
        Bc/vlHiyu0rYdUDIZ5oIt05j0evLgPe1nDfPW6VF+JYJYLK3XHMtWl8HzjsqfdwU
        BGCNi6/dor+Qe9uduRF4QKg1PFeyAuobUZjKrqNUUFCOw16tlYrmsMFTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=bn+CdI2mzadwD3ISILwshyyh0HI8VM1uFL6AVtefXJ4=; b=OzCZjtAW
        gBaouZLgxnDnH+V9Qh7yqZfg3+GMmnaV90PS0NnKH4niDr8ak1EhQKjAjBLitU2c
        uRjYzKlOhRmuadaAIZzBb92TcJRFvBdMl219MpHLAgtvkOmvrPGLdL1q/dqU+IWL
        S50+m1VzPZb1u5B+pivVc2DUyNnjSJuHIxpHBqzzxn8VQXeNmaoIlEoHI288xt8o
        AX+YhkFNhpUlEnU7/bC3Dl4l+mo72ywtGBmBfR06Q7oD6MjIcGg4qG6lE1kXyKY9
        Q2c2kRM/1DBjzyjVX3fsrreEfsUpKFV+P9CBmKcg9ylR5pGHOjo2H+1UAPnvfU+n
        hHLnAyIFe1WZzA==
X-ME-Sender: <xms:iyNyX2ZXd5V3dgNZ89hnqArVurdkNhK1Z9z8kaZDa8Wz5VA9k5ck2w>
    <xme:iyNyX5b2UypKzEaGhWn_6_R5V4uVGPi3a0xUlLkANcR_tvU_Q636KDWbiIG3Hdo6q
    6XTxH-CYwkOIaE25w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeigdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeduhfffve
    ektdduhfdutdfgtdekkedvhfetuedufedtgffgvdevleehheevjefgtdenucfkphepuddv
    rdegiedruddtiedrudeigeenucevlhhushhtvghrufhiiigvpeduvdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:iyNyXw8a89JuAxLwa9qNPRnpZu83Xv4rRR6c_onQZUA9mYMrAld4PA>
    <xmx:iyNyX4r-ooevLrZr95pzgqxvSfXMWHOYuBuGJHFbvAtV3aNKO1VuuQ>
    <xmx:iyNyXxohksChmsPzf3mkpfTCgQN2D3RT63BS3EpmPkN41fzF5fCQFQ>
    <xmx:iyNyX8DHWS7FoTqt3C1YPpBTipfukfvQXHPiaoDLpdvojT8oo6OZcgIeEdw>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id 686373064685;
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
Subject: [RFC PATCH v2 15/30] mm: thp: add PUD THP to deferred split list when PUD mapping is gone.
Date:   Mon, 28 Sep 2020 13:54:13 -0400
Message-Id: <20200928175428.4110504-16-zi.yan@sent.com>
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

When PUD mapping is gone, there is no need to keep the PUD THP. Add it
to deferred split list, so when memory pressure comes, the THP will be
split.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/rmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/rmap.c b/mm/rmap.c
index b4950f7a0978..424322807966 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1329,6 +1329,9 @@ static void page_remove_anon_compound_rmap(struct page *page, int map_order)
 				}
 				__dec_node_page_state(page, NR_ANON_THPS);
 			}
+			/* deferred split huge pud page if PUD map is gone */
+			if (!compound_mapcount(head))
+				deferred_split_huge_page(head);
 			nr += HPAGE_PMD_NR;
 			__mod_node_page_state(page_pgdat(head), NR_ANON_MAPPED, -nr);
 			return;
-- 
2.28.0

