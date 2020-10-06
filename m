Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0A5D284E13
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 16:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgJFOfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 10:35:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:52504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbgJFOfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 10:35:14 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A67B3208B8;
        Tue,  6 Oct 2020 14:35:13 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kPo3c-002zFc-K0; Tue, 06 Oct 2020 10:35:12 -0400
Message-ID: <20201006143512.497217762@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 06 Oct 2020 10:34:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [for-linus][PATCH 12/15] ftrace: Simplify the calculation of page number for
 ftrace_page->records
References: <20201006143446.182666356@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yang <richard.weiyang@linux.alibaba.com>

Based on the following two reasones, we could simplify the calculation:

  - If the number after roundup count is not power of 2, we would
    definitely have more than 1 empty page with a higher order.
  - get_count_order() just return current order, so one lower order
    could meet the requirement.

The calculation could be simplified by lower one order level when pages
are not power of 2.

Link: https://lkml.kernel.org/r/20200831031104.23322-5-richard.weiyang@linux.alibaba.com

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index c51a91aea1fd..c3be18b4f27b 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3129,18 +3129,19 @@ static int ftrace_update_code(struct module *mod, struct ftrace_page *new_pgs)
 static int ftrace_allocate_records(struct ftrace_page *pg, int count)
 {
 	int order;
-	int cnt;
+	int pages, cnt;
 
 	if (WARN_ON(!count))
 		return -EINVAL;
 
-	order = get_count_order(DIV_ROUND_UP(count, ENTRIES_PER_PAGE));
+	pages = DIV_ROUND_UP(count, ENTRIES_PER_PAGE);
+	order = get_count_order(pages);
 
 	/*
 	 * We want to fill as much as possible. No more than a page
 	 * may be empty.
 	 */
-	while ((PAGE_SIZE << order) / ENTRY_SIZE >= count + ENTRIES_PER_PAGE)
+	if (!is_power_of_2(pages))
 		order--;
 
  again:
-- 
2.28.0


