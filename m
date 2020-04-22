Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E32F1B4349
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 13:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgDVLaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 07:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727010AbgDVL3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 07:29:40 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A27C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 04:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=oUbXjfV1dlNCWV/ZlTMhYxqUYOa2PzHrzpjIIU6gtnE=; b=RFaOM1FCNEe25RWL6WT8jRMSiT
        r13qsJcGA21NRlLiL3fSdq5YGnk5KYir4QMDx+vB0YowuZCg9IWF9PCR5RJATDzhray2TrUn1OlTB
        wNaACKiMCvchBaf8f/k4ByrwGBaRA3gBwwnDG51lGIMknw/O499FqL9znKJBBEitT58nYTJ58xMyG
        EvggQc/2QzmflphJZNMx/KUrlpxM8Vq7tykufz437931uz+qsp3tlcTmgw4GlqASayWwfTptpBLWo
        W0TqQ3dDvhMA6blRGeRjuOf7O2yEnOA5VkQXBVFYeX0TcRXc5/E1XPTOhuFGfnBJD89+IFyyluHpX
        ZS+a5VOg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRDYw-0006qp-SB; Wed, 22 Apr 2020 11:29:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4A4F430796D;
        Wed, 22 Apr 2020 13:29:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E120522B95898; Wed, 22 Apr 2020 13:29:02 +0200 (CEST)
Message-Id: <20200422112831.928975262@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 22 Apr 2020 13:27:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, rostedt@goodmis.org, qais.yousef@arm.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        peterz@infradead.org, daniel.lezcano@linaro.org,
        rafael.j.wysocki@intel.com
Subject: [PATCH 12/23] sched,powercap: Convert to sched_set_fifo*()
References: <20200422112719.826676174@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because SCHED_FIFO is a broken scheduler model (see previous patches)
take away the priority field, the kernel can't possibly make an
informed decision.

Effectively no change.

Cc: daniel.lezcano@linaro.org
Cc: rafael.j.wysocki@intel.com
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/powercap/idle_inject.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/powercap/idle_inject.c
+++ b/drivers/powercap/idle_inject.c
@@ -255,9 +255,7 @@ void idle_inject_stop(struct idle_inject
  */
 static void idle_inject_setup(unsigned int cpu)
 {
-	struct sched_param param = { .sched_priority = MAX_USER_RT_PRIO / 2 };
-
-	sched_setscheduler(current, SCHED_FIFO, &param);
+	sched_set_fifo(current);
 }
 
 /**


