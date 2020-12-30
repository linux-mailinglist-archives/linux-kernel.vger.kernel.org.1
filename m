Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B85242E7561
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 01:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgL3AfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 19:35:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48316 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726323AbgL3Ae7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 19:34:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609288413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RthBOmbQ7PFuAQ6fuTWW+KikcxySvwjLFJe3elHnxKs=;
        b=EFQFgCjKYZq59nin4esthji3iVMNqxtk4nUcq7cMVBKGPBr/7zxuqD9OuEhbFLjuG0p+RM
        GtydD3rhrrsjMTPkMDGnCGo2C8eeuEUpED+ahlSIvTstKP+bdYVmnn3Vi4gbFObFdW3b29
        jpUFLGgtAFKW8sewwe6ed7vf1/+8tC0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565-0F9I7xqpP7O2WIEi5ZlH3w-1; Tue, 29 Dec 2020 19:33:29 -0500
X-MC-Unique: 0F9I7xqpP7O2WIEi5ZlH3w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89812180A089;
        Wed, 30 Dec 2020 00:33:28 +0000 (UTC)
Received: from localhost (ovpn-12-20.pek2.redhat.com [10.72.12.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0947F5D9C2;
        Wed, 30 Dec 2020 00:33:24 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 4/6] block: set .bi_max_vecs as actual allocated vector number
Date:   Wed, 30 Dec 2020 08:32:53 +0800
Message-Id: <20201230003255.3450874-5-ming.lei@redhat.com>
In-Reply-To: <20201230003255.3450874-1-ming.lei@redhat.com>
References: <20201230003255.3450874-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bvec_alloc() may allocate more bio vectors than requested, so set .bi_max_vecs as
actual allocated vector number, instead of the requested number. This way can help
fs build bigger bio because new bio often won't be allocated until the current one
becomes full.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 3991a5aab1bc..e567feb380b6 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -502,12 +502,13 @@ struct bio *bio_alloc_bioset(gfp_t gfp_mask, unsigned int nr_iovecs,
 			goto err_free;
 
 		bio->bi_flags |= idx << BVEC_POOL_OFFSET;
+		bio->bi_max_vecs = bvec_nr_vecs(idx);
 	} else if (nr_iovecs) {
 		bvl = bio->bi_inline_vecs;
+		bio->bi_max_vecs = inline_vecs;
 	}
 
 	bio->bi_pool = bs;
-	bio->bi_max_vecs = nr_iovecs;
 	bio->bi_io_vec = bvl;
 	return bio;
 
-- 
2.28.0

