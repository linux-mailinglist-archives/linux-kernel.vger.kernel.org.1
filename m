Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1674E245B54
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 06:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgHQEJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 00:09:50 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:37904 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726676AbgHQEJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 00:09:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U5xGSVm_1597637373;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U5xGSVm_1597637373)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 17 Aug 2020 12:09:33 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, hch@lst.de, baolin.wang@linux.alibaba.com,
        baolin.wang7@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 0/5] Some clean-ups for bio merge
Date:   Mon, 17 Aug 2020 12:09:14 +0800
Message-Id: <cover.1597637287.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There are some duplicated code when trying to merge bio from pluged list
and software queue, thus this patch set did some clean-ups when merging
a bio. Any comments are welcome. Thanks.

Baolin Wang (5):
  block: Move bio merge related functions into blk-merge.c
  block: Remove redundant blk_mq_sched_allow_merge() validation
  block: Add a new helper to attempt to merge a bio
  block: Remove blk_mq_attempt_merge() function
  block: Remove __blk_mq_sched_bio_merge() helper

 block/blk-core.c     | 156 -----------------------------------------------
 block/blk-merge.c    | 168 +++++++++++++++++++++++++++++++++++++++++++++++++++
 block/blk-mq-sched.c |  64 ++++++--------------
 block/blk-mq-sched.h |  13 +---
 block/blk.h          |   9 +++
 5 files changed, 197 insertions(+), 213 deletions(-)

-- 
1.8.3.1

