Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE3B429F19E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 17:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgJ2Qf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 12:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgJ2Q35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:29:57 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D670C0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=e2/3ZAdKT7UTtCZHl8MzCRzww3KY//KKPqZMJkiz9hA=; b=W7+EMBw4AloYyyRf/X2ROzu3PX
        pQchpVpW4TtWJctBDyVu7k13f5BqiW5v7XbOhxsqI9thDMIe3XXF1HL3jP/DgAI1kmtcNeYLE4ZwF
        xhaYfptH2d7XJ1Y+czxq0Hwv8pEajZXTLck3i44eV32qr4/aHOapgj8FH62rLgKywz0VaCGb6bSpc
        +fC7X0zwaR1b5Y5xRH+hScvniBvp6AIBuJxjuZmPT7Il8tU51jx0R030aMPD9NmFw18m+6BZHzISW
        VLrLDXN/z+DYPk0XeB10gmVKHhMUsF564xZyUQFkojyBwEggS89wqo0jPAt0xBxd4PKl6n7HrWcLZ
        m48VQN0A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYAo8-00067U-6I; Thu, 29 Oct 2020 16:29:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 053633012C3;
        Thu, 29 Oct 2020 17:29:47 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E34EA2107F308; Thu, 29 Oct 2020 17:29:46 +0100 (CET)
Message-ID: <20201029162901.972161394@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 29 Oct 2020 17:27:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, eranian@google.com,
        ak@linux.intel.com, peterz@infradead.org
Subject: [PATCH v2 2/4] perf: Simplify group_sched_in()
References: <20201029162719.519685265@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Collate the error paths. Code duplication only leads to divergence and
extra bugs.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2580,11 +2580,8 @@ group_sched_in(struct perf_event *group_
 
 	pmu->start_txn(pmu, PERF_PMU_TXN_ADD);
 
-	if (event_sched_in(group_event, cpuctx, ctx)) {
-		pmu->cancel_txn(pmu);
-		perf_mux_hrtimer_restart(cpuctx);
-		return -EAGAIN;
-	}
+	if (event_sched_in(group_event, cpuctx, ctx))
+		goto error;
 
 	/*
 	 * Schedule in siblings as one group (if any):
@@ -2613,10 +2610,9 @@ group_sched_in(struct perf_event *group_
 	}
 	event_sched_out(group_event, cpuctx, ctx);
 
+error:
 	pmu->cancel_txn(pmu);
-
 	perf_mux_hrtimer_restart(cpuctx);
-
 	return -EAGAIN;
 }
 


