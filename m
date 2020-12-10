Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB8A2D5EC6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 15:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbgLJO5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 09:57:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:58680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727321AbgLJO5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 09:57:20 -0500
Date:   Thu, 10 Dec 2020 15:56:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607612199;
        bh=uKyGDekai/Mk+uYEzgAyret3/T1UrzvVnJckF/SqmrU=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=UBXo1YH/xLVFpYkcBS38ywyz88GQcNIEdUGTNuREg7UufAElIIr9qfdI5QaxVvLS0
         ABQXU3KjWp1+LjRjfR1JtYJdFNYuPSIxr2xuVlCyfImvNBkizXHCd6Ncvl3DjsPjUI
         4/W0tQzlMnreHSWhiZKByhjiYYOR2v388GrlVagoSSzwP6hbghUOl/UeHftAiimxjR
         H3v3iLitH+QnjmY9LtMVHm0IJ96I8SmvYO/qQIrZR51FjyUVhDG4897u/QqEWQI57H
         CJKWW4Ofrz4j02kT/kND7kxshQjDyjyrJ0dT84mkalPVP7pU5h8+SDXnnqlrYyr8cq
         gHwWFZVi0AdYQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: NOHZ tick-stop error: Non-RCU local softirq work is pending
Message-ID: <20201210145637.GA164661@lothringen>
References: <20201118175218.GA16039@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118175218.GA16039@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 18, 2020 at 09:52:18AM -0800, Paul E. McKenney wrote:
> Hello, Frederic,
> 
> Here is the last few months' pile of warnings from rcutorture runs.
> 
> 							Thanx, Paul
> 
> [  255.098527] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #282!!!
> [  414.534548] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
> [ 3798.654736] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
> [ 1718.589367] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
> [ 6632.777655] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
> [ 2873.688490] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
> [ 3081.738937] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
> [ 2673.597523] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
> [ 1467.372887] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
> [   34.371094] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
> [ 1147.260097] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
> [ 5066.699589] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
> [  816.338843] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
> [   34.338836] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
> [ 1234.111394] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
> [ 1282.109415] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
> [  239.215890] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
> [  367.918969] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
> [ 1461.037894] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
> [ 1503.810903] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
> [ 1503.811939] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
> [  699.514824] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
> [  751.681629] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
> [  287.770126] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
> [  287.771096] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
> [  648.009370] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
> [  924.733405] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
> [  924.734011] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
> [ 1743.197353] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #02!!!
> [ 1528.161635] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
> [ 1528.162313] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
> [  265.201513] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
> [  473.137587] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #202!!!
> [  187.375426] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!
> [ 1361.544451] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #80!!!
> [   79.519727] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #280!!!

Would you be willing to run TREE05 for me until it triggers the issue with:

      trace_event=softirq_raise trace_options=stacktrace

And with the below patch, thanks! (make sure you have CONFIG_EVENT_TRACING=y)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 81632cd5e3b7..1751e2d9a5b5 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -929,6 +929,8 @@ static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
 		    (local_softirq_pending() & SOFTIRQ_STOP_IDLE_MASK)) {
 			pr_warn("NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #%02x!!!\n",
 				(unsigned int) local_softirq_pending());
+			dump_stack();
+			ftrace_dump(DUMP_ORIG);
 			ratelimit++;
 		}
 		return false;
