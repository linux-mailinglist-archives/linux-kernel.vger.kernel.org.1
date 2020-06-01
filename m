Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095C91EA048
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 10:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbgFAIpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 04:45:05 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:34100 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728314AbgFAIpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 04:45:02 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0U-C-4Hb_1591001087;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0U-C-4Hb_1591001087)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 01 Jun 2020 16:44:47 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>, Tejun Heo <tj@kernel.org>
Subject: [PATCH 0/4] workqueue: reduce the sizeof pool_workqueue
Date:   Mon,  1 Jun 2020 08:44:38 +0000
Message-Id: <20200601084442.8284-1-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The major memory ussage in workqueue is on the pool_workqueue.
The pool_workqueue has alignment requirement which often leads
to padding.

Reducing the memory usage for the pool_workqueue is valuable.

And 32bit system often has less memory, less workqueues,
less works, less concurrent flush_workqueue()s, so we can
slash the flush color on 32bit system to reduce memory usage

Before patch:
The sizeof the struct pool_workqueue is 256 bytes,
only 136 bytes is in use in 32bit system

After patch:
The sizeof the struct pool_workqueue is 128 bytes,
only 104 bytes is in use in 32bit system, there is still
room for future usage.

Setting WORK_STRUCT_COLOR_BITS to 3 can't reduce the sizeof
the struct pool_workqueue in 64bit system, unless combined
with big refactor for unbound pwq.

Lai Jiangshan (4):
  workqueue: fix a piece of comment about reserved bits for work flags
  workqueue: use BUILD_BUG_ON() for compile time test instead of
    WARN_ON()
  workqueue: add a BUILD_BUG_ON() to check the size of struct
    pool_workqueue
  workqueue: slash half memory usage in 32bit system

Cc: Tejun Heo <tj@kernel.org>

 include/linux/workqueue.h |  8 +++++++-
 kernel/workqueue.c        | 10 +++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

-- 
2.20.1

