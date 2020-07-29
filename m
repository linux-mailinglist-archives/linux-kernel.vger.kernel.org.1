Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482BD231819
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 05:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgG2D2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 23:28:55 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:38198 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726290AbgG2D2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 23:28:54 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U46nKku_1595993330;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U46nKku_1595993330)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 29 Jul 2020 11:28:50 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, hch@lst.de, baolin.wang@linux.alibaba.com,
        baolin.wang7@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Some clean-ups for bio merge
Date:   Wed, 29 Jul 2020 11:28:32 +0800
Message-Id: <cover.1595987955.git.baolin.wang@linux.alibaba.com>
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

