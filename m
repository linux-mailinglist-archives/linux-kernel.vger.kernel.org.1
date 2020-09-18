Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F97D26FF39
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 15:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgIRNza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 09:55:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36667 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726776AbgIRNza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 09:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600437328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=9E4MFof7nUo0/wMiUkKWQUNotogwZFFdR4mKeWQqr64=;
        b=MKMgZd5zmqubvWekmY7E32uw9tG4QW1DLPet5jHssvq2P1lxeW+dt3thyi2GiPbeqwmAB+
        vNeLVYTx8RXFcSKRdYcEJTo4BJmXX1hvWrLzBH691wRcmriZMqlc5vQCknR62Wb7HSdW9W
        0Zuit+rICjq9nHRNqaUTHXE2bh6l5o8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-j69NuKkRM_24IGWCgqAKuA-1; Fri, 18 Sep 2020 09:55:26 -0400
X-MC-Unique: j69NuKkRM_24IGWCgqAKuA-1
Received: by mail-pj1-f71.google.com with SMTP id fs5so3156502pjb.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 06:55:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9E4MFof7nUo0/wMiUkKWQUNotogwZFFdR4mKeWQqr64=;
        b=P3R+u1gJel+zVBN2We6QXeN7dBBBIH9fVBjp8YaKx/skFAtn5y0nvvy+/YOS/sHEIx
         M/b/knT83+oWxiWemQX127Sz4vk7eIwUW5HQ10cBcPnVsAcjaHTDmxPOCoMsDUSBSXhu
         HHKV4tYyhg3kqWtT1twLLyok3mbJiKAHFT5gQRa1xxJO6OIbnwHQYoy3E/0KUNjIJnmn
         PISSB1R22F4Os+Nmv+VamgbbsqMb1DgkE/QXp2DYuO8K4lBm3yF1aW21SF3+Kj8FJlsp
         CQty7HxEvoO5mxx45oKgJ5ZJd51S7DX/OEW5mxR74k2D+Ee9YKvDty84RfFBH8wDI3IT
         2kow==
X-Gm-Message-State: AOAM533FuGcnEkb5A953Jog4sTDGp1TqLSiIrmU72KIFVoD+G0MjhXtD
        4ZvmKiZdrTX/B3WsMlq4Q4ReRBI7ognX0U9a32Cx3hIY4pv/Hd8dA+HpeBJGfyVfnV2+XGTr4M8
        dxkQpA14ws/HXevLk7G7rPujf
X-Received: by 2002:a17:902:b7c8:b029:d0:cbe1:e7b2 with SMTP id v8-20020a170902b7c8b02900d0cbe1e7b2mr33465976plz.35.1600437325773;
        Fri, 18 Sep 2020 06:55:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUrSr6Izh1DQEjayoRt2kONSYDRKoE2mHgL/SDltaFgDhXhbjERmcBZq8/FbtrYG6WbwnCPQ==
X-Received: by 2002:a17:902:b7c8:b029:d0:cbe1:e7b2 with SMTP id v8-20020a170902b7c8b02900d0cbe1e7b2mr33465962plz.35.1600437325518;
        Fri, 18 Sep 2020 06:55:25 -0700 (PDT)
Received: from xiangao.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j19sm3642016pfe.108.2020.09.18.06.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 06:55:25 -0700 (PDT)
From:   Gao Xiang <hsiangkao@redhat.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>,
        Gao Xiang <hsiangkao@redhat.com>
Subject: [PATCH 4/4] erofs: add REQ_RAHEAD flag to readahead requests
Date:   Fri, 18 Sep 2020 21:54:36 +0800
Message-Id: <20200918135436.17689-4-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200918135436.17689-1-hsiangkao@redhat.com>
References: <20200918135436.17689-1-hsiangkao@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's add REQ_RAHEAD flag so it'd be easier to identify
readahead I/O requests in blktrace.

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/data.c  | 2 +-
 fs/erofs/zdata.c | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 459ecb42cbd3..347be146884c 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -224,7 +224,7 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
 		bio_set_dev(bio, sb->s_bdev);
 		bio->bi_iter.bi_sector = (sector_t)blknr <<
 			LOG_SECTORS_PER_BLOCK;
-		bio->bi_opf = REQ_OP_READ;
+		bio->bi_opf = REQ_OP_READ | (ra ? REQ_RAHEAD : 0);
 	}
 
 	err = bio_add_page(bio, page, PAGE_SIZE, 0);
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index bb20f73f10e0..23940edf16ce 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -136,6 +136,7 @@ struct z_erofs_decompress_frontend {
 	struct erofs_map_blocks map;
 
 	unsigned int compressedblock_total;
+	bool readahead;
 
 	/* used for applying cache strategy on the fly */
 	bool backmost;
@@ -1220,6 +1221,8 @@ static void z_erofs_submit_queue(struct super_block *sb,
 					LOG_SECTORS_PER_BLOCK;
 				bio->bi_private = bi_private;
 				bio->bi_opf = REQ_OP_READ;
+				if (f->readahead)
+					bio->bi_opf |= REQ_RAHEAD;
 				++nr_bios;
 			}
 
@@ -1318,6 +1321,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
 
 	trace_erofs_readpages(inode, readahead_index(rac), nr_pages, false);
 
+	f.readahead = true;
 	f.headoffset = readahead_pos(rac);
 
 	while ((page = readahead_page(rac))) {
-- 
2.18.1

