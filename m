Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99930257201
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 05:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgHaDLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Aug 2020 23:11:10 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:41592 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726573AbgHaDLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 23:11:09 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U7JKC3o_1598843466;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U7JKC3o_1598843466)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 31 Aug 2020 11:11:06 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH 0/6] ftrace: trivial cleanup
Date:   Mon, 31 Aug 2020 11:10:58 +0800
Message-Id: <20200831031104.23322-1-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial cleanups relates to ftrace.

Wei Yang (6):
  ftrace: define seq_file only for FMODE_READ
  ftrace: use fls() to get the bits for dup_hash()
  ftrace: simplify the dyn_ftrace->flags macro
  ftrace: simplify the calculation of page number for
    ftrace_page->records
  ftrace: replace do_for_each_ftrace_rec() with for_ftrace_rec_iter()
  ftrace: ftrace_global_list is renamed to ftrace_ops_list

 include/linux/ftrace.h |  11 ++---
 kernel/trace/ftrace.c  | 108 ++++++++++++++++++++---------------------
 2 files changed, 56 insertions(+), 63 deletions(-)

-- 
2.20.1 (Apple Git-117)

