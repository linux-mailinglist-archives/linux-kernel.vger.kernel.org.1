Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4CB5251654
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 12:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729745AbgHYKNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 06:13:11 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26169 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729722AbgHYKNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 06:13:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598350388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nn3/ojYLQ9s2otrwm8DXYS3SN2GWnlZwcAeWY3DObA8=;
        b=XcifGtBgduYumLQlbSx5TGC5WEpZ9dFFJ/xytcRz/66rfB6PX8c6tCHyXKoLRDLblneSRV
        8wKwlSfqdEQf3WSCFHBn8iA6sVrfs0vOC9VW1HcdctwnX6xZjXx9/jbwVdiMDhd/fLkCw0
        uaJYjzV+sWnl4+eVgath9/hUkw8m8eU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-548-PhKnMpzLOb-3Ew9bSd3ydw-1; Tue, 25 Aug 2020 06:13:05 -0400
X-MC-Unique: PhKnMpzLOb-3Ew9bSd3ydw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8EC3F81F01D;
        Tue, 25 Aug 2020 10:13:04 +0000 (UTC)
Received: from localhost (ovpn-13-7.pek2.redhat.com [10.72.13.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D57251014172;
        Tue, 25 Aug 2020 10:13:00 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
        Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/2] percpu_ref & block: reduce memory footprint of percpu_ref in fast path
Date:   Tue, 25 Aug 2020 18:12:46 +0800
Message-Id: <20200825101248.8027-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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


Ming Lei (2):
  percpu_ref: reduce memory footprint of percpu_ref in fast path
  block: move 'q_usage_counter' into front of 'request_queue'

 drivers/infiniband/sw/rdmavt/mr.c |   2 +-
 include/linux/blkdev.h            |   3 +-
 include/linux/percpu-refcount.h   |  43 +++++++++----
 lib/percpu-refcount.c             | 101 ++++++++++++++++++++----------
 4 files changed, 101 insertions(+), 48 deletions(-)

Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bvanassche@acm.org>
-- 
2.25.2

