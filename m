Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 467BE25AB17
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 14:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgIBM1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 08:27:03 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32677 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726177AbgIBM07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 08:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599049618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9eHg4n9Mrbjk8IN5UH1B1k5VMpWNZ5atFdJ2hB4iC3M=;
        b=S0Z48kmzqTZR3mZ2SzcBsu4yPxJpC99YercEJ17vRilYfNUN8kpIy/v1jxxZgfvY9EbTX4
        GmFEt5eCRhNJOoSOTJiC9BxEmTV34ssFupnRdtdRrjZPcEcWDXclNIQmF5strkxhTOFQMA
        o1yBzp5gJ1q93FHS14lbZQ4Xs++DXXQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-puG_S4o8M2q_OG0lkFs1QQ-1; Wed, 02 Sep 2020 08:26:57 -0400
X-MC-Unique: puG_S4o8M2q_OG0lkFs1QQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37AE41888A3E;
        Wed,  2 Sep 2020 12:26:55 +0000 (UTC)
Received: from localhost (ovpn-12-189.pek2.redhat.com [10.72.12.189])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 65D7665F5E;
        Wed,  2 Sep 2020 12:26:51 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
        Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH V2 0/2] percpu_ref & block: reduce memory footprint of percpu_ref in fast path
Date:   Wed,  2 Sep 2020 20:26:41 +0800
Message-Id: <20200902122643.634143-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The 1st patch removes memory footprint of percpu_ref in fast path
from 7 words to 2 words, since it is often used in fast path and
embedded in user struct.

The 2nd patch moves .q_usage_counter to 1st cacheline of
'request_queue'.

Simple test on null_blk shows ~2% IOPS boost on one 16cores(two threads
per core) machine, dual socket/numa.

V2:
	- pass 'gfp' to kzalloc() for fixing block/027 failure reported by
	kernel test robot
	- protect percpu_ref_is_zero() with destroying percpu-refcount by
	spin lock  

Ming Lei (2):
  percpu_ref: reduce memory footprint of percpu_ref in fast path
  block: move 'q_usage_counter' into front of 'request_queue'

 drivers/infiniband/sw/rdmavt/mr.c |   2 +-
 include/linux/blkdev.h            |   3 +-
 include/linux/percpu-refcount.h   |  45 ++++-------
 lib/percpu-refcount.c             | 128 ++++++++++++++++++++++--------
 4 files changed, 115 insertions(+), 63 deletions(-)

Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bvanassche@acm.org>
-- 
2.25.2

