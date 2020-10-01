Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B30280328
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 17:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732619AbgJAPtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 11:49:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59284 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732507AbgJAPtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 11:49:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601567375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oiTRa+VL3UYBQkggS5s/6LNHr5dPZxoNb4+G/XwOhxk=;
        b=KpHip++un7Gd1DCLvPdPjvQ6kk038l9RqrC1XB4VT7ea75MfYPK0jHuWW1mBbecZd+Y4hQ
        qVCzgb+y7yjS5Usa7KaEnGSDlI7+0W25gewl0VCU8ZW6JCRV71JqR1UjSJom5eIgVUVNaN
        bK6+1q0MSfbKISaTCZtYyJ/MEg9+fxk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-V-0SDF6zNCGHF2bdrKJvuQ-1; Thu, 01 Oct 2020 11:49:01 -0400
X-MC-Unique: V-0SDF6zNCGHF2bdrKJvuQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CCC97805EE3;
        Thu,  1 Oct 2020 15:48:58 +0000 (UTC)
Received: from localhost (ovpn-12-47.pek2.redhat.com [10.72.12.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B7B919650;
        Thu,  1 Oct 2020 15:48:47 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>,
        Veronika Kabatova <vkabatov@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>, Tejun Heo <tj@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH V7 0/2] percpu_ref & block: reduce memory footprint of percpu_ref in fast path
Date:   Thu,  1 Oct 2020 23:48:40 +0800
Message-Id: <20201001154842.26896-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

V7:
	- add comments about reason for struct split

V6:
	- drop the 1st patch which adds percpu_ref_is_initialized() for MD
	only, since Christoph doesn't like it

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

Ming Lei (2):
  percpu_ref: reduce memory footprint of percpu_ref in fast path
  block: move 'q_usage_counter' into front of 'request_queue'

 drivers/infiniband/sw/rdmavt/mr.c |   2 +-
 include/linux/blkdev.h            |   3 +-
 include/linux/percpu-refcount.h   |  52 ++++++------
 lib/percpu-refcount.c             | 131 ++++++++++++++++++++++--------
 4 files changed, 125 insertions(+), 63 deletions(-)

Cc: Veronika Kabatova <vkabatov@redhat.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bvanassche@acm.org>
-- 
2.25.2

