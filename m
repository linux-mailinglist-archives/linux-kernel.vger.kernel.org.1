Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740AD27B3E5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 20:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgI1SBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 14:01:40 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:40979 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726832AbgI1SBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:01:21 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 4B923D71;
        Mon, 28 Sep 2020 13:55:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 28 Sep 2020 13:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=o0WCxQyI2O6mh
        GAJROeebiC+vwx5YKmyUHqh7AyOuKk=; b=bPqHgoSeqVUscY4YGUlnjKCBypnig
        5aMXn+EAoCrtOBY2XDUZPdAPt5U7Ph8M1/lmYI6nREKNcIe+D8AY1DU6eFN5C3XM
        mXAwgVfDTUnvxoztaJBlvYp77fqBu4URm4CCrqOCE5e9sMcxa6TjYTLGZjSW6Tjd
        I57SIz+rUbDqedJVEtqyfVNT+JdQh/YHHOILb8/80o5CetepUBvvfKXEJC3ShCS2
        /VmVr9d7pAW8aV112CnvU4OgSChzFoN7vKUC/oV2dj4x6hUp4Ps2EBXQjEzCK8tp
        Nd7U6yPMpK3jzIHGmkpPdzjXCGSxDwFcnIIghXX7HkgdfaGIPBnB+Q6Uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=o0WCxQyI2O6mhGAJROeebiC+vwx5YKmyUHqh7AyOuKk=; b=QysaKMya
        UJNPeNsO849elS+MTT/9LzLCGhmvb8wCwheU+6wpcxcQcvl5inN6+T3xCfyyserm
        tit146y3F1jwZIr3CgYnUme7wTZPnTifUUxNf+YaFYnYiYKMiddk1/S+1nG7WdW6
        2tmUJoQrtL2Gr38eHnqkDQOCnIh9oljmd9krdx9NSs+zMdCa5/d8AWYqIJTAsGrX
        RZ4Q2WWj9QgJAKDWCxUqbzj+7aMIWiWJjutoAfczhV0excCHFUqu7twiVmCn9rM1
        aWCMN+P4ZtVZXgAcvkq246wTpMrplnEDqNfAOmaU3fP3uUJ6zWet150RHynWkEgm
        SMpQk4Vgfy4wZw==
X-ME-Sender: <xms:iCNyX-9t0C1HD-pMRdCcHlWvnQM8Nn91HfNMeXRKgyryXEAX6jEQxQ>
    <xme:iCNyX-ukzaaPoyFB-MPZcKmcNEI1JZGS-ol91VImT-IPAdtC343hD0PkpU2rgRbDE
    sWP8gt6J--9mtXxLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeigdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeduhfffve
    ektdduhfdutdfgtdekkedvhfetuedufedtgffgvdevleehheevjefgtdenucfkphepuddv
    rdegiedruddtiedrudeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:iCNyX0CyvpHsQCVZHaGQcGq2O95_74dnVNTNjOAC3R4oTodGVG8TmQ>
    <xmx:iCNyX2fROnqH-zJjAACXk0JZB5ZuzXR3ITdTTrJSd773gDBgkAuEKg>
    <xmx:iCNyXzN3ZXyJradLBDtpoFvKrF3_-KPz1xnBV8cARDn0IIURgKW49w>
    <xmx:iCNyX6nCMiayuJ-uj91qTFWAbzYgW6YH0q5WKwJdnz-92g5174oQcjgedzI>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0EF7F306468C;
        Mon, 28 Sep 2020 13:55:20 -0400 (EDT)
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
Subject: [RFC PATCH v2 06/30] mm: change thp_order and thp_nr as we will have not just PMD THPs.
Date:   Mon, 28 Sep 2020 13:54:04 -0400
Message-Id: <20200928175428.4110504-7-zi.yan@sent.com>
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

As PUD THP is going to be added in the following patches, thp_order and
thp_nr can be HPAGE_PUD_ORDER and HPAGE_PUD_NR, respectively.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/huge_mm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index e9d228d4fc69..addd206150e2 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -279,7 +279,7 @@ static inline unsigned int thp_order(struct page *page)
 {
 	VM_BUG_ON_PGFLAGS(PageTail(page), page);
 	if (PageHead(page))
-		return HPAGE_PMD_ORDER;
+		return page[1].compound_order;
 	return 0;
 }
 
@@ -291,7 +291,7 @@ static inline int thp_nr_pages(struct page *page)
 {
 	VM_BUG_ON_PGFLAGS(PageTail(page), page);
 	if (PageHead(page))
-		return HPAGE_PMD_NR;
+		return (1<<page[1].compound_order);
 	return 1;
 }
 
-- 
2.28.0

