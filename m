Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B9C27B400
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 20:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgI1SCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 14:02:53 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:44839 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726788AbgI1SBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:01:19 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 9BF05E79;
        Mon, 28 Sep 2020 13:55:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 28 Sep 2020 13:55:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=M3Z5iltvAqpPX
        zgr4nDP3SM4M0PVu4wUve2VkVgkarQ=; b=RIm6Hu50wQRzGwujXp7gxNqIZcVKi
        KpBjCp4WeVNao7jLnVzlYFRx/wq6Ony32NdgfgQuswGC92phH9PfzBvoCsvoqyxZ
        KND7r3CEXZOqnam2Kkl0QxdDGe3FQcpmCImJ7YkOgPLqErBwe1IQ033ZDdn8l36Z
        pcp8v78qe6g1cKLPFOTxeSnwNSvCwEBvOwTZbW32BXE7elOyHbIRQWVn9jBRh9yC
        l8Z7TiBLaLN2BTSsBI3yoreMaPfQEf0jYXen2dndh7zrCjO7mPbn5sPfVxunUhpd
        rw3r5DdVtQJIQ33GFJCQa3yC/Zw9kT7UzmMuu2XeU+34FAaLEjMbzMYbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=M3Z5iltvAqpPXzgr4nDP3SM4M0PVu4wUve2VkVgkarQ=; b=S2bT/ZI0
        ecspBpXxJ0fmgANiN86cZWhwvxMJoG724bYeA/5cCMMK9pe6O6vuIb96paQmfKLi
        Tbf3NccwNxQQbHQp0T5GYaRmGIeoZvos8t2GPlI41g37ie21tyF8OqeX/23jbiWA
        CHn36krd80hPd67dEpYjRqwwFFRdRez+JK2CgQmrcU8EwaCw/SHzrAjcj/jY41bH
        LwgH09D2ZYk0eO6IQtC9eQXYttV5k1o6dymMEj3aDKrD1odPZI49qXZAp31kMtkY
        dTPMvvgnMzFDSNri+kSIZ+9HZB3vx4CFYmobc2mq3CBvSLGKlLWegc1pyDwzddvm
        v+fPZp3vbVFv0A==
X-ME-Sender: <xms:iyNyX6GqyK7MtR4lQo5KotS8RZyFDhsu6gsBdsOcPTJk-oBDrABVBw>
    <xme:iyNyX7VoH-eU81_mt7uvYLJkAV3vnhJVKs5LX-kTcqm--IKpfdACeZK_uqyFPl4GK
    9JTINuQ8h1TN3Ouuw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeigdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeduhfffve
    ektdduhfdutdfgtdekkedvhfetuedufedtgffgvdevleehheevjefgtdenucfkphepuddv
    rdegiedruddtiedrudeigeenucevlhhushhtvghrufhiiigvpeduvdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:iyNyX0KLrhQERkVz4CUnPufMR899uZRS0Tbs6lB3WSfOqWfOISkrIQ>
    <xmx:iyNyX0EDKoGhYngAIbyg-RLAIN2NfzErLOlkK3cL-Xzgb97s7hPzTg>
    <xmx:iyNyXwWN_1f1ALJOAhO9k8QY2l3E2qAxIHAEm_DuDTxkjiintZbSRg>
    <xmx:iyNyXxtEISkX-Sfvz4dW_YlUnNpAEATn_Vn-2mfjesecAY1EU2DQ-iXt1jc>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id 88CE33064683;
        Mon, 28 Sep 2020 13:55:22 -0400 (EDT)
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
Subject: [RFC PATCH v2 13/30] mm: rmap: add map_order to page_remove_anon_compound_rmap.
Date:   Mon, 28 Sep 2020 13:54:11 -0400
Message-Id: <20200928175428.4110504-14-zi.yan@sent.com>
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

When PMD-mapped PUD THP is enabled by the upcoming commits, we can unmap
a PMD-mapped PUD THP that should be counted as NR_ANON_THPS. The added
map_order tells us about this situation.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/rmap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 0d922e5fb38c..7fc0bf07b9bc 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1292,7 +1292,7 @@ static void page_remove_file_rmap(struct page *page, bool compound)
 		clear_page_mlock(page);
 }
 
-static void page_remove_anon_compound_rmap(struct page *page)
+static void page_remove_anon_compound_rmap(struct page *page, int map_order)
 {
 	int i, nr;
 
@@ -1306,7 +1306,7 @@ static void page_remove_anon_compound_rmap(struct page *page)
 	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
 		return;
 
-	if (thp_nr_pages(page) == HPAGE_PMD_NR)
+	if (map_order == HPAGE_PMD_ORDER)
 		__dec_lruvec_page_state(page, NR_ANON_THPS);
 	else
 		__dec_lruvec_page_state(page, NR_ANON_THPS_PUD);
@@ -1357,7 +1357,7 @@ void page_remove_rmap(struct page *page, int map_order)
 	}
 
 	if (compound) {
-		page_remove_anon_compound_rmap(page);
+		page_remove_anon_compound_rmap(page, map_order);
 		goto out;
 	}
 
-- 
2.28.0

