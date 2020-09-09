Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B874262850
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 09:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbgIIHSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 03:18:49 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43484 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727935AbgIIHSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 03:18:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599635923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8kHLShDIjtW+nOie5lwVauvpaW35ekCPOUCvTdPotmg=;
        b=bf/yfZM6NDPiar3UcMy36StZGiXT7Q1+CHXsOuIIQTZlT8WpgRzpEFc2KVj6vk7i9BjfG4
        o/FAymVM6Xtlf1oCHuYWvHCivC4xFPdqEMcloBWROJoPeiLubjRHhI6H4W0BJ/P+0mMj9J
        GfdGlkvKqbHA15eKrV5GL3qXyd8obmg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-eHeI1RO6Ov2mrQOsZapeZA-1; Wed, 09 Sep 2020 03:18:42 -0400
X-MC-Unique: eHeI1RO6Ov2mrQOsZapeZA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B057D10055B6;
        Wed,  9 Sep 2020 07:18:40 +0000 (UTC)
Received: from localhost (ovpn-12-76.pek2.redhat.com [10.72.12.76])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F0C425C1C4;
        Wed,  9 Sep 2020 07:18:39 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>,
        Veronika Kabatova <vkabatov@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Tejun Heo <tj@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH V4 3/3] block: move 'q_usage_counter' into front of 'request_queue'
Date:   Wed,  9 Sep 2020 15:18:13 +0800
Message-Id: <20200909071813.1580038-4-ming.lei@redhat.com>
In-Reply-To: <20200909071813.1580038-1-ming.lei@redhat.com>
References: <20200909071813.1580038-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
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
index 7d82959e7b86..7b1e53084799 100644
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

