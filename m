Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1ED2A09A3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 16:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbgJ3PVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 11:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbgJ3PVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 11:21:50 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232D9C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 08:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=e7UtJQ0GpwJ2/6Ic+CVEgkpSKe0Ng6nztF3SR5eihrM=; b=K64cO9dFMsNCyudlOf6mol0kuI
        pweGGpyOEciWklL806vVZohx2dZs/ECWRDKS/qusMk6f5gQVop1uvrucGsiYdFGSmZ+qQzxfS/xcP
        hdbG45S5REl+z3LfctDIENQ3u19EHm4Uc3Cp3J8PGv/7JpLpACtRINk/zwoqUTg7BoR+ZRMVbyE+h
        cDl4m/DNOzLbdMUk/mE9U8OIEY3ndVHBwpgxl8xwaMBnvfl4W8iMW4BxlqLjDTmAC6lx2HxVbXqRA
        vgUZBgY9eeJjkqCLhqWTe4xdJcCkQVyIG53GDqmXzGViy0B5203XSY1xKMVHq2eNlwS63eEWjyUri
        KEeouBxA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYWDK-0003Lg-JQ; Fri, 30 Oct 2020 15:21:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 13DDB307936;
        Fri, 30 Oct 2020 16:21:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id EFEC82B708596; Fri, 30 Oct 2020 16:21:11 +0100 (CET)
Message-ID: <20201030151955.187580298@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 30 Oct 2020 16:13:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, kan.liang@linux.intel.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, ak@linux.intel.com, eranian@google.com,
        peterz@infradead.org, Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH 4/6] perf: Optimize get_recursion_context()
References: <20201030151345.540479897@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  "Look ma, no branches!"

Cc: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/internal.h |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -205,16 +205,15 @@ DEFINE_OUTPUT_COPY(__output_copy_user, a
 
 static inline int get_recursion_context(int *recursion)
 {
-	int rctx;
+	unsigned int pc = preempt_count();
+	unsigned int rctx = 0;
 
-	if (unlikely(in_nmi()))
-		rctx = 3;
-	else if (in_irq())
-		rctx = 2;
-	else if (in_serving_softirq())
-		rctx = 1;
-	else
-		rctx = 0;
+	if (pc & (NMI_MASK))
+		rctx++;
+	if (pc & (NMI_MASK | HARDIRQ_MASK))
+		rctx++;
+	if (pc & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET))
+		rctx++;
 
 	if (recursion[rctx])
 		return -1;


