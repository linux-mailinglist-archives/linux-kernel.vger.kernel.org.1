Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1692E755D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 01:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgL3Aey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 19:34:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41038 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726323AbgL3Aey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 19:34:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609288408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fwl6RY+UMRO8wNHf36iDoh5MgKPeUmz1oSOI+tFW2+U=;
        b=ch3XrkBaGgltvFPilEJdKM6jSQDdlRx4EkvSH1KWn6yeLm/D6ay1cynkMWD+2P71UgSwoO
        vuhUNSEbVUcROI7MHbP5hgbU9h1hiY8hfNCzoiDzQKMtwvJ5XyjBWJKcdTQMvtE5pZjEIO
        18VuHJ5ce/F3J213BLfP5Xp+Ht1s0+0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-kuTVC_PtOM6ZzdBL1TLghg-1; Tue, 29 Dec 2020 19:33:23 -0500
X-MC-Unique: kuTVC_PtOM6ZzdBL1TLghg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DFB1800D53;
        Wed, 30 Dec 2020 00:33:22 +0000 (UTC)
Received: from localhost (ovpn-12-20.pek2.redhat.com [10.72.12.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B3875D6DC;
        Wed, 30 Dec 2020 00:33:17 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/6] block: don't allocate inline bvecs if this bioset needn't bvecs
Date:   Wed, 30 Dec 2020 08:32:52 +0800
Message-Id: <20201230003255.3450874-4-ming.lei@redhat.com>
In-Reply-To: <20201230003255.3450874-1-ming.lei@redhat.com>
References: <20201230003255.3450874-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The inline bvecs won't be used if user needn't bvecs by not passing
BIOSET_NEED_BVECS, so don't allocate bvecs in this situation.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bio.c         | 11 +++++++----
 include/linux/bio.h |  1 +
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index aa657cdd7c8c..3991a5aab1bc 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -110,7 +110,7 @@ static void bio_put_slab(struct bio_set *bs)
 {
 	struct bio_slab *bslab = NULL;
 	unsigned int slab_size = bs->front_pad + sizeof(struct bio) +
-		BIO_INLINE_VECS * sizeof(struct bio_vec);
+		bs->back_pad;
 
 	mutex_lock(&bio_slab_lock);
 
@@ -1567,15 +1567,18 @@ int bioset_init(struct bio_set *bs,
 		unsigned int front_pad,
 		int flags)
 {
-	unsigned int back_pad = BIO_INLINE_VECS * sizeof(struct bio_vec);
-
 	bs->front_pad = front_pad;
 
+	if (flags & BIOSET_NEED_BVECS)
+		bs->back_pad = BIO_INLINE_VECS * sizeof(struct bio_vec);
+	else
+		bs->back_pad = 0;
+
 	spin_lock_init(&bs->rescue_lock);
 	bio_list_init(&bs->rescue_list);
 	INIT_WORK(&bs->rescue_work, bio_alloc_rescue);
 
-	bs->bio_slab = bio_find_or_create_slab(front_pad + back_pad);
+	bs->bio_slab = bio_find_or_create_slab(bs->front_pad + bs->back_pad);
 	if (!bs->bio_slab)
 		return -ENOMEM;
 
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 1edda614f7ce..f606eb1e556f 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -703,6 +703,7 @@ struct bio_set {
 	mempool_t bvec_integrity_pool;
 #endif
 
+	unsigned int back_pad;
 	/*
 	 * Deadlock avoidance for stacking block drivers: see comments in
 	 * bio_alloc_bioset() for details
-- 
2.28.0

