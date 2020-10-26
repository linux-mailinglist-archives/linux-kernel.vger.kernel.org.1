Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 134092991CA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784893AbgJZQEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:04:54 -0400
Received: from shelob.surriel.com ([96.67.55.147]:55606 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1774040AbgJZQEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:04:53 -0400
Received: from [2603:3005:d05:2b00:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1kX4zF-0004Ss-JC; Mon, 26 Oct 2020 12:04:45 -0400
Date:   Mon, 26 Oct 2020 12:04:45 -0400
From:   Rik van Riel <riel@surriel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Chris Mason <clm@fb.com>, Peter Zijlstra <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix scheduler regression from "sched/fair: Rework
 load_balance()"
Message-ID: <20201026120445.6a5dbbbe@imladris.surriel.com>
In-Reply-To: <CAKfTPtAfKn0jzOpPNR4NUb0zLs02iLQq2_UCDSCEwhTB2LDAig@mail.gmail.com>
References: <DB4481A8-FD4E-4879-9CD2-275ABAFC09CF@fb.com>
        <CAKfTPtBiOFXwV9SkZ=YBw16xoS6LSrKVR4sFX6r2hZPZ9_5-+A@mail.gmail.com>
        <0014CA62-A632-495A-92B0-4B14C8CA193C@fb.com>
        <20201026142455.GA13495@vingu-book>
        <465597a2250d69346cff73dd07817794d3e80244.camel@surriel.com>
        <CAKfTPtCVzass7GM5oj3o3y0ru4HQViWZc2+D-RpFoLvg=__FrA@mail.gmail.com>
        <334f491d2887a6ed7c5347d5125412849feb8a0a.camel@surriel.com>
        <CAKfTPtAfKn0jzOpPNR4NUb0zLs02iLQq2_UCDSCEwhTB2LDAig@mail.gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Oct 2020 16:42:14 +0100
Vincent Guittot <vincent.guittot@linaro.org> wrote:
> On Mon, 26 Oct 2020 at 16:04, Rik van Riel <riel@surriel.com> wrote:

> > Could utilization estimates be off, either lagging or
> > simply having a wrong estimate for a task, resulting
> > in no task getting pulled sometimes, while doing a
> > migrate_task imbalance always moves over something?  
> 
> task and cpu utilization are not always up to fully synced and may lag
> a bit which explains that sometimes LB can fail to migrate for a small
> diff

OK, running with this little snippet below, I see latencies
improve back to near where they used to be:

Latency percentiles (usec) runtime 150 (s)
        50.0th: 13
        75.0th: 31
        90.0th: 69
        95.0th: 90
        *99.0th: 761
        99.5th: 2268
        99.9th: 9104
        min=1, max=16158

I suspect the right/cleaner approach might be to use
migrate_task more in !CPU_NOT_IDLE cases?

Running a task to an idle CPU immediately, instead of refusing
to have the load balancer move it, improves latencies for fairly
obvious reasons.

I am not entirely clear on why the load balancer should need to
be any more conservative about moving tasks than the wakeup
path is in eg. select_idle_sibling.


diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 35bdc0cccfa6..60acf71a2d39 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7415,7 +7415,7 @@ static int detach_tasks(struct lb_env *env)
 		case migrate_util:
 			util = task_util_est(p);
 
-			if (util > env->imbalance)
+			if (util > env->imbalance && env->idle == CPU_NOT_IDLE)
 				goto next;
 
 			env->imbalance -= util;
