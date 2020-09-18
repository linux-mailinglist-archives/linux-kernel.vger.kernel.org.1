Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C1726FF38
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 15:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgIRNz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 09:55:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27668 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726121AbgIRNzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 09:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600437323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=ytkKnz8VBXNqJL2t26ngvolOmdh+YZX9OChbdG+k8tw=;
        b=ENpXvQXkgCkSyV+PR6yOHJXkAtxkhqElmnRi+V5oHPza5BVzwYJorF5fXNOpFtt/5T+VS5
        JjEPONPr99iNA693umD6VvUmDAs62ppIiWphU3CneolHOblQeQCIgK9Vb+Mk0RetIccdin
        OpkoRM/jqPUEYP683hUTYmQAPkg62Og=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-C9hdeviZPfyaMJTV8cll2A-1; Fri, 18 Sep 2020 09:55:22 -0400
X-MC-Unique: C9hdeviZPfyaMJTV8cll2A-1
Received: by mail-pf1-f197.google.com with SMTP id i128so3685824pfg.22
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 06:55:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ytkKnz8VBXNqJL2t26ngvolOmdh+YZX9OChbdG+k8tw=;
        b=O66HV71WA/tXlhJrdMN9S8ksgf6mZc3M9mK2XMrPmFFufEp9Fvh5i5EC/q4+lnkV4S
         U86jGvxk7N7QlR+MJh54kh+E4zs2YAcNN/XBF8ZDT6aaEqtAPVrJ3R+EIzbCQRBue6RZ
         a6dpcJfw9cq8BtgegeFmDvlarDKYC3CZahqvotowuqjMNo0TXNFd3uZV4kguyiwZpJYa
         XQBTMxkQhb+6QFWuNyIx5UEk4vV50N9v7K6xHYSCCwy3yt3ewwakXxizc4Hj4B5ZcMgs
         Dpv6xhnNPMCcP4l4IVjoH8/0hgrv1x8lBd0t3uNQOjwZW2V6RPm1CTCHUbF88NU6Ibwq
         V9fQ==
X-Gm-Message-State: AOAM5328pAurnoAMVs6N1S/X8oCRffKCzGmJyzb1LkCJEmDhOoL46mYY
        znVviyNSg80MX6gydHFAJI70P7yOXNU0Tz8Jd5sDZta6+YZ0Jgkbz3Ry2z4Us566Rm6mri7Zs6u
        8tZ2IXDhtVTUenxH+qghceFC2
X-Received: by 2002:a05:6a00:1356:b029:13e:d13d:a084 with SMTP id k22-20020a056a001356b029013ed13da084mr31754312pfu.27.1600437321094;
        Fri, 18 Sep 2020 06:55:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGbH+jdpiMZmorFwyMSN8G/zeHh3ycd6m1lP9N9eXAmrX30yk1MiHWjJ8zQi4WsZWau5pZMQ==
X-Received: by 2002:a05:6a00:1356:b029:13e:d13d:a084 with SMTP id k22-20020a056a001356b029013ed13da084mr31754291pfu.27.1600437320844;
        Fri, 18 Sep 2020 06:55:20 -0700 (PDT)
Received: from xiangao.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j19sm3642016pfe.108.2020.09.18.06.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 06:55:20 -0700 (PDT)
From:   Gao Xiang <hsiangkao@redhat.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>,
        Gao Xiang <hsiangkao@redhat.com>
