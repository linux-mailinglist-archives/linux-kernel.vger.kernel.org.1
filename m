Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10BF279EC1
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 08:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730488AbgI0G1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 02:27:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30269 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730358AbgI0G1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 02:27:31 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601188050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EbzAX+YvEvHOO3NGqM8YXZj1EdlAEAqHUR00Ej4MfhM=;
        b=RjeXwRcU3O9Sio+0IO73DZeBkdU3X0zlJpcybO8jCzabIZv+xmhMrasN77jFT9z/fRIOZP
        gTmqF6szVg0XzFmvCQOw2ZfDqihIeTKNGJTWWF7tabkgBFjzqYJe74PTiws5o+7KVVES7Z
        S2thm4LxRzupIPmsvJwg1XUSwW8anzE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-A8PJ2bKXO5eN_OIZSMW1_Q-1; Sun, 27 Sep 2020 02:27:25 -0400
X-MC-Unique: A8PJ2bKXO5eN_OIZSMW1_Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 745C91868411;
        Sun, 27 Sep 2020 06:27:24 +0000 (UTC)
Received: from localhost (ovpn-12-180.pek2.redhat.com [10.72.12.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 01C717368F;
        Sun, 27 Sep 2020 06:27:20 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>,
        Veronika Kabatova <vkabatov@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Tejun Heo <tj@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH V5 3/3] block: move 'q_usage_counter' into front of 'request_queue'
Date:   Sun, 27 Sep 2020 14:26:54 +0800
Message-Id: <20200927062654.2750277-4-ming.lei@redhat.com>
In-Reply-To: <20200927062654.2750277-1-ming.lei@redhat.com>
References: <20200927062654.2750277-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The field of 'q_usage_counter' is always fetched in fast path of every
block driver, and move it into front of 'request_queue', so it can be
fetched into 1st cacheline of 'request_queue' instance.

Tested-by: Veronika Kabatova <vkabatov@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/blkdev.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d5a3e1a4c2f7..67935b3bef6c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -397,6 +397,8 @@ struct request_queue {
 	struct request		*last_merge;
 	struct elevator_queue	*elevator;
 
+	struct percpu_ref	q_usage_counter;
+
 	struct blk_queue_stats	*stats;
 	struct rq_qos		*rq_qos;
 
@@ -569,7 +571,6 @@ struct request_queue {
 	 * percpu_ref_kill() and percpu_ref_reinit().
 	 */
 	struct mutex		mq_freeze_lock;
-	struct percpu_ref	q_usage_counter;
 
 	struct blk_mq_tag_set	*tag_set;
 	struct list_head	tag_set_list;
-- 
2.25.2

