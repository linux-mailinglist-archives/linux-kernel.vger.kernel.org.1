Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5D1273807
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 03:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgIVB0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 21:26:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729555AbgIVBYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 21:24:53 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C017623AC0;
        Tue, 22 Sep 2020 01:24:52 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kKX35-001sMC-R2; Mon, 21 Sep 2020 21:24:51 -0400
Message-ID: <20200922012451.714244672@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 21 Sep 2020 21:24:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [for-next][PATCH 12/26] tracing: remove a pointless assignment
References: <20200922012414.115238201@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

The "tr" is a stack variable so setting it to NULL before a return is
a no-op.  Delete the assignment.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 1c4ca25944ba..55b829863127 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8799,7 +8799,6 @@ static int __remove_instance(struct trace_array *tr)
 	free_cpumask_var(tr->tracing_cpumask);
 	kfree(tr->name);
 	kfree(tr);
-	tr = NULL;
 
 	return 0;
 }
-- 
2.28.0