Subject: [PATCH 3/4] erofs: specify accurate nr_iovecs for compressed bios
Date:   Fri, 18 Sep 2020 21:54:35 +0800
Message-Id: <20200918135436.17689-3-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200918135436.17689-1-hsiangkao@redhat.com>
References: <20200918135436.17689-1-hsiangkao@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use more accurate compressed page count
instead of BIO_MAX_PAGES unconditionally.

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/zdata.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index d483e9fee41c..bb20f73f10e0 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -135,6 +135,8 @@ struct z_erofs_decompress_frontend {
 	struct z_erofs_collector clt;
 	struct erofs_map_blocks map;
 
+	unsigned int compressedblock_total;
+
 	/* used for applying cache strategy on the fly */
 	bool backmost;
 	erofs_off_t headoffset;
@@ -622,6 +624,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 
 	preload_compressed_pages(clt, MNGD_MAPPING(sbi),
 				 cache_strategy, pagepool);
+	fe->compressedblock_total += BIT(clt->pcl->clusterbits);
 
 hitted:
 	/*
@@ -1151,7 +1154,7 @@ static void move_to_bypass_jobqueue(struct z_erofs_pcluster *pcl,
 }
 
 static void z_erofs_submit_queue(struct super_block *sb,
-				 z_erofs_next_pcluster_t owned_head,
+				 struct z_erofs_decompress_frontend *f,
 				 struct list_head *pagepool,
 				 struct z_erofs_decompressqueue *fgq,
 				 bool *force_fg)
@@ -1160,10 +1163,12 @@ static void z_erofs_submit_queue(struct super_block *sb,
 	z_erofs_next_pcluster_t qtail[NR_JOBQUEUES];
 	struct z_erofs_decompressqueue *q[NR_JOBQUEUES];
 	void *bi_private;
+	z_erofs_next_pcluster_t owned_head = f->clt.owned_head;
 	/* since bio will be NULL, no need to initialize last_index */
 	pgoff_t last_index;
 	unsigned int nr_bios = 0;
 	struct bio *bio = NULL;
+	int cblks = f->compressedblock_total;
 
 	bi_private = jobqueueset_init(sb, q, fgq, force_fg);
 	qtail[JQ_BYPASS] = &q[JQ_BYPASS]->head;
@@ -1207,8 +1212,8 @@ static void z_erofs_submit_queue(struct super_block *sb,
 			}
 
 			if (!bio) {
-				bio = bio_alloc(GFP_NOIO, BIO_MAX_PAGES);
-
+				bio = bio_alloc(GFP_NOIO,
+						min(cblks, BIO_MAX_PAGES));
 				bio->bi_end_io = z_erofs_decompressqueue_endio;
 				bio_set_dev(bio, sb->s_bdev);
 				bio->bi_iter.bi_sector = (sector_t)cur <<
@@ -1221,6 +1226,7 @@ static void z_erofs_submit_queue(struct super_block *sb,
 			if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE)
 				goto submit_bio_retry;
 
+			--cblks;
 			last_index = cur;
 			bypass = false;
 		} while (++cur < end);
@@ -1234,6 +1240,8 @@ static void z_erofs_submit_queue(struct super_block *sb,
 	if (bio)
 		submit_bio(bio);
 
+	DBG_BUGON(cblks);
+
 	/*
 	 * although background is preferred, no one is pending for submission.
 	 * don't issue workqueue for decompression but drop it directly instead.
@@ -1246,14 +1254,14 @@ static void z_erofs_submit_queue(struct super_block *sb,
 }
 
 static void z_erofs_runqueue(struct super_block *sb,
-			     struct z_erofs_collector *clt,
+			     struct z_erofs_decompress_frontend *f,
 			     struct list_head *pagepool, bool force_fg)
 {
 	struct z_erofs_decompressqueue io[NR_JOBQUEUES];
 
-	if (clt->owned_head == Z_EROFS_PCLUSTER_TAIL)
+	if (f->clt.owned_head == Z_EROFS_PCLUSTER_TAIL)
 		return;
-	z_erofs_submit_queue(sb, clt->owned_head, pagepool, io, &force_fg);
+	z_erofs_submit_queue(sb, f, pagepool, io, &force_fg);
 
 	/* handle bypass queue (no i/o pclusters) immediately */
 	z_erofs_decompress_queue(&io[JQ_BYPASS], pagepool);
@@ -1284,7 +1292,7 @@ static int z_erofs_readpage(struct file *file, struct page *page)
 	(void)z_erofs_collector_end(&f.clt);
 
 	/* if some compressed cluster ready, need submit them anyway */
-	z_erofs_runqueue(inode->i_sb, &f.clt, &pagepool, true);
+	z_erofs_runqueue(inode->i_sb, &f, &pagepool, true);
 
 	if (err)
 		erofs_err(inode->i_sb, "failed to read, err [%d]", err);
@@ -1343,7 +1351,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
 
 	(void)z_erofs_collector_end(&f.clt);
 
-	z_erofs_runqueue(inode->i_sb, &f.clt, &pagepool, sync);
+	z_erofs_runqueue(inode->i_sb, &f, &pagepool, sync);
 
 	if (f.map.mpage)
 		put_page(f.map.mpage);
-- 
2.18.1

