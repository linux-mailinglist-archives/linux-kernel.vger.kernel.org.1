Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3946B2E2B10
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 11:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbgLYKCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 05:02:38 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:46543 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726322AbgLYKCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 05:02:38 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UJjFIVO_1608890514;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UJjFIVO_1608890514)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 25 Dec 2020 18:01:55 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     willy@infradead.org
Cc:     tim.c.chen@linux.intel.com,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/4] pre sort pages on lruvec in pagevec
Date:   Fri, 25 Dec 2020 17:59:46 +0800
Message-Id: <1608890390-64305-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20201126155553.GT4327@casper.infradead.org>
References: <20201126155553.GT4327@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This idea was tried on per memcg lru lock patchset v18, and had a good
result, about 5%~20+% performance gain on lru lock busy benchmarks,
like case-lru-file-readtwice.

But on the latest kernel, I can not reproduce the result on my box.
Also I can not reproduce Tim's performance gain too on my box.

So I don't know if it's workable in some scenario, just sent out if
someone has interesting...

Alex Shi (4):
  mm/swap.c: pre-sort pages in pagevec for pagevec_lru_move_fn
  mm/swap.c: bail out early for no memcg and no numa
  mm/swap.c: extend the usage to pagevec_lru_add
  mm/swap.c: no sort if all page's lruvec are same

Cc: Konstantin Khlebnikov <koct9i@gmail.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org

 mm/swap.c | 118 +++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 91 insertions(+), 27 deletions(-)

-- 
2.29.GIT

