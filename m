Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55EC2A9025
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 08:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgKFHSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 02:18:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:45598 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbgKFHSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 02:18:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C69A8AB8F;
        Fri,  6 Nov 2020 07:18:38 +0000 (UTC)
Date:   Thu, 5 Nov 2020 22:56:42 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 03/28] locktorture: Track time of last
 ->writeunlock()
Message-ID: <20201106065642.ti7mgrll7mbrndja@linux-p48b.lan>
References: <20201105234658.GA23142@paulmck-ThinkPad-P72>
 <20201105234719.23307-3-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201105234719.23307-3-paulmck@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Nov 2020, paulmck@kernel.org wrote:

>From: "Paul E. McKenney" <paulmck@kernel.org>
>
>This commit adds a last_lock_release variable that tracks the time of
>the last ->writeunlock() call, which allows easier diagnosing of lock
>hangs when using a kernel debugger.

This makes sense to have.

Acked-by: Davidlohr Bueso <dbueso@suse.de>

>
>Cc: Davidlohr Bueso <dave@stgolabs.net>
>Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>---
> kernel/locking/locktorture.c | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
>index 62d215b..316531d 100644
>--- a/kernel/locking/locktorture.c
>+++ b/kernel/locking/locktorture.c
>@@ -60,6 +60,7 @@ static struct task_struct **reader_tasks;
>
> static bool lock_is_write_held;
> static bool lock_is_read_held;
>+static unsigned long last_lock_release;
>
> struct lock_stress_stats {
> 	long n_lock_fail;
>@@ -632,6 +633,7 @@ static int lock_torture_writer(void *arg)
> 		lwsp->n_lock_acquired++;
> 		cxt.cur_ops->write_delay(&rand);
> 		lock_is_write_held = false;
>+		WRITE_ONCE(last_lock_release, jiffies);
> 		cxt.cur_ops->writeunlock();
>
> 		stutter_wait("lock_torture_writer");
>-- 
>2.9.5
>
