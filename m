Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 179E02BA542
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 09:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbgKTI5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 03:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbgKTI5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 03:57:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AF7C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 00:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lFHxzgab5fio/KXrJQrfE454z4bsCaBUVcUqkcbYglQ=; b=tBb/H8lhrultIR/T8/Zu1OmLW8
        /zd8gfzND8C4vWVFJhyoEIWdhl1QGSzpj6IroRfQ780ZDXwY2JEnbmRI//R5r3iV96ySt6JthVuTe
        SCpiUAVhXA0H7GERqHYX2NmWRphzF7NrQPiR1YtuwBtEq91uQHv2p9V9Jboob7xUf1WPJ4MOoqXbr
        ahyBDWnhpYIqsB7ilUO+NcOUMhutrll8Q8oxSis1VrAqGSgbJNdsu3JB/ayzEQJhOrK0ZByoVvosU
        ntNYmx2aRmw/2TnOcBreIKRay4k/nazg1ZJgd6jyUDKvLJHoJ2UzvOsuZa3RJwI6xrmrbmUemHMZy
        O1MVNyuA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kg2Dv-0002rU-7v; Fri, 20 Nov 2020 08:56:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DBF20304D28;
        Fri, 20 Nov 2020 09:56:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A706A29E75A18; Fri, 20 Nov 2020 09:56:53 +0100 (CET)
Date:   Fri, 20 Nov 2020 09:56:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        dietmar.eggemann@arm.com, patrick.bellasi@matbug.net,
        lenb@kernel.org, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com, ionela.voinescu@arm.com,
        qperret@google.com, viresh.kumar@linaro.org
Subject: Re: [RFC] Documentation/scheduler/schedutil.txt
Message-ID: <20201120085653.GA3092@hirez.programming.kicks-ass.net>
References: <20201120075527.GB2414@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120075527.GB2414@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 08:55:27AM +0100, Peter Zijlstra wrote:
>  - In saturated scenarios task movement will cause some transient dips,
>    suppose we have a CPU saturated with 4 tasks, then when we migrate a task
>    to an idle CPU, the old CPU will have a 'running' value of 0.75 while the
>    new CPU will gain 0.25. This is inevitable and time progression will
>    correct this. XXX do we still guarantee f_max due to no idle-time?

Do we want something like this? Is the 1.5 threshold sane? (it's been too
long since I looked at actual numbers here)

---

diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 68d369cba9e4..f0bed8902c40 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -90,3 +90,4 @@ SCHED_FEAT(WA_BIAS, true)
  */
 SCHED_FEAT(UTIL_EST, true)
 SCHED_FEAT(UTIL_EST_FASTUP, true)
+SCHED_FEAT(UTIL_SAT, true)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 590e6f27068c..bf70e5ed8ba6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2593,10 +2593,17 @@ static inline unsigned long cpu_util_dl(struct rq *rq)
 	return READ_ONCE(rq->avg_dl.util_avg);
 }
 
+#define RUNNABLE_SAT (SCHED_CAPACITY_SCALE + SCHED_CAPACITY_SCALE/2)
+
 static inline unsigned long cpu_util_cfs(struct rq *rq)
 {
 	unsigned long util = READ_ONCE(rq->cfs.avg.util_avg);
 
+	if (sched_feat(UTIL_SAT)) {
+		if (READ_ONCE(rq->cfs.avg.runnable_avg) > RUNNABLE_SAT)
+			return SCHED_CAPACITY_SCALE;
+	}
+
 	if (sched_feat(UTIL_EST)) {
 		util = max_t(unsigned long, util,
 			     READ_ONCE(rq->cfs.avg.util_est.enqueued));
