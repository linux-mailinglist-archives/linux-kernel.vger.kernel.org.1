Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7F129F5D2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 21:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgJ2UEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 16:04:53 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:38039 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725780AbgJ2UEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 16:04:52 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 6C7485C00E7;
        Thu, 29 Oct 2020 16:04:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 29 Oct 2020 16:04:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:reply-to:mime-version
        :content-transfer-encoding; s=fm1; bh=aZLLXKp5r2DJC4J80zb/c1UjaT
        SWfTyQJPTu9tTd62M=; b=RZK50DSa4ZBCTbJmBMt2I/nt0teMNqY/9Uka0FOC5f
        c4RkwYCfi98RLzpLM6B0MvshvTEpPHFiMIvENHVtyx0QlnZvny+nB7gjLZtUhJcP
        OO+/brab6dUNk8zKJkmZf+mEql+xnEyj1X1izbW5dJu0JUQTobfg93AHSSWBjhhP
        qmS5wdf/hrMWqUsGqYLe++g0W+05xV7kMsueWY1bT0QpuDCsjt1CC81e9nMohfQF
        kuPsIcKQjS6S4YCIi4LKJj+rPpLiEUn0a0JQy5zN0FcO1Vxt1TvLdR9jpOnlR3Yo
        iBemLKMJWtB2Aj8HAHW44yKZQ7e7k8m1t4pbXm6dF9ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:reply-to:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=aZLLXK
        p5r2DJC4J80zb/c1UjaTSWfTyQJPTu9tTd62M=; b=rnxHk3yceoX3jSgD+S4wjJ
        6lSG/T/sGNbg6cmQBxgGwtrJbnEOH1WHp13HQ+W9Kn1/Meu/kyWXA/aJPw5w8sgz
        y1cJhXUcErxpTJA+uxEdVJ4E676LPrYhLgfYPG3ksZrD1AiV7X6l02XYrdwtsgzc
        8qeTP7NAphW11RAp9yX+Xt5eRwp9lEwRQub0cUbVePGs+rygHxNDnu1YVyq0M1X9
        B/tiz24pTRLbsLPqyU1Zwud92zlBTMW7jtclVUaHPbUq7KSFfYRjg4TEtrp0yYDI
        CJRI4GYE2LU2D+ujrt53GCp/KdTyQmokKVQ+Xf8kWji2sN18uiEXn7naHbp8Qf4g
        ==
X-ME-Sender: <xms:YiCbXzmq6Q8wNIl0wuE8DaF_OVa_0PMz9SxzfdxAfVMmYAzNH6Z3nQ>
    <xme:YiCbX23M7lfHQeI_hCz-dHBaRxtIPgddEWvmkk_2MbwSpJ_6tXe21Q7v2DO7MwS-A
    8oaZQ5PW7E3cxM7mw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrleefgddufeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkfforhgggfestdhqredtredttdenucfhrhhomhepkghiucgjrghn
    uceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepleetvddtvd
    dttdetffdvkeehffdtjefhkedtheffjeehvdejueektedukedufeffnecukfhppeduvddr
    geeirddutdeirdduieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:YiCbX5pQM-6XLZ9LWo2UdGFVuS6w1aFlACUAZFg9l6EPJ_PkaCzH8Q>
    <xmx:YiCbX7kZH6UeoFl4KgKYXSdIPR4lVx4NQT7DNSPBdSJVoVJ0WAajnw>
    <xmx:YiCbXx3uKaB5sGLJJow5mtMwZVBqN2qjXfIqsMbm3B7Jo8VzbGWXuQ>
    <xmx:YyCbX_DBR9rBQEdU9Nh4d0dQU99QP1cTrfGa1RGSx9k4zJis6bWvPg>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1BA97328005A;
        Thu, 29 Oct 2020 16:04:50 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org,
        Zi Yan <ziy@nvidia.com>
Subject: [PATCH] mm/compaction: count pages and stop correctly during page isolation.
Date:   Thu, 29 Oct 2020 16:04:35 -0400
Message-Id: <20201029200435.3386066-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.28.0
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

In isolate_migratepages_block, when cc->alloc_contig is true, we are
able to isolate compound pages, nr_migratepages and nr_isolated did not
count compound pages correctly, causing us to isolate more pages than we
thought. Use thp_nr_pages to count pages. Otherwise, we might be trapped
in too_many_isolated while loop, since the actual isolated pages can go
up to COMPACT_CLUSTER_MAX*512=3D16384, where COMPACT_CLUSTER_MAX is 32,
since we stop isolation after cc->nr_migratepages reaches to
COMPACT_CLUSTER_MAX.

In addition, after we fix the issue above, cc->nr_migratepages could
never be equal to COMPACT_CLUSTER_MAX if compound pages are isolated,
thus page isolation could not stop as we intended. Change the isolation
stop condition to >=3D.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/compaction.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index ee1f8439369e..0683a4999581 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1012,8 +1012,8 @@ isolate_migratepages_block(struct compact_control *cc=
, unsigned long low_pfn,
=20
 isolate_success:
 		list_add(&page->lru, &cc->migratepages);
-		cc->nr_migratepages++;
-		nr_isolated++;
+		cc->nr_migratepages +=3D thp_nr_pages(page);
+		nr_isolated +=3D thp_nr_pages(page);
=20
 		/*
 		 * Avoid isolating too much unless this block is being
@@ -1021,7 +1021,7 @@ isolate_migratepages_block(struct compact_control *cc=
, unsigned long low_pfn,
 		 * or a lock is contended. For contention, isolate quickly to
 		 * potentially remove one source of contention.
 		 */
-		if (cc->nr_migratepages =3D=3D COMPACT_CLUSTER_MAX &&
+		if (cc->nr_migratepages >=3D COMPACT_CLUSTER_MAX &&
 		    !cc->rescan && !cc->contended) {
 			++low_pfn;
 			break;
@@ -1132,7 +1132,7 @@ isolate_migratepages_range(struct compact_control *cc=
, unsigned long start_pfn,
 		if (!pfn)
 			break;
=20
-		if (cc->nr_migratepages =3D=3D COMPACT_CLUSTER_MAX)
+		if (cc->nr_migratepages >=3D COMPACT_CLUSTER_MAX)
 			break;
 	}
=20
--=20
2.28.0

