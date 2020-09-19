Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F554270B6E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 09:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgISH2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 03:28:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49144 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726112AbgISH23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 03:28:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600500507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=s5QBdWf0Be/EzSaYQm1AD046Zbo4g6mUJcMIOSDZ87c=;
        b=Mkt3n8SEY5UFiXIo31cmBOyJcLke9aooYbEvxJN5fXpf1yhKQ2YKGuLzZA5W6smCLESq4T
        +P74kUTcs2MPJlrftG81nkIHdjYGzuGsfqVJieGuXr0HS9XEQ4rD/kiCYVHRlEZqxzehMt
        kW4xAf1wMqHnlc4n/JrxnPO6zO58IDQ=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-sAhIStsGMMCTyORuz-ttaA-1; Sat, 19 Sep 2020 03:28:25 -0400
X-MC-Unique: sAhIStsGMMCTyORuz-ttaA-1
Received: by mail-pf1-f197.google.com with SMTP id f76so5099431pfa.5
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 00:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s5QBdWf0Be/EzSaYQm1AD046Zbo4g6mUJcMIOSDZ87c=;
        b=LwUmVWZOiDnv5/sx52Ti9fYUMRWFv8S1LpclFlb6RmK8yP9HCLfbW4MB0RN0e+OCSC
         r+eCAtcaOxzYMg8/7crQPNEZfElx6nHRH5EQROMrDSttfpu7pDonuZETw0GT+hhjMyC7
         uE9Lu2t/+Y9EB0FL2iOffi60AhFABNY/9cdLScgdWEcPSQzDTcTUHL9Duis4FAREaHEV
         iSdEWCDk8Z0rtJ78KrZjLjVpF+ymrneE/qMLBpofqLSvU35t0nV9ntfuqiMOZ0zuRs8D
         oxQMJC2xMQFVskfL6zzO+iGS71auR/WLb6Zit1PXy27bKX41mIldgntUc3lGewNajS3p
         O05Q==
X-Gm-Message-State: AOAM530PJQ7YdofHapqASKUcqj2MDhBXmmcCMKaO8V7Q91a82MnYet4w
        4j8tdEa+ku/b2DTDq7ag+6ShL+OUFOg57NhekqoYWdXa5cfRqcq9V6L9GMemlYgDFHX9lPV68hr
        ry7H39Pg0gQLn2RMgq11uWZKj
X-Received: by 2002:a17:902:b586:b029:d1:bb0f:2644 with SMTP id a6-20020a170902b586b02900d1bb0f2644mr32502957pls.34.1600500504785;
        Sat, 19 Sep 2020 00:28:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZYnm3xckGHKZChvOgswDfMVTG0fk8MOC46B/+w0qe2CXhzMvyQVAnykW4gqBnbQZw+2FQCQ==
X-Received: by 2002:a17:902:b586:b029:d1:bb0f:2644 with SMTP id a6-20020a170902b586b02900d1bb0f2644mr32502940pls.34.1600500504523;
        Sat, 19 Sep 2020 00:28:24 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s3sm5407381pfe.116.2020.09.19.00.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2020 00:28:24 -0700 (PDT)
From:   Gao Xiang <hsiangkao@redhat.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>,
        Gao Xiang <hsiangkao@redhat.com>
Subject: [PATCH v2 3/3] erofs: add REQ_RAHEAD flag to readahead requests
Date:   Sat, 19 Sep 2020 15:27:30 +0800
Message-Id: <20200919072730.24989-3-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200919072730.24989-1-hsiangkao@redhat.com>
References: <20200919072730.24989-1-hsiangkao@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's add REQ_RAHEAD flag so it'd be easier to identify
readahead I/O requests in blktrace.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
change since v1:
 since "erofs: add REQ_RAHEAD flag to readahead requests" is dropped,
 lifting up related code to this patch and rebase for now.

 fs/erofs/data.c  |  2 +-
 fs/erofs/zdata.c | 17 +++++++++++------
 2 files changed, 12 insertions(+), 7 deletions(-)

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
index bee6ce783c64..50912a5420b4 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -135,6 +135,7 @@ struct z_erofs_decompress_frontend {
 	struct z_erofs_collector clt;
 	struct erofs_map_blocks map;
 
+	bool readahead;
 	/* used for applying cache strategy on the fly */
 	bool backmost;
 	erofs_off_t headoffset;
@@ -1148,7 +1149,7 @@ static void move_to_bypass_jobqueue(struct z_erofs_pcluster *pcl,
 }
 
 static void z_erofs_submit_queue(struct super_block *sb,
-				 z_erofs_next_pcluster_t owned_head,
+				 struct z_erofs_decompress_frontend *f,
 				 struct list_head *pagepool,
 				 struct z_erofs_decompressqueue *fgq,
 				 bool *force_fg)
@@ -1157,6 +1158,7 @@ static void z_erofs_submit_queue(struct super_block *sb,
 	z_erofs_next_pcluster_t qtail[NR_JOBQUEUES];
 	struct z_erofs_decompressqueue *q[NR_JOBQUEUES];
 	void *bi_private;
+	z_erofs_next_pcluster_t owned_head = f->clt.owned_head;
 	/* since bio will be NULL, no need to initialize last_index */
 	pgoff_t last_index;
 	unsigned int nr_bios = 0;
@@ -1212,6 +1214,8 @@ static void z_erofs_submit_queue(struct super_block *sb,
 					LOG_SECTORS_PER_BLOCK;
 				bio->bi_private = bi_private;
 				bio->bi_opf = REQ_OP_READ;
+				if (f->readahead)
+					bio->bi_opf |= REQ_RAHEAD;
 				++nr_bios;
 			}
 
@@ -1243,14 +1247,14 @@ static void z_erofs_submit_queue(struct super_block *sb,
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
@@ -1281,7 +1285,7 @@ static int z_erofs_readpage(struct file *file, struct page *page)
 	(void)z_erofs_collector_end(&f.clt);
 
 	/* if some compressed cluster ready, need submit them anyway */
-	z_erofs_runqueue(inode->i_sb, &f.clt, &pagepool, true);
+	z_erofs_runqueue(inode->i_sb, &f, &pagepool, true);
 
 	if (err)
 		erofs_err(inode->i_sb, "failed to read, err [%d]", err);
@@ -1307,6 +1311,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
 
 	trace_erofs_readpages(inode, readahead_index(rac), nr_pages, false);
 
+	f.readahead = true;
 	f.headoffset = readahead_pos(rac);
 
 	while ((page = readahead_page(rac))) {
@@ -1340,7 +1345,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
 
 	(void)z_erofs_collector_end(&f.clt);
 
-	z_erofs_runqueue(inode->i_sb, &f.clt, &pagepool, sync);
+	z_erofs_runqueue(inode->i_sb, &f, &pagepool, sync);
 
 	if (f.map.mpage)
 		put_page(f.map.mpage);
-- 
2.18.1

