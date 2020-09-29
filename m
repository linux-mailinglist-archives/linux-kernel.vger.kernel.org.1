Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5AE127C096
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 11:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgI2JMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 05:12:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727854AbgI2JMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 05:12:00 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3C93204FD;
        Tue, 29 Sep 2020 09:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601370720;
        bh=Ro99+3eggNn8iafNxEoxyEpWU/yokJe5HPgAFlFJtJg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aYSSwiEuA7DNdbyfu62/HdciUlsBNLlSEmWy/CoRIP3VmuHwPcAtH17QQRgwNvXIn
         jSR9+7e8URP46YdQ2ndO0CUD5wOuxN6UciSxZJfMm7XF/W6T4d0GCdoPlryj/nqPxH
         sT5MESd8Mr8si5SP8vc2A3Wuc6nQLc92MZD0YdbQ=
Date:   Tue, 29 Sep 2020 02:11:59 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: compress: introduce page array
 slab cache
Message-ID: <20200929091159.GC1567825@google.com>
References: <20200914090514.50102-1-yuchao0@huawei.com>
 <20200929082306.GA1567825@google.com>
 <6e7639db-9120-d406-0a46-ec841845bb28@huawei.com>
 <20200929084739.GB1567825@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929084739.GB1567825@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/29, Jaegeuk Kim wrote:
> On 09/29, Chao Yu wrote:
> > On 2020/9/29 16:23, Jaegeuk Kim wrote:
> > > I found a bug related to the number of page pointer allocation related to
> > > nr_cpages.
> > 
> > Jaegeuk,
> > 
> > If I didn't miss anything, you mean that nr_cpages could be larger
> > than nr_rpages, right? the problematic case here is lzo/lzo-rle:
> > 
> > cc->clen = lzo1x_worst_compress(PAGE_SIZE << cc->log_cluster_size);
> > 
> > As we can't limited clen as we did for lz4/zstd:
> > 
> > cc->clen = cc->rlen - PAGE_SIZE - COMPRESS_HEADER_SIZE;
> 
> Yes, I've seen some memory corruption in lzo test. Here is another patch to fix
> mem leak.
> 
One more fix:

---
 fs/f2fs/compress.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index ba2d4897744d8..b9557865d627b 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -662,7 +662,7 @@ static int f2fs_compress_pages(struct compress_ctx *cc)
 
 	/* Now we're going to cut unnecessary tail pages */
 	new_cpages = page_array_alloc(cc->inode, new_nr_cpages);
-	if (new_cpages) {
+	if (!new_cpages) {
 		ret = -ENOMEM;
 		goto out_vunmap_cbuf;
 	}
@@ -1186,7 +1186,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 		 */
 		down_read(&sbi->node_write);
 	} else if (!f2fs_trylock_op(sbi)) {
-		return -EAGAIN;
+		goto out_free;
 	}
 
 	set_new_dnode(&dn, cc->inode, NULL, NULL, 0);
@@ -1325,8 +1325,6 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 			continue;
 		f2fs_put_page(cc->cpages[i], 1);
 	}
-	page_array_free(cc->inode, cc->cpages, cc->nr_cpages);
-	cc->cpages = NULL;
 out_put_cic:
 	kmem_cache_free(cic_entry_slab, cic);
 out_put_dnode:
@@ -1336,6 +1334,9 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 		up_read(&sbi->node_write);
 	else
 		f2fs_unlock_op(sbi);
+out_free:
+	page_array_free(cc->inode, cc->cpages, cc->nr_cpages);
+	cc->cpages = NULL;
 	return -EAGAIN;
 }
 
-- 
2.28.0.709.gb0816b6eb0-goog

