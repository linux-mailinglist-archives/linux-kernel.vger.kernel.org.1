Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3342A2E7565
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 01:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgL3AfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 19:35:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44317 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726323AbgL3AfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 19:35:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609288421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fQqmQgejia5zdNPAXJa4cSOsZ9WjULOA78O3gb5cwIM=;
        b=FA3iLIeQy71Xf1QSRqPZm2SUIihlIaPvmgEE3xcHDxQyrSoq/uNW+DnqmUNSS/b2ApQwAz
        c4HEuT8yvFI8q/hnOtp3YMh9smyDPpFoIAaXtDk2idS9ygukAsOBPOpilCOTmeghIVug1P
        fh07ne1Y5jVJri1m00OaGvtRY9wHRkA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-XivWjf9qNkyKmJLUk992cA-1; Tue, 29 Dec 2020 19:33:39 -0500
X-MC-Unique: XivWjf9qNkyKmJLUk992cA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F29B710054FF;
        Wed, 30 Dec 2020 00:33:37 +0000 (UTC)
Received: from localhost (ovpn-12-20.pek2.redhat.com [10.72.12.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F01CFE155;
        Wed, 30 Dec 2020 00:33:33 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        linux-bcache@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 6/6] bcache: don't pass BIOSET_NEED_BVECS for the 'bio_set' embedded in 'cache_set'
Date:   Wed, 30 Dec 2020 08:32:55 +0800
Message-Id: <20201230003255.3450874-7-ming.lei@redhat.com>
In-Reply-To: <20201230003255.3450874-1-ming.lei@redhat.com>
References: <20201230003255.3450874-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bioset is just for allocating bio only from bio_next_split, and it needn't
bvecs, so remove the flag.

Cc: linux-bcache@vger.kernel.org
Cc: Coly Li <colyli@suse.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/md/bcache/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 0e06d721cd8e..61c8aafc0a32 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1897,7 +1897,7 @@ struct cache_set *bch_cache_set_alloc(struct cache_sb *sb)
 		goto err;
 
 	if (bioset_init(&c->bio_split, 4, offsetof(struct bbio, bio),
-			BIOSET_NEED_BVECS|BIOSET_NEED_RESCUER))
+			BIOSET_NEED_RESCUER))
 		goto err;
 
 	c->uuids = alloc_meta_bucket_pages(GFP_KERNEL, sb);
-- 
2.28.0

