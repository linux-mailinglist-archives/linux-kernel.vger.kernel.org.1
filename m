Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 468A1279EB2
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 08:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbgI0G1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 02:27:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45663 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730421AbgI0G1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 02:27:11 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601188028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=s0QJrlkrbBeq+eVwaFFCQP+CMSNcINM05HMlBIsX0V8=;
        b=Ovv2SJVKUGcodYM9jTXEr+7BPzmg2ZFbGOmF9NBTXXK5JGlaeMLrxlsLex3L6TvmHP23Cj
        lwrc7dO9Xc5Ufv965Nh819LsY3cD7F4XFEbjWORDOPsg+wywh6QOZgb01s02mOnqq6CzLK
        3BGmhkY+OIiknzgwbGtFcIipf1OZE6A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-TJuJ8QZDO5WC0GTCfTVHMw-1; Sun, 27 Sep 2020 02:27:06 -0400
X-MC-Unique: TJuJ8QZDO5WC0GTCfTVHMw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C148910059A9;
        Sun, 27 Sep 2020 06:27:04 +0000 (UTC)
Received: from localhost (ovpn-12-180.pek2.redhat.com [10.72.12.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0EC4D7368F;
        Sun, 27 Sep 2020 06:26:59 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>,
        Veronika Kabatova <vkabatov@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>, Tejun Heo <tj@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH V5 0/3] percpu_ref & block: reduce memory footprint of percpu_ref in fast path
Date:   Sun, 27 Sep 2020 14:26:51 +0800
Message-Id: <20200927062654.2750277-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

V5:
	- fix memory leak on ref->data, only percpu_ref_exit() of patch 2
	is modified.

V4:
	- rename percpu_ref_inited as percpu_ref_is_initialized

V3:
	- fix kernel oops on MD
	- add patch for avoiding to use percpu-refcount internal from md
	  code
	- pass Red Hat CKI test which is done by Veronika Kabatova

V2:
	- pass 'gfp' to kzalloc() for fixing block/027 failure reported by
	kernel test robot
	- protect percpu_ref_is_zero() with destroying percpu-refcount by
	spin lock  


Ming Lei (3):
  percpu_ref: add percpu_ref_is_initialized for MD
  percpu_ref: reduce memory footprint of percpu_ref in fast path
  block: move 'q_usage_counter' into front of 'request_queue'

 drivers/infiniband/sw/rdmavt/mr.c |   2 +-
 drivers/md/md.c                   |   2 +-
 include/linux/blkdev.h            |   3 +-
 include/linux/percpu-refcount.h   |  46 ++++------
 lib/percpu-refcount.c             | 137 +++++++++++++++++++++++-------
 5 files changed, 126 insertions(+), 64 deletions(-)

Cc: Veronika Kabatova <vkabatov@redhat.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bvanassche@acm.org>
-- 
2.25.2

