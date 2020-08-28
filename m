Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09FD1255320
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 04:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgH1CxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 22:53:18 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:50461 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727817AbgH1CxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 22:53:17 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07425;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U73igLN_1598583195;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U73igLN_1598583195)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 28 Aug 2020 10:53:15 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, hch@lst.de, baolin.wang@linux.alibaba.com,
        baolin.wang7@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] Some clean-ups for bio merge
Date:   Fri, 28 Aug 2020 10:52:53 +0800
Message-Id: <cover.1598580324.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There are some duplicated code when trying to merge bio from pluged list
and software queue, thus this patch set did some clean-ups when merging
a bio. Any comments are welcome. Thanks.

Changes from v2:
 - Split blk_mq_bio_list_merge() moving into a separate patch.
 - Add reviewed-by tag from Christoph.
 - Coding style improvement.

Changes from v1:
 - Drop patch 2 and patch 5 in v1 patch set.
 - Add reviewed-by tag from Christoph.
 - Move blk_mq_bio_list_merge() into blk-merge.c and rename it.
 - Some coding style improvements.


Baolin Wang (4):
  block: Move bio merge related functions into blk-merge.c
  block: Move blk_mq_bio_list_merge() into blk-merge.c
  block: Add a new helper to attempt to merge a bio
  block: Remove blk_mq_attempt_merge() function

 block/blk-core.c       | 156 -------------------------------------
 block/blk-merge.c      | 203 +++++++++++++++++++++++++++++++++++++++++++++++++
 block/blk-mq-sched.c   |  94 +++++------------------
 block/blk.h            |  23 ++++--
 block/kyber-iosched.c  |   2 +-
 include/linux/blk-mq.h |   2 -
 6 files changed, 240 insertions(+), 240 deletions(-)

-- 
1.8.3.1

