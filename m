Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A69827B3EF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 20:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgI1SCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 14:02:08 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:56729 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726821AbgI1SBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:01:20 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 8D15EE05;
        Mon, 28 Sep 2020 13:55:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 28 Sep 2020 13:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=fBlfD3KicOh48
        xsTea8dHE8609zEG6sz2gFrwigOsnU=; b=fPRTBnTbx3dLJDGVIQn2jIdnZlFbQ
        /Sh5U12/4DT+wEEq6alb2D0bbKX4l6Raks1ESBkiRRU1vkIU3ZYQfU+AQ47rOmKs
        hI0zhJhNj/6YHcbxlbYCnhkuJIJN/g4b9yV9F7nfjFiBButXfhrqCJaZKaH59+tQ
        zYil0xzb3Pc4/vV7z3PhWn6VM9cHGplOMd9oV1m6Mk9hdZ1tv1/KakSybD0bp2Ei
        tjEpkd6qVIx7M28CMa8vvyXUt34XLJ2pN5Zy/TaZmV/87p+eDovVaiF+U2rBUupZ
        Ki6t4HPv7RcszDXSudrxRqMoLAoePQcOPgatINgD3uSEjDQZHsX94phKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=fBlfD3KicOh48xsTea8dHE8609zEG6sz2gFrwigOsnU=; b=dTWJdbWC
        u6lm0HJBcOlCQ82ni6AMa4eosL4aQbhDOSFYXyYXNe2DUkS4loq8atA1cjmrQybm
        6bcITY7fJcFPE+QlZvRJQRuyXYr8hYWBSNAZie5w+tjXbE3jFjsFu7YWCLDqCGsm
        L9IR4D7YkCDAEnKaH2BZ7lZEbEZ5HEqviZOcU1gW9leIAl9HT8SdTcc/ZUvW0dkO
        vu5zguNdQHpIbJNYmGEQF+SlgWbPuO5Oo2hUlL0B2mZ3QN2nZQPl3YPqsAinp4YG
        rAc/U8E9ibZZo6z/FrMdEoCzTytbDpsiPWJDuaD5EljpSc2YUhHnyT/NV3PgTdAe
        HjJ4nteLlqVJiQ==
X-ME-Sender: <xms:kSNyX8rCijGb9kCO6KZBvJlUdIcrKeEd10jKOS1qqQiSPMGuQ7UNkA>
    <xme:kSNyXyqIRMnl3F333LWKX2Okum3p1Xxd44eCNCRrCw2yoaU-2V3V4A-SrOY-ztGIa
    XomS1ZO0hCDfAIskw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeigdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeduhfffve
    ektdduhfdutdfgtdekkedvhfetuedufedtgffgvdevleehheevjefgtdenucfkphepuddv
    rdegiedruddtiedrudeigeenucevlhhushhtvghrufhiiigvpedvleenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:kSNyXxMOnC71wDLgblr86MGMvxT1vkyMpfvnsh3HTUVadx7jwFGYXg>
    <xmx:kSNyXz58fsVp1OMW1TbIJO_fYnHrNvJoISJmfi49i7eP0UCaJokdoQ>
    <xmx:kSNyX75e5kOKt7UtxKlJLrc2kYukWj-KPiARoF0IumZUCBrbRFP4rQ>
    <xmx:kSNyX6R8NjsvhTCvfs5--Od3HezKNO0MmGHmvCLrSHfUIe7AhnnX5g_8yHY>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id AEE59306467E;
        Mon, 28 Sep 2020 13:55:28 -0400 (EDT)
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
Subject: [RFC PATCH v2 30/30] mm: thp: enable anonymous PUD THP at page fault path.
Date:   Mon, 28 Sep 2020 13:54:28 -0400
Message-Id: <20200928175428.4110504-31-zi.yan@sent.com>
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

All previous commits have anonymous PUD THP support ready, so we can
enable anonymous PUD THP page fault now.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/memory.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 9f7b509a3aa7..dc285d9872fc 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4122,16 +4122,15 @@ static vm_fault_t create_huge_pud(struct vm_fault *vmf)
 {
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) &&			\
 	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
-	/* No support for anonymous transparent PUD pages yet */
 	if (vma_is_anonymous(vmf->vma))
-		goto split;
+		return do_huge_pud_anonymous_page(vmf);
 	if (vmf->vma->vm_ops->huge_fault) {
 		vm_fault_t ret = vmf->vma->vm_ops->huge_fault(vmf, PE_SIZE_PUD);
 
 		if (!(ret & VM_FAULT_FALLBACK))
 			return ret;
 	}
-split:
+
 	/* COW or write-notify not handled on PUD level: split pud.*/
 	__split_huge_pud(vmf->vma, vmf->pud, vmf->address, false, NULL);
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
-- 
2.28.0

