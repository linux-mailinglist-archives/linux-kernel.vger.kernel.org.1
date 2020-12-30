Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6275F2E755B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 01:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgL3Aer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 19:34:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20337 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726323AbgL3Aeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 19:34:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609288400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L655SkM+WbIqVs4mTheDHWzwhYB5oaZbWXpdwXtduMM=;
        b=NVJQf48dO1BEJr30iAvgaoAWzmXSmine2yKgIUmfQCBaACle1R5OXPIHiWP5Ct1tUauehQ
        Skhdb4MYSxunyqB87mebk2jHUClzeV9rB1yRDlzKTMsfVjFaB3t/syqD6eFkVlxtZwzzv9
        +U2sMlMpgMH8q0IgPGYglHMsoQzxnV8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-U0CwkETmMbCxYqjbUTDX0Q-1; Tue, 29 Dec 2020 19:33:17 -0500
X-MC-Unique: U0CwkETmMbCxYqjbUTDX0Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D605D180A08A;
        Wed, 30 Dec 2020 00:33:15 +0000 (UTC)
Received: from localhost (ovpn-12-20.pek2.redhat.com [10.72.12.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2061010013C1;
        Wed, 30 Dec 2020 00:33:14 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/6] block: don't pass BIOSET_NEED_BVECS for q->bio_split
Date:   Wed, 30 Dec 2020 08:32:51 +0800
Message-Id: <20201230003255.3450874-3-ming.lei@redhat.com>
In-Reply-To: <20201230003255.3450874-1-ming.lei@redhat.com>
References: <20201230003255.3450874-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

q->bio_split is only used by bio_split() for fast cloning bio, and no
need to allocate bvecs, so remove this flag.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 96e5fcd7f071..3480ca037d3f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -530,7 +530,7 @@ struct request_queue *blk_alloc_queue(int node_id)
 	if (q->id < 0)
 		goto fail_q;
 
-	ret = bioset_init(&q->bio_split, BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
+	ret = bioset_init(&q->bio_split, BIO_POOL_SIZE, 0, 0);
 	if (ret)
 		goto fail_id;
 
-- 
2.28.0

