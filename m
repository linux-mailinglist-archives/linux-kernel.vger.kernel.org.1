Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB6229613F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 16:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368298AbgJVO6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 10:58:10 -0400
Received: from sonic308-54.consmr.mail.gq1.yahoo.com ([98.137.68.30]:32962
        "EHLO sonic308-54.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S368245AbgJVO6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 10:58:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1603378689; bh=m+KvnfBf8xuQNeIuRRe0vdHUkvX140+IsRUPrl0yksw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=W2zSDzkS2yZELWeNGpxmBEQe8QOUf10AUcdWI4i8jlL/CAOLqigJUCb5wpKcfBnZLPnXUiRNDaQF3liCy02v+l5Sgh3CMv9DdRE4aRZs/a/M/bl8JtI1y6JlvbkiNvvtGM9aSDbBXujl8BKdnbjeNgt3xVjgX5j3IZftFGaTGb3wLGizz3Lz8L504KTskUErOdGhVSznqnRzBjzDLAE60GSH6ZlZjkYTf0WcglUbT0THJ1C4iOqH2LyIifABDQmWvQI0yAp91rRhk1qkqd2bUzAXDfr1rvscj/kgjK3q2Q+rdoSieHnY0HBf+V+s94oyRW4BnUjXxioCaWiX0+5g5g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1603378689; bh=kosD+O5ufdoCVlRY26HZ7wF1pOalxn9VMwsyXn7yteB=; h=From:To:Subject:Date; b=BQoZqIOsmra4FjJxzJXd9udL+J1CLm/Fp6VURdNRVXck+FihISj2J8M+D/4Uh33r5izrh2qmJmnQvTXD5Bg1Uf0DwcXChhBOFTy4BEH6ImfVJek0gS/MECUwtlQrrXCX94ZMM5PP++tP5kcElDzwqvLVtwglqpeP8HilCzhOAZ1XPdyZgX2ZUjgCauE29LW0RJb10oik10/G6wN5eGJBcFWLN6h/vzA7hCTW3ZS+P0NWsu8XTwk2zXzYpntVQ63iLBOqwGOJuua8TK8gq0NOa6p5l8WrpMUFqexZpKctgdJFSSdZydePwIYrpJyCC/pGnOFa8b+hXfI1jE76H47Zvg==
X-YMail-OSG: O0wFiQ4VM1leO0SpVBH547w9k6UpYj5UfSXwP9zdV7tAWZVe2QKVhdpse9Yfw8c
 DI.7.o1hrV8G5b0YVB.8_h4M5hCLcuOnax0yDF4xYlomc4SnJX06wDnH0mOcBX897VULzoidBSrb
 2Nx4SYFz4xfChplPyM0GlNbChK_4S1_6HtSzfLTWEU_PQkm5CvCSBbDRH0ztm08.K3wz4otcGJMD
 7Y2y75pE5iPaXYvzq7NW0CuQ.5vkgjXWOv7ngjf8QH.DwOFMJwIoKJTyb9WxYghxgkEA0HPB0mhB
 FeJ3Lqyoxop9Tj4v8GdXeEo3_fAvHsiZRL7ohYhCG0_eylegReeyetlqfkdSfVAkrjNJ4Sb1fm93
 2p0T1504M1BL3xz_xQ6p9kcAEeUQpcjaYUI4lxrLeHOk5H4OIjgOtR4.mvZySLENZUqYgHH.HQiC
 sn01b7TGw2N7SMHk9XDJmdKoouHHbn0eYfiic2cqcV1J4LrGwhUwXF2z9PE9sF2jI8_NCJ_8M_FA
 R.e430wJrrCTmmt2UkcGYozULYWDI.Biit4fFqiv3kaOXXHJimmmE8wripbeXCIlT.2uU1ldJUXQ
 F6in9M2Is8fMclJyGIC2OtrvmoiGTv5ow8I_37MY6gh64zWTCu.bTFDovUnM19ETnD.bve42wUot
 dspiHcwK82X8D4lAPp5g5zmnmvpRdkCWQodJYAvHr9ndVYd8RaAPHrqFQPl3DUhNFZ75oR7zzAQz
 WtjPYqZbWUVB61vavK0peti82MVQUzbEq1KNJltVb40ABIuYiCxlWxTyecVta6ZlN0hYaiwCoX0l
 tJxafxNhmHKVD2eKJ0K1qj2KMnW1vOTsHvz71Li0x4tE2zERYd7fRH4Fly_F9viFbt8IggR9MAf5
 PwqOLXBL0U_KfHawXUOcxFncijfYFckK8m0zjAXRdKFyJ2IWvQdTHd8VLkwgNFeHqQtiiesdDKh4
 7QTHIPtkp8X0MO9A7I41bAPi1Y.L.onKK28kGEy1qwB5dLRr.Vg4qDbs5pmH9BbdzbtaGxpFvPtT
 YoDuAp.QkZwFUY2oKrTBs_rAmTY34kqDraIUd5AaczKNViz8ZsUqP0OyWsCL6Wl7qxOxVOanyk5B
 qhvnwGXOjMOSbjnIxwR34IML5_RAbqH1wFFq29SCJ4UtWgtYg.UosH2utwvrR_ag9Y4_WwM.6XnX
 MNvvARHG_mPC1KA4mESB3FZZ09PTb_HwxszWculmEZfmHE3Kv6ECt8TDB79TjXj_c4AQWDxnDKHy
 ALA4MISnYxMxau4JaU5uL1gO_gd30ztYOOvoOO2josT1wHrKlBo__pkOUoU3x1olqKD37e0Wr570
 IAyR4KFAP0aST0GdFcS5DUV8sPWJm0Sy.Omrp6NA2nlOBeWo852gvIuFUobE8UjFsmmRdKjCFslS
 d3kAnqE1arF7N..1c3_w7GHvAJITPfwTBkzfKDoBHy7XC_qh2ziarjl2ky4FqFmKywurRR_5dY29
 VIzLaGjPdHylW548mKuvhDdWb_yXhz005IPfIMY6775uxvF3pIVOqMhaF0Jsjv9p6Zs.6J9XnKbP
 wlPVPM5YF.w--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.gq1.yahoo.com with HTTP; Thu, 22 Oct 2020 14:58:09 +0000
Received: by smtp401.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 354b2034a70b817070abfec37b60849b;
          Thu, 22 Oct 2020 14:58:03 +0000 (UTC)
From:   Gao Xiang <hsiangkao@aol.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@redhat.com>
Subject: [PATCH 4/4] erofs: complete a missing case for inplace I/O
Date:   Thu, 22 Oct 2020 22:57:24 +0800
Message-Id: <20201022145724.27284-4-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201022145724.27284-1-hsiangkao@aol.com>
References: <20201022145724.27284-1-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gao Xiang <hsiangkao@redhat.com>

Add a missing case which could cause unnecessary page allocation
but not directly use inplace I/O instead, which increases runtime
extra memory footprint.

The detail is, considering a file-backed page, the right half of
the page is chosen to be cached (e.g. the end page) and some of
its data doesn't exist in managed cache, so the pcluster will be
kept in the submission chain. (In other words, it cannot be
decompressed in advance, for example, due to the bypass chain).

Currently, the pcluster for this case is downgraded as NOINPLACE,
and stop the left half of the page from doing inplace I/O (so an
extra page allocation is needed then.)

Let's avoid such unnecessary downgrade instead.

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/zdata.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index edd7325570e1..ef12275f7fcc 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -160,7 +160,8 @@ static void preload_compressed_pages(struct z_erofs_collector *clt,
 	const unsigned int clusterpages = BIT(pcl->clusterbits);
 	struct page **pages = clt->compressedpages;
 	pgoff_t index = pcl->obj.index + (pages - pcl->compressed_pages);
-	bool standalone = true;
+	bool io_cant_bypass = false;
+	bool updated = false;
 
 	if (clt->mode < COLLECT_PRIMARY_FOLLOWED)
 		return;
@@ -180,20 +181,31 @@ static void preload_compressed_pages(struct z_erofs_collector *clt,
 		} else if (type == DELAYEDALLOC) {
 			t = tagptr_init(compressed_page_t, PAGE_UNALLOCATED);
 		} else {	/* DONTALLOC */
-			if (standalone)
+			/* update to first inplace I/O page */
+			if (!updated) {
 				clt->compressedpages = pages;
-			standalone = false;
+				updated = true;
+			}
+			io_cant_bypass = true;
 			continue;
 		}
 
-		if (!cmpxchg_relaxed(pages, NULL, tagptr_cast_ptr(t)))
+		if (!cmpxchg_relaxed(pages, NULL, tagptr_cast_ptr(t))) {
+			if (type == DELAYEDALLOC)
+				io_cant_bypass = true;
 			continue;
+		}
 
 		if (page)
 			put_page(page);
 	}
 
-	if (standalone)		/* downgrade to PRIMARY_FOLLOWED_NOINPLACE */
+	/*
+	 * for COLLECT_PRIMARY_FOLLOWED pcluster, if all managed pages have
+	 * been found (which means it can be handled without submittng I/O)
+	 * it's unsafe to do inplace I/O. let's downgrade to NOINPLACE instead.
+	 */
+	if (!io_cant_bypass)
 		clt->mode = COLLECT_PRIMARY_FOLLOWED_NOINPLACE;
 }
 
-- 
2.24.0

