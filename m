Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9248A1B4342
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 13:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgDVLaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 07:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727035AbgDVL3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 07:29:42 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3642BC03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 04:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=zYfiDfNmQtClS4fPFHWURrNp/udhCBE/1ohw3ojkMsY=; b=ahD0XGAOSrCNTvdAlkdOpGy6UD
        ys7W761dLGihg7sNEn98iIlnHa48Tms9vFE7oTvVxOnU+xR1BxyaHzuoX5Sx33qpJYPXuLaWe+yp1
        Vxe4ftGCdB61uNYieYSoB1imYRq9Bp8/BmMEmhzPj+g5hrW8QHGh9R5V/4lyIaAJCdwW4xPK3TRTW
        MhLND6d51xAPGMjMUUFbanzbTujrNRngskjMnjXkVDiminF2evoh6kzJd67XPIxEmIPumHuZUl1Fb
        hH8YkwQ9msE79nPMXNjFq2lWI57FZUrlK7cuim3V4Dk1+X7PH6hsZrBCUEQdikcfquOxfOhNQya/C
        0wVqVJEA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRDYy-0006rB-Bf; Wed, 22 Apr 2020 11:29:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 53859307979;
        Wed, 22 Apr 2020 13:29:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id F066E22B99F00; Wed, 22 Apr 2020 13:29:02 +0200 (CEST)
Message-Id: <20200422112832.165197058@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 22 Apr 2020 13:27:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, rostedt@goodmis.org, qais.yousef@arm.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        peterz@infradead.org, wim@linux-watchdog.org
Subject: [PATCH 16/23] sched,watchdog: Convert to sched_set_fifo()
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

Effectively changes prio from 99 to 50.

Cc: wim@linux-watchdog.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/watchdog/watchdog_dev.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -1144,14 +1144,13 @@ void watchdog_dev_unregister(struct watc
 int __init watchdog_dev_init(void)
 {
 	int err;
-	struct sched_param param = {.sched_priority = MAX_RT_PRIO - 1,};
 
 	watchdog_kworker = kthread_create_worker(0, "watchdogd");
 	if (IS_ERR(watchdog_kworker)) {
 		pr_err("Failed to create watchdog kworker\n");
 		return PTR_ERR(watchdog_kworker);
 	}
-	sched_setscheduler(watchdog_kworker->task, SCHED_FIFO, &param);
+	sched_set_fifo(watchdog_kworker->task);
 
 	err = class_register(&watchdog_class);
 	if (err < 0) {


