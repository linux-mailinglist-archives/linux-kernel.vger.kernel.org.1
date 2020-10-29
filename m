Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C38F29F19A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 17:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgJ2QaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 12:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgJ2Q36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:29:58 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0517C0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=fGX4zCJ8vVU+IVEt4sQ3DDy5dNUSFbOxBHF4wO17QvY=; b=LK4T9Aj92Zmy0zGEZPIq9XrCNd
        35m41mxY29d1GUPrF27vhpwRFwZLm0MnLHq6x63uBa7DLr95C4zQnrKvhKlJD/cuPt+umjyGLkPjw
        nmYTS12LJsLRKCliW1IuvnV+QL7hHOq46GFnDDJfy/3AKh6U+iLwsj+WrEmDplO2LR0S6xIVotXr0
        NcWDybhpzBgLioL3PHZuFsudJhU7JO95fVfL6V6wDFQqv1W79XhTGfUL8OIdi5XxicmWjfnS6j7vo
        bTug7kXCXw9bbhTgbc1uaumaK/AIwEOmErKXu4ZOfsanE9t+lFEcr54yWEg/KjRxVgQzrKvqWsLg6
        jFHswCGw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYAo8-00067T-5j; Thu, 29 Oct 2020 16:29:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 006A73006D0;
        Thu, 29 Oct 2020 17:29:47 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E142120409A7D; Thu, 29 Oct 2020 17:29:46 +0100 (CET)
Message-ID: <20201029162901.904060564@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 29 Oct 2020 17:27:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, eranian@google.com,
        ak@linux.intel.com, peterz@infradead.org
Subject: [PATCH v2 1/4] perf: Simplify group_sched_out()
References: <20201029162719.519685265@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since event_sched_out() clears cpuctx->exclusive upon removal of an
exclusive event (and only group leaders can be exclusive), there is no
point in group_sched_out() trying to do it too. It is impossible for
cpuctx->exclusive to still be set here.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2312,9 +2312,6 @@ group_sched_out(struct perf_event *group
 		event_sched_out(event, cpuctx, ctx);
 
 	perf_pmu_enable(ctx->pmu);
-
-	if (group_event->attr.exclusive)
-		cpuctx->exclusive = 0;
 }
 
 #define DETACH_GROUP	0x01UL


