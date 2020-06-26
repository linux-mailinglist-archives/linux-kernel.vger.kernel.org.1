Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C18620BAEC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 23:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725998AbgFZVFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 17:05:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgFZVFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 17:05:06 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43B7920720;
        Fri, 26 Jun 2020 21:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593205506;
        bh=bcnEDY2baADluA2OfBYZhXvSSPnVEiJFwVXnomA4i0o=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=TdkF652cvhtJnzyzi3Cm98ECt/CSWSN92xiu4XFPBKfoFc+UTfHkwn0sHbgF4ByJ1
         GLPT13ntMa1Fn6UluhoM7etb4gVWrRPJ5RtHhR4MQv5+45utfFIHDnX+Poi2lXtfw0
         FJvfY3QNGWoi6kY8r1m2dzjbKK2cU8H+xdChs5AQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 2A6E535230EC; Fri, 26 Jun 2020 14:05:06 -0700 (PDT)
Date:   Fri, 26 Jun 2020 14:05:06 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, luto@kernel.org, kernel-team@fb.com
Subject: [PATCH tick-sched] Clarify "NOHZ: local_softirq_pending" warning
Message-ID: <20200626210506.GA27189@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, can_stop_idle_tick() prints "NOHZ: local_softirq_pending HH"
(where "HH" is the hexadecimal softirq vector number) when one or more
non-RCU softirq handlers are still enablded when checking to stop the
scheduler-tick interrupt.  This message is not as enlightening as one
might hope, so this commit changes it to "NOHZ tick-stop error: Non-RCU
local softirq work is pending, handler #HH.

Reported-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

---

 tick-sched.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index f0199a4..349a25a 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -927,7 +927,7 @@ static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
 
 		if (ratelimit < 10 &&
 		    (local_softirq_pending() & SOFTIRQ_STOP_IDLE_MASK)) {
-			pr_warn("NOHZ: local_softirq_pending %02x\n",
+			pr_warn("NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #%02x\n",
 				(unsigned int) local_softirq_pending());
 			ratelimit++;
 		}
